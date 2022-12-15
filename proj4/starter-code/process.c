#include "process.h"

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>

#define STATUS(x) (WIFEXITED(x) ? WEXITSTATUS(x) : 128+WTERMSIG(x))

// stack
struct stack {
	size_t size;
	struct node * list;
};

struct node {
	char * dir;
	struct node * next;
};

typedef struct stack * Stack;

// creates empty stack
Stack createStack(void){
    Stack s = malloc(sizeof(struct stack));
    s->size = 0;
    s->list = 0;
    return s;
}

// frees stack
void freeStack(Stack s){
    // frees linked list
    struct node * curr = s->list;
    while(curr){
        struct node * tmp = curr->next;
		free(curr->dir);
        free(curr);
        curr = tmp;
    }
    // frees stack
    free(s);
}

// push dir to stack
void push(Stack s, char * dir){
    // create new node
    struct node * newNode = malloc(sizeof(struct node));
    newNode->dir = dir;
    newNode->next = s->list;
    // append to s->list
    s->list = newNode;
    s->size += 1;
}

// pop from stack
// returns popped dir, or null if stack is empty
char * pop(Stack s){
    struct node * popped = s->list;
	if(popped) {
		// remove popped node
		s->size -= 1;
		s->list = s->list->next;
		// free popped and return
		char * result = popped->dir;
		free(popped);
		return result;
	} else {
		return 0;
	}
}

// print stack
void printStack(Stack s){
    struct node * curr = s->list;
    while(curr){
        printf(" %s", curr->dir);
        curr = curr->next;
    }
    printf("\n");
}


// global variable for directory stack
Stack Dir_Stack;


// wrapper function for chdir
int Chdir(const char * dir, const char * cmd){
	if(chdir(dir) == -1) {
		switch errno {
			case 0:
				break;
			case ENOENT:
				WARN("%s: chdir fail: No such file or directory\n", cmd);
				break;
			case ENOTDIR:
				WARN("%s: chdir fail: Not a directory\n", cmd);
				break;
			default:
				WARN("%s\n", "error with chdir");
				break;
		}

		return errno;
	}

	return 0;
}

int Open(const char * path, int flags, mode_t mode){
	int fd = open(path, flags, mode);
	if(fd == -1) {
		switch errno{
			case EACCES:
				WARN("%s: Permission denied\n", path);
				break;
			default:
				WARN("%s: No such file or directory\n", path);
		}
		
		exit(errno);
	}
	return fd;
}

void redirectInput(int fromType, char * fromFile){
	int new_stdin_fd;
	if(fromType == RED_IN) {
		new_stdin_fd = Open(fromFile, O_RDONLY, 0);
	} else if (fromType == RED_IN_HERE) {
		// HEREdoc
		char temp_file_name[] = "/tmp/my_file_XXXXXX";
    	int tmpFD = mkstemp(temp_file_name);
		write(tmpFD, fromFile, strlen(fromFile));
		close(tmpFD);
		new_stdin_fd = Open(temp_file_name, O_RDONLY, 0);
		unlink(temp_file_name);
	}
	dup2(new_stdin_fd, STDIN_FILENO);
	close(new_stdin_fd);
}

void redirectOutput(int toType, char * toFile){
	int fd;
	if(toType == RED_OUT) {		
		// overwrite
		fd = Open(toFile, O_CREAT | O_WRONLY | O_TRUNC, S_IWUSR | S_IRUSR );
	} else if (toType == RED_OUT_APP) {
		// append
		fd = Open(toFile, O_CREAT | O_WRONLY | O_APPEND, S_IWUSR | S_IRUSR);
	}
	dup2(fd, STDOUT_FILENO); // close whatever is in the descriptor for stdout, 
										// and replace it with a copy of the new_stdout_fd descriptor
	close(fd);
}

void redirect(const CMD *cmdList){
	if(cmdList->fromType != NONE)
		redirectInput(cmdList->fromType, cmdList->fromFile);
	if(cmdList->toType != NONE)
		redirectOutput(cmdList->toType, cmdList->toFile);
}

// built-in command: cd
int processCd(const CMD *cmdList){

	int status;
	char * dir = 0;

	// check usage
	if(cmdList->argc > 2) {
		WARN("%s\n", "usage: cd OR cd <dirName>");
		return 1;
	}

	if(cmdList->argc == 1){
		// cd, with no arguments following
		dir = getenv("HOME");
	} else {
		// cd with argument
		dir = cmdList->argv[1];
	}

	pid_t pid = fork();
	if(pid < 0) {
		fprintf(stderr, "%s", "error with fork");
		return errno;
	}
	if(pid == 0){
		// set environment variables
		for(int i = 0; i < cmdList->nLocal; i++)
			setenv(cmdList->locVar[i], cmdList->locVal[i], 1);

		// check for redirection
		redirect(cmdList);

		exit(Chdir(dir, "cd"));		
	} else {
		// parent process
		waitpid(pid, &status, 0);
		if(status == 0){
			// repeat cd in parent
			chdir(dir);
		}
	}
	return STATUS(status);
}

// process built-in command: pushd
int processPushd(const CMD *cmdList){
	int status;

	// check usage
	if(cmdList->argc != 2) {
		WARN("%s\n", "usage: pushd <dirName>");
		return 1;
	}

	char * currDir = get_current_dir_name();
	char * newDir = cmdList->argv[1];
	
	pid_t pid = fork();
	if(pid < 0) {
		fprintf(stderr, "%s", "error with fork");
		return errno;
	}
	if(pid == 0){
		// set environment variables
		for(int i = 0; i < cmdList->nLocal; i++)
			setenv(cmdList->locVar[i], cmdList->locVal[i], 1);

		// check for redirection
		redirect(cmdList);
		
		// push curr directory onto stack
		push(Dir_Stack, currDir);

		int chdir_status = Chdir(newDir, "pushd");

		if(chdir_status == 0){
			currDir = get_current_dir_name();	// new directory
			printf("%s", currDir);
			free(currDir);
			printStack(Dir_Stack);
		}

		exit(chdir_status);
	} else {
		// parent process
		waitpid(pid, &status, 0);
		if(status == 0){
			// repeat cd in parent
			chdir(newDir);
			// push to stack
			push(Dir_Stack, currDir);
		}
	}
	return STATUS(status);
}

// process built-in command: popd
int processPopd(const CMD *cmdList){
	int status;

	// check usage
	if(cmdList->argc != 1) {
		WARN("%s\n", "usage: popd");
		return 1;
	}

	char * newDir = 0;
	
	pid_t pid = fork();
	if(pid < 0) {
		fprintf(stderr, "%s", "error with fork");
		return errno;
	}
	if(pid == 0){
		// set environment variables
		for(int i = 0; i < cmdList->nLocal; i++)
			setenv(cmdList->locVar[i], cmdList->locVal[i], 1);

		// check for redirection
		redirect(cmdList);

		newDir = pop(Dir_Stack);
		if(newDir == 0)
			DIE("%s\n", "popd: dir stack empty");

		int chdir_status = Chdir(newDir, "popd");

		if(chdir_status == 0){
			// print
			char * currDir = get_current_dir_name();
			printf("%s", currDir);
			printStack(Dir_Stack);
			free(currDir);
		}

		exit(chdir_status);
	} else {
		// parent process
		waitpid(pid, &status, 0);
		if(status == 0){
			// repeat pop & cd in parent
			newDir = pop(Dir_Stack);
			chdir(newDir);
			free(newDir);
		}
	}
	return STATUS(status);
}

int processSimple(const CMD *cmdList){

	// check for builtins
	// QUESTION: how do we get redirection to work?
	// TODO: add environment variables
	if(strcmp(cmdList->argv[0], "cd") == 0){
		int status = processCd(cmdList);
		return status;
	} else if (strcmp(cmdList->argv[0], "pushd") == 0){
		int status = processPushd(cmdList);
		return status;
	} else if (strcmp(cmdList->argv[0], "popd") == 0){
		int status = processPopd(cmdList);
		return status;
	}

	pid_t pid = fork();
	if(pid < 0) {
		fprintf(stderr, "%s", "error with fork");
		return errno;
	}
	int status;
	if(pid == 0){ // child process
		// set environment variables
		for(int i = 0; i < cmdList->nLocal; i++)
			setenv(cmdList->locVar[i], cmdList->locVal[i], 1);

		// check for redirection
		redirect(cmdList);

		// if execvp encounters error, will return -1
		execvp(cmdList->argv[0], cmdList->argv);
		fprintf(stderr, "%s: no such file or directory\n", cmdList->argv[0]);
		exit(errno);
	} else {
		// parent process
		waitpid(pid, &status, 0);
	}
	return STATUS(status);
}

int processPipe(const CMD *cmdList){

	int pipe_fd[2];
	int err = pipe(pipe_fd);

	if(err < 0)
		DIE("%s", "error with pipe");

	pid_t pid_left = fork();
	if(pid_left < 0) {
		fprintf(stderr, "%s", "error with fork");
		return errno;
	}

	if(pid_left == 0){
		// child to process everything on the left
		// send its output to pile_fd[1]
		dup2(pipe_fd[1], STDOUT_FILENO);
		close(pipe_fd[1]);
		close(pipe_fd[0]);
		int status = process(cmdList->left);
		exit(status);
	}

	pid_t pid_right = fork();
	if(pid_right < 0) {
		fprintf(stderr, "%s", "error with fork");
		return errno;
	}
	
	if(pid_right == 0){
		// child to process everything on the right
		// get its input from pile_fd[0]
		dup2(pipe_fd[0], STDIN_FILENO);
		close(pipe_fd[1]);
		close(pipe_fd[0]);
		int status = process(cmdList->right);
		exit(status);
	}

	int status_left;
	int status_right;

	// close parent's copy of pipe fd
	close(pipe_fd[0]);
	close(pipe_fd[1]);

	waitpid(pid_left, &status_left, 0);
	waitpid(pid_right, &status_right, 0);

	// printf("status right: %d\n", status_right);
	// printf("status left: %d\n", status_left);

	return STATUS(status_right) || STATUS(status_left);
}

int processAnd(const CMD *cmdList){
	int statusLeft = process(cmdList->left);
	if(statusLeft == 0) {
		int statusRight = process(cmdList->right);
		return statusRight;
	} else {
		return statusLeft;
	}
}

int processOr(const CMD *cmdList){
	int statusLeft = process(cmdList->left);
	if(statusLeft != 0){
		int statusRight = process(cmdList->right);
		return statusRight;
	} else {
		return statusLeft;
	}
}

int processSubcmd(const CMD *cmdList){
	// need to fork a child process, so that any 
	// environment variables on the subcmd does
	// not affect the main process.

	int status;
	int pid = fork();
	if(pid < 0) {
		fprintf(stderr, "%s", "error with fork");
		return errno;
	}

	if(pid == 0){
		// child
		// set environment variables of child process
		for(int i = 0; i < cmdList->nLocal; i++)
			setenv(cmdList->locVar[i], cmdList->locVal[i], 1);
		
		// check for redirection
		if(cmdList->fromType != NONE)
			redirectInput(cmdList->fromType, cmdList->fromFile);
		if(cmdList->toType != NONE)
			redirectOutput(cmdList->toType, cmdList->toFile);

		status = process(cmdList->left);
		exit(status);
	} else {
		// parent
		waitpid(pid, &status, 0);
	}

	return STATUS(status);
}

int processBackground(const CMD *cmdList){

	int status = 0;

	// check if it's left child is SEP_END
	if(cmdList->left && cmdList->left->type == SEP_END){
		// only the right child of SEP_END gets backgrounded
		int pid = fork();
		if(pid < 0) {
			fprintf(stderr, "%s", "error with fork");
			return errno;
		}

		if(pid == 0){
			// child
			status = process(cmdList->left->right);
			exit(status);
		} else {
			// parent: deal with foreground stuff
			status = process(cmdList->left->left);
			fprintf(stderr, "Backgrounded: %d\n", pid);
			if(cmdList->right){
				status = process(cmdList->right);
			}
		}
	} else {
		// the left child gets backgrounded
		int pid = fork();
		if(pid < 0) {
			fprintf(stderr, "%s", "error with fork");
			return errno;
		}

		if(pid == 0){
			// child
			status = process(cmdList->left);
			exit(status);
		} else {
			// parent: deal with foreground stuff
			fprintf(stderr, "Backgrounded: %d\n", pid);
			status = process(cmdList->right);
		}
	}

	return status;
}

int
process(const CMD *cmdList){

	// create directory stack
	if(Dir_Stack == 0)
		Dir_Stack = createStack();

	// reaping zombies
	pid_t child_pid;
	int child_status;
	while((child_pid = waitpid(-1, &child_status, WNOHANG)) > 0){
		// just reaped this child
		fprintf(stderr, "Completed: %d (%d)\n", child_pid, STATUS(child_status));
	}

	if(cmdList == 0)
		return 0;

	int status;
    
    switch(cmdList->type){
		case SIMPLE:
			status = processSimple(cmdList);
			break;
		case PIPE:
			status = processPipe(cmdList);
			break;
		case SEP_AND:
			status = processAnd(cmdList);
			break;
		case SEP_OR:
			status = processOr(cmdList);
			break;
		case SUBCMD:
			status = processSubcmd(cmdList);
			break;
		case SEP_END:
			process(cmdList->left);
			status = process(cmdList->right);
			break;
		case SEP_BG:
			status = processBackground(cmdList);
			break;
	}

	// set environment variable for exit status
	char * buf = calloc(4, sizeof(char));
	sprintf(buf, "%d", status);
	setenv("?", buf, 1);
	free(buf);

    return status;
}

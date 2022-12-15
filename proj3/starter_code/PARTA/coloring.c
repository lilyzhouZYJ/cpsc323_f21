#include"coloring.h"

/*
 * Init Function : Initializes basic global variables.
 */

void Init(char* inputFile)
{
	FILE* fp;
	char line[LINE_SIZE];
	fp = fopen(inputFile, "r");
	if(fp == NULL)
	{
			printf("\nInput file does not exist!!!!!");
			exit(0);
	}
	fgets(line, sizeof(line), fp);
	sscanf(line, "%d", &k);
	while(!feof(fp))
	{
		fgets(line,sizeof(line),fp);
		vertices++;
	}
	--vertices; 
}

/*
 * TO FILL - ReadInput function : This function should read the input into the graph data structure.
 */
void ReadInput(int G[vertices][vertices], char* inputFile)
{
	FILE* fp;
	fp = fopen(inputFile, "r");
	if(fp == NULL)
	{
		printf("\nInput file does not exist!!!!!");
		exit(0);
	}
	/*
		 Write your code here.
	*/
	// read k (number of colors)
	k = getc(fp) - '0';

	// read the rest
	int c;
	for(int i = 0; i < vertices; i++) {
		for(int j = 0; j < vertices; j++) {
			while((c = getc(fp)) == ',' || c == ' ' || c == '\n');
			G[i][j] = c - '0';
		}
	}
	
	// Remove this call to CheckInput later to adhere to output requirements.
	// CheckInput(G);
	fclose(fp);
}


/*
 * CheckInput Function : Utility function to check if the input you read into the data structure is correct.
 * 
 */
void CheckInput(int G[vertices][vertices])
{
	int i, j;
	printf("\n vertices is : %d\n", vertices);
	for (i = 0; i < vertices; i++)
	{
		for (j = 0; j < vertices; j++)
		{
			printf("\t %d", G[i][j]);
		}
		printf("\n");
	}

}

int backtrack(int G[vertices][vertices], int * colors, int currNode) {

	// base
	if(currNode >= vertices) return 1;

	// assign color to currNode
	int result = 0;
	for(int color = 0; color < k; color++) {
		colors[currNode] = color;
		// check for legality
		int legal = 1;
		for(int n = 0; n < vertices; n++) {
			if(G[currNode][n] == 1 && colors[n] == color) {
				// rejected
				legal = 0;
				break;
			}
		}

		if(legal == 1) {
			// color is legal
			// fill in the rest
			if(backtrack(G, colors, currNode+1))
				return 1;
		}

		// backtrack
		colors[currNode] = -1;
	}

	if(colors[currNode] == -1) {
		// no valid color
		return 0;
	}
	
	return result;
}

/*
 * TO FILL - ColorGraph Function : Function for to decide if the graph is k-colorable.
 */
void ColorGraph(int G[vertices][vertices])
{
	// Remove this CheckInput call to adhere to output requirements.
	// CheckInput(G);
       	
	/*
		 Write your Graph Coloring logic here.
	*/

	// tracks colors of each node
	int * colors = malloc(sizeof(int) * vertices);
	for(int i = 0; i < vertices; i++)
		colors[i] = -1;		// init to -1

	if(backtrack(G, colors, 0) == 0){
		printf("N");
	} else {
		printf("Y");
	}

	// for(int curr = 0; curr < vertices; curr++) {
	// 	// assign color to curr
	// 	int chosenColor = -1;
	// 	for(int color = 0; color < k; color++) {
	// 		chosenColor = color;
	// 		// check if color collides with any neighbors
	// 		for(int n = 0; n < vertices; n++) {
	// 			if(G[curr][n] == 1 && colors[n] == chosenColor) {
	// 				// does not work
	// 				chosenColor = -1;
	// 				break;
	// 			}
	// 		}
	// 		if(chosenColor != -1) {
	// 			// found color!
	// 			colors[curr] = chosenColor;
	// 			break;
	// 		}
	// 	}
	// 	if(chosenColor == -1) {
	// 		// no color found
	// 		printf("N");
	// 		return;
	// 	}
	// }


	/* BFS
	// track if each node has been visited
	int * visited = calloc(vertices, sizeof(int));
	int numVisited = 0;

	// stack for BFS
	int * stack = malloc(vertices * sizeof(int));
	int bottom = 0;
	int top = 0;

	// color for each node, initialize to 0 for all
	int * colors = calloc(vertices, sizeof(int));

	// max number of colors so far
	int max = 1;

	// while there are unvisited nodes
	while(numVisited < vertices) {
		
		// start bfs from some unvisited node
		int start = -1;
		for(int i = 0; i < vertices; i++) {
			if(visited[i] == 0) {
				start = i;
				break;
			}
		}

		// push it to stack
		stack[top++] = start;
		visited[start] = 1;
		numVisited++;

		while(top - bottom > 0) {
			int currNode = stack[bottom++];
			visited[currNode] = 1;
			numVisited++;

			// iterate through its neighbors
			for(int n = 0; n < vertices; n++) {
				if(G[currNode][n] == 1) {			// n is a neighbor node
					if(visited[n] == 0)
						// n is not yet visited
						// add n to stack
						stack[top++] = n;

					if(colors[n] == colors[currNode])
						colors[n]++;
					// update max color is needed
					if(colors[n] >= max) {
						max = colors[n];
						if(max > k) {
							printf("N");
							return;
						}
					}
				}
			}
		}

	}*/




	// // allocate memo
	// // each memo[i][j] is whether color j is not available to i
	// // - memo[i][j] == 0: not yet used by its neighbors
	// // - memo[i][j] == 1: already used by its neighbors
	// int ** memo = malloc(sizeof(int *) * vertices);
	// for(int i = 0; i < vertices; i++)
	// 	memo[i] = calloc(k, sizeof(int));

	// // start coloring
	// for(int i = 0; i < vertices; i++) {
	// 	// pick a color for node i
	// 	int color = -1;
	// 	for(int j = 0; j < k; j++) {
	// 		if (memo[i][j] == 0) {
	// 			color = j;
	// 			break;
	// 		}
	// 	}

	// 	// no colors available?
	// 	if(color == -1) {
	// 		printf("N");
	// 		return;
	// 	}

	// 	// found a color for the node i
	// 	// make this color unavailable to all its neighboring nodes
	// 	for(int n = 0; n < vertices; n++) {
	// 		if(G[i][n] == 1) {
	// 			memo[n][color] = 1;
	// 		}
	// 	}

	// 	// debugging
	// 	printf("added color %d to node %d\n", color, i);
	// 	printf("current color status of each node:\n");
	// 	for(int node = 0; node < vertices; node++) {
	// 		for(int col = 0; col < k; col++) {
	// 			printf(" %d ", memo[node][col]);
	// 		}
	// 		printf("\n");
	// 	}
	// }

	// return yes
	// printf("Y");
	// return;
}

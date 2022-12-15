#include"coloring.h"

int k, vertices;

int main(int argc, char* argv[])
{
	if(argc < 2 || argc > 2)
	{
		printf("\nIncorrect number of arguments;");
		exit(0);
	}	
        Init(argv[1]);
	int G[vertices][vertices];
	ReadInput(G, argv[1]);
	ColorGraph(G);
	return 0;
}


#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdbool.h>

#define LINE_SIZE 1024

extern int k, vertices;

void Init(char* inputFile);
void ReadInput(int G[vertices][vertices], char* inputFile);
void ColorGraph(int G[vertices][vertices]);

// Optional utility functions. You can add yours below this line.
void CheckInput(int[vertices][vertices]);

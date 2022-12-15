CC = gcc
CFLAGS = -std=c11 -pedantic -Wall -g3

PROGRAMS = proj1

all: $(PROGRAMS)

test: $(PROGRAMS)
	valgrind --leak-check=yes ./proj1 test.in

proj1: proj1.o macro_list.o state.o string.o string_list.o
	$(CC) $(CFLAGS) -o $@ $^

proj1.o: proj1.c proj1.h state.h macro_list.h string_list.h string.h

macro_list.o: macro_list.c macro_list.h string.h string_list.h

state.o: state.c state.h

string.o: string.c string.h

string_list.o: string_list.c string_list.h string.h

clean:
	$(RM) *.o $(PROGRAMS)
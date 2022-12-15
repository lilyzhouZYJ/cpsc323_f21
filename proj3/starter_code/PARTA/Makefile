CC=gcc
CFLAGS=-I.
DEPS = coloring.h
TESTDIR1 = testcases/set1/
TESTDIR2 = testcases/set2/

%.o: %.c $(DEPS)
	@$(CC) -c -Wall -Wextra -o $@ $< $(CFLAGS)

clean:
	@rm -rf *.o *.txt coloring

.PHONY: clean

coloring: coloring.o main.o
	@$(CC) -o coloring coloring.o main.o	

.PHONY:coloring

single:  $(input)
ifeq (, $(wildcard ./coloring))
	@echo Please create coloring executable first.
else
	@./coloring $(input);
endif
.PHONY: single

test2: $(input2)
ifeq (, $(wildcard ./coloring))
	@echo Please create coloring executable first.
else	
ifeq ($(shell ./coloring $(input2)), N)
	@echo  $(input2) PASSED
else
	@echo $(input2) FAILED
endif
endif
.PHONY: test2

test1: $(input1)
ifeq (, $(wildcard ./coloring))
	@echo Please create coloring executable first
else
ifeq ($(shell ./coloring $(input1)), Y)
	@echo $(input1) PASSED
else
	@echo $(input1) FAILED
endif
endif
.PHONY: test1


all:
ifeq (, $(wildcard ./coloring))
	@echo Please create coloring executable first
else
	@for FILE in $(shell ls ${TESTDIR1}); do $(MAKE) -s test1 input1=$(addsuffix $${FILE},${TESTDIR1});done;
	@for FILE in $(shell ls ${TESTDIR2}); do $(MAKE) -s test2 input2=$(addsuffix $${FILE},${TESTDIR2}); done;
.PHONY: all
endif

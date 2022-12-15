#include <stdlib.h>
#include <stdio.h>

/* String manipulation module */

typedef struct string_t * String;

// create new empty string
String string_create(size_t capacity);

// append char to string
void string_append(String str, int c);

// remove last appended char to string
void string_unappend(String str);

// terminate string, by adding \0
void string_terminate(String str);

// get size of string
size_t string_length(String str);

// get char at index
int string_charAt(String str, size_t index);

// return pointer to char array
char * string_charArr(String str);

// read next char in string, or EOF if no more chars to be read
int string_readChar(String str);

// un-read the last char in string
void string_unreadChar(String str);

// reset file position
void string_resetPosition(String str);

// print entire string to stdout
void string_print_entire(String str);

// print string, after file position
void string_print(String str);

// check if str1 (String) and str2 (char[]) are equal
int string_equal_char(String str1, char * str2, int str2Len);

// check if str1 and str2 (both Strings) are equal
int string_equal(String str1, String str2);

// make an exact copy of the str
String string_copy(String str);

// free string
void string_free(String str);
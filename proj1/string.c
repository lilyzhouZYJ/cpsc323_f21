#include <stdio.h>
#include "string.h"
#include "proj1.h"

struct string_t {
    char * data;            // char array
    size_t size;            // current number of chars in the array, excluding null terminator
    size_t capacity;        // max number of chars in the array, excluding null terminator
    size_t position;        // file position: points to next char to be read
};

// create new empty string
String string_create(size_t capacity)
{
    String str = malloc(sizeof(struct string_t));
    str->size = 0;
    str->capacity = capacity;
    str->data = malloc(sizeof(char) * (capacity + 1));      // add 1 for null terminator
    str->position = 0;
    return str;
}

// grow string
void grow(String str)
{
    size_t newCap = str->capacity * 2;
    str->data = realloc(str->data, (newCap + 1) * sizeof(char));
    str->capacity = newCap;
}

// append char to string
void string_append(String str, int c)
{
    // check if we need to grow string
    if (str->size == str->capacity) 
        grow(str);
    
    // append char
    str->data[(str->size)++] = c;
}

// remove last appended char to string
void string_unappend(String str)
{
    // check that string is not empty
    if(str->size == 0) {
        DIE("%s", "cannot unappend from empty string");
    }

    (str->size)--;
}

// terminate string, by adding \0
void string_terminate(String str)
{
    str->data[str->size] = '\0';
}

// get size of string
size_t string_length(String str)
{
    return str->size;
}

// get char at index
int string_charAt(String str, size_t index)
{
    // check that index is valid
    if(index < 0 || index >= str->size)
        DIE("Invalid index %ld in String of size %ld\n", index, str->size);
    
    return str->data[index];
}

// return pointer to char array
char * string_charArr(String str)
{
    return str->data;
}

// read next char in string
int string_readChar(String str)
{
    if(str->position >= str->size)
        return EOF;

    return str->data[(str->position)++];
}

// un-read the last char in string
void string_unreadChar(String str)
{
    (str->position)--;
}

// reset file position
void string_resetPosition(String str)
{
    str->position = 0;
}

// print string, after file position
void string_print(String str)
{
    char * buffer = str->data;
    size_t position = str->position;
    for(size_t i = position; i < str->size; i++) {
        putchar(buffer[i]);
    }
}

// print entire string to stdout
void string_print_entire(String str)
{
    char * buffer = str->data;
    for(int i = 0; i < str->size; i++) {
        putchar(buffer[i]);
    }
}

// check if str1 (String) and str2 (char[]) are equal
int string_equal_char(String str1, char * str2, int str2Len)
{
    if(str1->size != str2Len)
        return 0;
    
    char * str1Buff = str1->data;
    for(int i = 0; i < str2Len; i++) {
        if(str1Buff[i] != str2[i])
            return 0;
    }

    return 1;
}

// check if str1 and str2 (both Strings) are equal
int string_equal(String str1, String str2)
{
    if(string_length(str1) != string_length(str2))
        return 0;

    char * str1Buff = str1->data;
    char * str2Buff = str2->data;
    for(int i = 0; i < string_length(str1); i++){
        if(str1Buff[i] != str2Buff[i])
            return 0;
    }

    return 1;
}

// make an exact copy of the str
String string_copy(String str)
{
    String newStr = string_create(str->capacity);
    int size = str->size;
    newStr->size = size;
    newStr->position = str->position;

    for(int i = 0; i < size; i++) {
        newStr->data[i] = str->data[i];
    }
    newStr->data[size] = '\0';
    return newStr;
}

// free string
void string_free(String str)
{
    if(str == 0) return;

    free(str->data);
    free(str);
}
#include "string.h"

/**
 * String List data type:
 * Implemented as a linked list of Strings, to allow for easy insertion
 */

typedef struct string_list * StringList;

// create new string list
StringList strList_create(void);

// get first String
String strList_getFirst(StringList str);

// get last String
String strList_getLast(StringList str);

// append String at the tail of the list
void strList_appendTail(StringList str, String newStr);

// append String at the head of the list
// also will set file position to this String
void strList_appendHead(StringList str, String newStr);

// read next character, based on file position
int strList_readChar(StringList str);

// unread last character
// (only use to retrieve the SINGLE LAST character that was read)
void strList_unreadChar(StringList str);

// print string list, after file position
void strList_print(StringList str);

// print the entire string list
void strList_print_entire(StringList str);

// free the string list
void strList_free(StringList str);
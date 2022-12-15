#include "string_list.h"

struct string_list {
    struct string_list_node * head;         // first String node
    struct string_list_node * tail;         // last String node
    struct string_list_node * position;     // file position: next String to be read
};

// each String node of the list
struct string_list_node {
    struct string_list_node * prev;         // previous node
    struct string_list_node * next;         // next node
    String str;                            // the actual String
};

// create new string list
StringList strList_create(void)
{
    StringList str = malloc(sizeof(struct string_list));
    str->head = 0;
    str->tail = 0;
    str->position = 0;
    return str;
}

// get first String
String strList_getFirst(StringList str)
{
    return str->head->str;
}

// get last String
String strList_getLast(StringList str)
{
    return str->tail->str;
}

// append String at the tail of the list
void strList_appendTail(StringList str, String newStr)
{
    // create new string list node
    struct string_list_node * node = malloc(sizeof(struct string_list_node));
    node->prev = str->tail;
    node->next = 0;
    node->str = newStr;

    // append
    if(!str->tail) {
        // this is first node of the list
        str->head = node;
    } else {
        str->tail->next = node;
    }
    str->tail = node;
}

// reset file position to first String Node
void strList_resetPos(StringList str)
{
    str->position = str->head;
}

// append String at the head of the list
void strList_appendHead(StringList str, String newStr)
{
    // create new string list node
    struct string_list_node * node = malloc(sizeof(struct string_list_node));
    node->prev = 0;
    node->next = str->head;
    node->str = newStr;

    // append
    if(!str->head) {
        // this is the first node of the list
        str->tail = node;
    } else {
        str->head->prev = node;
    }
    str->head = node;

    // reset file position to head
    str->position = str->head;
}

// read next character, based on file position
int strList_readChar(StringList str)
{
    struct string_list_node * currNode = str->position;

    int c = EOF;
    while (currNode != 0 && (c = string_readChar(currNode->str)) == EOF) {
        // no more things to read from currNode
        // move on to next node
        currNode = currNode->next;
        str->position = currNode;
    }

    return c;
}

// unread last character
// (only use to retrieve the SINGLE LAST character that was read)
void strList_unreadChar(StringList str)
{
    string_unreadChar(str->position->str);
}

// print string list, after file position
void strList_print(StringList str)
{
    struct string_list_node * currNode = str->position;

    for( ; currNode != 0; currNode = currNode->next)
        string_print(currNode->str);
}

// print the entire string list
void strList_print_entire(StringList str)
{
    struct string_list_node * currNode = str->head;

    for( ; currNode != 0; currNode = currNode->next)
        string_print_entire(currNode->str);
}

// free the string list
void strList_free(StringList str)
{
    struct string_list_node * currNode;
    struct string_list_node * nextNode;

    for(currNode = str->head; currNode != 0; currNode = nextNode) {
        nextNode = currNode->next;
        // free currNode
        string_free(currNode->str);
        free(currNode);
    }

    free(str);
}
#include <stdlib.h>

#include "string.h"
#include "macro_list.h"

/* Store info on each custom-defined macro */

// each custom-defined macro
typedef struct macro_info {
    String macroName;
    String macroValue;
} * MacroInfo;

// list of custom-defined macros
struct macro_list {
    MacroInfo * list;           // list of MacroInfo
    size_t size;                // number of macros in the list
    size_t capacity;            // max number of macros in the list
};

// create MacroInfo
// private function
MacroInfo create_macro(String macroName, String macroValue)
{
    MacroInfo macro = malloc(sizeof(struct macro_info));
    macro->macroName = macroName;
    macro->macroValue = macroValue;
    return macro;
}

// create the list
MacroList create_macro_list(void)
{
    MacroList list = malloc(sizeof(struct macro_list));
    list->list = malloc(sizeof(MacroInfo) * 64);
    list->size = 0;
    list->capacity = 64;

    return list;
}

// free the macroInfo
void free_macroInfo(MacroInfo macro)
{
    string_free(macro->macroName);
    string_free(macro->macroValue);
    free(macro);
}

// free the macro list
void free_macro_list(MacroList list)
{
    size_t size = list->size;
    for(int i = 0; i < size; i++){
        MacroInfo curr = list->list[i];
        if(curr == 0)
            continue;

        // string_print_entire(curr->macroValue);

        free_macroInfo(curr);
    }
    free(list->list);
    free(list);
}

// grow the list, (by factor of 2)
// private function
void grow_list(MacroList list){
    list->capacity *= 2;
    list->list = realloc(list->list, sizeof(MacroInfo) * list->capacity);
}

// add macro to the list
void add_macro_list(String macroName, String macroValue, MacroList list)
{
    MacroInfo newMacro = create_macro(macroName, macroValue);

    // check if there is more space in the list
    if(list->size == list->capacity) {
        grow_list(list);
    }

    // add newMacro
    list->list[(list->size)++] = newMacro;
}

// delete macro from the list (lazy deletion)
// will not change list size, due to lazy deletion
void delete_macro_list(String macroName, MacroList list)
{
    int size = list->size;
    for(int i = 0; i < size; i++){
        MacroInfo curr = list->list[i];
        if(curr == 0)
            continue;
        
        if(string_equal(macroName, curr->macroName)){
            // found it, delete!
            free_macroInfo(curr);
            list->list[i] = 0;
        }
    }
}

// check if macro exists
int check_macro_validity(String macroName, MacroList list)
{
    int size = list->size;
    for(int i = 0; i < size; i++){
        MacroInfo curr = list->list[i];
        if(curr == 0)
            continue;
        
        if(string_equal(macroName, curr->macroName)){
            return 1;
        }
    }

    return 0;
}

// get value string of a macro
String get_macro_value(String macroName, MacroList list)
{
    int size = list->size;
    for(int i = 0; i < size; i++){
        MacroInfo curr = list->list[i];
        if(curr == 0)
            continue;
        
        if(string_equal(macroName, curr->macroName)){
            return curr->macroValue;
        }
    }

    return 0;
}
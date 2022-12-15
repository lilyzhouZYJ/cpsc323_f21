#include <stdlib.h>

#include "string.h"

/* List for storing custom-defined macros */

typedef struct macro_list * MacroList;

// create the list
MacroList create_macro_list(void);

// add macro to the list
void add_macro_list(String macroName, String macroValue, MacroList list);

// delete macro from the list
void delete_macro_list(String macroName, MacroList list);

// check if macro exists
int check_macro_validity(String macroName, MacroList list);

// get argument string of a macro
String get_macro_value(String macroName, MacroList list);

// free the macro list
void free_macro_list(MacroList list);
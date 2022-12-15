#include <stdlib.h>
#include <stdio.h>

#include "state.h"
#include "string.h"
#include "string_list.h"
#include "macro_list.h"
#include "proj1.h"

// declaration header
String process(StringList inputList, MacroList myMacros);
void readHelper(String buffer, FILE * f);



/* Utilities: Parsing macro name and arguments */

// Get the macro name from input string
// - at the end of this function, file position will point to first char after curly brace {
String getMacroName(StringList inputList)
{
    String macroName = string_create(20);

    int c;
    while((c = strList_readChar(inputList)) != '{') {
        // is c valid?
        if(!isalnum(c)) {
            DIE("expected {, found \'0x%x\'", c);
        }

        // store to macroName
        string_append(macroName, c);
    }
    string_terminate(macroName);

    return macroName;
}

// Get the next argument from input string
// - at the start of this function, the file position must points to first char after the curly brace {
// - at the end of this function, the file position will point to first char after the closing brace }
// - any escape characters will be retained
String getMacroArg(StringList inputList)
{
    String macroArg = string_create(20);

    int openBraces = 0;         // number of open braces, for brace balancing
    int escape = 0;             // are we currently in ESCAPE mode

    int c;
    while((c = strList_readChar(inputList)) != EOF && (c != '}' || escape || openBraces != 0)) {
        if (escape) {
            // in ESCAPE mode, means previous char was backslash
            escape = 0;
        } else {
            if(c == '\\') {
                escape = 1;
            } else if (c == '{') {      // only unescaped { and } count towards brace balancing
                openBraces++;
            } else if (c == '}') {
                openBraces--;
            }
        }
        string_append(macroArg, c);
    }
    
    // check if c has reached EOF before all braces are balanced
    if(c == EOF) {
        DIE("%s", "expected }, found EOS");
    }

    string_terminate(macroArg);

    // printf("printing: ");
    // string_print_entire(macroArg);
    // printf("\n");
    return macroArg;
}

// Check if a macro is already defined
int isMacroDefined(String macroName, MacroList myMacros)
{
    // custom macros
    if(check_macro_validity(macroName, myMacros))
        return 1;
    
    // built-in macros
    if(string_equal_char(macroName, "def", 3) ||
        string_equal_char(macroName, "undef", 5) || 
        string_equal_char(macroName, "if", 2) ||
        string_equal_char(macroName, "ifdef", 5) ||
        string_equal_char(macroName, "include", 7) ||
        string_equal_char(macroName, "expandafter", 11))
        return 1;

    return 0;
}





/* Expanding Macros */

// Expands the `def` macro
// @form    \def{NAME}{VALUE}
// @expl    Defines a macro of name NAME corresponding to VALUE.
// @ret     0
void expand_def(StringList inputList, MacroList myMacros) {

    // read first arg NAME
    String name = string_create(20);
    int c;
    while((c = strList_readChar(inputList)) != '}') {
        // is c still valid?
        // for `def`, the NAME argument must be alphanumeric
        if(!isalnum(c)) {
            string_free(name);
            DIE("%s", "Parsing error: first argument of \\def must be alphanumeric");
        }

        // store to name
        string_append(name, c);
    }
    string_terminate(name);

    // check if macro name is empty
    if(string_length(name) == 0) {
        string_free(name);
        DIE("%s", "Macro name is not alphanumeric");
    }

    // check if the macro is already defined
    if(isMacroDefined(name, myMacros)) {
        string_free(name);
        DIE("%s", "cannot redefine existing macro");
    }

    if((c = strList_readChar(inputList)) != '{'){
        string_free(name);
        DIE("expected {, found \'0x%x\'", c);
    }

    // read second arg VALUE
    String value = getMacroArg(inputList);

    // add to macro list
    add_macro_list(name, value, myMacros);
}

// Expands the `undef` macro
// @form    \undef{NAME}
// @expl    Un-defines the custom-defined macro.
// @ret     0
void expand_undef(StringList inputList, MacroList myMacros) {

    // read arg NAME
    String name = string_create(20);
    int c;
    while((c = strList_readChar(inputList)) != '}') {
        // is c still valid?
        // the macro NAME argument must be alphanumeric
        if(!isalnum(c)) {
            string_free(name);
            DIE("%s", "Parsing error: invalid macro name, alphanumeric characters expected");
        }

        // store to name
        string_append(name, c);
    }
    string_terminate(name);

    // check if the macro is defined
    if(!isMacroDefined(name, myMacros)) {
        string_free(name);
        DIE("%s", "cannot undef an undefined macro");
    }

    // check if the macro is a built in
    // built-in macros
    if(string_equal_char(name, "def", 3) ||
        string_equal_char(name, "undef", 5) || 
        string_equal_char(name, "if", 2) ||
        string_equal_char(name, "ifdef", 5) ||
        string_equal_char(name, "include", 7) ||
        string_equal_char(name, "expandafter", 11)) {

        string_free(name);
        DIE("%s", "cannot undef a built-in macro");

    }

    // remove from macro list
    delete_macro_list(name, myMacros);

    // need to free name also
    string_free(name);
}

// Expands the `if` macro
// @form    \if{COND}{THEN}{ELSE}
// @expl    If COND is non-empty string, expand THEN; otherwise, expand ELSE.
// @ret     THEN or ELSE, depending on COND.
String expand_if(StringList inputList) {

    // is COND empty string?
    int isEmpty = 1;

    // read arg COND
    int c;
    while((c = strList_readChar(inputList)) != '}') {
        isEmpty = 0;
    }

    // read intermediate {
    if((c = strList_readChar(inputList)) != '{')
        DIE("expected {, found \'0x%x\'", c);

    if(!isEmpty) {
        String then = getMacroArg(inputList);       // read THEN

        if((c = strList_readChar(inputList)) != '{')      // read intermediate {
            DIE("expected {, found \'0x%x\'", c);

        string_free(getMacroArg(inputList));        // also read ELSE, just to get it out of the way
        return then;
    } else {
        string_free(getMacroArg(inputList));        // read THEN, just to get it out of the way

        if((c = strList_readChar(inputList)) != '{')      // read intermediate {
            DIE("expected {, found \'0x%x\'", c);
        
        return getMacroArg(inputList);              // return ELSE
    }
}

// Expands the `ifdef` macro
// @form    \if{NAME}{THEN}{ELSE}
// @expl    If NAME is a defined macro, expand THEN; otherwise, expand ELSE.
// @ret     THEN or ELSE, depending on NAME.
String expand_ifdef(StringList inputList, MacroList myMacros) {

    // read arg NAME
    String name = getMacroArg(inputList);

    int c; 
    // read intermediate {
    if((c = strList_readChar(inputList)) != '{')      // read intermediate {
        DIE("expected {, found \'0x%x\'", c);

    String output;

    // check if NAME is a defined macro
    if( check_macro_validity(name, myMacros) ){
        // defined: return THEN
        output = getMacroArg(inputList);            // read THEN
        if((c = strList_readChar(inputList)) != '{')      // read intermediate {
            DIE("expected {, found \'0x%x\'", c);
        string_free(getMacroArg(inputList));        // also read ELSE, just to get it out of the way
    } else {
        // not defined: return ELSE
        string_free(getMacroArg(inputList));        // read THEN, just to get it out of the way
        if((c = strList_readChar(inputList)) != '{')      // read intermediate {
            DIE("expected {, found \'0x%x\'", c);
        output = getMacroArg(inputList);              // return ELSE
    }

    // free name
    string_free(name);

    return output;
}

// Expands the `include` macro
// @form    \include{PATH}
// @expl    Include the contents of PATH.
// @ret     Contents of PATH.
String expand_include(StringList inputList) {

    // read arg PATH
    String path = getMacroArg(inputList);

    String output = string_create(20);

    // get content of PATH file
    FILE * f = fopen(string_charArr(path), "r");
    readHelper(output, f);
    // terminate string with \0
    string_terminate(output);

    // free path and close file
    string_free(path);
    fclose(f);

    return output;
}

// Expands the `expandafter` macro
// @form    \expandafter{BEFORE}{AFTER}
// @expl    Expand AFTER first, then expand BEFORE.
// @ret     AFTER
String expand_expandafter(StringList inputList, MacroList myMacros) {

    // read arg BEFORE
    String before = getMacroArg(inputList);

    // read intermediate {
    int c;
    if((c = strList_readChar(inputList)) != '{')
            DIE("expected {, found \'0x%x\'", c);

    // read arg AFTER
    String after = getMacroArg(inputList);

    // expand AFTER first, using recursive call of process()
    // create new string list for AFTER
    StringList afterInput = strList_create();
    strList_appendHead(afterInput, after);
    // parse AFTER
    String expAfter = process(afterInput, myMacros);

    // now we can just append `before` and `expAfter` to inputList
    // in this order: before -> expAfter -> original inputList

    // we will just append expAfter, and before will be returned
    // to be appended by the caller function
    strList_appendHead(inputList, expAfter);

    strList_free(afterInput);
    return before;
}

// expand custom defined macro
String expand_custom(String macroName, StringList inputList, MacroList myMacros) {
    
    // check if macro exists
    if(!check_macro_validity(macroName, myMacros)) {
        string_free(macroName);
        DIE("%s", "anUndefinedMacro not defined");
    }

    // read value of macro
    // (need to make a copy of the returned String, to keep myMacros intact)
    String value = string_copy(get_macro_value(macroName, myMacros));

    // read argument
    String arg = getMacroArg(inputList);

    // actual output: after replacing all # in value with arg
    String output = string_create(20);

    int escape = 0;         // are we in ESCAPE mode?
    int c;
    while((c = string_readChar(value)) != EOF) {
        if(escape){
            string_append(output, c);
            escape = 0;
        } else {
            if (c == '#') {
                // replace with arg
                int argChar;
                while((argChar = string_readChar(arg)) != EOF)
                    string_append(output, argChar);
                // reset file position of arg, in case it is needed again
                string_resetPosition(arg);
            } else {
                if(c == '\\')
                    escape = 1;
                string_append(output, c);
            }
        }
    }

    string_free(value);
    string_free(arg);
    return output;
}



// Parse, process, and expand macro
// Return expanded string
String macro_parse(StringList inputList, MacroList myMacros)
{
    String macroName = getMacroName(inputList);

    // expanded string to be returned
    String expStr = 0;

    // built-in macros
    if(string_equal_char(macroName, "def", 3)){
        expand_def(inputList, myMacros);
    } else if (string_equal_char(macroName, "undef", 5)) {
        expand_undef(inputList, myMacros);
    } else if (string_equal_char(macroName, "if", 2)) {
        expStr = expand_if(inputList);
    } else if (string_equal_char(macroName, "ifdef", 5)) {
        expStr = expand_ifdef(inputList, myMacros);
    } else if (string_equal_char(macroName, "include", 7)) {
        expStr = expand_include(inputList);
    } else if (string_equal_char(macroName, "expandafter", 11)) {
        expStr = expand_expandafter(inputList, myMacros);
    }

    // custom-defined macros
    else {
        expStr = expand_custom(macroName, inputList, myMacros);
    }

    string_free(macroName);
    return expStr;
}


// Process input, returns output as String
// Escape chars will be retained
String process(StringList inputList, MacroList myMacros)
{
    // initialize state
    state_t myState = STATE_PLAINTEXT;

    // output string
    String output = string_create(20);

    int c;
    while ((c = strList_readChar(inputList)) != EOF) {

        // pass each char into state machine
        myState = state_update(myState, c);
        switch (myState) {
            case STATE_PLAINTEXT:
            case STATE_ESCAPE:
                // add c to output
                string_append(output, c);
                break;
            case STATE_MACRO:
                // c is first char of macro, need to unread it
                strList_unreadChar(inputList);

                // we have appended backslash \ to output
                // need to unappend it
                string_unappend(output);
                
                // process and expand the macro
                String expStr = macro_parse(inputList, myMacros);
                
                // append the expanded string to the front of inputList
                if(expStr != 0) 
                    strList_appendHead(inputList, expStr);

                // return to plaintext state
                myState = STATE_PLAINTEXT;

                // the loop will start processing from the start of expStr
                break;
        }
    }

    return output;
}


// Print buffer; escape chars will be dealt with here
void printOutput(String buffer) {
    int escape = 0;     // are we in ESCAPE mode
    int c;
    while((c = string_readChar(buffer)) != EOF) {
        if(escape) {
            if(c == '#' || c == '{' || c == '}' || c == '\\' || c == '%') 
                putchar(c);
            else {
                // not escape char
                putchar('\\');
                putchar(c);
            }
            escape = 0;
        } else {
            if(c == '\\') {
                escape = 1;
            } else {
                putchar(c);
            }
        }
    }

    // if after EOF, we are still in ESCAPE mode,
    // it means the last char is \, so we need to print it
    if(escape)
        putchar('\\');
}


// Reading from f and storing in String buffer
// Note that if f == 0, it means stdin
void readHelper(String buffer, FILE *f) {
    int escape = 0;     // are we in ESCAPE mode?
    int c;
    while((c = getc(f)) != EOF) {
        if(escape == 1) {
            // we are in ESCAPE mode
            // do not need to check for comments
            string_append(buffer, '\\');
            string_append(buffer, c);
            escape = 0;
        }

        else {
            // we are not in ESCAPE mode
            // need to check for comments
            if(c == '\\') {                 // check if we are going into ESCAPE
                escape = 1;
            } else if (c == '%') {          // check if we are starting a comment
                // find first new line
                while((c = getc(f)) != EOF && c != '\n')
                    continue;
                if(c == EOF) return;

                // found new line,
                // now need to find first non-blank, non-tab character
                while((c = getc(f)) != EOF && (c == ' ' || c == '\t'))
                    continue;
                if(c == EOF) return;

                // c is now the first non-blank, non-tab character
                ungetc(c, f);
            } else {
                string_append(buffer, c);
            }
        }
    }

    // if after EOF, we are still in ESCAPE mode,
    // it means the last char was \\, and we need to add it
    if(escape)
        string_append(buffer, '\\');
}


// Read all input into input buffer String
// Comments are removed in the process
void readInput(String input, int argc, char ** argv) {
    if(argc == 1){
        // taking input from stdin
        readHelper(input, stdin);
        // terminate string with \0
        string_terminate(input);
    } else {
        // take input from files
        for(int i = 1; i < argc; i++) {
            FILE * f = fopen(argv[i], "r");
            readHelper(input, f);
            fclose(f);
        }
        // terminate string with \0
        string_terminate(input);
    }
}


/* Main routine */
int main(int argc, char ** argv)
{
    // create macroList
    MacroList myMacros = create_macro_list();

    // read input (without comments) and store
    String input = string_create(64);
    readInput(input, argc, argv);

    // string_print_entire(input);

    // create StringList from input String
    StringList inputList = strList_create();
    strList_appendHead(inputList, input);
    
    // process input string, print output
    String output = process(inputList, myMacros);
    printOutput(output);

    // free things
    strList_free(inputList);
    free_macro_list(myMacros);
    string_free(output);
}
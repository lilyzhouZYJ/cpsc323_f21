#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
#include "state.h"
#include "string.h"

// @desc    update state based on input char
// @return  new state after processing input char
state_t state_update(state_t myState, int c)
{
    switch (myState) {
        case STATE_PLAINTEXT:
            if(c == '\\')
                myState = STATE_ESCAPE;
            break;
        
        case STATE_ESCAPE:
            if (isalnum(c)) {
                // macro start
                myState = STATE_MACRO;
            } else {
                // either escape, or not escape, we will not deal with it here...
                // will remove escape chars when main prints output to stdout
                myState = STATE_PLAINTEXT;
            } 
            break;
        
        case STATE_MACRO:
            break;
    }

    return myState;
}
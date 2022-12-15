#include <stdlib.h>

/* State machine */

// States:
// - plaintext: default state
// - escape: state after reading a backslash
// - macro: if the backslash is followed by alphanumeric characters

typedef enum {
    STATE_PLAINTEXT,
    STATE_ESCAPE,
    STATE_MACRO
} state_t;

// @desc    update state based on input char
state_t state_update(state_t, int);
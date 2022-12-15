#include "process.h"
#include "lib.h"
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
    
    pid_t p = getpid();
    srand(p);

    /* Single elements on heap of varying sizes */
    for(int i = 1; i < 2; ++i) {
        void *ptr = malloc(i);
        assert(ptr != NULL);

        /* Check that we can write */
        // memset(ptr, 'A', i);
        free(ptr);
    }
}

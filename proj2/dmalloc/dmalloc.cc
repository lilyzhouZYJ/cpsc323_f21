#define M61_DISABLE 1
#include "dmalloc.hh"
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cinttypes>
#include <cassert>

// Globals:
unsigned long long nactive = 0;     // number of active allocations [#malloc - #free]
unsigned long long active_size = 0; // number of bytes in active allocations
unsigned long long ntotal = 0;      // number of allocations, total
unsigned long long total_size = 0;  // number of bytes in allocations, total
unsigned long long nfail = 0;       // number of failed allocation attempts
unsigned long long fail_size = 0;   // number of bytes in failed allocation attempts
uintptr_t heap_min = UINTPTR_MAX;   // smallest address in any region ever allocated
uintptr_t heap_max = 0;             // largest address in any region ever allocated

// canary
#define CANARY_SIZE (200)
const char canary[CANARY_SIZE] = {0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD,
                                    0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD,
                                    0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD,
                                    0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD,
                                    0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD, 0xB, 0xE, 0xE, 0xF, 0xB, 0xE, 0xD, 0xE, 0xA, 0xD};

// magic number
#define MAGIC_SIZE (9)
const char magic[MAGIC_SIZE] = {0xA, 0x0, 0x9, 0x2, 0x9, 0x2, 0x0, 0x0, 0x1};
const char not_magic[MAGIC_SIZE] = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0};

// start of the linked list of allocation blocks
struct header * listHead = 0;

// header for each allocation block
struct header {
    uintptr_t startAddr;
    size_t size;
    struct header * next;
    long line;
    char active;
    char magic[8];
    char file_name[11];
    char under_canary[CANARY_SIZE];
};


/* Heavy hitters */

struct allocInfo {
    char * file_name;
    long line;
    size_t size;
};

// array of file name - line pairs
struct allocInfo arrAlloc[5] = {
    { .file_name = 0, .line = 0, .size = 0 },
    { .file_name = 0, .line = 0, .size = 0 },
    { .file_name = 0, .line = 0, .size = 0 },
    { .file_name = 0, .line = 0, .size = 0 },
    { .file_name = 0, .line = 0, .size = 0 },
};

// allocation size for each pair
// (these values do not represent total sizes)
size_t arrSize[5] = {0, 0, 0, 0, 0};

size_t totalSize = 0;

// If the arrays are full, remove elements.
// Determine which elements to remove by subtracting size from
// all elements currently in the array. If the resulting element
// has size <= 0, remove it.
// Returns index of any of the removed elements; if
// none was removed, return -1.
int hhRemoveAllocation(size_t currSize) {
    int ret = -1;
    for(int i = 0; i < 5; i++) {
        if(arrSize[i] <= currSize) {
            // remove element i
            arrSize[i] = 0;
            arrAlloc[i].file_name = 0;
            arrAlloc[i].line = 0;
            arrAlloc[i].size = 0;
            ret = i;
        }
    }
    return ret;
}

// add a new allocation
void hhAddAllocation(char * fileName, long line, size_t size) {
    totalSize += size;

    // check if the allocation is already in the array
    for(int i = 0; i < 5; i++) {
        if (arrAlloc[i].file_name == fileName && arrAlloc[i].line == line) {
            // already exists in array
            arrSize[i] += size;
            arrAlloc[i].size += size;
            return;
        }
    }

    // look for empty slot in the array
    for(int i = 0; i < 5; i++){
        if(arrAlloc[i].file_name == 0) {
            arrAlloc[i].file_name = fileName;
            arrAlloc[i].line = line;
            arrAlloc[i].size = size;
            arrSize[i] = size;
            return;
        }
    }

    // array is full, and the new allocation is not in it
    // need to remove elements
    int ind = hhRemoveAllocation(size);

    if(ind != -1) {
        // some element was removed
        arrAlloc[ind].file_name = fileName;
        arrAlloc[ind].line = line;
        arrAlloc[ind].size = size;
        arrSize[ind] = size;
    }
}



/// dmalloc_malloc(sz, file, line)
///    Return a pointer to `sz` bytes of newly-allocated dynamic memory.
///    The memory is not initialized. If `sz == 0`, then dmalloc_malloc must
///    return a unique, newly-allocated pointer value. The allocation
///    request was at location `file`:`line`.

void* dmalloc_malloc(size_t sz, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings

    // allocate: head + payload (sz bytes)
    uintptr_t block;
    if(sz + sizeof(struct header) + CANARY_SIZE < sz) {
        // overflow will happen, just allocate sz (will fail, and block will be nullptr)
        block = (uintptr_t) base_malloc(sz);
    } else {
        // no overflow:
        // allocate header + payload + overflow_canary
        block = (uintptr_t) base_malloc(sizeof(struct header) + sz + CANARY_SIZE);
    }

    if(block != 0) {
        // fill in the header
        struct header * head = (struct header *) block;
        head->startAddr = block + sizeof(struct header);
        head->size = sz;
        head->next = 0;
        head->line = line;
        head->active = 1;
        memcpy(head->magic, magic, MAGIC_SIZE);
        memcpy(head->file_name, file, 11);
        memcpy(head->under_canary, canary, CANARY_SIZE);

        // add overflow canary at the end
        uintptr_t overCanary = block + sizeof(struct header) + sz;
        memcpy((char*) overCanary, canary, CANARY_SIZE);

        // add the block to the linked list
        if(listHead == 0)
            listHead = head;
        else {
            head->next = listHead;
            listHead = head;
        }

        // not using struct below:=========
        // uintptr_t size = (uintptr_t) &sz;
        // for(int i = 0; i < 8; i++) {
        //     * (char*) block = * (char *) size;
        //     block++;
        //     size++;
        // }

        // update global vars
        nactive++;
        active_size += sz;
        ntotal++;
        total_size += sz;
        uintptr_t startBlock = block + sizeof(struct header);   // start of the actual block
        heap_max = heap_max > startBlock + sz ? heap_max : startBlock + sz;
        heap_min = heap_min < startBlock ? heap_min : startBlock;

        // add to heavy hitter arrays
        hhAddAllocation((char *) file, line, sz);

        // return (void *) block;
        return (void*) startBlock;
    } else {
        // update global vars
        nfail++;
        fail_size += sz;
        return 0;
    }    
}


/// dmalloc_free(ptr, file, line)
///    Free the memory space pointed to by `ptr`, which must have been
///    returned by a previous call to dmalloc_malloc. If `ptr == NULL`,
///    does nothing. The free was called at location `file`:`line`.

void dmalloc_free(void* ptr, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings

    // free(nullptr) does nothing
    if(ptr == 0) return;

    // check if ptr is a valid address to be freed:
    uintptr_t ptrVal = (uintptr_t) ptr;

    if(heap_max < heap_min || (uintptr_t)ptr < heap_min || (uintptr_t)ptr > heap_max) {
        // nothing has been allocated yet
        fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer 0x%lx, not in heap\n", file, line, ptrVal);
        exit(1);
    }

    // check if ptr is a legal pointer to be freed
    struct header * head = (struct header*) ((uintptr_t) ptr - sizeof(struct header));
    if(memcmp(head->under_canary, canary, CANARY_SIZE) != 0) {
        fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer 0x%lx, not allocated\n", file, line, ptrVal);
        // iterate through linked list to determine offset
        struct header * curr = listHead;
        while(curr != 0){
            if (ptrVal >= curr->startAddr && ptrVal < curr->startAddr + curr->size) {
                size_t offset = ptrVal - curr->startAddr;
                fprintf(stderr, "  %s:%ld: 0x%lx is %ld bytes inside a %ld byte region allocated here",
                            curr->file_name, curr->line, ptrVal, offset, curr->size);
                break;
            }
            curr = curr->next;
        }
        exit(1);
    }

    // check if ptr has been freed already
    if(head->active == 0) {
        fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer 0x%lx, double free\n", file, line, (uintptr_t)ptr);
        exit(1);
    }

    // check buffer overflow
    size_t size = head->size;
    uintptr_t overCanary = ((uintptr_t) ptr) + size;
    if(memcmp((char*) overCanary, canary, CANARY_SIZE) != 0) {
        fprintf(stderr, "MEMORY BUG: %s:%ld: detected wild write during free of pointer 0x%lx\n", file, line, (uintptr_t)ptr);
        exit(1);
    }


    // uintptr_t sizePtr = ((uintptr_t) ptr) - 8;      // where the size starts
    // size_t size = 0;                                // variable to store the size
    // uintptr_t varPtr = (uintptr_t) &size;              // points to size variable
    // for(int i = 0; i < 8; i++) {
    //     *(char *) (varPtr + i) = *(char *) (sizePtr + i);
    // }

    // update global vars
    nactive--;
    active_size -= size;

    // free
    head->active = 0;
    base_free((void*) ((uintptr_t) ptr - sizeof(struct header)));
}


/// dmalloc_calloc(nmemb, sz, file, line)
///    Return a pointer to newly-allocated dynamic memory big enough to
///    hold an array of `nmemb` elements of `sz` bytes each. If `sz == 0`,
///    then must return a unique, newly-allocated pointer value. Returned
///    memory should be initialized to zero. The allocation request was at
///    location `file`:`line`.

void* dmalloc_calloc(size_t nmemb, size_t sz, const char* file, long line) {
    // Your code here (to fix test014).

    // Note: does not update global variables here,
    // for dmalloc_malloc would handle that.

    // check for overflow
    size_t size = nmemb * sz;
    if(sz != size / nmemb) {
        // overflow
        nfail++;        // value for fail_size does not matter
        return 0;
    }

    void* ptr = dmalloc_malloc(nmemb * sz, file, line);
    if (ptr) {
        memset(ptr, 0, nmemb * sz);
    }
    return ptr;
}


/// dmalloc_get_statistics(stats)
///    Store the current memory statistics in `*stats`.

void dmalloc_get_statistics(dmalloc_statistics* stats) {
    // Stub: set all statistics to enormous numbers
    memset(stats, 255, sizeof(dmalloc_statistics));
    
    stats->nactive = nactive;
    stats->active_size = active_size;
    stats->ntotal = ntotal;
    stats->total_size = total_size;
    stats->nfail = nfail;
    stats->fail_size = fail_size;
    stats->heap_min = heap_min;
    stats->heap_max = heap_max;
}


/// dmalloc_print_statistics()
///    Print the current memory statistics.

void dmalloc_print_statistics() {
    dmalloc_statistics stats;
    dmalloc_get_statistics(&stats);

    printf("alloc count: active %10llu   total %10llu   fail %10llu\n",
           stats.nactive, stats.ntotal, stats.nfail);
    printf("alloc size:  active %10llu   total %10llu   fail %10llu\n",
           stats.active_size, stats.total_size, stats.fail_size);
}


/// dmalloc_print_leak_report()
///    Print a report of all currently-active allocated blocks of dynamic
///    memory.

void dmalloc_print_leak_report() {
    
    // iterate through the linked list of allocated blocks
    struct header * curr = listHead;
    while(curr != 0) {
        if(curr->active == 1) {
            uintptr_t ptr = ((uintptr_t) curr) + sizeof(struct header);
            char * file = curr->file_name;
            printf("LEAK CHECK: %s:%ld: allocated object 0x%lx with size %ld\n", file, curr->line, ptr, curr->size);
        }
        curr = curr->next;
    }
}


// for sorting
int compareAlloc(const void * a, const void * b){
    return ((struct allocInfo *) b)->size > ((struct allocInfo *) a)->size;
}

/// dmalloc_print_heavy_hitter_report()
///    Print a report of heavily-used allocation locations.

void dmalloc_print_heavy_hitter_report() {

    // sort in descending order
    qsort(arrAlloc, 5, sizeof(struct allocInfo), compareAlloc);
    
    for(int i = 0; i < 5; i++) {
        if(arrAlloc[i].file_name == 0) 
            continue;

        float percentage = ((float) arrAlloc[i].size) / totalSize * 100;
        printf("HEAVY HITTER: %s:%ld: %ld bytes (~%.1f%%)\n", arrAlloc[i].file_name, arrAlloc[i].line, arrAlloc[i].size, percentage);
    }

    // HEAVY HITTER: hhtest.cc:49: 1643786191 bytes (~50.1%)

}

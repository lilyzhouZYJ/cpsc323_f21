#include "malloc.h"

#define ALIGNMENT (8)

// header for a block of memory
struct block_header {
    struct block_header * next;
    struct block_header * prev;
    size_t block_size;      // including the header
};

const size_t HEADER_SIZE = sizeof(struct block_header);

// linked lists of blocks
struct block_header * free_list_start = 0;
struct block_header * allocated_list_start = 0;

// number of allocated blocks
int number_allocs = 0;

/* For quicksort */
// taken from p-heapinfo.c
typedef struct ptr_with_size{
    void * ptr;
    size_t size;
} ptr_with_size;

int compare( const void * a, const void * b){
    ptr_with_size * a_ptr = (ptr_with_size *) a;
    ptr_with_size * b_ptr = (ptr_with_size *) b;

    return (int)b_ptr->size - (int)a_ptr->size;
}

#define SWAP(a, b, size)                                                      \
  do                                                                              \
    {                                                                              \
      size_t __size = (size);                                                      \
      char *__a = (a), *__b = (b);                                              \
      do                                                                      \
        {                                                                      \
          char __tmp = *__a;                                                      \
          *__a++ = *__b;                                                      \
          *__b++ = __tmp;                                                      \
        } while (--__size > 0);                                                      \
    } while (0)
/* Discontinue quicksort algorithm when partition gets below this size.
   This particular magic number was chosen to work best on a Sun 4/260. */
#define MAX_THRESH 4
/* Stack node declarations used to store unfulfilled partition obligations. */
typedef struct
  {
    char *lo;
    char *hi;
  } stack_node;
#  define CHAR_BIT        8
#define STACK_SIZE        (CHAR_BIT * sizeof (size_t))
#define PUSH(low, high)        ((void) ((top->lo = (low)), (top->hi = (high)), ++top))
#define        POP(low, high)        ((void) (--top, (low = top->lo), (high = top->hi)))
#define        STACK_NOT_EMPTY        (stack < top)
typedef int (*__compar_fn_t) (const void *, const void *);

void
quicksort (void *const pbase, size_t total_elems, size_t size,
            __compar_fn_t cmp)
{
    char *base_ptr = (char *) pbase;
    const size_t max_thresh = MAX_THRESH * size;
    if (total_elems == 0)
	/* Avoid lossage with unsigned arithmetic below.  */
	return;
    if (total_elems > MAX_THRESH)
    {
	char *lo = base_ptr;
	char *hi = &lo[size * (total_elems - 1)];
	stack_node stack[STACK_SIZE];
	stack_node *top = stack;
	PUSH (NULL, NULL);
	while (STACK_NOT_EMPTY)
	{
	    char *left_ptr;
	    char *right_ptr;
	    /* Select median value from among LO, MID, and HI. Rearrange
	       LO and HI so the three values are sorted. This lowers the
	       probability of picking a pathological pivot value and
	       skips a comparison for both the LEFT_PTR and RIGHT_PTR in
	       the while loops. */
	    char *mid = lo + size * ((hi - lo) / size >> 1);
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
		SWAP (mid, lo, size);
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
		SWAP (mid, hi, size);
	    else
		goto jump_over;
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
		SWAP (mid, lo, size);
jump_over:;
	  left_ptr  = lo + size;
	  right_ptr = hi - size;
	  /* Here's the famous ``collapse the walls'' section of quicksort.
	     Gotta like those tight inner loops!  They are the main reason
	     that this algorithm runs much faster than others. */
	  do
	  {
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
		  left_ptr += size;
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
		  right_ptr -= size;
	      if (left_ptr < right_ptr)
	      {
		  SWAP (left_ptr, right_ptr, size);
		  if (mid == left_ptr)
		      mid = right_ptr;
		  else if (mid == right_ptr)
		      mid = left_ptr;
		  left_ptr += size;
		  right_ptr -= size;
	      }
	      else if (left_ptr == right_ptr)
	      {
		  left_ptr += size;
		  right_ptr -= size;
		  break;
	      }
	  }
	  while (left_ptr <= right_ptr);
	  /* Set up pointers for next iteration.  First determine whether
	     left and right partitions are below the threshold size.  If so,
	     ignore one or both.  Otherwise, push the larger partition's
	     bounds on the stack and continue sorting the smaller one. */
	  if ((size_t) (right_ptr - lo) <= max_thresh)
	  {
	      if ((size_t) (hi - left_ptr) <= max_thresh)
		  /* Ignore both small partitions. */
		  POP (lo, hi);
	      else
		  /* Ignore small left partition. */
		  lo = left_ptr;
	  }
	  else if ((size_t) (hi - left_ptr) <= max_thresh)
	      /* Ignore small right partition. */
	      hi = right_ptr;
	  else if ((right_ptr - lo) > (hi - left_ptr))
	  {
	      /* Push larger left partition indices. */
	      PUSH (lo, right_ptr);
	      lo = left_ptr;
	  }
	  else
	  {
	      /* Push larger right partition indices. */
	      PUSH (left_ptr, hi);
	      hi = right_ptr;
	  }
	}
    }
    /* Once the BASE_PTR array is partially sorted by quicksort the rest
       is completely sorted using insertion sort, since this is efficient
       for partitions below MAX_THRESH size. BASE_PTR points to the beginning
       of the array to sort, and END_PTR points at the very last element in
       the array (*not* one beyond it!). */
#define min(x, y) ((x) < (y) ? (x) : (y))
    {
	char *const end_ptr = &base_ptr[size * (total_elems - 1)];
	char *tmp_ptr = base_ptr;
	char *thresh = min(end_ptr, base_ptr + max_thresh);
	char *run_ptr;
	/* Find smallest element in first threshold and place it at the
	   array's beginning.  This is the smallest array element,
	   and the operation speeds up insertion sort's inner loop. */
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
	    if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
		tmp_ptr = run_ptr;
	if (tmp_ptr != base_ptr)
	    SWAP (tmp_ptr, base_ptr, size);
	/* Insertion sort, running from left-hand-side up to right-hand-side.  */
	run_ptr = base_ptr + size;
	while ((run_ptr += size) <= end_ptr)
	{
	    tmp_ptr = run_ptr - size;
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
		tmp_ptr -= size;
	    tmp_ptr += size;
	    if (tmp_ptr != run_ptr)
	    {
		char *trav;
		trav = run_ptr + size;
		while (--trav >= run_ptr)
		{
		    char c = *trav;
		    char *hi, *lo;
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
			*hi = *lo;
		    *hi = c;
		}
	    }
	}
    }
}

/* Add the given block to the given list */
void addNodeToList(struct block_header * header, struct block_header ** list_start){
    if(*list_start == 0) {
        // list is empty
        *list_start = header;
        return;
    }

    if(header < *list_start){
        // header goes to the front of the list
        header->next = *list_start;
        (*list_start)->prev = header;
        *list_start = header;
        return;
    }

    struct block_header * node = *list_start;
    struct block_header * nextNode = node->next;
    while(nextNode != 0){
        if(node < header && nextNode > header){
            // insert header between node and nextNode
            header->prev = node;
            header->next = nextNode;
            node->next = header;
            nextNode->prev = header;
            return;
        }
        node = nextNode;
        nextNode = node->next;
    }

    // reached end of list; append header there
    node->next = header;
    header->prev = node;
}


/* Remove the given block from its list */
void removeNodeFromList(struct block_header * header, struct block_header ** list_start){
    if(header == 0) return;

    struct block_header * prevNode = header->prev;
    struct block_header * nextNode = header->next;

    if(prevNode)
        prevNode->next = nextNode;
    if(nextNode)
        nextNode->prev = prevNode;

    // check if this block is the start of the list
    if(*list_start == header)
        *list_start = nextNode;

    header->next = 0;
    header->prev = 0;
}

/* Free a block */
void free(void *firstbyte) {
    
    // app_printf(0, "free\n");

    if(firstbyte == 0)
        return;

    // remove the block from allocated_list
    struct block_header * header = (struct block_header *) ((uintptr_t) firstbyte - HEADER_SIZE);
    removeNodeFromList(header, &allocated_list_start);

    // add the block to free-node list
    header->prev = 0;
    header->next = 0;
    addNodeToList(header, &free_list_start);

    // app_printf(0, "%x\n", free_list_start);

    number_allocs--;
}

/* Split a given block into two,
   given the size of the first part */
void splitFreeNode(struct block_header * node, size_t sz) {
    struct block_header * newNode = (struct block_header *) ((uintptr_t) node + sz);
    newNode->block_size = node->block_size - sz;

    // insert the new block into free-node list
    newNode->next = node->next;
    node->next = newNode;
    newNode->prev = node;
    if(newNode->next) newNode->next->prev = newNode;     
}

/* Traverse the free-node list to find a possible block;
   return the start of the block (start of the header) */
struct block_header * findFreeNode(size_t block_size){
    struct block_header * node = free_list_start;
    while(node != 0){
        if(node->block_size >= block_size) {
            // found a block
            // do we split the block?
            if(node->block_size - block_size >= HEADER_SIZE) {
                // split!
                splitFreeNode(node, block_size);
            } else {
                // we will just allocate the entire block
                block_size = node->block_size;
            }

            // remove this block from free-node list
            removeNodeFromList(node, &free_list_start);

            // update block_size
            node->block_size = block_size;

            return node;
        }
        node = node->next;
    }
    // no available block is found
    return 0;
}

void *malloc(uint64_t numbytes) {
    if(numbytes == 0) return NULL;

    // app_printf(0, "s\n");

    // size of allocated block, after accounting for alignment
    size_t allocatedBlockSize = numbytes + HEADER_SIZE;
    // app_printf(0, "%d\n", numbytes);
    if(allocatedBlockSize % ALIGNMENT != 0)
        allocatedBlockSize = (allocatedBlockSize & ~(ALIGNMENT-1)) + ALIGNMENT;

    // go through list of free blocks,
    // and find one that would fit
    struct block_header * target_block = findFreeNode(allocatedBlockSize);
    if(target_block == 0) {
        // no valid block: use sbrk to get more heap space
        target_block = (struct block_header *) sbrk(allocatedBlockSize);
        if((void *)target_block == (void *) -1) return 0;
        // set up block header
        target_block->block_size = allocatedBlockSize;
    }

    // add the block to allocated_list
    target_block->prev = 0;
    target_block->next = 0;
    addNodeToList(target_block, &allocated_list_start);

    // return start of payload
    number_allocs++;
    
    // app_printf(0, "%d\n", allocatedBlockSize);
    return (void*) ((uintptr_t) target_block + HEADER_SIZE);
}


void * calloc(uint64_t num, uint64_t sz) {
    // malloc
    void * new_payload = malloc(num * sz);
    if(new_payload == 0)
        return 0;

    // fill in 0's
    memset(new_payload, 0, num * sz);

    return new_payload;
}

/*
For realloc(ptr, size), if ptr is NULL, then the call is equivalent to malloc(size), 
for all values of size; if size is equal to zero, and ptr is not NULL, then the call 
is equivalent to free(ptr).
*/
void * realloc(void * ptr, uint64_t sz) {
    // edge cases:
    if(ptr == NULL) return malloc(sz);
    if(sz == 0) {
        free(ptr);
        return 0;       // TODO: check return value
    }

    struct block_header * orig_header = (struct block_header *) ((uintptr_t) ptr - HEADER_SIZE);
    size_t origPayloadSz = orig_header->block_size - HEADER_SIZE;
    size_t newPayloadSz = sz;
    if(newPayloadSz % ALIGNMENT != 0)
        newPayloadSz = (newPayloadSz & ~(ALIGNMENT-1)) + ALIGNMENT;

    // shrinking?
    if (newPayloadSz <= origPayloadSz) {
        // check if we need to split
        if(origPayloadSz - newPayloadSz >= HEADER_SIZE) {
            // split!
            struct block_header * free_header = (struct block_header *) ((uintptr_t) ptr + newPayloadSz);
            free_header->block_size = origPayloadSz - newPayloadSz;
            free_header->next = 0;
            free_header->prev = 0;
            addNodeToList(free_header, &free_list_start);
            // shrink the allocated block
            orig_header->block_size = newPayloadSz + HEADER_SIZE;
        }

        return ptr;
    }

    // growing:

    // malloc a new block
    void * new_payload = malloc(newPayloadSz);

    // copy the data
    memcpy(new_payload, ptr, origPayloadSz);

    // free the original block
    free(ptr);

    // return start of new payload
    return new_payload;
}

void defrag() {
    if(free_list_start == 0) return;

    // iterate through free-node list
    struct block_header * node = free_list_start;
    struct block_header * nextNode = node->next;
    while(nextNode != 0){
        // check if node and nextNode are adjacent
        if((uintptr_t) nextNode - (uintptr_t) node == node->block_size) {
            // are adjacent - merge into node
            node->block_size += nextNode->block_size;
            node->next = nextNode->next;
            if(nextNode->next) nextNode->next->prev = node;
            // update for loop
            nextNode = node->next;
        } else {
            node = nextNode;
            nextNode = node->next;
        }
    }
}




int heap_info(heap_info_struct * info) {
    
    // app_printf(0, "info\n");
    // app_printf(0, "~%d\n", number_allocs);

    /* Free block stuff */

    size_t largest_free_chunk = 0;
    size_t free_space = 0;

    // iterate through free-node list
    // app_printf(0, "%x\n", free_list_start);
    if(free_list_start != 0) {
        struct block_header * node = free_list_start;
        while(node != 0){
            free_space += node->block_size;
            if(node->block_size > largest_free_chunk)
                largest_free_chunk = node->block_size;
            node = node->next;
        }
    }
    info->free_space = free_space;
    info->largest_free_chunk = largest_free_chunk;


    /* Allocated block stuff */

    // number of allocated blocks
    int num_allocs = (int) number_allocs;

    if(num_allocs == 0){
        info->num_allocs = 0;
        info->size_array = 0;
        info->ptr_array = 0;
        return 0;
    }

    // set up ptr_with_size array
    ptr_with_size * arr = malloc(num_allocs * sizeof(ptr_with_size));
    if(arr == 0) return -1;

    // iterate through allocated-node list
    int index = 0;
    if(allocated_list_start != 0){
        struct block_header * node = allocated_list_start;
        while(node != 0){
            // make sure to exclude arr as metadata
            if((uintptr_t) node + HEADER_SIZE != (uintptr_t) arr) {
                arr[index].ptr = (void*) ((uintptr_t) node + HEADER_SIZE);
                arr[index].size = node->block_size - HEADER_SIZE;
                index++;
                // app_printf(0, "%d\n", node->block_size - HEADER_SIZE);
            }
            node = node->next;
        }
    }

    // sort the array
    quicksort(arr, num_allocs, sizeof(ptr_with_size), &compare);

    // set up pointer and size arrays
    long * size_array = malloc(num_allocs * sizeof(long));
    void ** ptr_array = malloc(num_allocs * sizeof(void *));
    if(size_array == 0 || ptr_array == 0) return -1;

    for(int i = 0; i < num_allocs; i++){
        size_array[i] = arr[i].size;
        ptr_array[i] = arr[i].ptr;
        // console_clear();
        // app_printf(0, "%x\n", ptr_array[i]);
    }

    free(arr);

    // fill in struct
    info->num_allocs = num_allocs;
    info->size_array = size_array;
    info->ptr_array = ptr_array;

    return 0;
}

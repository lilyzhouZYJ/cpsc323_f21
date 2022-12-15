
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	55                   	push   %rbp
  2c0001:	48 89 e5             	mov    %rsp,%rbp
  2c0004:	41 56                	push   %r14
  2c0006:	41 55                	push   %r13
  2c0008:	41 54                	push   %r12
  2c000a:	53                   	push   %rbx
  2c000b:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c000f:	cd 31                	int    $0x31
  2c0011:	41 89 c4             	mov    %eax,%r12d
    
    pid_t p = getpid();
    srand(p);
  2c0014:	89 c7                	mov    %eax,%edi
  2c0016:	e8 6a 03 00 00       	callq  2c0385 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 3e 11 00 00       	callq  2c1163 <malloc>
  2c0025:	48 89 c7             	mov    %rax,%rdi
  2c0028:	ba 00 00 00 00       	mov    $0x0,%edx
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	    array[i] = i;
  2c002d:	89 14 97             	mov    %edx,(%rdi,%rdx,4)
    for(int  i = 0 ; i < 10; i++){
  2c0030:	48 83 c2 01          	add    $0x1,%rdx
  2c0034:	48 83 fa 0a          	cmp    $0xa,%rdx
  2c0038:	75 f3                	jne    2c002d <process_main+0x2d>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c003a:	be 50 00 00 00       	mov    $0x50,%esi
  2c003f:	e8 d7 11 00 00       	callq  2c121b <realloc>
  2c0044:	49 89 c5             	mov    %rax,%r13
  2c0047:	b8 00 00 00 00       	mov    $0x0,%eax

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c004c:	41 39 44 85 00       	cmp    %eax,0x0(%r13,%rax,4)
  2c0051:	75 64                	jne    2c00b7 <process_main+0xb7>
    for(int i = 0 ; i < 10 ; i++){
  2c0053:	48 83 c0 01          	add    $0x1,%rax
  2c0057:	48 83 f8 0a          	cmp    $0xa,%rax
  2c005b:	75 ef                	jne    2c004c <process_main+0x4c>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c005d:	be 04 00 00 00       	mov    $0x4,%esi
  2c0062:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c0067:	e8 7c 11 00 00       	callq  2c11e8 <calloc>
  2c006c:	49 89 c6             	mov    %rax,%r14

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c006f:	48 8d 50 78          	lea    0x78(%rax),%rdx
	assert(array2[i] == 0);
  2c0073:	8b 18                	mov    (%rax),%ebx
  2c0075:	85 db                	test   %ebx,%ebx
  2c0077:	75 52                	jne    2c00cb <process_main+0xcb>
    for(int i = 0 ; i < 30; i++){
  2c0079:	48 83 c0 04          	add    $0x4,%rax
  2c007d:	48 39 d0             	cmp    %rdx,%rax
  2c0080:	75 f1                	jne    2c0073 <process_main+0x73>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c0082:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  2c0086:	e8 a1 12 00 00       	callq  2c132c <heap_info>
  2c008b:	85 c0                	test   %eax,%eax
  2c008d:	75 64                	jne    2c00f3 <process_main+0xf3>
	    // check if allocations are in sorted order
        for(int  i = 1 ; i < info.num_allocs; i++){
  2c008f:	8b 55 c0             	mov    -0x40(%rbp),%edx
  2c0092:	83 fa 01             	cmp    $0x1,%edx
  2c0095:	7e 70                	jle    2c0107 <process_main+0x107>
  2c0097:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c009b:	8d 52 fe             	lea    -0x2(%rdx),%edx
  2c009e:	48 8d 54 d0 08       	lea    0x8(%rax,%rdx,8),%rdx
            assert(info.size_array[i] < info.size_array[i-1]);
  2c00a3:	48 8b 30             	mov    (%rax),%rsi
  2c00a6:	48 39 70 08          	cmp    %rsi,0x8(%rax)
  2c00aa:	7d 33                	jge    2c00df <process_main+0xdf>
        for(int  i = 1 ; i < info.num_allocs; i++){
  2c00ac:	48 83 c0 08          	add    $0x8,%rax
  2c00b0:	48 39 d0             	cmp    %rdx,%rax
  2c00b3:	75 ee                	jne    2c00a3 <process_main+0xa3>
  2c00b5:	eb 50                	jmp    2c0107 <process_main+0x107>
	assert(array[i] == i);
  2c00b7:	ba 40 16 2c 00       	mov    $0x2c1640,%edx
  2c00bc:	be 1a 00 00 00       	mov    $0x1a,%esi
  2c00c1:	bf 4e 16 2c 00       	mov    $0x2c164e,%edi
  2c00c6:	e8 46 15 00 00       	callq  2c1611 <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 5d 16 2c 00       	mov    $0x2c165d,%edx
  2c00d0:	be 22 00 00 00       	mov    $0x22,%esi
  2c00d5:	bf 4e 16 2c 00       	mov    $0x2c164e,%edi
  2c00da:	e8 32 15 00 00       	callq  2c1611 <assert_fail>
            assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba 80 16 2c 00       	mov    $0x2c1680,%edx
  2c00e4:	be 29 00 00 00       	mov    $0x29,%esi
  2c00e9:	bf 4e 16 2c 00       	mov    $0x2c164e,%edi
  2c00ee:	e8 1e 15 00 00       	callq  2c1611 <assert_fail>
        }
    }
    else{
	    app_printf(0, "heap_info failed\n");
  2c00f3:	be 6c 16 2c 00       	mov    $0x2c166c,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 ac 13 00 00       	callq  2c14b3 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 77 0f 00 00       	callq  2c1086 <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 6f 0f 00 00       	callq  2c1086 <free>

    uint64_t total_time = 0;
  2c0117:	41 bd 00 00 00 00    	mov    $0x0,%r13d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c011d:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c011f:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0123:	89 c0                	mov    %eax,%eax
  2c0125:	48 09 c2             	or     %rax,%rdx
  2c0128:	49 89 d6             	mov    %rdx,%r14
    int total_pages = 0;
    
    // allocate pages till no more memory
    while (1) {
	uint64_t time = rdtsc();
	void * ptr = malloc(PAGESIZE);
  2c012b:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c0130:	e8 2e 10 00 00       	callq  2c1163 <malloc>
  2c0135:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c0138:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  2c013a:	48 c1 e2 20          	shl    $0x20,%rdx
  2c013e:	89 c0                	mov    %eax,%eax
  2c0140:	48 09 c2             	or     %rax,%rdx
	total_time += (rdtsc() - time);
  2c0143:	4c 29 f2             	sub    %r14,%rdx
  2c0146:	49 01 d5             	add    %rdx,%r13
	if(ptr == NULL)
  2c0149:	48 85 c9             	test   %rcx,%rcx
  2c014c:	74 08                	je     2c0156 <process_main+0x156>
	    break;
	total_pages++;
  2c014e:	83 c3 01             	add    $0x1,%ebx
	*((int *)ptr) = p; // check write access
  2c0151:	44 89 21             	mov    %r12d,(%rcx)
    while (1) {
  2c0154:	eb c7                	jmp    2c011d <process_main+0x11d>
    }

    app_printf(p, "Total_time taken to alloc: %d Average time: %d\n", total_time, total_time/total_pages);
  2c0156:	48 63 db             	movslq %ebx,%rbx
  2c0159:	4c 89 e8             	mov    %r13,%rax
  2c015c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0161:	48 f7 f3             	div    %rbx
  2c0164:	48 89 c1             	mov    %rax,%rcx
  2c0167:	4c 89 ea             	mov    %r13,%rdx
  2c016a:	be b0 16 2c 00       	mov    $0x2c16b0,%esi
  2c016f:	44 89 e7             	mov    %r12d,%edi
  2c0172:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0177:	e8 37 13 00 00       	callq  2c14b3 <app_printf>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  2c017c:	cd 32                	int    $0x32
  2c017e:	eb fc                	jmp    2c017c <process_main+0x17c>

00000000002c0180 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c0180:	48 89 f9             	mov    %rdi,%rcx
  2c0183:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c0185:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  2c018c:	00 
  2c018d:	72 08                	jb     2c0197 <console_putc+0x17>
        cp->cursor = console;
  2c018f:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  2c0196:	00 
    }
    if (c == '\n') {
  2c0197:	40 80 fe 0a          	cmp    $0xa,%sil
  2c019b:	74 16                	je     2c01b3 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  2c019d:	48 8b 41 08          	mov    0x8(%rcx),%rax
  2c01a1:	48 8d 50 02          	lea    0x2(%rax),%rdx
  2c01a5:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  2c01a9:	40 0f b6 f6          	movzbl %sil,%esi
  2c01ad:	09 fe                	or     %edi,%esi
  2c01af:	66 89 30             	mov    %si,(%rax)
    }
}
  2c01b2:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  2c01b3:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  2c01b7:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  2c01be:	4c 89 c6             	mov    %r8,%rsi
  2c01c1:	48 d1 fe             	sar    %rsi
  2c01c4:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c01cb:	66 66 66 
  2c01ce:	48 89 f0             	mov    %rsi,%rax
  2c01d1:	48 f7 ea             	imul   %rdx
  2c01d4:	48 c1 fa 05          	sar    $0x5,%rdx
  2c01d8:	49 c1 f8 3f          	sar    $0x3f,%r8
  2c01dc:	4c 29 c2             	sub    %r8,%rdx
  2c01df:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  2c01e3:	48 c1 e2 04          	shl    $0x4,%rdx
  2c01e7:	89 f0                	mov    %esi,%eax
  2c01e9:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  2c01eb:	83 cf 20             	or     $0x20,%edi
  2c01ee:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c01f2:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  2c01f6:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  2c01fa:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  2c01fd:	83 c0 01             	add    $0x1,%eax
  2c0200:	83 f8 50             	cmp    $0x50,%eax
  2c0203:	75 e9                	jne    2c01ee <console_putc+0x6e>
  2c0205:	c3                   	retq   

00000000002c0206 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  2c0206:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c020a:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  2c020e:	73 0b                	jae    2c021b <string_putc+0x15>
        *sp->s++ = c;
  2c0210:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0214:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  2c0218:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  2c021b:	c3                   	retq   

00000000002c021c <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  2c021c:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c021f:	48 85 d2             	test   %rdx,%rdx
  2c0222:	74 17                	je     2c023b <memcpy+0x1f>
  2c0224:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  2c0229:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  2c022e:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0232:	48 83 c1 01          	add    $0x1,%rcx
  2c0236:	48 39 d1             	cmp    %rdx,%rcx
  2c0239:	75 ee                	jne    2c0229 <memcpy+0xd>
}
  2c023b:	c3                   	retq   

00000000002c023c <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  2c023c:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  2c023f:	48 39 fe             	cmp    %rdi,%rsi
  2c0242:	72 1d                	jb     2c0261 <memmove+0x25>
        while (n-- > 0) {
  2c0244:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c0249:	48 85 d2             	test   %rdx,%rdx
  2c024c:	74 12                	je     2c0260 <memmove+0x24>
            *d++ = *s++;
  2c024e:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  2c0252:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  2c0256:	48 83 c1 01          	add    $0x1,%rcx
  2c025a:	48 39 ca             	cmp    %rcx,%rdx
  2c025d:	75 ef                	jne    2c024e <memmove+0x12>
}
  2c025f:	c3                   	retq   
  2c0260:	c3                   	retq   
    if (s < d && s + n > d) {
  2c0261:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  2c0265:	48 39 cf             	cmp    %rcx,%rdi
  2c0268:	73 da                	jae    2c0244 <memmove+0x8>
        while (n-- > 0) {
  2c026a:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  2c026e:	48 85 d2             	test   %rdx,%rdx
  2c0271:	74 ec                	je     2c025f <memmove+0x23>
            *--d = *--s;
  2c0273:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  2c0277:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  2c027a:	48 83 e9 01          	sub    $0x1,%rcx
  2c027e:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  2c0282:	75 ef                	jne    2c0273 <memmove+0x37>
  2c0284:	c3                   	retq   

00000000002c0285 <memset>:
void* memset(void* v, int c, size_t n) {
  2c0285:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0288:	48 85 d2             	test   %rdx,%rdx
  2c028b:	74 12                	je     2c029f <memset+0x1a>
  2c028d:	48 01 fa             	add    %rdi,%rdx
  2c0290:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  2c0293:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0296:	48 83 c1 01          	add    $0x1,%rcx
  2c029a:	48 39 ca             	cmp    %rcx,%rdx
  2c029d:	75 f4                	jne    2c0293 <memset+0xe>
}
  2c029f:	c3                   	retq   

00000000002c02a0 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  2c02a0:	80 3f 00             	cmpb   $0x0,(%rdi)
  2c02a3:	74 10                	je     2c02b5 <strlen+0x15>
  2c02a5:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  2c02aa:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  2c02ae:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  2c02b2:	75 f6                	jne    2c02aa <strlen+0xa>
  2c02b4:	c3                   	retq   
  2c02b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c02ba:	c3                   	retq   

00000000002c02bb <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  2c02bb:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c02be:	ba 00 00 00 00       	mov    $0x0,%edx
  2c02c3:	48 85 f6             	test   %rsi,%rsi
  2c02c6:	74 11                	je     2c02d9 <strnlen+0x1e>
  2c02c8:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  2c02cc:	74 0c                	je     2c02da <strnlen+0x1f>
        ++n;
  2c02ce:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c02d2:	48 39 d0             	cmp    %rdx,%rax
  2c02d5:	75 f1                	jne    2c02c8 <strnlen+0xd>
  2c02d7:	eb 04                	jmp    2c02dd <strnlen+0x22>
  2c02d9:	c3                   	retq   
  2c02da:	48 89 d0             	mov    %rdx,%rax
}
  2c02dd:	c3                   	retq   

00000000002c02de <strcpy>:
char* strcpy(char* dst, const char* src) {
  2c02de:	48 89 f8             	mov    %rdi,%rax
  2c02e1:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  2c02e6:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  2c02ea:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  2c02ed:	48 83 c2 01          	add    $0x1,%rdx
  2c02f1:	84 c9                	test   %cl,%cl
  2c02f3:	75 f1                	jne    2c02e6 <strcpy+0x8>
}
  2c02f5:	c3                   	retq   

00000000002c02f6 <strcmp>:
    while (*a && *b && *a == *b) {
  2c02f6:	0f b6 07             	movzbl (%rdi),%eax
  2c02f9:	84 c0                	test   %al,%al
  2c02fb:	74 1a                	je     2c0317 <strcmp+0x21>
  2c02fd:	0f b6 16             	movzbl (%rsi),%edx
  2c0300:	38 c2                	cmp    %al,%dl
  2c0302:	75 13                	jne    2c0317 <strcmp+0x21>
  2c0304:	84 d2                	test   %dl,%dl
  2c0306:	74 0f                	je     2c0317 <strcmp+0x21>
        ++a, ++b;
  2c0308:	48 83 c7 01          	add    $0x1,%rdi
  2c030c:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  2c0310:	0f b6 07             	movzbl (%rdi),%eax
  2c0313:	84 c0                	test   %al,%al
  2c0315:	75 e6                	jne    2c02fd <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  2c0317:	3a 06                	cmp    (%rsi),%al
  2c0319:	0f 97 c0             	seta   %al
  2c031c:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  2c031f:	83 d8 00             	sbb    $0x0,%eax
}
  2c0322:	c3                   	retq   

00000000002c0323 <strchr>:
    while (*s && *s != (char) c) {
  2c0323:	0f b6 07             	movzbl (%rdi),%eax
  2c0326:	84 c0                	test   %al,%al
  2c0328:	74 10                	je     2c033a <strchr+0x17>
  2c032a:	40 38 f0             	cmp    %sil,%al
  2c032d:	74 18                	je     2c0347 <strchr+0x24>
        ++s;
  2c032f:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  2c0333:	0f b6 07             	movzbl (%rdi),%eax
  2c0336:	84 c0                	test   %al,%al
  2c0338:	75 f0                	jne    2c032a <strchr+0x7>
        return NULL;
  2c033a:	40 84 f6             	test   %sil,%sil
  2c033d:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0342:	48 0f 44 c7          	cmove  %rdi,%rax
}
  2c0346:	c3                   	retq   
  2c0347:	48 89 f8             	mov    %rdi,%rax
  2c034a:	c3                   	retq   

00000000002c034b <rand>:
    if (!rand_seed_set) {
  2c034b:	83 3d b2 1c 00 00 00 	cmpl   $0x0,0x1cb2(%rip)        # 2c2004 <rand_seed_set>
  2c0352:	74 1b                	je     2c036f <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0354:	69 05 a2 1c 00 00 0d 	imul   $0x19660d,0x1ca2(%rip),%eax        # 2c2000 <rand_seed>
  2c035b:	66 19 00 
  2c035e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0363:	89 05 97 1c 00 00    	mov    %eax,0x1c97(%rip)        # 2c2000 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0369:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c036e:	c3                   	retq   
    rand_seed = seed;
  2c036f:	c7 05 87 1c 00 00 9e 	movl   $0x30d4879e,0x1c87(%rip)        # 2c2000 <rand_seed>
  2c0376:	87 d4 30 
    rand_seed_set = 1;
  2c0379:	c7 05 81 1c 00 00 01 	movl   $0x1,0x1c81(%rip)        # 2c2004 <rand_seed_set>
  2c0380:	00 00 00 
}
  2c0383:	eb cf                	jmp    2c0354 <rand+0x9>

00000000002c0385 <srand>:
    rand_seed = seed;
  2c0385:	89 3d 75 1c 00 00    	mov    %edi,0x1c75(%rip)        # 2c2000 <rand_seed>
    rand_seed_set = 1;
  2c038b:	c7 05 6f 1c 00 00 01 	movl   $0x1,0x1c6f(%rip)        # 2c2004 <rand_seed_set>
  2c0392:	00 00 00 
}
  2c0395:	c3                   	retq   

00000000002c0396 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0396:	55                   	push   %rbp
  2c0397:	48 89 e5             	mov    %rsp,%rbp
  2c039a:	41 57                	push   %r15
  2c039c:	41 56                	push   %r14
  2c039e:	41 55                	push   %r13
  2c03a0:	41 54                	push   %r12
  2c03a2:	53                   	push   %rbx
  2c03a3:	48 83 ec 58          	sub    $0x58,%rsp
  2c03a7:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  2c03ab:	0f b6 02             	movzbl (%rdx),%eax
  2c03ae:	84 c0                	test   %al,%al
  2c03b0:	0f 84 b0 06 00 00    	je     2c0a66 <printer_vprintf+0x6d0>
  2c03b6:	49 89 fe             	mov    %rdi,%r14
  2c03b9:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  2c03bc:	41 89 f7             	mov    %esi,%r15d
  2c03bf:	e9 a4 04 00 00       	jmpq   2c0868 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  2c03c4:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  2c03c9:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  2c03cf:	45 84 e4             	test   %r12b,%r12b
  2c03d2:	0f 84 82 06 00 00    	je     2c0a5a <printer_vprintf+0x6c4>
        int flags = 0;
  2c03d8:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  2c03de:	41 0f be f4          	movsbl %r12b,%esi
  2c03e2:	bf e1 18 2c 00       	mov    $0x2c18e1,%edi
  2c03e7:	e8 37 ff ff ff       	callq  2c0323 <strchr>
  2c03ec:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  2c03ef:	48 85 c0             	test   %rax,%rax
  2c03f2:	74 55                	je     2c0449 <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  2c03f4:	48 81 e9 e1 18 2c 00 	sub    $0x2c18e1,%rcx
  2c03fb:	b8 01 00 00 00       	mov    $0x1,%eax
  2c0400:	d3 e0                	shl    %cl,%eax
  2c0402:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  2c0405:	48 83 c3 01          	add    $0x1,%rbx
  2c0409:	44 0f b6 23          	movzbl (%rbx),%r12d
  2c040d:	45 84 e4             	test   %r12b,%r12b
  2c0410:	75 cc                	jne    2c03de <printer_vprintf+0x48>
  2c0412:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  2c0416:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  2c041c:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  2c0423:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  2c0426:	0f 84 a9 00 00 00    	je     2c04d5 <printer_vprintf+0x13f>
        int length = 0;
  2c042c:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  2c0431:	0f b6 13             	movzbl (%rbx),%edx
  2c0434:	8d 42 bd             	lea    -0x43(%rdx),%eax
  2c0437:	3c 37                	cmp    $0x37,%al
  2c0439:	0f 87 c4 04 00 00    	ja     2c0903 <printer_vprintf+0x56d>
  2c043f:	0f b6 c0             	movzbl %al,%eax
  2c0442:	ff 24 c5 f0 16 2c 00 	jmpq   *0x2c16f0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  2c0449:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  2c044d:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  2c0452:	3c 08                	cmp    $0x8,%al
  2c0454:	77 2f                	ja     2c0485 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0456:	0f b6 03             	movzbl (%rbx),%eax
  2c0459:	8d 50 d0             	lea    -0x30(%rax),%edx
  2c045c:	80 fa 09             	cmp    $0x9,%dl
  2c045f:	77 5e                	ja     2c04bf <printer_vprintf+0x129>
  2c0461:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  2c0467:	48 83 c3 01          	add    $0x1,%rbx
  2c046b:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  2c0470:	0f be c0             	movsbl %al,%eax
  2c0473:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0478:	0f b6 03             	movzbl (%rbx),%eax
  2c047b:	8d 50 d0             	lea    -0x30(%rax),%edx
  2c047e:	80 fa 09             	cmp    $0x9,%dl
  2c0481:	76 e4                	jbe    2c0467 <printer_vprintf+0xd1>
  2c0483:	eb 97                	jmp    2c041c <printer_vprintf+0x86>
        } else if (*format == '*') {
  2c0485:	41 80 fc 2a          	cmp    $0x2a,%r12b
  2c0489:	75 3f                	jne    2c04ca <printer_vprintf+0x134>
            width = va_arg(val, int);
  2c048b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c048f:	8b 07                	mov    (%rdi),%eax
  2c0491:	83 f8 2f             	cmp    $0x2f,%eax
  2c0494:	77 17                	ja     2c04ad <printer_vprintf+0x117>
  2c0496:	89 c2                	mov    %eax,%edx
  2c0498:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c049c:	83 c0 08             	add    $0x8,%eax
  2c049f:	89 07                	mov    %eax,(%rdi)
  2c04a1:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  2c04a4:	48 83 c3 01          	add    $0x1,%rbx
  2c04a8:	e9 6f ff ff ff       	jmpq   2c041c <printer_vprintf+0x86>
            width = va_arg(val, int);
  2c04ad:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c04b1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c04b5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c04b9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c04bd:	eb e2                	jmp    2c04a1 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c04bf:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  2c04c5:	e9 52 ff ff ff       	jmpq   2c041c <printer_vprintf+0x86>
        int width = -1;
  2c04ca:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  2c04d0:	e9 47 ff ff ff       	jmpq   2c041c <printer_vprintf+0x86>
            ++format;
  2c04d5:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  2c04d9:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  2c04dd:	8d 48 d0             	lea    -0x30(%rax),%ecx
  2c04e0:	80 f9 09             	cmp    $0x9,%cl
  2c04e3:	76 13                	jbe    2c04f8 <printer_vprintf+0x162>
            } else if (*format == '*') {
  2c04e5:	3c 2a                	cmp    $0x2a,%al
  2c04e7:	74 33                	je     2c051c <printer_vprintf+0x186>
            ++format;
  2c04e9:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  2c04ec:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  2c04f3:	e9 34 ff ff ff       	jmpq   2c042c <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c04f8:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  2c04fd:	48 83 c2 01          	add    $0x1,%rdx
  2c0501:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  2c0504:	0f be c0             	movsbl %al,%eax
  2c0507:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c050b:	0f b6 02             	movzbl (%rdx),%eax
  2c050e:	8d 70 d0             	lea    -0x30(%rax),%esi
  2c0511:	40 80 fe 09          	cmp    $0x9,%sil
  2c0515:	76 e6                	jbe    2c04fd <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  2c0517:	48 89 d3             	mov    %rdx,%rbx
  2c051a:	eb 1c                	jmp    2c0538 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  2c051c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0520:	8b 07                	mov    (%rdi),%eax
  2c0522:	83 f8 2f             	cmp    $0x2f,%eax
  2c0525:	77 23                	ja     2c054a <printer_vprintf+0x1b4>
  2c0527:	89 c2                	mov    %eax,%edx
  2c0529:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c052d:	83 c0 08             	add    $0x8,%eax
  2c0530:	89 07                	mov    %eax,(%rdi)
  2c0532:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  2c0534:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  2c0538:	85 c9                	test   %ecx,%ecx
  2c053a:	b8 00 00 00 00       	mov    $0x0,%eax
  2c053f:	0f 49 c1             	cmovns %ecx,%eax
  2c0542:	89 45 9c             	mov    %eax,-0x64(%rbp)
  2c0545:	e9 e2 fe ff ff       	jmpq   2c042c <printer_vprintf+0x96>
                precision = va_arg(val, int);
  2c054a:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c054e:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0552:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c0556:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c055a:	eb d6                	jmp    2c0532 <printer_vprintf+0x19c>
        switch (*format) {
  2c055c:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  2c0561:	e9 f3 00 00 00       	jmpq   2c0659 <printer_vprintf+0x2c3>
            ++format;
  2c0566:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  2c056a:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  2c056f:	e9 bd fe ff ff       	jmpq   2c0431 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0574:	85 c9                	test   %ecx,%ecx
  2c0576:	74 55                	je     2c05cd <printer_vprintf+0x237>
  2c0578:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c057c:	8b 07                	mov    (%rdi),%eax
  2c057e:	83 f8 2f             	cmp    $0x2f,%eax
  2c0581:	77 38                	ja     2c05bb <printer_vprintf+0x225>
  2c0583:	89 c2                	mov    %eax,%edx
  2c0585:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c0589:	83 c0 08             	add    $0x8,%eax
  2c058c:	89 07                	mov    %eax,(%rdi)
  2c058e:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0591:	48 89 d0             	mov    %rdx,%rax
  2c0594:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  2c0598:	49 89 d0             	mov    %rdx,%r8
  2c059b:	49 f7 d8             	neg    %r8
  2c059e:	25 80 00 00 00       	and    $0x80,%eax
  2c05a3:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c05a7:	0b 45 a8             	or     -0x58(%rbp),%eax
  2c05aa:	83 c8 60             	or     $0x60,%eax
  2c05ad:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  2c05b0:	41 bc 7d 16 2c 00    	mov    $0x2c167d,%r12d
            break;
  2c05b6:	e9 35 01 00 00       	jmpq   2c06f0 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c05bb:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c05bf:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c05c3:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c05c7:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c05cb:	eb c1                	jmp    2c058e <printer_vprintf+0x1f8>
  2c05cd:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c05d1:	8b 07                	mov    (%rdi),%eax
  2c05d3:	83 f8 2f             	cmp    $0x2f,%eax
  2c05d6:	77 10                	ja     2c05e8 <printer_vprintf+0x252>
  2c05d8:	89 c2                	mov    %eax,%edx
  2c05da:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c05de:	83 c0 08             	add    $0x8,%eax
  2c05e1:	89 07                	mov    %eax,(%rdi)
  2c05e3:	48 63 12             	movslq (%rdx),%rdx
  2c05e6:	eb a9                	jmp    2c0591 <printer_vprintf+0x1fb>
  2c05e8:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c05ec:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c05f0:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c05f4:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c05f8:	eb e9                	jmp    2c05e3 <printer_vprintf+0x24d>
        int base = 10;
  2c05fa:	be 0a 00 00 00       	mov    $0xa,%esi
  2c05ff:	eb 58                	jmp    2c0659 <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0601:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0605:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0609:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c060d:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c0611:	eb 60                	jmp    2c0673 <printer_vprintf+0x2dd>
  2c0613:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0617:	8b 07                	mov    (%rdi),%eax
  2c0619:	83 f8 2f             	cmp    $0x2f,%eax
  2c061c:	77 10                	ja     2c062e <printer_vprintf+0x298>
  2c061e:	89 c2                	mov    %eax,%edx
  2c0620:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c0624:	83 c0 08             	add    $0x8,%eax
  2c0627:	89 07                	mov    %eax,(%rdi)
  2c0629:	44 8b 02             	mov    (%rdx),%r8d
  2c062c:	eb 48                	jmp    2c0676 <printer_vprintf+0x2e0>
  2c062e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0632:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0636:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c063a:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c063e:	eb e9                	jmp    2c0629 <printer_vprintf+0x293>
  2c0640:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  2c0643:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  2c064a:	bf d0 18 2c 00       	mov    $0x2c18d0,%edi
  2c064f:	e9 e2 02 00 00       	jmpq   2c0936 <printer_vprintf+0x5a0>
            base = 16;
  2c0654:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0659:	85 c9                	test   %ecx,%ecx
  2c065b:	74 b6                	je     2c0613 <printer_vprintf+0x27d>
  2c065d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0661:	8b 01                	mov    (%rcx),%eax
  2c0663:	83 f8 2f             	cmp    $0x2f,%eax
  2c0666:	77 99                	ja     2c0601 <printer_vprintf+0x26b>
  2c0668:	89 c2                	mov    %eax,%edx
  2c066a:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c066e:	83 c0 08             	add    $0x8,%eax
  2c0671:	89 01                	mov    %eax,(%rcx)
  2c0673:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  2c0676:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  2c067a:	85 f6                	test   %esi,%esi
  2c067c:	79 c2                	jns    2c0640 <printer_vprintf+0x2aa>
        base = -base;
  2c067e:	41 89 f1             	mov    %esi,%r9d
  2c0681:	f7 de                	neg    %esi
  2c0683:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  2c068a:	bf b0 18 2c 00       	mov    $0x2c18b0,%edi
  2c068f:	e9 a2 02 00 00       	jmpq   2c0936 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  2c0694:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0698:	8b 07                	mov    (%rdi),%eax
  2c069a:	83 f8 2f             	cmp    $0x2f,%eax
  2c069d:	77 1c                	ja     2c06bb <printer_vprintf+0x325>
  2c069f:	89 c2                	mov    %eax,%edx
  2c06a1:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c06a5:	83 c0 08             	add    $0x8,%eax
  2c06a8:	89 07                	mov    %eax,(%rdi)
  2c06aa:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c06ad:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  2c06b4:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  2c06b9:	eb c3                	jmp    2c067e <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  2c06bb:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c06bf:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c06c3:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c06c7:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c06cb:	eb dd                	jmp    2c06aa <printer_vprintf+0x314>
            data = va_arg(val, char*);
  2c06cd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c06d1:	8b 01                	mov    (%rcx),%eax
  2c06d3:	83 f8 2f             	cmp    $0x2f,%eax
  2c06d6:	0f 87 a5 01 00 00    	ja     2c0881 <printer_vprintf+0x4eb>
  2c06dc:	89 c2                	mov    %eax,%edx
  2c06de:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c06e2:	83 c0 08             	add    $0x8,%eax
  2c06e5:	89 01                	mov    %eax,(%rcx)
  2c06e7:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  2c06ea:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  2c06f0:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c06f3:	83 e0 20             	and    $0x20,%eax
  2c06f6:	89 45 8c             	mov    %eax,-0x74(%rbp)
  2c06f9:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  2c06ff:	0f 85 21 02 00 00    	jne    2c0926 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c0705:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c0708:	89 45 88             	mov    %eax,-0x78(%rbp)
  2c070b:	83 e0 60             	and    $0x60,%eax
  2c070e:	83 f8 60             	cmp    $0x60,%eax
  2c0711:	0f 84 54 02 00 00    	je     2c096b <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c0717:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c071a:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  2c071d:	48 c7 45 a0 7d 16 2c 	movq   $0x2c167d,-0x60(%rbp)
  2c0724:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c0725:	83 f8 21             	cmp    $0x21,%eax
  2c0728:	0f 84 79 02 00 00    	je     2c09a7 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c072e:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  2c0731:	89 f8                	mov    %edi,%eax
  2c0733:	f7 d0                	not    %eax
  2c0735:	c1 e8 1f             	shr    $0x1f,%eax
  2c0738:	89 45 84             	mov    %eax,-0x7c(%rbp)
  2c073b:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  2c073f:	0f 85 9e 02 00 00    	jne    2c09e3 <printer_vprintf+0x64d>
  2c0745:	84 c0                	test   %al,%al
  2c0747:	0f 84 96 02 00 00    	je     2c09e3 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  2c074d:	48 63 f7             	movslq %edi,%rsi
  2c0750:	4c 89 e7             	mov    %r12,%rdi
  2c0753:	e8 63 fb ff ff       	callq  2c02bb <strnlen>
  2c0758:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c075b:	8b 45 88             	mov    -0x78(%rbp),%eax
  2c075e:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  2c0761:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c0768:	83 f8 22             	cmp    $0x22,%eax
  2c076b:	0f 84 aa 02 00 00    	je     2c0a1b <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  2c0771:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  2c0775:	e8 26 fb ff ff       	callq  2c02a0 <strlen>
  2c077a:	8b 55 9c             	mov    -0x64(%rbp),%edx
  2c077d:	03 55 98             	add    -0x68(%rbp),%edx
  2c0780:	44 89 e9             	mov    %r13d,%ecx
  2c0783:	29 d1                	sub    %edx,%ecx
  2c0785:	29 c1                	sub    %eax,%ecx
  2c0787:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  2c078a:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c078d:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  2c0791:	75 2d                	jne    2c07c0 <printer_vprintf+0x42a>
  2c0793:	85 c9                	test   %ecx,%ecx
  2c0795:	7e 29                	jle    2c07c0 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  2c0797:	44 89 fa             	mov    %r15d,%edx
  2c079a:	be 20 00 00 00       	mov    $0x20,%esi
  2c079f:	4c 89 f7             	mov    %r14,%rdi
  2c07a2:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c07a5:	41 83 ed 01          	sub    $0x1,%r13d
  2c07a9:	45 85 ed             	test   %r13d,%r13d
  2c07ac:	7f e9                	jg     2c0797 <printer_vprintf+0x401>
  2c07ae:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  2c07b1:	85 ff                	test   %edi,%edi
  2c07b3:	b8 01 00 00 00       	mov    $0x1,%eax
  2c07b8:	0f 4f c7             	cmovg  %edi,%eax
  2c07bb:	29 c7                	sub    %eax,%edi
  2c07bd:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  2c07c0:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  2c07c4:	0f b6 07             	movzbl (%rdi),%eax
  2c07c7:	84 c0                	test   %al,%al
  2c07c9:	74 22                	je     2c07ed <printer_vprintf+0x457>
  2c07cb:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c07cf:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  2c07d2:	0f b6 f0             	movzbl %al,%esi
  2c07d5:	44 89 fa             	mov    %r15d,%edx
  2c07d8:	4c 89 f7             	mov    %r14,%rdi
  2c07db:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  2c07de:	48 83 c3 01          	add    $0x1,%rbx
  2c07e2:	0f b6 03             	movzbl (%rbx),%eax
  2c07e5:	84 c0                	test   %al,%al
  2c07e7:	75 e9                	jne    2c07d2 <printer_vprintf+0x43c>
  2c07e9:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  2c07ed:	8b 45 9c             	mov    -0x64(%rbp),%eax
  2c07f0:	85 c0                	test   %eax,%eax
  2c07f2:	7e 1d                	jle    2c0811 <printer_vprintf+0x47b>
  2c07f4:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c07f8:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  2c07fa:	44 89 fa             	mov    %r15d,%edx
  2c07fd:	be 30 00 00 00       	mov    $0x30,%esi
  2c0802:	4c 89 f7             	mov    %r14,%rdi
  2c0805:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  2c0808:	83 eb 01             	sub    $0x1,%ebx
  2c080b:	75 ed                	jne    2c07fa <printer_vprintf+0x464>
  2c080d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  2c0811:	8b 45 98             	mov    -0x68(%rbp),%eax
  2c0814:	85 c0                	test   %eax,%eax
  2c0816:	7e 27                	jle    2c083f <printer_vprintf+0x4a9>
  2c0818:	89 c0                	mov    %eax,%eax
  2c081a:	4c 01 e0             	add    %r12,%rax
  2c081d:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c0821:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  2c0824:	41 0f b6 34 24       	movzbl (%r12),%esi
  2c0829:	44 89 fa             	mov    %r15d,%edx
  2c082c:	4c 89 f7             	mov    %r14,%rdi
  2c082f:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  2c0832:	49 83 c4 01          	add    $0x1,%r12
  2c0836:	49 39 dc             	cmp    %rbx,%r12
  2c0839:	75 e9                	jne    2c0824 <printer_vprintf+0x48e>
  2c083b:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  2c083f:	45 85 ed             	test   %r13d,%r13d
  2c0842:	7e 14                	jle    2c0858 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  2c0844:	44 89 fa             	mov    %r15d,%edx
  2c0847:	be 20 00 00 00       	mov    $0x20,%esi
  2c084c:	4c 89 f7             	mov    %r14,%rdi
  2c084f:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  2c0852:	41 83 ed 01          	sub    $0x1,%r13d
  2c0856:	75 ec                	jne    2c0844 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  2c0858:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  2c085c:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  2c0860:	84 c0                	test   %al,%al
  2c0862:	0f 84 fe 01 00 00    	je     2c0a66 <printer_vprintf+0x6d0>
        if (*format != '%') {
  2c0868:	3c 25                	cmp    $0x25,%al
  2c086a:	0f 84 54 fb ff ff    	je     2c03c4 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  2c0870:	0f b6 f0             	movzbl %al,%esi
  2c0873:	44 89 fa             	mov    %r15d,%edx
  2c0876:	4c 89 f7             	mov    %r14,%rdi
  2c0879:	41 ff 16             	callq  *(%r14)
            continue;
  2c087c:	4c 89 e3             	mov    %r12,%rbx
  2c087f:	eb d7                	jmp    2c0858 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  2c0881:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0885:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c0889:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c088d:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c0891:	e9 51 fe ff ff       	jmpq   2c06e7 <printer_vprintf+0x351>
            color = va_arg(val, int);
  2c0896:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c089a:	8b 07                	mov    (%rdi),%eax
  2c089c:	83 f8 2f             	cmp    $0x2f,%eax
  2c089f:	77 10                	ja     2c08b1 <printer_vprintf+0x51b>
  2c08a1:	89 c2                	mov    %eax,%edx
  2c08a3:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c08a7:	83 c0 08             	add    $0x8,%eax
  2c08aa:	89 07                	mov    %eax,(%rdi)
  2c08ac:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  2c08af:	eb a7                	jmp    2c0858 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  2c08b1:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c08b5:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c08b9:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c08bd:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c08c1:	eb e9                	jmp    2c08ac <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  2c08c3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c08c7:	8b 01                	mov    (%rcx),%eax
  2c08c9:	83 f8 2f             	cmp    $0x2f,%eax
  2c08cc:	77 23                	ja     2c08f1 <printer_vprintf+0x55b>
  2c08ce:	89 c2                	mov    %eax,%edx
  2c08d0:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c08d4:	83 c0 08             	add    $0x8,%eax
  2c08d7:	89 01                	mov    %eax,(%rcx)
  2c08d9:	8b 02                	mov    (%rdx),%eax
  2c08db:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  2c08de:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  2c08e2:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c08e6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  2c08ec:	e9 ff fd ff ff       	jmpq   2c06f0 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  2c08f1:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c08f5:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c08f9:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c08fd:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c0901:	eb d6                	jmp    2c08d9 <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  2c0903:	84 d2                	test   %dl,%dl
  2c0905:	0f 85 39 01 00 00    	jne    2c0a44 <printer_vprintf+0x6ae>
  2c090b:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  2c090f:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  2c0913:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  2c0917:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c091b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  2c0921:	e9 ca fd ff ff       	jmpq   2c06f0 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  2c0926:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  2c092c:	bf d0 18 2c 00       	mov    $0x2c18d0,%edi
        if (flags & FLAG_NUMERIC) {
  2c0931:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  2c0936:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  2c093a:	4c 89 c1             	mov    %r8,%rcx
  2c093d:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  2c0941:	48 63 f6             	movslq %esi,%rsi
  2c0944:	49 83 ec 01          	sub    $0x1,%r12
  2c0948:	48 89 c8             	mov    %rcx,%rax
  2c094b:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0950:	48 f7 f6             	div    %rsi
  2c0953:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  2c0957:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  2c095b:	48 89 ca             	mov    %rcx,%rdx
  2c095e:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  2c0961:	48 39 d6             	cmp    %rdx,%rsi
  2c0964:	76 de                	jbe    2c0944 <printer_vprintf+0x5ae>
  2c0966:	e9 9a fd ff ff       	jmpq   2c0705 <printer_vprintf+0x36f>
                prefix = "-";
  2c096b:	48 c7 45 a0 e5 16 2c 	movq   $0x2c16e5,-0x60(%rbp)
  2c0972:	00 
            if (flags & FLAG_NEGATIVE) {
  2c0973:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c0976:	a8 80                	test   $0x80,%al
  2c0978:	0f 85 b0 fd ff ff    	jne    2c072e <printer_vprintf+0x398>
                prefix = "+";
  2c097e:	48 c7 45 a0 e0 16 2c 	movq   $0x2c16e0,-0x60(%rbp)
  2c0985:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c0986:	a8 10                	test   $0x10,%al
  2c0988:	0f 85 a0 fd ff ff    	jne    2c072e <printer_vprintf+0x398>
                prefix = " ";
  2c098e:	a8 08                	test   $0x8,%al
  2c0990:	ba 7d 16 2c 00       	mov    $0x2c167d,%edx
  2c0995:	b8 ed 18 2c 00       	mov    $0x2c18ed,%eax
  2c099a:	48 0f 44 c2          	cmove  %rdx,%rax
  2c099e:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  2c09a2:	e9 87 fd ff ff       	jmpq   2c072e <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  2c09a7:	41 8d 41 10          	lea    0x10(%r9),%eax
  2c09ab:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  2c09b0:	0f 85 78 fd ff ff    	jne    2c072e <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  2c09b6:	4d 85 c0             	test   %r8,%r8
  2c09b9:	75 0d                	jne    2c09c8 <printer_vprintf+0x632>
  2c09bb:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  2c09c2:	0f 84 66 fd ff ff    	je     2c072e <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  2c09c8:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  2c09cc:	ba e7 16 2c 00       	mov    $0x2c16e7,%edx
  2c09d1:	b8 e2 16 2c 00       	mov    $0x2c16e2,%eax
  2c09d6:	48 0f 44 c2          	cmove  %rdx,%rax
  2c09da:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  2c09de:	e9 4b fd ff ff       	jmpq   2c072e <printer_vprintf+0x398>
            len = strlen(data);
  2c09e3:	4c 89 e7             	mov    %r12,%rdi
  2c09e6:	e8 b5 f8 ff ff       	callq  2c02a0 <strlen>
  2c09eb:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c09ee:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  2c09f2:	0f 84 63 fd ff ff    	je     2c075b <printer_vprintf+0x3c5>
  2c09f8:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  2c09fc:	0f 84 59 fd ff ff    	je     2c075b <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  2c0a02:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  2c0a05:	89 ca                	mov    %ecx,%edx
  2c0a07:	29 c2                	sub    %eax,%edx
  2c0a09:	39 c1                	cmp    %eax,%ecx
  2c0a0b:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a10:	0f 4e d0             	cmovle %eax,%edx
  2c0a13:	89 55 9c             	mov    %edx,-0x64(%rbp)
  2c0a16:	e9 56 fd ff ff       	jmpq   2c0771 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  2c0a1b:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  2c0a1f:	e8 7c f8 ff ff       	callq  2c02a0 <strlen>
  2c0a24:	8b 7d 98             	mov    -0x68(%rbp),%edi
  2c0a27:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  2c0a2a:	44 89 e9             	mov    %r13d,%ecx
  2c0a2d:	29 f9                	sub    %edi,%ecx
  2c0a2f:	29 c1                	sub    %eax,%ecx
  2c0a31:	44 39 ea             	cmp    %r13d,%edx
  2c0a34:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a39:	0f 4d c8             	cmovge %eax,%ecx
  2c0a3c:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  2c0a3f:	e9 2d fd ff ff       	jmpq   2c0771 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  2c0a44:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  2c0a47:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  2c0a4b:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c0a4f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  2c0a55:	e9 96 fc ff ff       	jmpq   2c06f0 <printer_vprintf+0x35a>
        int flags = 0;
  2c0a5a:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  2c0a61:	e9 b0 f9 ff ff       	jmpq   2c0416 <printer_vprintf+0x80>
}
  2c0a66:	48 83 c4 58          	add    $0x58,%rsp
  2c0a6a:	5b                   	pop    %rbx
  2c0a6b:	41 5c                	pop    %r12
  2c0a6d:	41 5d                	pop    %r13
  2c0a6f:	41 5e                	pop    %r14
  2c0a71:	41 5f                	pop    %r15
  2c0a73:	5d                   	pop    %rbp
  2c0a74:	c3                   	retq   

00000000002c0a75 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c0a75:	55                   	push   %rbp
  2c0a76:	48 89 e5             	mov    %rsp,%rbp
  2c0a79:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  2c0a7d:	48 c7 45 f0 80 01 2c 	movq   $0x2c0180,-0x10(%rbp)
  2c0a84:	00 
        cpos = 0;
  2c0a85:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  2c0a8b:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a90:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  2c0a93:	48 63 ff             	movslq %edi,%rdi
  2c0a96:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  2c0a9d:	00 
  2c0a9e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c0aa2:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  2c0aa6:	e8 eb f8 ff ff       	callq  2c0396 <printer_vprintf>
    return cp.cursor - console;
  2c0aab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0aaf:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c0ab5:	48 d1 f8             	sar    %rax
}
  2c0ab8:	c9                   	leaveq 
  2c0ab9:	c3                   	retq   

00000000002c0aba <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  2c0aba:	55                   	push   %rbp
  2c0abb:	48 89 e5             	mov    %rsp,%rbp
  2c0abe:	48 83 ec 50          	sub    $0x50,%rsp
  2c0ac2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0ac6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0aca:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  2c0ace:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c0ad5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c0ad9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0add:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c0ae1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c0ae5:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c0ae9:	e8 87 ff ff ff       	callq  2c0a75 <console_vprintf>
}
  2c0aee:	c9                   	leaveq 
  2c0aef:	c3                   	retq   

00000000002c0af0 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c0af0:	55                   	push   %rbp
  2c0af1:	48 89 e5             	mov    %rsp,%rbp
  2c0af4:	53                   	push   %rbx
  2c0af5:	48 83 ec 28          	sub    $0x28,%rsp
  2c0af9:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  2c0afc:	48 c7 45 d8 06 02 2c 	movq   $0x2c0206,-0x28(%rbp)
  2c0b03:	00 
    sp.s = s;
  2c0b04:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  2c0b08:	48 85 f6             	test   %rsi,%rsi
  2c0b0b:	75 0b                	jne    2c0b18 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  2c0b0d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c0b10:	29 d8                	sub    %ebx,%eax
}
  2c0b12:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0b16:	c9                   	leaveq 
  2c0b17:	c3                   	retq   
        sp.end = s + size - 1;
  2c0b18:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  2c0b1d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c0b21:	be 00 00 00 00       	mov    $0x0,%esi
  2c0b26:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  2c0b2a:	e8 67 f8 ff ff       	callq  2c0396 <printer_vprintf>
        *sp.s = 0;
  2c0b2f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0b33:	c6 00 00             	movb   $0x0,(%rax)
  2c0b36:	eb d5                	jmp    2c0b0d <vsnprintf+0x1d>

00000000002c0b38 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c0b38:	55                   	push   %rbp
  2c0b39:	48 89 e5             	mov    %rsp,%rbp
  2c0b3c:	48 83 ec 50          	sub    $0x50,%rsp
  2c0b40:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0b44:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0b48:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c0b4c:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c0b53:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c0b57:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0b5b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c0b5f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c0b63:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c0b67:	e8 84 ff ff ff       	callq  2c0af0 <vsnprintf>
    va_end(val);
    return n;
}
  2c0b6c:	c9                   	leaveq 
  2c0b6d:	c3                   	retq   

00000000002c0b6e <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c0b6e:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  2c0b73:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  2c0b78:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c0b7d:	48 83 c0 02          	add    $0x2,%rax
  2c0b81:	48 39 d0             	cmp    %rdx,%rax
  2c0b84:	75 f2                	jne    2c0b78 <console_clear+0xa>
    }
    cursorpos = 0;
  2c0b86:	c7 05 6c 84 df ff 00 	movl   $0x0,-0x207b94(%rip)        # b8ffc <cursorpos>
  2c0b8d:	00 00 00 
}
  2c0b90:	c3                   	retq   

00000000002c0b91 <compare>:

int compare( const void * a, const void * b){
    ptr_with_size * a_ptr = (ptr_with_size *) a;
    ptr_with_size * b_ptr = (ptr_with_size *) b;

    return (int)b_ptr->size - (int)a_ptr->size;
  2c0b91:	48 8b 46 08          	mov    0x8(%rsi),%rax
  2c0b95:	2b 47 08             	sub    0x8(%rdi),%eax
}
  2c0b98:	c3                   	retq   

00000000002c0b99 <quicksort>:
typedef int (*__compar_fn_t) (const void *, const void *);

void
quicksort (void *const pbase, size_t total_elems, size_t size,
            __compar_fn_t cmp)
{
  2c0b99:	55                   	push   %rbp
  2c0b9a:	48 89 e5             	mov    %rsp,%rbp
  2c0b9d:	41 57                	push   %r15
  2c0b9f:	41 56                	push   %r14
  2c0ba1:	41 55                	push   %r13
  2c0ba3:	41 54                	push   %r12
  2c0ba5:	53                   	push   %rbx
  2c0ba6:	48 81 ec 48 04 00 00 	sub    $0x448,%rsp
  2c0bad:	48 89 bd a0 fb ff ff 	mov    %rdi,-0x460(%rbp)
  2c0bb4:	48 89 b5 98 fb ff ff 	mov    %rsi,-0x468(%rbp)
  2c0bbb:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
    char *base_ptr = (char *) pbase;
    const size_t max_thresh = MAX_THRESH * size;
    if (total_elems == 0)
  2c0bc2:	48 85 f6             	test   %rsi,%rsi
  2c0bc5:	0f 84 94 03 00 00    	je     2c0f5f <quicksort+0x3c6>
  2c0bcb:	48 89 f0             	mov    %rsi,%rax
  2c0bce:	48 89 cb             	mov    %rcx,%rbx
    const size_t max_thresh = MAX_THRESH * size;
  2c0bd1:	48 8d 0c 95 00 00 00 	lea    0x0(,%rdx,4),%rcx
  2c0bd8:	00 
  2c0bd9:	48 89 8d a8 fb ff ff 	mov    %rcx,-0x458(%rbp)
	/* Avoid lossage with unsigned arithmetic below.  */
	return;
    if (total_elems > MAX_THRESH)
  2c0be0:	48 83 fe 04          	cmp    $0x4,%rsi
  2c0be4:	0f 86 bd 02 00 00    	jbe    2c0ea7 <quicksort+0x30e>
    {
	char *lo = base_ptr;
	char *hi = &lo[size * (total_elems - 1)];
  2c0bea:	48 83 e8 01          	sub    $0x1,%rax
  2c0bee:	48 0f af c2          	imul   %rdx,%rax
  2c0bf2:	48 01 f8             	add    %rdi,%rax
  2c0bf5:	48 89 85 c0 fb ff ff 	mov    %rax,-0x440(%rbp)
	stack_node stack[STACK_SIZE];
	stack_node *top = stack;
	PUSH (NULL, NULL);
  2c0bfc:	48 c7 85 d0 fb ff ff 	movq   $0x0,-0x430(%rbp)
  2c0c03:	00 00 00 00 
  2c0c07:	48 c7 85 d8 fb ff ff 	movq   $0x0,-0x428(%rbp)
  2c0c0e:	00 00 00 00 
	char *lo = base_ptr;
  2c0c12:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
	PUSH (NULL, NULL);
  2c0c19:	48 8d 85 e0 fb ff ff 	lea    -0x420(%rbp),%rax
  2c0c20:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
		goto jump_over;
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
		SWAP (mid, lo, size);
jump_over:;
	  left_ptr  = lo + size;
	  right_ptr = hi - size;
  2c0c27:	48 f7 da             	neg    %rdx
  2c0c2a:	49 89 d7             	mov    %rdx,%r15
  2c0c2d:	e9 8c 01 00 00       	jmpq   2c0dbe <quicksort+0x225>
  2c0c32:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0c39:	49 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%rdi
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c0c3e:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  2c0c45:	4c 89 e8             	mov    %r13,%rax
  2c0c48:	0f b6 08             	movzbl (%rax),%ecx
  2c0c4b:	48 83 c0 01          	add    $0x1,%rax
  2c0c4f:	0f b6 32             	movzbl (%rdx),%esi
  2c0c52:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c0c56:	48 83 c2 01          	add    $0x1,%rdx
  2c0c5a:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c0c5d:	48 39 c7             	cmp    %rax,%rdi
  2c0c60:	75 e6                	jne    2c0c48 <quicksort+0xaf>
  2c0c62:	e9 92 01 00 00       	jmpq   2c0df9 <quicksort+0x260>
  2c0c67:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0c6e:	4d 8d 64 05 00       	lea    0x0(%r13,%rax,1),%r12
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  2c0c73:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
		SWAP (mid, hi, size);
  2c0c7a:	4c 89 e8             	mov    %r13,%rax
  2c0c7d:	0f b6 08             	movzbl (%rax),%ecx
  2c0c80:	48 83 c0 01          	add    $0x1,%rax
  2c0c84:	0f b6 32             	movzbl (%rdx),%esi
  2c0c87:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c0c8b:	48 83 c2 01          	add    $0x1,%rdx
  2c0c8f:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c0c92:	49 39 c4             	cmp    %rax,%r12
  2c0c95:	75 e6                	jne    2c0c7d <quicksort+0xe4>
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c0c97:	48 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%rsi
  2c0c9e:	4c 89 ef             	mov    %r13,%rdi
  2c0ca1:	ff d3                	callq  *%rbx
  2c0ca3:	85 c0                	test   %eax,%eax
  2c0ca5:	0f 89 62 01 00 00    	jns    2c0e0d <quicksort+0x274>
  2c0cab:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  2c0cb2:	4c 89 e8             	mov    %r13,%rax
  2c0cb5:	0f b6 08             	movzbl (%rax),%ecx
  2c0cb8:	48 83 c0 01          	add    $0x1,%rax
  2c0cbc:	0f b6 32             	movzbl (%rdx),%esi
  2c0cbf:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c0cc3:	48 83 c2 01          	add    $0x1,%rdx
  2c0cc7:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c0cca:	49 39 c4             	cmp    %rax,%r12
  2c0ccd:	75 e6                	jne    2c0cb5 <quicksort+0x11c>
jump_over:;
  2c0ccf:	e9 39 01 00 00       	jmpq   2c0e0d <quicksort+0x274>
	  do
	  {
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
		  left_ptr += size;
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
		  right_ptr -= size;
  2c0cd4:	4d 01 fc             	add    %r15,%r12
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
  2c0cd7:	4c 89 e6             	mov    %r12,%rsi
  2c0cda:	4c 89 ef             	mov    %r13,%rdi
  2c0cdd:	ff d3                	callq  *%rbx
  2c0cdf:	85 c0                	test   %eax,%eax
  2c0ce1:	78 f1                	js     2c0cd4 <quicksort+0x13b>
	      if (left_ptr < right_ptr)
  2c0ce3:	4d 39 e6             	cmp    %r12,%r14
  2c0ce6:	72 1c                	jb     2c0d04 <quicksort+0x16b>
		  else if (mid == right_ptr)
		      mid = left_ptr;
		  left_ptr += size;
		  right_ptr -= size;
	      }
	      else if (left_ptr == right_ptr)
  2c0ce8:	74 5e                	je     2c0d48 <quicksort+0x1af>
		  left_ptr += size;
		  right_ptr -= size;
		  break;
	      }
	  }
	  while (left_ptr <= right_ptr);
  2c0cea:	4d 39 e6             	cmp    %r12,%r14
  2c0ced:	77 63                	ja     2c0d52 <quicksort+0x1b9>
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
  2c0cef:	4c 89 ee             	mov    %r13,%rsi
  2c0cf2:	4c 89 f7             	mov    %r14,%rdi
  2c0cf5:	ff d3                	callq  *%rbx
  2c0cf7:	85 c0                	test   %eax,%eax
  2c0cf9:	79 dc                	jns    2c0cd7 <quicksort+0x13e>
		  left_ptr += size;
  2c0cfb:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  2c0d02:	eb eb                	jmp    2c0cef <quicksort+0x156>
  2c0d04:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0d0b:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
	      if (left_ptr < right_ptr)
  2c0d0f:	4c 89 e2             	mov    %r12,%rdx
  2c0d12:	4c 89 f0             	mov    %r14,%rax
		  SWAP (left_ptr, right_ptr, size);
  2c0d15:	0f b6 08             	movzbl (%rax),%ecx
  2c0d18:	48 83 c0 01          	add    $0x1,%rax
  2c0d1c:	0f b6 32             	movzbl (%rdx),%esi
  2c0d1f:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c0d23:	48 83 c2 01          	add    $0x1,%rdx
  2c0d27:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c0d2a:	48 39 f8             	cmp    %rdi,%rax
  2c0d2d:	75 e6                	jne    2c0d15 <quicksort+0x17c>
		  if (mid == left_ptr)
  2c0d2f:	4d 39 ee             	cmp    %r13,%r14
  2c0d32:	74 0f                	je     2c0d43 <quicksort+0x1aa>
		  else if (mid == right_ptr)
  2c0d34:	4d 39 ec             	cmp    %r13,%r12
  2c0d37:	4d 0f 44 ee          	cmove  %r14,%r13
		  right_ptr -= size;
  2c0d3b:	4d 01 fc             	add    %r15,%r12
		  left_ptr += size;
  2c0d3e:	49 89 fe             	mov    %rdi,%r14
  2c0d41:	eb a7                	jmp    2c0cea <quicksort+0x151>
  2c0d43:	4d 89 e5             	mov    %r12,%r13
  2c0d46:	eb f3                	jmp    2c0d3b <quicksort+0x1a2>
		  left_ptr += size;
  2c0d48:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
		  right_ptr -= size;
  2c0d4f:	4d 01 fc             	add    %r15,%r12
	  /* Set up pointers for next iteration.  First determine whether
	     left and right partitions are below the threshold size.  If so,
	     ignore one or both.  Otherwise, push the larger partition's
	     bounds on the stack and continue sorting the smaller one. */
	  if ((size_t) (right_ptr - lo) <= max_thresh)
  2c0d52:	4c 89 e0             	mov    %r12,%rax
  2c0d55:	48 2b 85 b8 fb ff ff 	sub    -0x448(%rbp),%rax
  2c0d5c:	48 8b bd a8 fb ff ff 	mov    -0x458(%rbp),%rdi
  2c0d63:	48 39 f8             	cmp    %rdi,%rax
  2c0d66:	0f 87 bf 00 00 00    	ja     2c0e2b <quicksort+0x292>
	  {
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  2c0d6c:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c0d73:	4c 29 f0             	sub    %r14,%rax
		  /* Ignore both small partitions. */
		  POP (lo, hi);
	      else
		  /* Ignore small left partition. */
		  lo = left_ptr;
  2c0d76:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  2c0d7d:	48 39 f8             	cmp    %rdi,%rax
  2c0d80:	77 28                	ja     2c0daa <quicksort+0x211>
		  POP (lo, hi);
  2c0d82:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c0d89:	48 8b 78 f0          	mov    -0x10(%rax),%rdi
  2c0d8d:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
  2c0d94:	48 8b 78 f8          	mov    -0x8(%rax),%rdi
  2c0d98:	48 89 bd c0 fb ff ff 	mov    %rdi,-0x440(%rbp)
  2c0d9f:	48 8d 40 f0          	lea    -0x10(%rax),%rax
  2c0da3:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	while (STACK_NOT_EMPTY)
  2c0daa:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  2c0db1:	48 39 85 b0 fb ff ff 	cmp    %rax,-0x450(%rbp)
  2c0db8:	0f 86 e9 00 00 00    	jbe    2c0ea7 <quicksort+0x30e>
	    char *mid = lo + size * ((hi - lo) / size >> 1);
  2c0dbe:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c0dc5:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  2c0dcc:	48 29 f8             	sub    %rdi,%rax
  2c0dcf:	48 8b 8d c8 fb ff ff 	mov    -0x438(%rbp),%rcx
  2c0dd6:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0ddb:	48 f7 f1             	div    %rcx
  2c0dde:	48 d1 e8             	shr    %rax
  2c0de1:	48 0f af c1          	imul   %rcx,%rax
  2c0de5:	4c 8d 2c 07          	lea    (%rdi,%rax,1),%r13
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c0de9:	48 89 fe             	mov    %rdi,%rsi
  2c0dec:	4c 89 ef             	mov    %r13,%rdi
  2c0def:	ff d3                	callq  *%rbx
  2c0df1:	85 c0                	test   %eax,%eax
  2c0df3:	0f 88 39 fe ff ff    	js     2c0c32 <quicksort+0x99>
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  2c0df9:	4c 89 ee             	mov    %r13,%rsi
  2c0dfc:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  2c0e03:	ff d3                	callq  *%rbx
  2c0e05:	85 c0                	test   %eax,%eax
  2c0e07:	0f 88 5a fe ff ff    	js     2c0c67 <quicksort+0xce>
	  left_ptr  = lo + size;
  2c0e0d:	4c 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%r14
  2c0e14:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
	  right_ptr = hi - size;
  2c0e1b:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c0e22:	4e 8d 24 38          	lea    (%rax,%r15,1),%r12
  2c0e26:	e9 c4 fe ff ff       	jmpq   2c0cef <quicksort+0x156>
	  }
	  else if ((size_t) (hi - left_ptr) <= max_thresh)
  2c0e2b:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
  2c0e32:	4c 29 f2             	sub    %r14,%rdx
  2c0e35:	48 3b 95 a8 fb ff ff 	cmp    -0x458(%rbp),%rdx
  2c0e3c:	76 5d                	jbe    2c0e9b <quicksort+0x302>
	      /* Ignore small right partition. */
	      hi = right_ptr;
	  else if ((right_ptr - lo) > (hi - left_ptr))
  2c0e3e:	48 39 d0             	cmp    %rdx,%rax
  2c0e41:	7e 2c                	jle    2c0e6f <quicksort+0x2d6>
	  {
	      /* Push larger left partition indices. */
	      PUSH (lo, right_ptr);
  2c0e43:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c0e4a:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  2c0e51:	48 89 38             	mov    %rdi,(%rax)
  2c0e54:	4c 89 60 08          	mov    %r12,0x8(%rax)
  2c0e58:	48 83 c0 10          	add    $0x10,%rax
  2c0e5c:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      lo = left_ptr;
  2c0e63:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
  2c0e6a:	e9 3b ff ff ff       	jmpq   2c0daa <quicksort+0x211>
	  }
	  else
	  {
	      /* Push larger right partition indices. */
	      PUSH (left_ptr, hi);
  2c0e6f:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c0e76:	4c 89 30             	mov    %r14,(%rax)
  2c0e79:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  2c0e80:	48 89 78 08          	mov    %rdi,0x8(%rax)
  2c0e84:	48 83 c0 10          	add    $0x10,%rax
  2c0e88:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      hi = right_ptr;
  2c0e8f:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  2c0e96:	e9 0f ff ff ff       	jmpq   2c0daa <quicksort+0x211>
	      hi = right_ptr;
  2c0e9b:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  2c0ea2:	e9 03 ff ff ff       	jmpq   2c0daa <quicksort+0x211>
       for partitions below MAX_THRESH size. BASE_PTR points to the beginning
       of the array to sort, and END_PTR points at the very last element in
       the array (*not* one beyond it!). */
#define min(x, y) ((x) < (y) ? (x) : (y))
    {
	char *const end_ptr = &base_ptr[size * (total_elems - 1)];
  2c0ea7:	4c 8b bd 98 fb ff ff 	mov    -0x468(%rbp),%r15
  2c0eae:	49 83 ef 01          	sub    $0x1,%r15
  2c0eb2:	48 8b bd c8 fb ff ff 	mov    -0x438(%rbp),%rdi
  2c0eb9:	4c 0f af ff          	imul   %rdi,%r15
  2c0ebd:	4c 8b ad a0 fb ff ff 	mov    -0x460(%rbp),%r13
  2c0ec4:	4d 01 ef             	add    %r13,%r15
	char *tmp_ptr = base_ptr;
	char *thresh = min(end_ptr, base_ptr + max_thresh);
  2c0ec7:	48 8b 85 a8 fb ff ff 	mov    -0x458(%rbp),%rax
  2c0ece:	4c 01 e8             	add    %r13,%rax
  2c0ed1:	49 39 c7             	cmp    %rax,%r15
  2c0ed4:	49 0f 46 c7          	cmovbe %r15,%rax
	char *run_ptr;
	/* Find smallest element in first threshold and place it at the
	   array's beginning.  This is the smallest array element,
	   and the operation speeds up insertion sort's inner loop. */
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  2c0ed8:	4d 89 ec             	mov    %r13,%r12
  2c0edb:	49 01 fc             	add    %rdi,%r12
  2c0ede:	4c 39 e0             	cmp    %r12,%rax
  2c0ee1:	72 66                	jb     2c0f49 <quicksort+0x3b0>
  2c0ee3:	4d 89 e6             	mov    %r12,%r14
	char *tmp_ptr = base_ptr;
  2c0ee6:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  2c0eed:	49 89 c4             	mov    %rax,%r12
	    if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c0ef0:	4c 89 ee             	mov    %r13,%rsi
  2c0ef3:	4c 89 f7             	mov    %r14,%rdi
  2c0ef6:	ff d3                	callq  *%rbx
  2c0ef8:	85 c0                	test   %eax,%eax
  2c0efa:	4d 0f 48 ee          	cmovs  %r14,%r13
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  2c0efe:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  2c0f05:	4d 39 f4             	cmp    %r14,%r12
  2c0f08:	73 e6                	jae    2c0ef0 <quicksort+0x357>
  2c0f0a:	4c 8b a5 c0 fb ff ff 	mov    -0x440(%rbp),%r12
		tmp_ptr = run_ptr;
	if (tmp_ptr != base_ptr)
  2c0f11:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0f18:	49 8d 4c 05 00       	lea    0x0(%r13,%rax,1),%rcx
  2c0f1d:	48 8b 85 a0 fb ff ff 	mov    -0x460(%rbp),%rax
  2c0f24:	4c 3b ad a0 fb ff ff 	cmp    -0x460(%rbp),%r13
  2c0f2b:	74 1c                	je     2c0f49 <quicksort+0x3b0>
	    SWAP (tmp_ptr, base_ptr, size);
  2c0f2d:	41 0f b6 55 00       	movzbl 0x0(%r13),%edx
  2c0f32:	49 83 c5 01          	add    $0x1,%r13
  2c0f36:	0f b6 30             	movzbl (%rax),%esi
  2c0f39:	41 88 75 ff          	mov    %sil,-0x1(%r13)
  2c0f3d:	48 83 c0 01          	add    $0x1,%rax
  2c0f41:	88 50 ff             	mov    %dl,-0x1(%rax)
  2c0f44:	49 39 cd             	cmp    %rcx,%r13
  2c0f47:	75 e4                	jne    2c0f2d <quicksort+0x394>
	/* Insertion sort, running from left-hand-side up to right-hand-side.  */
	run_ptr = base_ptr + size;
	while ((run_ptr += size) <= end_ptr)
  2c0f49:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0f50:	4d 8d 34 04          	lea    (%r12,%rax,1),%r14
	{
	    tmp_ptr = run_ptr - size;
  2c0f54:	48 f7 d8             	neg    %rax
  2c0f57:	49 89 c5             	mov    %rax,%r13
	while ((run_ptr += size) <= end_ptr)
  2c0f5a:	4d 39 f7             	cmp    %r14,%r15
  2c0f5d:	73 15                	jae    2c0f74 <quicksort+0x3db>
		    *hi = c;
		}
	    }
	}
    }
}
  2c0f5f:	48 81 c4 48 04 00 00 	add    $0x448,%rsp
  2c0f66:	5b                   	pop    %rbx
  2c0f67:	41 5c                	pop    %r12
  2c0f69:	41 5d                	pop    %r13
  2c0f6b:	41 5e                	pop    %r14
  2c0f6d:	41 5f                	pop    %r15
  2c0f6f:	5d                   	pop    %rbp
  2c0f70:	c3                   	retq   
		tmp_ptr -= size;
  2c0f71:	4d 01 ec             	add    %r13,%r12
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c0f74:	4c 89 e6             	mov    %r12,%rsi
  2c0f77:	4c 89 f7             	mov    %r14,%rdi
  2c0f7a:	ff d3                	callq  *%rbx
  2c0f7c:	85 c0                	test   %eax,%eax
  2c0f7e:	78 f1                	js     2c0f71 <quicksort+0x3d8>
	    tmp_ptr += size;
  2c0f80:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0f87:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
	    if (tmp_ptr != run_ptr)
  2c0f8b:	4c 39 f6             	cmp    %r14,%rsi
  2c0f8e:	75 17                	jne    2c0fa7 <quicksort+0x40e>
	while ((run_ptr += size) <= end_ptr)
  2c0f90:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0f97:	4c 01 f0             	add    %r14,%rax
  2c0f9a:	4d 89 f4             	mov    %r14,%r12
  2c0f9d:	49 39 c7             	cmp    %rax,%r15
  2c0fa0:	72 bd                	jb     2c0f5f <quicksort+0x3c6>
  2c0fa2:	49 89 c6             	mov    %rax,%r14
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c0fa5:	eb cd                	jmp    2c0f74 <quicksort+0x3db>
		while (--trav >= run_ptr)
  2c0fa7:	49 8d 7c 06 ff       	lea    -0x1(%r14,%rax,1),%rdi
  2c0fac:	4c 39 f7             	cmp    %r14,%rdi
  2c0faf:	72 df                	jb     2c0f90 <quicksort+0x3f7>
  2c0fb1:	4d 8d 46 ff          	lea    -0x1(%r14),%r8
  2c0fb5:	4d 89 c2             	mov    %r8,%r10
  2c0fb8:	eb 13                	jmp    2c0fcd <quicksort+0x434>
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c0fba:	48 89 f9             	mov    %rdi,%rcx
		    *hi = c;
  2c0fbd:	44 88 09             	mov    %r9b,(%rcx)
		while (--trav >= run_ptr)
  2c0fc0:	48 83 ef 01          	sub    $0x1,%rdi
  2c0fc4:	49 83 e8 01          	sub    $0x1,%r8
  2c0fc8:	49 39 fa             	cmp    %rdi,%r10
  2c0fcb:	74 c3                	je     2c0f90 <quicksort+0x3f7>
		    char c = *trav;
  2c0fcd:	44 0f b6 0f          	movzbl (%rdi),%r9d
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c0fd1:	4c 89 c0             	mov    %r8,%rax
  2c0fd4:	4c 39 c6             	cmp    %r8,%rsi
  2c0fd7:	77 e1                	ja     2c0fba <quicksort+0x421>
  2c0fd9:	48 89 fa             	mov    %rdi,%rdx
			*hi = *lo;
  2c0fdc:	0f b6 08             	movzbl (%rax),%ecx
  2c0fdf:	88 0a                	mov    %cl,(%rdx)
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c0fe1:	48 89 c1             	mov    %rax,%rcx
  2c0fe4:	4c 01 e8             	add    %r13,%rax
  2c0fe7:	48 2b 95 c8 fb ff ff 	sub    -0x438(%rbp),%rdx
  2c0fee:	48 39 c6             	cmp    %rax,%rsi
  2c0ff1:	76 e9                	jbe    2c0fdc <quicksort+0x443>
  2c0ff3:	eb c8                	jmp    2c0fbd <quicksort+0x424>

00000000002c0ff5 <addNodeToList>:

/* Add the given block to the given list */
void addNodeToList(struct block_header * header, struct block_header ** list_start){
    if(*list_start == 0) {
  2c0ff5:	48 8b 16             	mov    (%rsi),%rdx
  2c0ff8:	48 85 d2             	test   %rdx,%rdx
  2c0ffb:	74 3b                	je     2c1038 <addNodeToList+0x43>
        // list is empty
        *list_start = header;
        return;
    }

    if(header < *list_start){
  2c0ffd:	48 39 fa             	cmp    %rdi,%rdx
  2c1000:	77 3a                	ja     2c103c <addNodeToList+0x47>
        *list_start = header;
        return;
    }

    struct block_header * node = *list_start;
    struct block_header * nextNode = node->next;
  2c1002:	48 8b 02             	mov    (%rdx),%rax
    while(nextNode != 0){
  2c1005:	48 85 c0             	test   %rax,%rax
  2c1008:	74 3d                	je     2c1047 <addNodeToList+0x52>
        if(node < header && nextNode > header){
  2c100a:	48 39 fa             	cmp    %rdi,%rdx
  2c100d:	73 05                	jae    2c1014 <addNodeToList+0x1f>
  2c100f:	48 39 c7             	cmp    %rax,%rdi
  2c1012:	72 15                	jb     2c1029 <addNodeToList+0x34>
            node->next = header;
            nextNode->prev = header;
            return;
        }
        node = nextNode;
        nextNode = node->next;
  2c1014:	48 89 c2             	mov    %rax,%rdx
  2c1017:	48 8b 00             	mov    (%rax),%rax
    while(nextNode != 0){
  2c101a:	48 85 c0             	test   %rax,%rax
  2c101d:	74 28                	je     2c1047 <addNodeToList+0x52>
        if(node < header && nextNode > header){
  2c101f:	48 39 d7             	cmp    %rdx,%rdi
  2c1022:	76 f0                	jbe    2c1014 <addNodeToList+0x1f>
  2c1024:	48 39 c7             	cmp    %rax,%rdi
  2c1027:	73 eb                	jae    2c1014 <addNodeToList+0x1f>
            header->prev = node;
  2c1029:	48 89 57 08          	mov    %rdx,0x8(%rdi)
            header->next = nextNode;
  2c102d:	48 89 07             	mov    %rax,(%rdi)
            node->next = header;
  2c1030:	48 89 3a             	mov    %rdi,(%rdx)
            nextNode->prev = header;
  2c1033:	48 89 78 08          	mov    %rdi,0x8(%rax)
            return;
  2c1037:	c3                   	retq   
        *list_start = header;
  2c1038:	48 89 3e             	mov    %rdi,(%rsi)
        return;
  2c103b:	c3                   	retq   
        header->next = *list_start;
  2c103c:	48 89 17             	mov    %rdx,(%rdi)
        (*list_start)->prev = header;
  2c103f:	48 89 7a 08          	mov    %rdi,0x8(%rdx)
        *list_start = header;
  2c1043:	48 89 3e             	mov    %rdi,(%rsi)
        return;
  2c1046:	c3                   	retq   
    }

    // reached end of list; append header there
    node->next = header;
  2c1047:	48 89 3a             	mov    %rdi,(%rdx)
    header->prev = node;
  2c104a:	48 89 57 08          	mov    %rdx,0x8(%rdi)
}
  2c104e:	c3                   	retq   

00000000002c104f <removeNodeFromList>:


/* Remove the given block from its list */
void removeNodeFromList(struct block_header * header, struct block_header ** list_start){
    if(header == 0) return;
  2c104f:	48 85 ff             	test   %rdi,%rdi
  2c1052:	74 2c                	je     2c1080 <removeNodeFromList+0x31>

    struct block_header * prevNode = header->prev;
  2c1054:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    struct block_header * nextNode = header->next;
  2c1058:	48 8b 07             	mov    (%rdi),%rax

    if(prevNode)
  2c105b:	48 85 d2             	test   %rdx,%rdx
  2c105e:	74 03                	je     2c1063 <removeNodeFromList+0x14>
        prevNode->next = nextNode;
  2c1060:	48 89 02             	mov    %rax,(%rdx)
    if(nextNode)
  2c1063:	48 85 c0             	test   %rax,%rax
  2c1066:	74 04                	je     2c106c <removeNodeFromList+0x1d>
        nextNode->prev = prevNode;
  2c1068:	48 89 50 08          	mov    %rdx,0x8(%rax)

    // check if this block is the start of the list
    if(*list_start == header)
  2c106c:	48 39 3e             	cmp    %rdi,(%rsi)
  2c106f:	74 10                	je     2c1081 <removeNodeFromList+0x32>
        *list_start = nextNode;

    header->next = 0;
  2c1071:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    header->prev = 0;
  2c1078:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c107f:	00 
}
  2c1080:	c3                   	retq   
        *list_start = nextNode;
  2c1081:	48 89 06             	mov    %rax,(%rsi)
  2c1084:	eb eb                	jmp    2c1071 <removeNodeFromList+0x22>

00000000002c1086 <free>:
/* Free a block */
void free(void *firstbyte) {
    
    // app_printf(0, "free\n");

    if(firstbyte == 0)
  2c1086:	48 85 ff             	test   %rdi,%rdi
  2c1089:	74 44                	je     2c10cf <free+0x49>
void free(void *firstbyte) {
  2c108b:	55                   	push   %rbp
  2c108c:	48 89 e5             	mov    %rsp,%rbp
  2c108f:	41 54                	push   %r12
  2c1091:	53                   	push   %rbx
  2c1092:	48 89 fb             	mov    %rdi,%rbx
        return;

    // remove the block from allocated_list
    struct block_header * header = (struct block_header *) ((uintptr_t) firstbyte - HEADER_SIZE);
  2c1095:	4c 8d 67 e8          	lea    -0x18(%rdi),%r12
    removeNodeFromList(header, &allocated_list_start);
  2c1099:	be 10 20 2c 00       	mov    $0x2c2010,%esi
  2c109e:	4c 89 e7             	mov    %r12,%rdi
  2c10a1:	e8 a9 ff ff ff       	callq  2c104f <removeNodeFromList>

    // add the block to free-node list
    header->prev = 0;
  2c10a6:	48 c7 43 f0 00 00 00 	movq   $0x0,-0x10(%rbx)
  2c10ad:	00 
    header->next = 0;
  2c10ae:	48 c7 43 e8 00 00 00 	movq   $0x0,-0x18(%rbx)
  2c10b5:	00 
    addNodeToList(header, &free_list_start);
  2c10b6:	be 18 20 2c 00       	mov    $0x2c2018,%esi
  2c10bb:	4c 89 e7             	mov    %r12,%rdi
  2c10be:	e8 32 ff ff ff       	callq  2c0ff5 <addNodeToList>

    // app_printf(0, "%x\n", free_list_start);

    number_allocs--;
  2c10c3:	83 2d 3e 0f 00 00 01 	subl   $0x1,0xf3e(%rip)        # 2c2008 <number_allocs>
}
  2c10ca:	5b                   	pop    %rbx
  2c10cb:	41 5c                	pop    %r12
  2c10cd:	5d                   	pop    %rbp
  2c10ce:	c3                   	retq   
  2c10cf:	c3                   	retq   

00000000002c10d0 <splitFreeNode>:

/* Split a given block into two,
   given the size of the first part */
void splitFreeNode(struct block_header * node, size_t sz) {
    struct block_header * newNode = (struct block_header *) ((uintptr_t) node + sz);
  2c10d0:	48 8d 04 37          	lea    (%rdi,%rsi,1),%rax
    newNode->block_size = node->block_size - sz;
  2c10d4:	48 8b 57 10          	mov    0x10(%rdi),%rdx
  2c10d8:	48 29 f2             	sub    %rsi,%rdx
  2c10db:	48 89 50 10          	mov    %rdx,0x10(%rax)

    // insert the new block into free-node list
    newNode->next = node->next;
  2c10df:	48 8b 17             	mov    (%rdi),%rdx
  2c10e2:	48 89 10             	mov    %rdx,(%rax)
    node->next = newNode;
  2c10e5:	48 89 07             	mov    %rax,(%rdi)
    newNode->prev = node;
  2c10e8:	48 89 78 08          	mov    %rdi,0x8(%rax)
    if(newNode->next) newNode->next->prev = newNode;     
  2c10ec:	48 8b 10             	mov    (%rax),%rdx
  2c10ef:	48 85 d2             	test   %rdx,%rdx
  2c10f2:	74 04                	je     2c10f8 <splitFreeNode+0x28>
  2c10f4:	48 89 42 08          	mov    %rax,0x8(%rdx)
}
  2c10f8:	c3                   	retq   

00000000002c10f9 <findFreeNode>:

/* Traverse the free-node list to find a possible block;
   return the start of the block (start of the header) */
struct block_header * findFreeNode(size_t block_size){
  2c10f9:	55                   	push   %rbp
  2c10fa:	48 89 e5             	mov    %rsp,%rbp
  2c10fd:	41 55                	push   %r13
  2c10ff:	41 54                	push   %r12
  2c1101:	53                   	push   %rbx
  2c1102:	48 83 ec 08          	sub    $0x8,%rsp
  2c1106:	49 89 fd             	mov    %rdi,%r13
    struct block_header * node = free_list_start;
  2c1109:	48 8b 1d 08 0f 00 00 	mov    0xf08(%rip),%rbx        # 2c2018 <free_list_start>
    while(node != 0){
  2c1110:	48 85 db             	test   %rbx,%rbx
  2c1113:	74 30                	je     2c1145 <findFreeNode+0x4c>
        if(node->block_size >= block_size) {
  2c1115:	4c 8b 63 10          	mov    0x10(%rbx),%r12
  2c1119:	4d 39 ec             	cmp    %r13,%r12
  2c111c:	73 0a                	jae    2c1128 <findFreeNode+0x2f>
            // update block_size
            node->block_size = block_size;

            return node;
        }
        node = node->next;
  2c111e:	48 8b 1b             	mov    (%rbx),%rbx
    while(node != 0){
  2c1121:	48 85 db             	test   %rbx,%rbx
  2c1124:	75 ef                	jne    2c1115 <findFreeNode+0x1c>
  2c1126:	eb 1d                	jmp    2c1145 <findFreeNode+0x4c>
            if(node->block_size - block_size >= HEADER_SIZE) {
  2c1128:	4c 89 e0             	mov    %r12,%rax
  2c112b:	4c 29 e8             	sub    %r13,%rax
  2c112e:	48 83 f8 17          	cmp    $0x17,%rax
  2c1132:	77 1f                	ja     2c1153 <findFreeNode+0x5a>
            removeNodeFromList(node, &free_list_start);
  2c1134:	be 18 20 2c 00       	mov    $0x2c2018,%esi
  2c1139:	48 89 df             	mov    %rbx,%rdi
  2c113c:	e8 0e ff ff ff       	callq  2c104f <removeNodeFromList>
            node->block_size = block_size;
  2c1141:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    }
    // no available block is found
    return 0;
}
  2c1145:	48 89 d8             	mov    %rbx,%rax
  2c1148:	48 83 c4 08          	add    $0x8,%rsp
  2c114c:	5b                   	pop    %rbx
  2c114d:	41 5c                	pop    %r12
  2c114f:	41 5d                	pop    %r13
  2c1151:	5d                   	pop    %rbp
  2c1152:	c3                   	retq   
                splitFreeNode(node, block_size);
  2c1153:	4c 89 ee             	mov    %r13,%rsi
  2c1156:	48 89 df             	mov    %rbx,%rdi
  2c1159:	e8 72 ff ff ff       	callq  2c10d0 <splitFreeNode>
  2c115e:	4d 89 ec             	mov    %r13,%r12
  2c1161:	eb d1                	jmp    2c1134 <findFreeNode+0x3b>

00000000002c1163 <malloc>:

void *malloc(uint64_t numbytes) {
  2c1163:	55                   	push   %rbp
  2c1164:	48 89 e5             	mov    %rsp,%rbp
  2c1167:	41 54                	push   %r12
  2c1169:	53                   	push   %rbx
    if(numbytes == 0) return NULL;
  2c116a:	48 85 ff             	test   %rdi,%rdi
  2c116d:	74 72                	je     2c11e1 <malloc+0x7e>

    // app_printf(0, "s\n");

    // size of allocated block, after accounting for alignment
    size_t allocatedBlockSize = numbytes + HEADER_SIZE;
  2c116f:	4c 8d 67 18          	lea    0x18(%rdi),%r12
    // app_printf(0, "%d\n", numbytes);
    if(allocatedBlockSize % ALIGNMENT != 0)
        allocatedBlockSize = (allocatedBlockSize & ~(ALIGNMENT-1)) + ALIGNMENT;
  2c1173:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
  2c1177:	49 83 c4 08          	add    $0x8,%r12
  2c117b:	48 8d 47 18          	lea    0x18(%rdi),%rax
  2c117f:	40 f6 c7 07          	test   $0x7,%dil
  2c1183:	4c 0f 44 e0          	cmove  %rax,%r12

    // go through list of free blocks,
    // and find one that would fit
    struct block_header * target_block = findFreeNode(allocatedBlockSize);
  2c1187:	4c 89 e7             	mov    %r12,%rdi
  2c118a:	e8 6a ff ff ff       	callq  2c10f9 <findFreeNode>
  2c118f:	48 89 c3             	mov    %rax,%rbx
    if(target_block == 0) {
  2c1192:	48 85 c0             	test   %rax,%rax
  2c1195:	74 2f                	je     2c11c6 <malloc+0x63>
        // set up block header
        target_block->block_size = allocatedBlockSize;
    }

    // add the block to allocated_list
    target_block->prev = 0;
  2c1197:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  2c119e:	00 
    target_block->next = 0;
  2c119f:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    addNodeToList(target_block, &allocated_list_start);
  2c11a6:	be 10 20 2c 00       	mov    $0x2c2010,%esi
  2c11ab:	48 89 df             	mov    %rbx,%rdi
  2c11ae:	e8 42 fe ff ff       	callq  2c0ff5 <addNodeToList>

    // return start of payload
    number_allocs++;
  2c11b3:	83 05 4e 0e 00 00 01 	addl   $0x1,0xe4e(%rip)        # 2c2008 <number_allocs>
    
    // app_printf(0, "%d\n", allocatedBlockSize);
    return (void*) ((uintptr_t) target_block + HEADER_SIZE);
  2c11ba:	48 83 c3 18          	add    $0x18,%rbx
}
  2c11be:	48 89 d8             	mov    %rbx,%rax
  2c11c1:	5b                   	pop    %rbx
  2c11c2:	41 5c                	pop    %r12
  2c11c4:	5d                   	pop    %rbp
  2c11c5:	c3                   	retq   
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c11c6:	4c 89 e7             	mov    %r12,%rdi
  2c11c9:	cd 3a                	int    $0x3a
  2c11cb:	48 89 05 4e 0e 00 00 	mov    %rax,0xe4e(%rip)        # 2c2020 <result.0>
        if((void *)target_block == (void *) -1) return 0;
  2c11d2:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c11d6:	74 e6                	je     2c11be <malloc+0x5b>
        target_block->block_size = allocatedBlockSize;
  2c11d8:	4c 89 60 10          	mov    %r12,0x10(%rax)
        target_block = (struct block_header *) sbrk(allocatedBlockSize);
  2c11dc:	48 89 c3             	mov    %rax,%rbx
  2c11df:	eb b6                	jmp    2c1197 <malloc+0x34>
    if(numbytes == 0) return NULL;
  2c11e1:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c11e6:	eb d6                	jmp    2c11be <malloc+0x5b>

00000000002c11e8 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  2c11e8:	55                   	push   %rbp
  2c11e9:	48 89 e5             	mov    %rsp,%rbp
  2c11ec:	41 54                	push   %r12
  2c11ee:	53                   	push   %rbx
    // malloc
    void * new_payload = malloc(num * sz);
  2c11ef:	48 0f af fe          	imul   %rsi,%rdi
  2c11f3:	49 89 fc             	mov    %rdi,%r12
  2c11f6:	e8 68 ff ff ff       	callq  2c1163 <malloc>
  2c11fb:	48 89 c3             	mov    %rax,%rbx
    if(new_payload == 0)
  2c11fe:	48 85 c0             	test   %rax,%rax
  2c1201:	74 10                	je     2c1213 <calloc+0x2b>
        return 0;

    // fill in 0's
    memset(new_payload, 0, num * sz);
  2c1203:	4c 89 e2             	mov    %r12,%rdx
  2c1206:	be 00 00 00 00       	mov    $0x0,%esi
  2c120b:	48 89 c7             	mov    %rax,%rdi
  2c120e:	e8 72 f0 ff ff       	callq  2c0285 <memset>

    return new_payload;
}
  2c1213:	48 89 d8             	mov    %rbx,%rax
  2c1216:	5b                   	pop    %rbx
  2c1217:	41 5c                	pop    %r12
  2c1219:	5d                   	pop    %rbp
  2c121a:	c3                   	retq   

00000000002c121b <realloc>:
/*
For realloc(ptr, size), if ptr is NULL, then the call is equivalent to malloc(size), 
for all values of size; if size is equal to zero, and ptr is not NULL, then the call 
is equivalent to free(ptr).
*/
void * realloc(void * ptr, uint64_t sz) {
  2c121b:	55                   	push   %rbp
  2c121c:	48 89 e5             	mov    %rsp,%rbp
  2c121f:	41 57                	push   %r15
  2c1221:	41 56                	push   %r14
  2c1223:	41 55                	push   %r13
  2c1225:	41 54                	push   %r12
  2c1227:	53                   	push   %rbx
  2c1228:	48 83 ec 08          	sub    $0x8,%rsp
  2c122c:	48 89 f3             	mov    %rsi,%rbx
    // edge cases:
    if(ptr == NULL) return malloc(sz);
  2c122f:	48 85 ff             	test   %rdi,%rdi
  2c1232:	74 60                	je     2c1294 <realloc+0x79>
  2c1234:	49 89 fc             	mov    %rdi,%r12
    if(sz == 0) {
  2c1237:	48 85 f6             	test   %rsi,%rsi
  2c123a:	74 65                	je     2c12a1 <realloc+0x86>
        free(ptr);
        return 0;       // TODO: check return value
    }

    struct block_header * orig_header = (struct block_header *) ((uintptr_t) ptr - HEADER_SIZE);
    size_t origPayloadSz = orig_header->block_size - HEADER_SIZE;
  2c123c:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  2c1240:	4c 8d 68 e8          	lea    -0x18(%rax),%r13
    size_t newPayloadSz = sz;
    if(newPayloadSz % ALIGNMENT != 0)
        newPayloadSz = (newPayloadSz & ~(ALIGNMENT-1)) + ALIGNMENT;
  2c1244:	48 89 f0             	mov    %rsi,%rax
  2c1247:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  2c124b:	48 83 c0 08          	add    $0x8,%rax
  2c124f:	40 f6 c6 07          	test   $0x7,%sil
  2c1253:	48 0f 45 d8          	cmovne %rax,%rbx

    // shrinking?
    if (newPayloadSz <= origPayloadSz) {
  2c1257:	4c 39 eb             	cmp    %r13,%rbx
  2c125a:	77 52                	ja     2c12ae <realloc+0x93>
        // check if we need to split
        if(origPayloadSz - newPayloadSz >= HEADER_SIZE) {
  2c125c:	49 29 dd             	sub    %rbx,%r13
            addNodeToList(free_header, &free_list_start);
            // shrink the allocated block
            orig_header->block_size = newPayloadSz + HEADER_SIZE;
        }

        return ptr;
  2c125f:	49 89 fe             	mov    %rdi,%r14
        if(origPayloadSz - newPayloadSz >= HEADER_SIZE) {
  2c1262:	49 83 fd 17          	cmp    $0x17,%r13
  2c1266:	76 67                	jbe    2c12cf <realloc+0xb4>
            struct block_header * free_header = (struct block_header *) ((uintptr_t) ptr + newPayloadSz);
  2c1268:	48 8d 3c 1f          	lea    (%rdi,%rbx,1),%rdi
            free_header->block_size = origPayloadSz - newPayloadSz;
  2c126c:	4c 89 6f 10          	mov    %r13,0x10(%rdi)
            free_header->next = 0;
  2c1270:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
            free_header->prev = 0;
  2c1277:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c127e:	00 
            addNodeToList(free_header, &free_list_start);
  2c127f:	be 18 20 2c 00       	mov    $0x2c2018,%esi
  2c1284:	e8 6c fd ff ff       	callq  2c0ff5 <addNodeToList>
            orig_header->block_size = newPayloadSz + HEADER_SIZE;
  2c1289:	48 83 c3 18          	add    $0x18,%rbx
  2c128d:	49 89 5c 24 f8       	mov    %rbx,-0x8(%r12)
  2c1292:	eb 3b                	jmp    2c12cf <realloc+0xb4>
    if(ptr == NULL) return malloc(sz);
  2c1294:	48 89 f7             	mov    %rsi,%rdi
  2c1297:	e8 c7 fe ff ff       	callq  2c1163 <malloc>
  2c129c:	49 89 c6             	mov    %rax,%r14
  2c129f:	eb 2e                	jmp    2c12cf <realloc+0xb4>
        free(ptr);
  2c12a1:	e8 e0 fd ff ff       	callq  2c1086 <free>
        return 0;       // TODO: check return value
  2c12a6:	41 be 00 00 00 00    	mov    $0x0,%r14d
  2c12ac:	eb 21                	jmp    2c12cf <realloc+0xb4>
    }

    // growing:

    // malloc a new block
    void * new_payload = malloc(newPayloadSz);
  2c12ae:	48 89 df             	mov    %rbx,%rdi
  2c12b1:	e8 ad fe ff ff       	callq  2c1163 <malloc>
  2c12b6:	49 89 c6             	mov    %rax,%r14

    // copy the data
    memcpy(new_payload, ptr, origPayloadSz);
  2c12b9:	4c 89 ea             	mov    %r13,%rdx
  2c12bc:	4c 89 e6             	mov    %r12,%rsi
  2c12bf:	48 89 c7             	mov    %rax,%rdi
  2c12c2:	e8 55 ef ff ff       	callq  2c021c <memcpy>

    // free the original block
    free(ptr);
  2c12c7:	4c 89 e7             	mov    %r12,%rdi
  2c12ca:	e8 b7 fd ff ff       	callq  2c1086 <free>

    // return start of new payload
    return new_payload;
}
  2c12cf:	4c 89 f0             	mov    %r14,%rax
  2c12d2:	48 83 c4 08          	add    $0x8,%rsp
  2c12d6:	5b                   	pop    %rbx
  2c12d7:	41 5c                	pop    %r12
  2c12d9:	41 5d                	pop    %r13
  2c12db:	41 5e                	pop    %r14
  2c12dd:	41 5f                	pop    %r15
  2c12df:	5d                   	pop    %rbp
  2c12e0:	c3                   	retq   

00000000002c12e1 <defrag>:

void defrag() {
    if(free_list_start == 0) return;
  2c12e1:	48 8b 15 30 0d 00 00 	mov    0xd30(%rip),%rdx        # 2c2018 <free_list_start>
  2c12e8:	48 85 d2             	test   %rdx,%rdx
  2c12eb:	74 08                	je     2c12f5 <defrag+0x14>

    // iterate through free-node list
    struct block_header * node = free_list_start;
    struct block_header * nextNode = node->next;
  2c12ed:	48 8b 02             	mov    (%rdx),%rax
    while(nextNode != 0){
  2c12f0:	48 85 c0             	test   %rax,%rax
  2c12f3:	75 0c                	jne    2c1301 <defrag+0x20>
        } else {
            node = nextNode;
            nextNode = node->next;
        }
    }
}
  2c12f5:	c3                   	retq   
            nextNode = node->next;
  2c12f6:	48 89 c2             	mov    %rax,%rdx
  2c12f9:	48 8b 00             	mov    (%rax),%rax
    while(nextNode != 0){
  2c12fc:	48 85 c0             	test   %rax,%rax
  2c12ff:	74 f4                	je     2c12f5 <defrag+0x14>
        if((uintptr_t) nextNode - (uintptr_t) node == node->block_size) {
  2c1301:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  2c1305:	48 89 c6             	mov    %rax,%rsi
  2c1308:	48 29 d6             	sub    %rdx,%rsi
  2c130b:	48 39 ce             	cmp    %rcx,%rsi
  2c130e:	75 e6                	jne    2c12f6 <defrag+0x15>
            node->block_size += nextNode->block_size;
  2c1310:	48 03 48 10          	add    0x10(%rax),%rcx
  2c1314:	48 89 4a 10          	mov    %rcx,0x10(%rdx)
            node->next = nextNode->next;
  2c1318:	48 8b 00             	mov    (%rax),%rax
  2c131b:	48 89 02             	mov    %rax,(%rdx)
            if(nextNode->next) nextNode->next->prev = node;
  2c131e:	48 85 c0             	test   %rax,%rax
  2c1321:	74 04                	je     2c1327 <defrag+0x46>
  2c1323:	48 89 50 08          	mov    %rdx,0x8(%rax)
            nextNode = node->next;
  2c1327:	48 8b 02             	mov    (%rdx),%rax
  2c132a:	eb d0                	jmp    2c12fc <defrag+0x1b>

00000000002c132c <heap_info>:




int heap_info(heap_info_struct * info) {
  2c132c:	55                   	push   %rbp
  2c132d:	48 89 e5             	mov    %rsp,%rbp
  2c1330:	41 57                	push   %r15
  2c1332:	41 56                	push   %r14
  2c1334:	41 55                	push   %r13
  2c1336:	41 54                	push   %r12
  2c1338:	53                   	push   %rbx
  2c1339:	48 83 ec 08          	sub    $0x8,%rsp
  2c133d:	49 89 fc             	mov    %rdi,%r12
    size_t largest_free_chunk = 0;
    size_t free_space = 0;

    // iterate through free-node list
    // app_printf(0, "%x\n", free_list_start);
    if(free_list_start != 0) {
  2c1340:	48 8b 05 d1 0c 00 00 	mov    0xcd1(%rip),%rax        # 2c2018 <free_list_start>
  2c1347:	48 85 c0             	test   %rax,%rax
  2c134a:	74 62                	je     2c13ae <heap_info+0x82>
    size_t free_space = 0;
  2c134c:	be 00 00 00 00       	mov    $0x0,%esi
    size_t largest_free_chunk = 0;
  2c1351:	b9 00 00 00 00       	mov    $0x0,%ecx
        struct block_header * node = free_list_start;
        while(node != 0){
            free_space += node->block_size;
  2c1356:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c135a:	48 01 d6             	add    %rdx,%rsi
            if(node->block_size > largest_free_chunk)
  2c135d:	48 39 d1             	cmp    %rdx,%rcx
  2c1360:	48 0f 42 ca          	cmovb  %rdx,%rcx
                largest_free_chunk = node->block_size;
            node = node->next;
  2c1364:	48 8b 00             	mov    (%rax),%rax
        while(node != 0){
  2c1367:	48 85 c0             	test   %rax,%rax
  2c136a:	75 ea                	jne    2c1356 <heap_info+0x2a>
        }
    }
    info->free_space = free_space;
  2c136c:	41 89 74 24 18       	mov    %esi,0x18(%r12)
    info->largest_free_chunk = largest_free_chunk;
  2c1371:	41 89 4c 24 1c       	mov    %ecx,0x1c(%r12)


    /* Allocated block stuff */

    // number of allocated blocks
    int num_allocs = (int) number_allocs;
  2c1376:	44 8b 3d 8b 0c 00 00 	mov    0xc8b(%rip),%r15d        # 2c2008 <number_allocs>

    if(num_allocs == 0){
  2c137d:	45 85 ff             	test   %r15d,%r15d
  2c1380:	75 38                	jne    2c13ba <heap_info+0x8e>
        info->num_allocs = 0;
  2c1382:	41 c7 04 24 00 00 00 	movl   $0x0,(%r12)
  2c1389:	00 
        info->size_array = 0;
  2c138a:	49 c7 44 24 08 00 00 	movq   $0x0,0x8(%r12)
  2c1391:	00 00 
        info->ptr_array = 0;
  2c1393:	49 c7 44 24 10 00 00 	movq   $0x0,0x10(%r12)
  2c139a:	00 00 
    info->num_allocs = num_allocs;
    info->size_array = size_array;
    info->ptr_array = ptr_array;

    return 0;
}
  2c139c:	44 89 f8             	mov    %r15d,%eax
  2c139f:	48 83 c4 08          	add    $0x8,%rsp
  2c13a3:	5b                   	pop    %rbx
  2c13a4:	41 5c                	pop    %r12
  2c13a6:	41 5d                	pop    %r13
  2c13a8:	41 5e                	pop    %r14
  2c13aa:	41 5f                	pop    %r15
  2c13ac:	5d                   	pop    %rbp
  2c13ad:	c3                   	retq   
    size_t free_space = 0;
  2c13ae:	be 00 00 00 00       	mov    $0x0,%esi
    size_t largest_free_chunk = 0;
  2c13b3:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c13b8:	eb b2                	jmp    2c136c <heap_info+0x40>
    ptr_with_size * arr = malloc(num_allocs * sizeof(ptr_with_size));
  2c13ba:	4d 63 ef             	movslq %r15d,%r13
  2c13bd:	4c 89 ef             	mov    %r13,%rdi
  2c13c0:	48 c1 e7 04          	shl    $0x4,%rdi
  2c13c4:	e8 9a fd ff ff       	callq  2c1163 <malloc>
  2c13c9:	48 89 c3             	mov    %rax,%rbx
    if(arr == 0) return -1;
  2c13cc:	48 85 c0             	test   %rax,%rax
  2c13cf:	0f 84 c8 00 00 00    	je     2c149d <heap_info+0x171>
    if(allocated_list_start != 0){
  2c13d5:	48 8b 05 34 0c 00 00 	mov    0xc34(%rip),%rax        # 2c2010 <allocated_list_start>
  2c13dc:	48 85 c0             	test   %rax,%rax
  2c13df:	74 36                	je     2c1417 <heap_info+0xeb>
    int index = 0;
  2c13e1:	be 00 00 00 00       	mov    $0x0,%esi
  2c13e6:	eb 24                	jmp    2c140c <heap_info+0xe0>
                arr[index].ptr = (void*) ((uintptr_t) node + HEADER_SIZE);
  2c13e8:	48 63 d6             	movslq %esi,%rdx
  2c13eb:	48 c1 e2 04          	shl    $0x4,%rdx
  2c13ef:	48 01 da             	add    %rbx,%rdx
  2c13f2:	48 89 0a             	mov    %rcx,(%rdx)
                arr[index].size = node->block_size - HEADER_SIZE;
  2c13f5:	48 8b 78 10          	mov    0x10(%rax),%rdi
  2c13f9:	48 8d 4f e8          	lea    -0x18(%rdi),%rcx
  2c13fd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
                index++;
  2c1401:	83 c6 01             	add    $0x1,%esi
            node = node->next;
  2c1404:	48 8b 00             	mov    (%rax),%rax
        while(node != 0){
  2c1407:	48 85 c0             	test   %rax,%rax
  2c140a:	74 0b                	je     2c1417 <heap_info+0xeb>
            if((uintptr_t) node + HEADER_SIZE != (uintptr_t) arr) {
  2c140c:	48 8d 48 18          	lea    0x18(%rax),%rcx
  2c1410:	48 39 cb             	cmp    %rcx,%rbx
  2c1413:	75 d3                	jne    2c13e8 <heap_info+0xbc>
  2c1415:	eb ed                	jmp    2c1404 <heap_info+0xd8>
    quicksort(arr, num_allocs, sizeof(ptr_with_size), &compare);
  2c1417:	b9 91 0b 2c 00       	mov    $0x2c0b91,%ecx
  2c141c:	ba 10 00 00 00       	mov    $0x10,%edx
  2c1421:	4c 89 ee             	mov    %r13,%rsi
  2c1424:	48 89 df             	mov    %rbx,%rdi
  2c1427:	e8 6d f7 ff ff       	callq  2c0b99 <quicksort>
    long * size_array = malloc(num_allocs * sizeof(long));
  2c142c:	49 c1 e5 03          	shl    $0x3,%r13
  2c1430:	4c 89 ef             	mov    %r13,%rdi
  2c1433:	e8 2b fd ff ff       	callq  2c1163 <malloc>
  2c1438:	49 89 c6             	mov    %rax,%r14
    void ** ptr_array = malloc(num_allocs * sizeof(void *));
  2c143b:	4c 89 ef             	mov    %r13,%rdi
  2c143e:	e8 20 fd ff ff       	callq  2c1163 <malloc>
  2c1443:	49 89 c5             	mov    %rax,%r13
    if(size_array == 0 || ptr_array == 0) return -1;
  2c1446:	4d 85 f6             	test   %r14,%r14
  2c1449:	74 5d                	je     2c14a8 <heap_info+0x17c>
  2c144b:	48 85 c0             	test   %rax,%rax
  2c144e:	74 58                	je     2c14a8 <heap_info+0x17c>
    for(int i = 0; i < num_allocs; i++){
  2c1450:	45 85 ff             	test   %r15d,%r15d
  2c1453:	7e 27                	jle    2c147c <heap_info+0x150>
  2c1455:	44 89 f9             	mov    %r15d,%ecx
  2c1458:	48 c1 e1 03          	shl    $0x3,%rcx
  2c145c:	b8 00 00 00 00       	mov    $0x0,%eax
        size_array[i] = arr[i].size;
  2c1461:	48 8b 54 43 08       	mov    0x8(%rbx,%rax,2),%rdx
  2c1466:	49 89 14 06          	mov    %rdx,(%r14,%rax,1)
        ptr_array[i] = arr[i].ptr;
  2c146a:	48 8b 14 43          	mov    (%rbx,%rax,2),%rdx
  2c146e:	49 89 54 05 00       	mov    %rdx,0x0(%r13,%rax,1)
    for(int i = 0; i < num_allocs; i++){
  2c1473:	48 83 c0 08          	add    $0x8,%rax
  2c1477:	48 39 c1             	cmp    %rax,%rcx
  2c147a:	75 e5                	jne    2c1461 <heap_info+0x135>
    free(arr);
  2c147c:	48 89 df             	mov    %rbx,%rdi
  2c147f:	e8 02 fc ff ff       	callq  2c1086 <free>
    info->num_allocs = num_allocs;
  2c1484:	45 89 3c 24          	mov    %r15d,(%r12)
    info->size_array = size_array;
  2c1488:	4d 89 74 24 08       	mov    %r14,0x8(%r12)
    info->ptr_array = ptr_array;
  2c148d:	4d 89 6c 24 10       	mov    %r13,0x10(%r12)
    return 0;
  2c1492:	41 bf 00 00 00 00    	mov    $0x0,%r15d
  2c1498:	e9 ff fe ff ff       	jmpq   2c139c <heap_info+0x70>
    if(arr == 0) return -1;
  2c149d:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
  2c14a3:	e9 f4 fe ff ff       	jmpq   2c139c <heap_info+0x70>
    if(size_array == 0 || ptr_array == 0) return -1;
  2c14a8:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
  2c14ae:	e9 e9 fe ff ff       	jmpq   2c139c <heap_info+0x70>

00000000002c14b3 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c14b3:	55                   	push   %rbp
  2c14b4:	48 89 e5             	mov    %rsp,%rbp
  2c14b7:	48 83 ec 50          	sub    $0x50,%rsp
  2c14bb:	49 89 f2             	mov    %rsi,%r10
  2c14be:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c14c2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c14c6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c14ca:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c14ce:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  2c14d3:	85 ff                	test   %edi,%edi
  2c14d5:	78 2e                	js     2c1505 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c14d7:	48 63 ff             	movslq %edi,%rdi
  2c14da:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c14e1:	cc cc cc 
  2c14e4:	48 89 f8             	mov    %rdi,%rax
  2c14e7:	48 f7 e2             	mul    %rdx
  2c14ea:	48 89 d0             	mov    %rdx,%rax
  2c14ed:	48 c1 e8 02          	shr    $0x2,%rax
  2c14f1:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c14f5:	48 01 c2             	add    %rax,%rdx
  2c14f8:	48 29 d7             	sub    %rdx,%rdi
  2c14fb:	0f b6 b7 1d 19 2c 00 	movzbl 0x2c191d(%rdi),%esi
  2c1502:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  2c1505:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c150c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1510:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1514:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1518:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c151c:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c1520:	4c 89 d2             	mov    %r10,%rdx
  2c1523:	8b 3d d3 7a df ff    	mov    -0x20852d(%rip),%edi        # b8ffc <cursorpos>
  2c1529:	e8 47 f5 ff ff       	callq  2c0a75 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c152e:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c1533:	ba 00 00 00 00       	mov    $0x0,%edx
  2c1538:	0f 4d c2             	cmovge %edx,%eax
  2c153b:	89 05 bb 7a df ff    	mov    %eax,-0x208545(%rip)        # b8ffc <cursorpos>
    }
}
  2c1541:	c9                   	leaveq 
  2c1542:	c3                   	retq   

00000000002c1543 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  2c1543:	55                   	push   %rbp
  2c1544:	48 89 e5             	mov    %rsp,%rbp
  2c1547:	53                   	push   %rbx
  2c1548:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c154f:	48 89 fb             	mov    %rdi,%rbx
  2c1552:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c1556:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c155a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c155e:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c1562:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c1566:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c156d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1571:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c1575:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c1579:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c157d:	ba 07 00 00 00       	mov    $0x7,%edx
  2c1582:	be e7 18 2c 00       	mov    $0x2c18e7,%esi
  2c1587:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c158e:	e8 89 ec ff ff       	callq  2c021c <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c1593:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c1597:	48 89 da             	mov    %rbx,%rdx
  2c159a:	be 99 00 00 00       	mov    $0x99,%esi
  2c159f:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c15a6:	e8 45 f5 ff ff       	callq  2c0af0 <vsnprintf>
  2c15ab:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c15ae:	85 d2                	test   %edx,%edx
  2c15b0:	7e 0f                	jle    2c15c1 <kernel_panic+0x7e>
  2c15b2:	83 c0 06             	add    $0x6,%eax
  2c15b5:	48 98                	cltq   
  2c15b7:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c15be:	0a 
  2c15bf:	75 2a                	jne    2c15eb <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c15c1:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c15c8:	48 89 d9             	mov    %rbx,%rcx
  2c15cb:	ba ef 18 2c 00       	mov    $0x2c18ef,%edx
  2c15d0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c15d5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c15da:	b8 00 00 00 00       	mov    $0x0,%eax
  2c15df:	e8 d6 f4 ff ff       	callq  2c0aba <console_printf>
    asm volatile ("int %0" : /* no result */
  2c15e4:	48 89 df             	mov    %rbx,%rdi
  2c15e7:	cd 30                	int    $0x30
 loop: goto loop;
  2c15e9:	eb fe                	jmp    2c15e9 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c15eb:	48 63 c2             	movslq %edx,%rax
  2c15ee:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c15f4:	0f 94 c2             	sete   %dl
  2c15f7:	0f b6 d2             	movzbl %dl,%edx
  2c15fa:	48 29 d0             	sub    %rdx,%rax
  2c15fd:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c1604:	ff 
  2c1605:	be 7c 16 2c 00       	mov    $0x2c167c,%esi
  2c160a:	e8 cf ec ff ff       	callq  2c02de <strcpy>
  2c160f:	eb b0                	jmp    2c15c1 <kernel_panic+0x7e>

00000000002c1611 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c1611:	55                   	push   %rbp
  2c1612:	48 89 e5             	mov    %rsp,%rbp
  2c1615:	48 89 f9             	mov    %rdi,%rcx
  2c1618:	41 89 f0             	mov    %esi,%r8d
  2c161b:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c161e:	ba f8 18 2c 00       	mov    $0x2c18f8,%edx
  2c1623:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c1628:	bf 30 07 00 00       	mov    $0x730,%edi
  2c162d:	b8 00 00 00 00       	mov    $0x0,%eax
  2c1632:	e8 83 f4 ff ff       	callq  2c0aba <console_printf>
    asm volatile ("int %0" : /* no result */
  2c1637:	bf 00 00 00 00       	mov    $0x0,%edi
  2c163c:	cd 30                	int    $0x30
 loop: goto loop;
  2c163e:	eb fe                	jmp    2c163e <assert_fail+0x2d>

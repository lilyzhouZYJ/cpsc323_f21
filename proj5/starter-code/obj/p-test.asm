
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:

// These global variables go on the data page.
uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	41 54                	push   %r12
  100006:	53                   	push   %rbx

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100007:	cd 31                	int    $0x31
  100009:	41 89 c4             	mov    %eax,%r12d

    pid_t parent = sys_getpid();
    app_printf(parent, "Parent pid is %d\n", parent);
  10000c:	89 c2                	mov    %eax,%edx
  10000e:	be 00 0d 10 00       	mov    $0x100d00,%esi
  100013:	89 c7                	mov    %eax,%edi
  100015:	b8 00 00 00 00       	mov    $0x0,%eax
  10001a:	e8 54 0b 00 00       	callq  100b73 <app_printf>
// sys_fork()
//    Fork the current process. On success, return the child's process ID to
//    the parent, and return 0 to the child. On failure, return -1.
static inline pid_t sys_fork(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10001f:	cd 34                	int    $0x34
    pid_t fork = sys_fork();
    assert(fork >= 0);
  100021:	85 c0                	test   %eax,%eax
  100023:	78 44                	js     100069 <process_main+0x69>
  100025:	89 c3                	mov    %eax,%ebx

    srand(parent);
  100027:	44 89 e7             	mov    %r12d,%edi
  10002a:	e8 38 03 00 00       	callq  100367 <srand>
    if(fork != 0){
  10002f:	85 db                	test   %ebx,%ebx
  100031:	75 4a                	jne    10007d <process_main+0x7d>
    asm volatile ("int %1" : "=a" (result)
  100033:	cd 31                	int    $0x31
  100035:	89 c3                	mov    %eax,%ebx
    }
    else
    {
child:;
        pid_t p = sys_getpid();
        srand(p);
  100037:	89 c7                	mov    %eax,%edi
  100039:	e8 29 03 00 00       	callq  100367 <srand>

        // The heap starts on the page right after the 'end' symbol,
        // whose address is the first address not allocated to process code
        // or data.
        heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10003e:	b8 17 20 10 00       	mov    $0x102017,%eax
  100043:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100049:	48 89 05 b8 0f 00 00 	mov    %rax,0xfb8(%rip)        # 101008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100050:	48 89 e0             	mov    %rsp,%rax

        // The bottom of the stack is the first address on the current
        // stack page (this process never needs more than one stack page).
        stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100053:	48 83 e8 01          	sub    $0x1,%rax
  100057:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10005d:	48 89 05 9c 0f 00 00 	mov    %rax,0xf9c(%rip)        # 101000 <stack_bottom>
  100064:	e9 85 00 00 00       	jmpq   1000ee <process_main+0xee>
    assert(fork >= 0);
  100069:	ba 12 0d 10 00       	mov    $0x100d12,%edx
  10006e:	be 10 00 00 00       	mov    $0x10,%esi
  100073:	bf 1c 0d 10 00       	mov    $0x100d1c,%edi
  100078:	e8 53 0c 00 00       	callq  100cd0 <assert_fail>
        app_printf(parent, "%dp\n", parent);
  10007d:	44 89 e2             	mov    %r12d,%edx
  100080:	be 25 0d 10 00       	mov    $0x100d25,%esi
  100085:	44 89 e7             	mov    %r12d,%edi
  100088:	b8 00 00 00 00       	mov    $0x0,%eax
  10008d:	e8 e1 0a 00 00       	callq  100b73 <app_printf>
  100092:	eb 08                	jmp    10009c <process_main+0x9c>
    asm volatile ("int %1" : "=a" (result)
  100094:	cd 34                	int    $0x34
                if(fork_new == 0){
  100096:	85 c0                	test   %eax,%eax
  100098:	74 99                	je     100033 <process_main+0x33>
    asm volatile ("int %0" : /* no result */
  10009a:	cd 32                	int    $0x32
            if(rand() % ALLOC_SLOWDOWN == parent){
  10009c:	e8 8c 02 00 00       	callq  10032d <rand>
  1000a1:	48 63 d0             	movslq %eax,%rdx
  1000a4:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1000ab:	48 c1 fa 25          	sar    $0x25,%rdx
  1000af:	89 c1                	mov    %eax,%ecx
  1000b1:	c1 f9 1f             	sar    $0x1f,%ecx
  1000b4:	29 ca                	sub    %ecx,%edx
  1000b6:	6b d2 64             	imul   $0x64,%edx,%edx
  1000b9:	29 d0                	sub    %edx,%eax
  1000bb:	44 39 e0             	cmp    %r12d,%eax
  1000be:	74 d4                	je     100094 <process_main+0x94>
  1000c0:	cd 32                	int    $0x32
}
  1000c2:	eb d8                	jmp    10009c <process_main+0x9c>

        // Allocate heap pages until (1) hit the stack (out of address space)
        // or (2) allocation fails (out of physical memory).
        while (1) {
            if ((rand() % ALLOC_SLOWDOWN) < p) {
                assert(sys_getpid() != parent);
  1000c4:	ba 2a 0d 10 00       	mov    $0x100d2a,%edx
  1000c9:	be 36 00 00 00       	mov    $0x36,%esi
  1000ce:	bf 1c 0d 10 00       	mov    $0x100d1c,%edi
  1000d3:	e8 f8 0b 00 00       	callq  100cd0 <assert_fail>
                if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
                    break;
                }
                *heap_top = p;      /* check we have write access to new page */
  1000d8:	48 8b 05 29 0f 00 00 	mov    0xf29(%rip),%rax        # 101008 <heap_top>
  1000df:	88 18                	mov    %bl,(%rax)
                heap_top += PAGESIZE;
  1000e1:	48 81 05 1c 0f 00 00 	addq   $0x1000,0xf1c(%rip)        # 101008 <heap_top>
  1000e8:	00 10 00 00 
    asm volatile ("int %0" : /* no result */
  1000ec:	cd 32                	int    $0x32
            if ((rand() % ALLOC_SLOWDOWN) < p) {
  1000ee:	e8 3a 02 00 00       	callq  10032d <rand>
  1000f3:	48 63 d0             	movslq %eax,%rdx
  1000f6:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1000fd:	48 c1 fa 25          	sar    $0x25,%rdx
  100101:	89 c1                	mov    %eax,%ecx
  100103:	c1 f9 1f             	sar    $0x1f,%ecx
  100106:	29 ca                	sub    %ecx,%edx
  100108:	6b d2 64             	imul   $0x64,%edx,%edx
  10010b:	29 d0                	sub    %edx,%eax
  10010d:	39 d8                	cmp    %ebx,%eax
  10010f:	7d db                	jge    1000ec <process_main+0xec>
    asm volatile ("int %1" : "=a" (result)
  100111:	cd 31                	int    $0x31
                assert(sys_getpid() != parent);
  100113:	41 39 c4             	cmp    %eax,%r12d
  100116:	74 ac                	je     1000c4 <process_main+0xc4>
                if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  100118:	48 8b 3d e9 0e 00 00 	mov    0xee9(%rip),%rdi        # 101008 <heap_top>
  10011f:	48 3b 3d da 0e 00 00 	cmp    0xeda(%rip),%rdi        # 101000 <stack_bottom>
  100126:	74 17                	je     10013f <process_main+0x13f>
    if(ad >= 0x300000)
  100128:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
  10012e:	75 0f                	jne    10013f <process_main+0x13f>
  100130:	48 81 ff ff ff 2f 00 	cmp    $0x2fffff,%rdi
  100137:	77 06                	ja     10013f <process_main+0x13f>
    asm volatile ("int %1" : "=a" (result)
  100139:	cd 33                	int    $0x33
  10013b:	85 c0                	test   %eax,%eax
  10013d:	79 99                	jns    1000d8 <process_main+0xd8>
void process_main(void) {
  10013f:	b8 0a 00 00 00       	mov    $0xa,%eax
    asm volatile ("int %0" : /* no result */
  100144:	cd 32                	int    $0x32
            sys_yield();
        }

        // After running out of memory, make an exit after 10 yields
        int i = 10;
        while(i--){
  100146:	83 e8 01             	sub    $0x1,%eax
  100149:	75 f9                	jne    100144 <process_main+0x144>
            sys_yield();
        }
        app_printf(p, "%d\n", p);
  10014b:	89 da                	mov    %ebx,%edx
  10014d:	be 0e 0d 10 00       	mov    $0x100d0e,%esi
  100152:	89 df                	mov    %ebx,%edi
  100154:	b8 00 00 00 00       	mov    $0x0,%eax
  100159:	e8 15 0a 00 00       	callq  100b73 <app_printf>

// sys_exit()
//    Exit this process. Does not return.
static inline void sys_exit(void) __attribute__((noreturn));
static inline void sys_exit(void) {
    asm volatile ("int %0" : /* no result */
  10015e:	cd 35                	int    $0x35
                  : "i" (INT_SYS_EXIT)
                  : "cc", "memory");
 spinloop: goto spinloop;       // should never get here
  100160:	eb fe                	jmp    100160 <process_main+0x160>

0000000000100162 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100162:	48 89 f9             	mov    %rdi,%rcx
  100165:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100167:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  10016e:	00 
  10016f:	72 08                	jb     100179 <console_putc+0x17>
        cp->cursor = console;
  100171:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  100178:	00 
    }
    if (c == '\n') {
  100179:	40 80 fe 0a          	cmp    $0xa,%sil
  10017d:	74 16                	je     100195 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  10017f:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100183:	48 8d 50 02          	lea    0x2(%rax),%rdx
  100187:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  10018b:	40 0f b6 f6          	movzbl %sil,%esi
  10018f:	09 fe                	or     %edi,%esi
  100191:	66 89 30             	mov    %si,(%rax)
    }
}
  100194:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  100195:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  100199:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  1001a0:	4c 89 c6             	mov    %r8,%rsi
  1001a3:	48 d1 fe             	sar    %rsi
  1001a6:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1001ad:	66 66 66 
  1001b0:	48 89 f0             	mov    %rsi,%rax
  1001b3:	48 f7 ea             	imul   %rdx
  1001b6:	48 c1 fa 05          	sar    $0x5,%rdx
  1001ba:	49 c1 f8 3f          	sar    $0x3f,%r8
  1001be:	4c 29 c2             	sub    %r8,%rdx
  1001c1:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  1001c5:	48 c1 e2 04          	shl    $0x4,%rdx
  1001c9:	89 f0                	mov    %esi,%eax
  1001cb:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1001cd:	83 cf 20             	or     $0x20,%edi
  1001d0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1001d4:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  1001d8:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1001dc:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  1001df:	83 c0 01             	add    $0x1,%eax
  1001e2:	83 f8 50             	cmp    $0x50,%eax
  1001e5:	75 e9                	jne    1001d0 <console_putc+0x6e>
  1001e7:	c3                   	retq   

00000000001001e8 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1001e8:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1001ec:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1001f0:	73 0b                	jae    1001fd <string_putc+0x15>
        *sp->s++ = c;
  1001f2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1001f6:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  1001fa:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  1001fd:	c3                   	retq   

00000000001001fe <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  1001fe:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100201:	48 85 d2             	test   %rdx,%rdx
  100204:	74 17                	je     10021d <memcpy+0x1f>
  100206:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  10020b:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  100210:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100214:	48 83 c1 01          	add    $0x1,%rcx
  100218:	48 39 d1             	cmp    %rdx,%rcx
  10021b:	75 ee                	jne    10020b <memcpy+0xd>
}
  10021d:	c3                   	retq   

000000000010021e <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  10021e:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  100221:	48 39 fe             	cmp    %rdi,%rsi
  100224:	72 1d                	jb     100243 <memmove+0x25>
        while (n-- > 0) {
  100226:	b9 00 00 00 00       	mov    $0x0,%ecx
  10022b:	48 85 d2             	test   %rdx,%rdx
  10022e:	74 12                	je     100242 <memmove+0x24>
            *d++ = *s++;
  100230:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  100234:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  100238:	48 83 c1 01          	add    $0x1,%rcx
  10023c:	48 39 ca             	cmp    %rcx,%rdx
  10023f:	75 ef                	jne    100230 <memmove+0x12>
}
  100241:	c3                   	retq   
  100242:	c3                   	retq   
    if (s < d && s + n > d) {
  100243:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  100247:	48 39 cf             	cmp    %rcx,%rdi
  10024a:	73 da                	jae    100226 <memmove+0x8>
        while (n-- > 0) {
  10024c:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  100250:	48 85 d2             	test   %rdx,%rdx
  100253:	74 ec                	je     100241 <memmove+0x23>
            *--d = *--s;
  100255:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  100259:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  10025c:	48 83 e9 01          	sub    $0x1,%rcx
  100260:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  100264:	75 ef                	jne    100255 <memmove+0x37>
  100266:	c3                   	retq   

0000000000100267 <memset>:
void* memset(void* v, int c, size_t n) {
  100267:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10026a:	48 85 d2             	test   %rdx,%rdx
  10026d:	74 12                	je     100281 <memset+0x1a>
  10026f:	48 01 fa             	add    %rdi,%rdx
  100272:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  100275:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100278:	48 83 c1 01          	add    $0x1,%rcx
  10027c:	48 39 ca             	cmp    %rcx,%rdx
  10027f:	75 f4                	jne    100275 <memset+0xe>
}
  100281:	c3                   	retq   

0000000000100282 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100282:	80 3f 00             	cmpb   $0x0,(%rdi)
  100285:	74 10                	je     100297 <strlen+0x15>
  100287:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  10028c:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  100290:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  100294:	75 f6                	jne    10028c <strlen+0xa>
  100296:	c3                   	retq   
  100297:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10029c:	c3                   	retq   

000000000010029d <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  10029d:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1002a0:	ba 00 00 00 00       	mov    $0x0,%edx
  1002a5:	48 85 f6             	test   %rsi,%rsi
  1002a8:	74 11                	je     1002bb <strnlen+0x1e>
  1002aa:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  1002ae:	74 0c                	je     1002bc <strnlen+0x1f>
        ++n;
  1002b0:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1002b4:	48 39 d0             	cmp    %rdx,%rax
  1002b7:	75 f1                	jne    1002aa <strnlen+0xd>
  1002b9:	eb 04                	jmp    1002bf <strnlen+0x22>
  1002bb:	c3                   	retq   
  1002bc:	48 89 d0             	mov    %rdx,%rax
}
  1002bf:	c3                   	retq   

00000000001002c0 <strcpy>:
char* strcpy(char* dst, const char* src) {
  1002c0:	48 89 f8             	mov    %rdi,%rax
  1002c3:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  1002c8:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1002cc:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1002cf:	48 83 c2 01          	add    $0x1,%rdx
  1002d3:	84 c9                	test   %cl,%cl
  1002d5:	75 f1                	jne    1002c8 <strcpy+0x8>
}
  1002d7:	c3                   	retq   

00000000001002d8 <strcmp>:
    while (*a && *b && *a == *b) {
  1002d8:	0f b6 07             	movzbl (%rdi),%eax
  1002db:	84 c0                	test   %al,%al
  1002dd:	74 1a                	je     1002f9 <strcmp+0x21>
  1002df:	0f b6 16             	movzbl (%rsi),%edx
  1002e2:	38 c2                	cmp    %al,%dl
  1002e4:	75 13                	jne    1002f9 <strcmp+0x21>
  1002e6:	84 d2                	test   %dl,%dl
  1002e8:	74 0f                	je     1002f9 <strcmp+0x21>
        ++a, ++b;
  1002ea:	48 83 c7 01          	add    $0x1,%rdi
  1002ee:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  1002f2:	0f b6 07             	movzbl (%rdi),%eax
  1002f5:	84 c0                	test   %al,%al
  1002f7:	75 e6                	jne    1002df <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  1002f9:	3a 06                	cmp    (%rsi),%al
  1002fb:	0f 97 c0             	seta   %al
  1002fe:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  100301:	83 d8 00             	sbb    $0x0,%eax
}
  100304:	c3                   	retq   

0000000000100305 <strchr>:
    while (*s && *s != (char) c) {
  100305:	0f b6 07             	movzbl (%rdi),%eax
  100308:	84 c0                	test   %al,%al
  10030a:	74 10                	je     10031c <strchr+0x17>
  10030c:	40 38 f0             	cmp    %sil,%al
  10030f:	74 18                	je     100329 <strchr+0x24>
        ++s;
  100311:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  100315:	0f b6 07             	movzbl (%rdi),%eax
  100318:	84 c0                	test   %al,%al
  10031a:	75 f0                	jne    10030c <strchr+0x7>
        return NULL;
  10031c:	40 84 f6             	test   %sil,%sil
  10031f:	b8 00 00 00 00       	mov    $0x0,%eax
  100324:	48 0f 44 c7          	cmove  %rdi,%rax
}
  100328:	c3                   	retq   
  100329:	48 89 f8             	mov    %rdi,%rax
  10032c:	c3                   	retq   

000000000010032d <rand>:
    if (!rand_seed_set) {
  10032d:	83 3d e0 0c 00 00 00 	cmpl   $0x0,0xce0(%rip)        # 101014 <rand_seed_set>
  100334:	74 1b                	je     100351 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100336:	69 05 d0 0c 00 00 0d 	imul   $0x19660d,0xcd0(%rip),%eax        # 101010 <rand_seed>
  10033d:	66 19 00 
  100340:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100345:	89 05 c5 0c 00 00    	mov    %eax,0xcc5(%rip)        # 101010 <rand_seed>
    return rand_seed & RAND_MAX;
  10034b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100350:	c3                   	retq   
    rand_seed = seed;
  100351:	c7 05 b5 0c 00 00 9e 	movl   $0x30d4879e,0xcb5(%rip)        # 101010 <rand_seed>
  100358:	87 d4 30 
    rand_seed_set = 1;
  10035b:	c7 05 af 0c 00 00 01 	movl   $0x1,0xcaf(%rip)        # 101014 <rand_seed_set>
  100362:	00 00 00 
}
  100365:	eb cf                	jmp    100336 <rand+0x9>

0000000000100367 <srand>:
    rand_seed = seed;
  100367:	89 3d a3 0c 00 00    	mov    %edi,0xca3(%rip)        # 101010 <rand_seed>
    rand_seed_set = 1;
  10036d:	c7 05 9d 0c 00 00 01 	movl   $0x1,0xc9d(%rip)        # 101014 <rand_seed_set>
  100374:	00 00 00 
}
  100377:	c3                   	retq   

0000000000100378 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100378:	55                   	push   %rbp
  100379:	48 89 e5             	mov    %rsp,%rbp
  10037c:	41 57                	push   %r15
  10037e:	41 56                	push   %r14
  100380:	41 55                	push   %r13
  100382:	41 54                	push   %r12
  100384:	53                   	push   %rbx
  100385:	48 83 ec 58          	sub    $0x58,%rsp
  100389:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  10038d:	0f b6 02             	movzbl (%rdx),%eax
  100390:	84 c0                	test   %al,%al
  100392:	0f 84 b0 06 00 00    	je     100a48 <printer_vprintf+0x6d0>
  100398:	49 89 fe             	mov    %rdi,%r14
  10039b:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  10039e:	41 89 f7             	mov    %esi,%r15d
  1003a1:	e9 a4 04 00 00       	jmpq   10084a <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  1003a6:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  1003ab:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1003b1:	45 84 e4             	test   %r12b,%r12b
  1003b4:	0f 84 82 06 00 00    	je     100a3c <printer_vprintf+0x6c4>
        int flags = 0;
  1003ba:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  1003c0:	41 0f be f4          	movsbl %r12b,%esi
  1003c4:	bf 41 0f 10 00       	mov    $0x100f41,%edi
  1003c9:	e8 37 ff ff ff       	callq  100305 <strchr>
  1003ce:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1003d1:	48 85 c0             	test   %rax,%rax
  1003d4:	74 55                	je     10042b <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  1003d6:	48 81 e9 41 0f 10 00 	sub    $0x100f41,%rcx
  1003dd:	b8 01 00 00 00       	mov    $0x1,%eax
  1003e2:	d3 e0                	shl    %cl,%eax
  1003e4:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1003e7:	48 83 c3 01          	add    $0x1,%rbx
  1003eb:	44 0f b6 23          	movzbl (%rbx),%r12d
  1003ef:	45 84 e4             	test   %r12b,%r12b
  1003f2:	75 cc                	jne    1003c0 <printer_vprintf+0x48>
  1003f4:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  1003f8:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  1003fe:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  100405:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  100408:	0f 84 a9 00 00 00    	je     1004b7 <printer_vprintf+0x13f>
        int length = 0;
  10040e:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  100413:	0f b6 13             	movzbl (%rbx),%edx
  100416:	8d 42 bd             	lea    -0x43(%rdx),%eax
  100419:	3c 37                	cmp    $0x37,%al
  10041b:	0f 87 c4 04 00 00    	ja     1008e5 <printer_vprintf+0x56d>
  100421:	0f b6 c0             	movzbl %al,%eax
  100424:	ff 24 c5 50 0d 10 00 	jmpq   *0x100d50(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  10042b:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  10042f:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  100434:	3c 08                	cmp    $0x8,%al
  100436:	77 2f                	ja     100467 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100438:	0f b6 03             	movzbl (%rbx),%eax
  10043b:	8d 50 d0             	lea    -0x30(%rax),%edx
  10043e:	80 fa 09             	cmp    $0x9,%dl
  100441:	77 5e                	ja     1004a1 <printer_vprintf+0x129>
  100443:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  100449:	48 83 c3 01          	add    $0x1,%rbx
  10044d:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100452:	0f be c0             	movsbl %al,%eax
  100455:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10045a:	0f b6 03             	movzbl (%rbx),%eax
  10045d:	8d 50 d0             	lea    -0x30(%rax),%edx
  100460:	80 fa 09             	cmp    $0x9,%dl
  100463:	76 e4                	jbe    100449 <printer_vprintf+0xd1>
  100465:	eb 97                	jmp    1003fe <printer_vprintf+0x86>
        } else if (*format == '*') {
  100467:	41 80 fc 2a          	cmp    $0x2a,%r12b
  10046b:	75 3f                	jne    1004ac <printer_vprintf+0x134>
            width = va_arg(val, int);
  10046d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100471:	8b 07                	mov    (%rdi),%eax
  100473:	83 f8 2f             	cmp    $0x2f,%eax
  100476:	77 17                	ja     10048f <printer_vprintf+0x117>
  100478:	89 c2                	mov    %eax,%edx
  10047a:	48 03 57 10          	add    0x10(%rdi),%rdx
  10047e:	83 c0 08             	add    $0x8,%eax
  100481:	89 07                	mov    %eax,(%rdi)
  100483:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  100486:	48 83 c3 01          	add    $0x1,%rbx
  10048a:	e9 6f ff ff ff       	jmpq   1003fe <printer_vprintf+0x86>
            width = va_arg(val, int);
  10048f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100493:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100497:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10049b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10049f:	eb e2                	jmp    100483 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1004a1:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1004a7:	e9 52 ff ff ff       	jmpq   1003fe <printer_vprintf+0x86>
        int width = -1;
  1004ac:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1004b2:	e9 47 ff ff ff       	jmpq   1003fe <printer_vprintf+0x86>
            ++format;
  1004b7:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1004bb:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1004bf:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1004c2:	80 f9 09             	cmp    $0x9,%cl
  1004c5:	76 13                	jbe    1004da <printer_vprintf+0x162>
            } else if (*format == '*') {
  1004c7:	3c 2a                	cmp    $0x2a,%al
  1004c9:	74 33                	je     1004fe <printer_vprintf+0x186>
            ++format;
  1004cb:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1004ce:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1004d5:	e9 34 ff ff ff       	jmpq   10040e <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1004da:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  1004df:	48 83 c2 01          	add    $0x1,%rdx
  1004e3:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  1004e6:	0f be c0             	movsbl %al,%eax
  1004e9:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1004ed:	0f b6 02             	movzbl (%rdx),%eax
  1004f0:	8d 70 d0             	lea    -0x30(%rax),%esi
  1004f3:	40 80 fe 09          	cmp    $0x9,%sil
  1004f7:	76 e6                	jbe    1004df <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  1004f9:	48 89 d3             	mov    %rdx,%rbx
  1004fc:	eb 1c                	jmp    10051a <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  1004fe:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100502:	8b 07                	mov    (%rdi),%eax
  100504:	83 f8 2f             	cmp    $0x2f,%eax
  100507:	77 23                	ja     10052c <printer_vprintf+0x1b4>
  100509:	89 c2                	mov    %eax,%edx
  10050b:	48 03 57 10          	add    0x10(%rdi),%rdx
  10050f:	83 c0 08             	add    $0x8,%eax
  100512:	89 07                	mov    %eax,(%rdi)
  100514:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  100516:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  10051a:	85 c9                	test   %ecx,%ecx
  10051c:	b8 00 00 00 00       	mov    $0x0,%eax
  100521:	0f 49 c1             	cmovns %ecx,%eax
  100524:	89 45 9c             	mov    %eax,-0x64(%rbp)
  100527:	e9 e2 fe ff ff       	jmpq   10040e <printer_vprintf+0x96>
                precision = va_arg(val, int);
  10052c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100530:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100534:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100538:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10053c:	eb d6                	jmp    100514 <printer_vprintf+0x19c>
        switch (*format) {
  10053e:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100543:	e9 f3 00 00 00       	jmpq   10063b <printer_vprintf+0x2c3>
            ++format;
  100548:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  10054c:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100551:	e9 bd fe ff ff       	jmpq   100413 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100556:	85 c9                	test   %ecx,%ecx
  100558:	74 55                	je     1005af <printer_vprintf+0x237>
  10055a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10055e:	8b 07                	mov    (%rdi),%eax
  100560:	83 f8 2f             	cmp    $0x2f,%eax
  100563:	77 38                	ja     10059d <printer_vprintf+0x225>
  100565:	89 c2                	mov    %eax,%edx
  100567:	48 03 57 10          	add    0x10(%rdi),%rdx
  10056b:	83 c0 08             	add    $0x8,%eax
  10056e:	89 07                	mov    %eax,(%rdi)
  100570:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100573:	48 89 d0             	mov    %rdx,%rax
  100576:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  10057a:	49 89 d0             	mov    %rdx,%r8
  10057d:	49 f7 d8             	neg    %r8
  100580:	25 80 00 00 00       	and    $0x80,%eax
  100585:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100589:	0b 45 a8             	or     -0x58(%rbp),%eax
  10058c:	83 c8 60             	or     $0x60,%eax
  10058f:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  100592:	41 bc 11 0d 10 00    	mov    $0x100d11,%r12d
            break;
  100598:	e9 35 01 00 00       	jmpq   1006d2 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10059d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005a1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005a5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005a9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005ad:	eb c1                	jmp    100570 <printer_vprintf+0x1f8>
  1005af:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005b3:	8b 07                	mov    (%rdi),%eax
  1005b5:	83 f8 2f             	cmp    $0x2f,%eax
  1005b8:	77 10                	ja     1005ca <printer_vprintf+0x252>
  1005ba:	89 c2                	mov    %eax,%edx
  1005bc:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005c0:	83 c0 08             	add    $0x8,%eax
  1005c3:	89 07                	mov    %eax,(%rdi)
  1005c5:	48 63 12             	movslq (%rdx),%rdx
  1005c8:	eb a9                	jmp    100573 <printer_vprintf+0x1fb>
  1005ca:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005ce:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1005d2:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005d6:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1005da:	eb e9                	jmp    1005c5 <printer_vprintf+0x24d>
        int base = 10;
  1005dc:	be 0a 00 00 00       	mov    $0xa,%esi
  1005e1:	eb 58                	jmp    10063b <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1005e3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005e7:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005eb:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005ef:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005f3:	eb 60                	jmp    100655 <printer_vprintf+0x2dd>
  1005f5:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005f9:	8b 07                	mov    (%rdi),%eax
  1005fb:	83 f8 2f             	cmp    $0x2f,%eax
  1005fe:	77 10                	ja     100610 <printer_vprintf+0x298>
  100600:	89 c2                	mov    %eax,%edx
  100602:	48 03 57 10          	add    0x10(%rdi),%rdx
  100606:	83 c0 08             	add    $0x8,%eax
  100609:	89 07                	mov    %eax,(%rdi)
  10060b:	44 8b 02             	mov    (%rdx),%r8d
  10060e:	eb 48                	jmp    100658 <printer_vprintf+0x2e0>
  100610:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100614:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100618:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10061c:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100620:	eb e9                	jmp    10060b <printer_vprintf+0x293>
  100622:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  100625:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  10062c:	bf 30 0f 10 00       	mov    $0x100f30,%edi
  100631:	e9 e2 02 00 00       	jmpq   100918 <printer_vprintf+0x5a0>
            base = 16;
  100636:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10063b:	85 c9                	test   %ecx,%ecx
  10063d:	74 b6                	je     1005f5 <printer_vprintf+0x27d>
  10063f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100643:	8b 01                	mov    (%rcx),%eax
  100645:	83 f8 2f             	cmp    $0x2f,%eax
  100648:	77 99                	ja     1005e3 <printer_vprintf+0x26b>
  10064a:	89 c2                	mov    %eax,%edx
  10064c:	48 03 51 10          	add    0x10(%rcx),%rdx
  100650:	83 c0 08             	add    $0x8,%eax
  100653:	89 01                	mov    %eax,(%rcx)
  100655:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  100658:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  10065c:	85 f6                	test   %esi,%esi
  10065e:	79 c2                	jns    100622 <printer_vprintf+0x2aa>
        base = -base;
  100660:	41 89 f1             	mov    %esi,%r9d
  100663:	f7 de                	neg    %esi
  100665:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  10066c:	bf 10 0f 10 00       	mov    $0x100f10,%edi
  100671:	e9 a2 02 00 00       	jmpq   100918 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  100676:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10067a:	8b 07                	mov    (%rdi),%eax
  10067c:	83 f8 2f             	cmp    $0x2f,%eax
  10067f:	77 1c                	ja     10069d <printer_vprintf+0x325>
  100681:	89 c2                	mov    %eax,%edx
  100683:	48 03 57 10          	add    0x10(%rdi),%rdx
  100687:	83 c0 08             	add    $0x8,%eax
  10068a:	89 07                	mov    %eax,(%rdi)
  10068c:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  10068f:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  100696:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  10069b:	eb c3                	jmp    100660 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  10069d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1006a1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1006a5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1006a9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1006ad:	eb dd                	jmp    10068c <printer_vprintf+0x314>
            data = va_arg(val, char*);
  1006af:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1006b3:	8b 01                	mov    (%rcx),%eax
  1006b5:	83 f8 2f             	cmp    $0x2f,%eax
  1006b8:	0f 87 a5 01 00 00    	ja     100863 <printer_vprintf+0x4eb>
  1006be:	89 c2                	mov    %eax,%edx
  1006c0:	48 03 51 10          	add    0x10(%rcx),%rdx
  1006c4:	83 c0 08             	add    $0x8,%eax
  1006c7:	89 01                	mov    %eax,(%rcx)
  1006c9:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1006cc:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1006d2:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006d5:	83 e0 20             	and    $0x20,%eax
  1006d8:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1006db:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1006e1:	0f 85 21 02 00 00    	jne    100908 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1006e7:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006ea:	89 45 88             	mov    %eax,-0x78(%rbp)
  1006ed:	83 e0 60             	and    $0x60,%eax
  1006f0:	83 f8 60             	cmp    $0x60,%eax
  1006f3:	0f 84 54 02 00 00    	je     10094d <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1006f9:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006fc:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  1006ff:	48 c7 45 a0 11 0d 10 	movq   $0x100d11,-0x60(%rbp)
  100706:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100707:	83 f8 21             	cmp    $0x21,%eax
  10070a:	0f 84 79 02 00 00    	je     100989 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100710:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  100713:	89 f8                	mov    %edi,%eax
  100715:	f7 d0                	not    %eax
  100717:	c1 e8 1f             	shr    $0x1f,%eax
  10071a:	89 45 84             	mov    %eax,-0x7c(%rbp)
  10071d:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100721:	0f 85 9e 02 00 00    	jne    1009c5 <printer_vprintf+0x64d>
  100727:	84 c0                	test   %al,%al
  100729:	0f 84 96 02 00 00    	je     1009c5 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  10072f:	48 63 f7             	movslq %edi,%rsi
  100732:	4c 89 e7             	mov    %r12,%rdi
  100735:	e8 63 fb ff ff       	callq  10029d <strnlen>
  10073a:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  10073d:	8b 45 88             	mov    -0x78(%rbp),%eax
  100740:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  100743:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  10074a:	83 f8 22             	cmp    $0x22,%eax
  10074d:	0f 84 aa 02 00 00    	je     1009fd <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100753:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100757:	e8 26 fb ff ff       	callq  100282 <strlen>
  10075c:	8b 55 9c             	mov    -0x64(%rbp),%edx
  10075f:	03 55 98             	add    -0x68(%rbp),%edx
  100762:	44 89 e9             	mov    %r13d,%ecx
  100765:	29 d1                	sub    %edx,%ecx
  100767:	29 c1                	sub    %eax,%ecx
  100769:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  10076c:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10076f:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100773:	75 2d                	jne    1007a2 <printer_vprintf+0x42a>
  100775:	85 c9                	test   %ecx,%ecx
  100777:	7e 29                	jle    1007a2 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  100779:	44 89 fa             	mov    %r15d,%edx
  10077c:	be 20 00 00 00       	mov    $0x20,%esi
  100781:	4c 89 f7             	mov    %r14,%rdi
  100784:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100787:	41 83 ed 01          	sub    $0x1,%r13d
  10078b:	45 85 ed             	test   %r13d,%r13d
  10078e:	7f e9                	jg     100779 <printer_vprintf+0x401>
  100790:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  100793:	85 ff                	test   %edi,%edi
  100795:	b8 01 00 00 00       	mov    $0x1,%eax
  10079a:	0f 4f c7             	cmovg  %edi,%eax
  10079d:	29 c7                	sub    %eax,%edi
  10079f:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  1007a2:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1007a6:	0f b6 07             	movzbl (%rdi),%eax
  1007a9:	84 c0                	test   %al,%al
  1007ab:	74 22                	je     1007cf <printer_vprintf+0x457>
  1007ad:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007b1:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  1007b4:	0f b6 f0             	movzbl %al,%esi
  1007b7:	44 89 fa             	mov    %r15d,%edx
  1007ba:	4c 89 f7             	mov    %r14,%rdi
  1007bd:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  1007c0:	48 83 c3 01          	add    $0x1,%rbx
  1007c4:	0f b6 03             	movzbl (%rbx),%eax
  1007c7:	84 c0                	test   %al,%al
  1007c9:	75 e9                	jne    1007b4 <printer_vprintf+0x43c>
  1007cb:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1007cf:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1007d2:	85 c0                	test   %eax,%eax
  1007d4:	7e 1d                	jle    1007f3 <printer_vprintf+0x47b>
  1007d6:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007da:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1007dc:	44 89 fa             	mov    %r15d,%edx
  1007df:	be 30 00 00 00       	mov    $0x30,%esi
  1007e4:	4c 89 f7             	mov    %r14,%rdi
  1007e7:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  1007ea:	83 eb 01             	sub    $0x1,%ebx
  1007ed:	75 ed                	jne    1007dc <printer_vprintf+0x464>
  1007ef:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  1007f3:	8b 45 98             	mov    -0x68(%rbp),%eax
  1007f6:	85 c0                	test   %eax,%eax
  1007f8:	7e 27                	jle    100821 <printer_vprintf+0x4a9>
  1007fa:	89 c0                	mov    %eax,%eax
  1007fc:	4c 01 e0             	add    %r12,%rax
  1007ff:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100803:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  100806:	41 0f b6 34 24       	movzbl (%r12),%esi
  10080b:	44 89 fa             	mov    %r15d,%edx
  10080e:	4c 89 f7             	mov    %r14,%rdi
  100811:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  100814:	49 83 c4 01          	add    $0x1,%r12
  100818:	49 39 dc             	cmp    %rbx,%r12
  10081b:	75 e9                	jne    100806 <printer_vprintf+0x48e>
  10081d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  100821:	45 85 ed             	test   %r13d,%r13d
  100824:	7e 14                	jle    10083a <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  100826:	44 89 fa             	mov    %r15d,%edx
  100829:	be 20 00 00 00       	mov    $0x20,%esi
  10082e:	4c 89 f7             	mov    %r14,%rdi
  100831:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  100834:	41 83 ed 01          	sub    $0x1,%r13d
  100838:	75 ec                	jne    100826 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  10083a:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  10083e:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100842:	84 c0                	test   %al,%al
  100844:	0f 84 fe 01 00 00    	je     100a48 <printer_vprintf+0x6d0>
        if (*format != '%') {
  10084a:	3c 25                	cmp    $0x25,%al
  10084c:	0f 84 54 fb ff ff    	je     1003a6 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100852:	0f b6 f0             	movzbl %al,%esi
  100855:	44 89 fa             	mov    %r15d,%edx
  100858:	4c 89 f7             	mov    %r14,%rdi
  10085b:	41 ff 16             	callq  *(%r14)
            continue;
  10085e:	4c 89 e3             	mov    %r12,%rbx
  100861:	eb d7                	jmp    10083a <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  100863:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100867:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10086b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10086f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100873:	e9 51 fe ff ff       	jmpq   1006c9 <printer_vprintf+0x351>
            color = va_arg(val, int);
  100878:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10087c:	8b 07                	mov    (%rdi),%eax
  10087e:	83 f8 2f             	cmp    $0x2f,%eax
  100881:	77 10                	ja     100893 <printer_vprintf+0x51b>
  100883:	89 c2                	mov    %eax,%edx
  100885:	48 03 57 10          	add    0x10(%rdi),%rdx
  100889:	83 c0 08             	add    $0x8,%eax
  10088c:	89 07                	mov    %eax,(%rdi)
  10088e:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  100891:	eb a7                	jmp    10083a <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  100893:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100897:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10089b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10089f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1008a3:	eb e9                	jmp    10088e <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  1008a5:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1008a9:	8b 01                	mov    (%rcx),%eax
  1008ab:	83 f8 2f             	cmp    $0x2f,%eax
  1008ae:	77 23                	ja     1008d3 <printer_vprintf+0x55b>
  1008b0:	89 c2                	mov    %eax,%edx
  1008b2:	48 03 51 10          	add    0x10(%rcx),%rdx
  1008b6:	83 c0 08             	add    $0x8,%eax
  1008b9:	89 01                	mov    %eax,(%rcx)
  1008bb:	8b 02                	mov    (%rdx),%eax
  1008bd:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  1008c0:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1008c4:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1008c8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1008ce:	e9 ff fd ff ff       	jmpq   1006d2 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  1008d3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1008d7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1008db:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1008df:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1008e3:	eb d6                	jmp    1008bb <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  1008e5:	84 d2                	test   %dl,%dl
  1008e7:	0f 85 39 01 00 00    	jne    100a26 <printer_vprintf+0x6ae>
  1008ed:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  1008f1:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  1008f5:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  1008f9:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1008fd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100903:	e9 ca fd ff ff       	jmpq   1006d2 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  100908:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  10090e:	bf 30 0f 10 00       	mov    $0x100f30,%edi
        if (flags & FLAG_NUMERIC) {
  100913:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  100918:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  10091c:	4c 89 c1             	mov    %r8,%rcx
  10091f:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  100923:	48 63 f6             	movslq %esi,%rsi
  100926:	49 83 ec 01          	sub    $0x1,%r12
  10092a:	48 89 c8             	mov    %rcx,%rax
  10092d:	ba 00 00 00 00       	mov    $0x0,%edx
  100932:	48 f7 f6             	div    %rsi
  100935:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  100939:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  10093d:	48 89 ca             	mov    %rcx,%rdx
  100940:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  100943:	48 39 d6             	cmp    %rdx,%rsi
  100946:	76 de                	jbe    100926 <printer_vprintf+0x5ae>
  100948:	e9 9a fd ff ff       	jmpq   1006e7 <printer_vprintf+0x36f>
                prefix = "-";
  10094d:	48 c7 45 a0 46 0d 10 	movq   $0x100d46,-0x60(%rbp)
  100954:	00 
            if (flags & FLAG_NEGATIVE) {
  100955:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100958:	a8 80                	test   $0x80,%al
  10095a:	0f 85 b0 fd ff ff    	jne    100710 <printer_vprintf+0x398>
                prefix = "+";
  100960:	48 c7 45 a0 41 0d 10 	movq   $0x100d41,-0x60(%rbp)
  100967:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100968:	a8 10                	test   $0x10,%al
  10096a:	0f 85 a0 fd ff ff    	jne    100710 <printer_vprintf+0x398>
                prefix = " ";
  100970:	a8 08                	test   $0x8,%al
  100972:	ba 11 0d 10 00       	mov    $0x100d11,%edx
  100977:	b8 4d 0f 10 00       	mov    $0x100f4d,%eax
  10097c:	48 0f 44 c2          	cmove  %rdx,%rax
  100980:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100984:	e9 87 fd ff ff       	jmpq   100710 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  100989:	41 8d 41 10          	lea    0x10(%r9),%eax
  10098d:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  100992:	0f 85 78 fd ff ff    	jne    100710 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  100998:	4d 85 c0             	test   %r8,%r8
  10099b:	75 0d                	jne    1009aa <printer_vprintf+0x632>
  10099d:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  1009a4:	0f 84 66 fd ff ff    	je     100710 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  1009aa:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1009ae:	ba 48 0d 10 00       	mov    $0x100d48,%edx
  1009b3:	b8 43 0d 10 00       	mov    $0x100d43,%eax
  1009b8:	48 0f 44 c2          	cmove  %rdx,%rax
  1009bc:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1009c0:	e9 4b fd ff ff       	jmpq   100710 <printer_vprintf+0x398>
            len = strlen(data);
  1009c5:	4c 89 e7             	mov    %r12,%rdi
  1009c8:	e8 b5 f8 ff ff       	callq  100282 <strlen>
  1009cd:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1009d0:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1009d4:	0f 84 63 fd ff ff    	je     10073d <printer_vprintf+0x3c5>
  1009da:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1009de:	0f 84 59 fd ff ff    	je     10073d <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  1009e4:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  1009e7:	89 ca                	mov    %ecx,%edx
  1009e9:	29 c2                	sub    %eax,%edx
  1009eb:	39 c1                	cmp    %eax,%ecx
  1009ed:	b8 00 00 00 00       	mov    $0x0,%eax
  1009f2:	0f 4e d0             	cmovle %eax,%edx
  1009f5:	89 55 9c             	mov    %edx,-0x64(%rbp)
  1009f8:	e9 56 fd ff ff       	jmpq   100753 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  1009fd:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100a01:	e8 7c f8 ff ff       	callq  100282 <strlen>
  100a06:	8b 7d 98             	mov    -0x68(%rbp),%edi
  100a09:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  100a0c:	44 89 e9             	mov    %r13d,%ecx
  100a0f:	29 f9                	sub    %edi,%ecx
  100a11:	29 c1                	sub    %eax,%ecx
  100a13:	44 39 ea             	cmp    %r13d,%edx
  100a16:	b8 00 00 00 00       	mov    $0x0,%eax
  100a1b:	0f 4d c8             	cmovge %eax,%ecx
  100a1e:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  100a21:	e9 2d fd ff ff       	jmpq   100753 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  100a26:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100a29:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  100a2d:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100a31:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100a37:	e9 96 fc ff ff       	jmpq   1006d2 <printer_vprintf+0x35a>
        int flags = 0;
  100a3c:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100a43:	e9 b0 f9 ff ff       	jmpq   1003f8 <printer_vprintf+0x80>
}
  100a48:	48 83 c4 58          	add    $0x58,%rsp
  100a4c:	5b                   	pop    %rbx
  100a4d:	41 5c                	pop    %r12
  100a4f:	41 5d                	pop    %r13
  100a51:	41 5e                	pop    %r14
  100a53:	41 5f                	pop    %r15
  100a55:	5d                   	pop    %rbp
  100a56:	c3                   	retq   

0000000000100a57 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100a57:	55                   	push   %rbp
  100a58:	48 89 e5             	mov    %rsp,%rbp
  100a5b:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  100a5f:	48 c7 45 f0 62 01 10 	movq   $0x100162,-0x10(%rbp)
  100a66:	00 
        cpos = 0;
  100a67:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  100a6d:	b8 00 00 00 00       	mov    $0x0,%eax
  100a72:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100a75:	48 63 ff             	movslq %edi,%rdi
  100a78:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  100a7f:	00 
  100a80:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100a84:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100a88:	e8 eb f8 ff ff       	callq  100378 <printer_vprintf>
    return cp.cursor - console;
  100a8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a91:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100a97:	48 d1 f8             	sar    %rax
}
  100a9a:	c9                   	leaveq 
  100a9b:	c3                   	retq   

0000000000100a9c <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  100a9c:	55                   	push   %rbp
  100a9d:	48 89 e5             	mov    %rsp,%rbp
  100aa0:	48 83 ec 50          	sub    $0x50,%rsp
  100aa4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100aa8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100aac:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  100ab0:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100ab7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100abb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100abf:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100ac3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100ac7:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100acb:	e8 87 ff ff ff       	callq  100a57 <console_vprintf>
}
  100ad0:	c9                   	leaveq 
  100ad1:	c3                   	retq   

0000000000100ad2 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100ad2:	55                   	push   %rbp
  100ad3:	48 89 e5             	mov    %rsp,%rbp
  100ad6:	53                   	push   %rbx
  100ad7:	48 83 ec 28          	sub    $0x28,%rsp
  100adb:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  100ade:	48 c7 45 d8 e8 01 10 	movq   $0x1001e8,-0x28(%rbp)
  100ae5:	00 
    sp.s = s;
  100ae6:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100aea:	48 85 f6             	test   %rsi,%rsi
  100aed:	75 0b                	jne    100afa <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100aef:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100af2:	29 d8                	sub    %ebx,%eax
}
  100af4:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100af8:	c9                   	leaveq 
  100af9:	c3                   	retq   
        sp.end = s + size - 1;
  100afa:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100aff:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100b03:	be 00 00 00 00       	mov    $0x0,%esi
  100b08:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100b0c:	e8 67 f8 ff ff       	callq  100378 <printer_vprintf>
        *sp.s = 0;
  100b11:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100b15:	c6 00 00             	movb   $0x0,(%rax)
  100b18:	eb d5                	jmp    100aef <vsnprintf+0x1d>

0000000000100b1a <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100b1a:	55                   	push   %rbp
  100b1b:	48 89 e5             	mov    %rsp,%rbp
  100b1e:	48 83 ec 50          	sub    $0x50,%rsp
  100b22:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b26:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b2a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100b2e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100b35:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100b39:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100b3d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100b41:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100b45:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100b49:	e8 84 ff ff ff       	callq  100ad2 <vsnprintf>
    va_end(val);
    return n;
}
  100b4e:	c9                   	leaveq 
  100b4f:	c3                   	retq   

0000000000100b50 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b50:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100b55:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100b5a:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b5f:	48 83 c0 02          	add    $0x2,%rax
  100b63:	48 39 d0             	cmp    %rdx,%rax
  100b66:	75 f2                	jne    100b5a <console_clear+0xa>
    }
    cursorpos = 0;
  100b68:	c7 05 8a 84 fb ff 00 	movl   $0x0,-0x47b76(%rip)        # b8ffc <cursorpos>
  100b6f:	00 00 00 
}
  100b72:	c3                   	retq   

0000000000100b73 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100b73:	55                   	push   %rbp
  100b74:	48 89 e5             	mov    %rsp,%rbp
  100b77:	48 83 ec 50          	sub    $0x50,%rsp
  100b7b:	49 89 f2             	mov    %rsi,%r10
  100b7e:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100b82:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b86:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b8a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100b8e:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100b93:	85 ff                	test   %edi,%edi
  100b95:	78 2e                	js     100bc5 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100b97:	48 63 ff             	movslq %edi,%rdi
  100b9a:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100ba1:	cc cc cc 
  100ba4:	48 89 f8             	mov    %rdi,%rax
  100ba7:	48 f7 e2             	mul    %rdx
  100baa:	48 89 d0             	mov    %rdx,%rax
  100bad:	48 c1 e8 02          	shr    $0x2,%rax
  100bb1:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100bb5:	48 01 c2             	add    %rax,%rdx
  100bb8:	48 29 d7             	sub    %rdx,%rdi
  100bbb:	0f b6 b7 7d 0f 10 00 	movzbl 0x100f7d(%rdi),%esi
  100bc2:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100bc5:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100bcc:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100bd0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100bd4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100bd8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100bdc:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100be0:	4c 89 d2             	mov    %r10,%rdx
  100be3:	8b 3d 13 84 fb ff    	mov    -0x47bed(%rip),%edi        # b8ffc <cursorpos>
  100be9:	e8 69 fe ff ff       	callq  100a57 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100bee:	3d 30 07 00 00       	cmp    $0x730,%eax
  100bf3:	ba 00 00 00 00       	mov    $0x0,%edx
  100bf8:	0f 4d c2             	cmovge %edx,%eax
  100bfb:	89 05 fb 83 fb ff    	mov    %eax,-0x47c05(%rip)        # b8ffc <cursorpos>
    }
}
  100c01:	c9                   	leaveq 
  100c02:	c3                   	retq   

0000000000100c03 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  100c03:	55                   	push   %rbp
  100c04:	48 89 e5             	mov    %rsp,%rbp
  100c07:	53                   	push   %rbx
  100c08:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100c0f:	48 89 fb             	mov    %rdi,%rbx
  100c12:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100c16:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100c1a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100c1e:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100c22:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100c26:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100c2d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100c31:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100c35:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100c39:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100c3d:	ba 07 00 00 00       	mov    $0x7,%edx
  100c42:	be 47 0f 10 00       	mov    $0x100f47,%esi
  100c47:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100c4e:	e8 ab f5 ff ff       	callq  1001fe <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100c53:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100c57:	48 89 da             	mov    %rbx,%rdx
  100c5a:	be 99 00 00 00       	mov    $0x99,%esi
  100c5f:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100c66:	e8 67 fe ff ff       	callq  100ad2 <vsnprintf>
  100c6b:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100c6e:	85 d2                	test   %edx,%edx
  100c70:	7e 0f                	jle    100c81 <panic+0x7e>
  100c72:	83 c0 06             	add    $0x6,%eax
  100c75:	48 98                	cltq   
  100c77:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100c7e:	0a 
  100c7f:	75 29                	jne    100caa <panic+0xa7>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100c81:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  100c88:	ba 4f 0f 10 00       	mov    $0x100f4f,%edx
  100c8d:	be 00 c0 00 00       	mov    $0xc000,%esi
  100c92:	bf 30 07 00 00       	mov    $0x730,%edi
  100c97:	b8 00 00 00 00       	mov    $0x0,%eax
  100c9c:	e8 fb fd ff ff       	callq  100a9c <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100ca1:	bf 00 00 00 00       	mov    $0x0,%edi
  100ca6:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  100ca8:	eb fe                	jmp    100ca8 <panic+0xa5>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100caa:	48 63 c2             	movslq %edx,%rax
  100cad:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100cb3:	0f 94 c2             	sete   %dl
  100cb6:	0f b6 d2             	movzbl %dl,%edx
  100cb9:	48 29 d0             	sub    %rdx,%rax
  100cbc:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100cc3:	ff 
  100cc4:	be 10 0d 10 00       	mov    $0x100d10,%esi
  100cc9:	e8 f2 f5 ff ff       	callq  1002c0 <strcpy>
  100cce:	eb b1                	jmp    100c81 <panic+0x7e>

0000000000100cd0 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100cd0:	55                   	push   %rbp
  100cd1:	48 89 e5             	mov    %rsp,%rbp
  100cd4:	48 89 f9             	mov    %rdi,%rcx
  100cd7:	41 89 f0             	mov    %esi,%r8d
  100cda:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100cdd:	ba 58 0f 10 00       	mov    $0x100f58,%edx
  100ce2:	be 00 c0 00 00       	mov    $0xc000,%esi
  100ce7:	bf 30 07 00 00       	mov    $0x730,%edi
  100cec:	b8 00 00 00 00       	mov    $0x0,%eax
  100cf1:	e8 a6 fd ff ff       	callq  100a9c <console_printf>
    asm volatile ("int %0" : /* no result */
  100cf6:	bf 00 00 00 00       	mov    $0x0,%edi
  100cfb:	cd 30                	int    $0x30
 loop: goto loop;
  100cfd:	eb fe                	jmp    100cfd <assert_fail+0x2d>

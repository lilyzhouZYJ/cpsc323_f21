
obj/p-fork.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp
// sys_fork()
//    Fork the current process. On success, return the child's process ID to
//    the parent, and return 0 to the child. On failure, return -1.
static inline pid_t sys_fork(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 34                	int    $0x34
    // Fork a total of three new copies.
    pid_t p1 = sys_fork();
    assert(p1 >= 0);
  10000b:	85 c0                	test   %eax,%eax
  10000d:	78 50                	js     10005f <process_main+0x5f>
  10000f:	89 c2                	mov    %eax,%edx
  100011:	cd 34                	int    $0x34
  100013:	89 c1                	mov    %eax,%ecx
    pid_t p2 = sys_fork();
    assert(p2 >= 0);
  100015:	85 c0                	test   %eax,%eax
  100017:	78 5a                	js     100073 <process_main+0x73>
    asm volatile ("int %1" : "=a" (result)
  100019:	cd 31                	int    $0x31

    // Check fork return values: fork should return 0 to child.
    if (sys_getpid() == 1) {
  10001b:	83 f8 01             	cmp    $0x1,%eax
  10001e:	74 67                	je     100087 <process_main+0x87>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
    } else {
        assert(p1 == 0 || p2 == 0);
  100020:	85 d2                	test   %edx,%edx
  100022:	74 08                	je     10002c <process_main+0x2c>
  100024:	85 c9                	test   %ecx,%ecx
  100026:	0f 85 81 00 00 00    	jne    1000ad <process_main+0xad>
  10002c:	cd 31                	int    $0x31
  10002e:	89 c3                	mov    %eax,%ebx
    }

    // The rest of this code is like p-allocator.c.

    pid_t p = sys_getpid();
    srand(p);
  100030:	89 c7                	mov    %eax,%edi
  100032:	e8 f5 02 00 00       	callq  10032c <srand>

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100037:	b8 17 20 10 00       	mov    $0x102017,%eax
  10003c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100042:	48 89 05 bf 0f 00 00 	mov    %rax,0xfbf(%rip)        # 101008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100049:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  10004c:	48 83 e8 01          	sub    $0x1,%rax
  100050:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100056:	48 89 05 a3 0f 00 00 	mov    %rax,0xfa3(%rip)        # 101000 <stack_bottom>
  10005d:	eb 64                	jmp    1000c3 <process_main+0xc3>
    assert(p1 >= 0);
  10005f:	ba d0 0c 10 00       	mov    $0x100cd0,%edx
  100064:	be 0d 00 00 00       	mov    $0xd,%esi
  100069:	bf d8 0c 10 00       	mov    $0x100cd8,%edi
  10006e:	e8 22 0c 00 00       	callq  100c95 <assert_fail>
    assert(p2 >= 0);
  100073:	ba e1 0c 10 00       	mov    $0x100ce1,%edx
  100078:	be 0f 00 00 00       	mov    $0xf,%esi
  10007d:	bf d8 0c 10 00       	mov    $0x100cd8,%edi
  100082:	e8 0e 0c 00 00       	callq  100c95 <assert_fail>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
  100087:	85 c9                	test   %ecx,%ecx
  100089:	0f 94 c0             	sete   %al
  10008c:	39 ca                	cmp    %ecx,%edx
  10008e:	0f 94 c1             	sete   %cl
  100091:	08 c8                	or     %cl,%al
  100093:	75 04                	jne    100099 <process_main+0x99>
  100095:	85 d2                	test   %edx,%edx
  100097:	75 93                	jne    10002c <process_main+0x2c>
  100099:	ba 00 0d 10 00       	mov    $0x100d00,%edx
  10009e:	be 13 00 00 00       	mov    $0x13,%esi
  1000a3:	bf d8 0c 10 00       	mov    $0x100cd8,%edi
  1000a8:	e8 e8 0b 00 00       	callq  100c95 <assert_fail>
        assert(p1 == 0 || p2 == 0);
  1000ad:	ba e9 0c 10 00       	mov    $0x100ce9,%edx
  1000b2:	be 15 00 00 00       	mov    $0x15,%esi
  1000b7:	bf d8 0c 10 00       	mov    $0x100cd8,%edi
  1000bc:	e8 d4 0b 00 00       	callq  100c95 <assert_fail>
    asm volatile ("int %0" : /* no result */
  1000c1:	cd 32                	int    $0x32

    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  1000c3:	e8 2a 02 00 00       	callq  1002f2 <rand>
  1000c8:	48 63 d0             	movslq %eax,%rdx
  1000cb:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1000d2:	48 c1 fa 25          	sar    $0x25,%rdx
  1000d6:	89 c1                	mov    %eax,%ecx
  1000d8:	c1 f9 1f             	sar    $0x1f,%ecx
  1000db:	29 ca                	sub    %ecx,%edx
  1000dd:	6b d2 64             	imul   $0x64,%edx,%edx
  1000e0:	29 d0                	sub    %edx,%eax
  1000e2:	39 d8                	cmp    %ebx,%eax
  1000e4:	7d db                	jge    1000c1 <process_main+0xc1>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  1000e6:	48 8b 3d 1b 0f 00 00 	mov    0xf1b(%rip),%rdi        # 101008 <heap_top>
  1000ed:	48 3b 3d 0c 0f 00 00 	cmp    0xf0c(%rip),%rdi        # 101000 <stack_bottom>
  1000f4:	74 2d                	je     100123 <process_main+0x123>
    if(ad >= 0x300000)
  1000f6:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
  1000fc:	75 25                	jne    100123 <process_main+0x123>
  1000fe:	48 81 ff ff ff 2f 00 	cmp    $0x2fffff,%rdi
  100105:	77 1c                	ja     100123 <process_main+0x123>
    asm volatile ("int %1" : "=a" (result)
  100107:	cd 33                	int    $0x33
  100109:	85 c0                	test   %eax,%eax
  10010b:	78 16                	js     100123 <process_main+0x123>
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
  10010d:	48 8b 05 f4 0e 00 00 	mov    0xef4(%rip),%rax        # 101008 <heap_top>
  100114:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  100116:	48 81 05 e7 0e 00 00 	addq   $0x1000,0xee7(%rip)        # 101008 <heap_top>
  10011d:	00 10 00 00 
  100121:	eb 9e                	jmp    1000c1 <process_main+0xc1>
    asm volatile ("int %0" : /* no result */
  100123:	cd 32                	int    $0x32
  100125:	eb fc                	jmp    100123 <process_main+0x123>

0000000000100127 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100127:	48 89 f9             	mov    %rdi,%rcx
  10012a:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10012c:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  100133:	00 
  100134:	72 08                	jb     10013e <console_putc+0x17>
        cp->cursor = console;
  100136:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  10013d:	00 
    }
    if (c == '\n') {
  10013e:	40 80 fe 0a          	cmp    $0xa,%sil
  100142:	74 16                	je     10015a <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  100144:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100148:	48 8d 50 02          	lea    0x2(%rax),%rdx
  10014c:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  100150:	40 0f b6 f6          	movzbl %sil,%esi
  100154:	09 fe                	or     %edi,%esi
  100156:	66 89 30             	mov    %si,(%rax)
    }
}
  100159:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  10015a:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  10015e:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  100165:	4c 89 c6             	mov    %r8,%rsi
  100168:	48 d1 fe             	sar    %rsi
  10016b:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100172:	66 66 66 
  100175:	48 89 f0             	mov    %rsi,%rax
  100178:	48 f7 ea             	imul   %rdx
  10017b:	48 c1 fa 05          	sar    $0x5,%rdx
  10017f:	49 c1 f8 3f          	sar    $0x3f,%r8
  100183:	4c 29 c2             	sub    %r8,%rdx
  100186:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  10018a:	48 c1 e2 04          	shl    $0x4,%rdx
  10018e:	89 f0                	mov    %esi,%eax
  100190:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  100192:	83 cf 20             	or     $0x20,%edi
  100195:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100199:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  10019d:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1001a1:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  1001a4:	83 c0 01             	add    $0x1,%eax
  1001a7:	83 f8 50             	cmp    $0x50,%eax
  1001aa:	75 e9                	jne    100195 <console_putc+0x6e>
  1001ac:	c3                   	retq   

00000000001001ad <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1001ad:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1001b1:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1001b5:	73 0b                	jae    1001c2 <string_putc+0x15>
        *sp->s++ = c;
  1001b7:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1001bb:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  1001bf:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  1001c2:	c3                   	retq   

00000000001001c3 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  1001c3:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001c6:	48 85 d2             	test   %rdx,%rdx
  1001c9:	74 17                	je     1001e2 <memcpy+0x1f>
  1001cb:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  1001d0:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  1001d5:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001d9:	48 83 c1 01          	add    $0x1,%rcx
  1001dd:	48 39 d1             	cmp    %rdx,%rcx
  1001e0:	75 ee                	jne    1001d0 <memcpy+0xd>
}
  1001e2:	c3                   	retq   

00000000001001e3 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  1001e3:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  1001e6:	48 39 fe             	cmp    %rdi,%rsi
  1001e9:	72 1d                	jb     100208 <memmove+0x25>
        while (n-- > 0) {
  1001eb:	b9 00 00 00 00       	mov    $0x0,%ecx
  1001f0:	48 85 d2             	test   %rdx,%rdx
  1001f3:	74 12                	je     100207 <memmove+0x24>
            *d++ = *s++;
  1001f5:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  1001f9:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  1001fd:	48 83 c1 01          	add    $0x1,%rcx
  100201:	48 39 ca             	cmp    %rcx,%rdx
  100204:	75 ef                	jne    1001f5 <memmove+0x12>
}
  100206:	c3                   	retq   
  100207:	c3                   	retq   
    if (s < d && s + n > d) {
  100208:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  10020c:	48 39 cf             	cmp    %rcx,%rdi
  10020f:	73 da                	jae    1001eb <memmove+0x8>
        while (n-- > 0) {
  100211:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  100215:	48 85 d2             	test   %rdx,%rdx
  100218:	74 ec                	je     100206 <memmove+0x23>
            *--d = *--s;
  10021a:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  10021e:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  100221:	48 83 e9 01          	sub    $0x1,%rcx
  100225:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  100229:	75 ef                	jne    10021a <memmove+0x37>
  10022b:	c3                   	retq   

000000000010022c <memset>:
void* memset(void* v, int c, size_t n) {
  10022c:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10022f:	48 85 d2             	test   %rdx,%rdx
  100232:	74 12                	je     100246 <memset+0x1a>
  100234:	48 01 fa             	add    %rdi,%rdx
  100237:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  10023a:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10023d:	48 83 c1 01          	add    $0x1,%rcx
  100241:	48 39 ca             	cmp    %rcx,%rdx
  100244:	75 f4                	jne    10023a <memset+0xe>
}
  100246:	c3                   	retq   

0000000000100247 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100247:	80 3f 00             	cmpb   $0x0,(%rdi)
  10024a:	74 10                	je     10025c <strlen+0x15>
  10024c:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  100251:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  100255:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  100259:	75 f6                	jne    100251 <strlen+0xa>
  10025b:	c3                   	retq   
  10025c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100261:	c3                   	retq   

0000000000100262 <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  100262:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100265:	ba 00 00 00 00       	mov    $0x0,%edx
  10026a:	48 85 f6             	test   %rsi,%rsi
  10026d:	74 11                	je     100280 <strnlen+0x1e>
  10026f:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  100273:	74 0c                	je     100281 <strnlen+0x1f>
        ++n;
  100275:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100279:	48 39 d0             	cmp    %rdx,%rax
  10027c:	75 f1                	jne    10026f <strnlen+0xd>
  10027e:	eb 04                	jmp    100284 <strnlen+0x22>
  100280:	c3                   	retq   
  100281:	48 89 d0             	mov    %rdx,%rax
}
  100284:	c3                   	retq   

0000000000100285 <strcpy>:
char* strcpy(char* dst, const char* src) {
  100285:	48 89 f8             	mov    %rdi,%rax
  100288:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  10028d:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  100291:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  100294:	48 83 c2 01          	add    $0x1,%rdx
  100298:	84 c9                	test   %cl,%cl
  10029a:	75 f1                	jne    10028d <strcpy+0x8>
}
  10029c:	c3                   	retq   

000000000010029d <strcmp>:
    while (*a && *b && *a == *b) {
  10029d:	0f b6 07             	movzbl (%rdi),%eax
  1002a0:	84 c0                	test   %al,%al
  1002a2:	74 1a                	je     1002be <strcmp+0x21>
  1002a4:	0f b6 16             	movzbl (%rsi),%edx
  1002a7:	38 c2                	cmp    %al,%dl
  1002a9:	75 13                	jne    1002be <strcmp+0x21>
  1002ab:	84 d2                	test   %dl,%dl
  1002ad:	74 0f                	je     1002be <strcmp+0x21>
        ++a, ++b;
  1002af:	48 83 c7 01          	add    $0x1,%rdi
  1002b3:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  1002b7:	0f b6 07             	movzbl (%rdi),%eax
  1002ba:	84 c0                	test   %al,%al
  1002bc:	75 e6                	jne    1002a4 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  1002be:	3a 06                	cmp    (%rsi),%al
  1002c0:	0f 97 c0             	seta   %al
  1002c3:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  1002c6:	83 d8 00             	sbb    $0x0,%eax
}
  1002c9:	c3                   	retq   

00000000001002ca <strchr>:
    while (*s && *s != (char) c) {
  1002ca:	0f b6 07             	movzbl (%rdi),%eax
  1002cd:	84 c0                	test   %al,%al
  1002cf:	74 10                	je     1002e1 <strchr+0x17>
  1002d1:	40 38 f0             	cmp    %sil,%al
  1002d4:	74 18                	je     1002ee <strchr+0x24>
        ++s;
  1002d6:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  1002da:	0f b6 07             	movzbl (%rdi),%eax
  1002dd:	84 c0                	test   %al,%al
  1002df:	75 f0                	jne    1002d1 <strchr+0x7>
        return NULL;
  1002e1:	40 84 f6             	test   %sil,%sil
  1002e4:	b8 00 00 00 00       	mov    $0x0,%eax
  1002e9:	48 0f 44 c7          	cmove  %rdi,%rax
}
  1002ed:	c3                   	retq   
  1002ee:	48 89 f8             	mov    %rdi,%rax
  1002f1:	c3                   	retq   

00000000001002f2 <rand>:
    if (!rand_seed_set) {
  1002f2:	83 3d 1b 0d 00 00 00 	cmpl   $0x0,0xd1b(%rip)        # 101014 <rand_seed_set>
  1002f9:	74 1b                	je     100316 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1002fb:	69 05 0b 0d 00 00 0d 	imul   $0x19660d,0xd0b(%rip),%eax        # 101010 <rand_seed>
  100302:	66 19 00 
  100305:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10030a:	89 05 00 0d 00 00    	mov    %eax,0xd00(%rip)        # 101010 <rand_seed>
    return rand_seed & RAND_MAX;
  100310:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100315:	c3                   	retq   
    rand_seed = seed;
  100316:	c7 05 f0 0c 00 00 9e 	movl   $0x30d4879e,0xcf0(%rip)        # 101010 <rand_seed>
  10031d:	87 d4 30 
    rand_seed_set = 1;
  100320:	c7 05 ea 0c 00 00 01 	movl   $0x1,0xcea(%rip)        # 101014 <rand_seed_set>
  100327:	00 00 00 
}
  10032a:	eb cf                	jmp    1002fb <rand+0x9>

000000000010032c <srand>:
    rand_seed = seed;
  10032c:	89 3d de 0c 00 00    	mov    %edi,0xcde(%rip)        # 101010 <rand_seed>
    rand_seed_set = 1;
  100332:	c7 05 d8 0c 00 00 01 	movl   $0x1,0xcd8(%rip)        # 101014 <rand_seed_set>
  100339:	00 00 00 
}
  10033c:	c3                   	retq   

000000000010033d <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10033d:	55                   	push   %rbp
  10033e:	48 89 e5             	mov    %rsp,%rbp
  100341:	41 57                	push   %r15
  100343:	41 56                	push   %r14
  100345:	41 55                	push   %r13
  100347:	41 54                	push   %r12
  100349:	53                   	push   %rbx
  10034a:	48 83 ec 58          	sub    $0x58,%rsp
  10034e:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  100352:	0f b6 02             	movzbl (%rdx),%eax
  100355:	84 c0                	test   %al,%al
  100357:	0f 84 b0 06 00 00    	je     100a0d <printer_vprintf+0x6d0>
  10035d:	49 89 fe             	mov    %rdi,%r14
  100360:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  100363:	41 89 f7             	mov    %esi,%r15d
  100366:	e9 a4 04 00 00       	jmpq   10080f <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  10036b:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  100370:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  100376:	45 84 e4             	test   %r12b,%r12b
  100379:	0f 84 82 06 00 00    	je     100a01 <printer_vprintf+0x6c4>
        int flags = 0;
  10037f:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  100385:	41 0f be f4          	movsbl %r12b,%esi
  100389:	bf 21 0f 10 00       	mov    $0x100f21,%edi
  10038e:	e8 37 ff ff ff       	callq  1002ca <strchr>
  100393:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  100396:	48 85 c0             	test   %rax,%rax
  100399:	74 55                	je     1003f0 <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  10039b:	48 81 e9 21 0f 10 00 	sub    $0x100f21,%rcx
  1003a2:	b8 01 00 00 00       	mov    $0x1,%eax
  1003a7:	d3 e0                	shl    %cl,%eax
  1003a9:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1003ac:	48 83 c3 01          	add    $0x1,%rbx
  1003b0:	44 0f b6 23          	movzbl (%rbx),%r12d
  1003b4:	45 84 e4             	test   %r12b,%r12b
  1003b7:	75 cc                	jne    100385 <printer_vprintf+0x48>
  1003b9:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  1003bd:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  1003c3:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  1003ca:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  1003cd:	0f 84 a9 00 00 00    	je     10047c <printer_vprintf+0x13f>
        int length = 0;
  1003d3:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  1003d8:	0f b6 13             	movzbl (%rbx),%edx
  1003db:	8d 42 bd             	lea    -0x43(%rdx),%eax
  1003de:	3c 37                	cmp    $0x37,%al
  1003e0:	0f 87 c4 04 00 00    	ja     1008aa <printer_vprintf+0x56d>
  1003e6:	0f b6 c0             	movzbl %al,%eax
  1003e9:	ff 24 c5 30 0d 10 00 	jmpq   *0x100d30(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  1003f0:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  1003f4:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  1003f9:	3c 08                	cmp    $0x8,%al
  1003fb:	77 2f                	ja     10042c <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003fd:	0f b6 03             	movzbl (%rbx),%eax
  100400:	8d 50 d0             	lea    -0x30(%rax),%edx
  100403:	80 fa 09             	cmp    $0x9,%dl
  100406:	77 5e                	ja     100466 <printer_vprintf+0x129>
  100408:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  10040e:	48 83 c3 01          	add    $0x1,%rbx
  100412:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100417:	0f be c0             	movsbl %al,%eax
  10041a:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10041f:	0f b6 03             	movzbl (%rbx),%eax
  100422:	8d 50 d0             	lea    -0x30(%rax),%edx
  100425:	80 fa 09             	cmp    $0x9,%dl
  100428:	76 e4                	jbe    10040e <printer_vprintf+0xd1>
  10042a:	eb 97                	jmp    1003c3 <printer_vprintf+0x86>
        } else if (*format == '*') {
  10042c:	41 80 fc 2a          	cmp    $0x2a,%r12b
  100430:	75 3f                	jne    100471 <printer_vprintf+0x134>
            width = va_arg(val, int);
  100432:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100436:	8b 07                	mov    (%rdi),%eax
  100438:	83 f8 2f             	cmp    $0x2f,%eax
  10043b:	77 17                	ja     100454 <printer_vprintf+0x117>
  10043d:	89 c2                	mov    %eax,%edx
  10043f:	48 03 57 10          	add    0x10(%rdi),%rdx
  100443:	83 c0 08             	add    $0x8,%eax
  100446:	89 07                	mov    %eax,(%rdi)
  100448:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  10044b:	48 83 c3 01          	add    $0x1,%rbx
  10044f:	e9 6f ff ff ff       	jmpq   1003c3 <printer_vprintf+0x86>
            width = va_arg(val, int);
  100454:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100458:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10045c:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100460:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100464:	eb e2                	jmp    100448 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100466:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  10046c:	e9 52 ff ff ff       	jmpq   1003c3 <printer_vprintf+0x86>
        int width = -1;
  100471:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  100477:	e9 47 ff ff ff       	jmpq   1003c3 <printer_vprintf+0x86>
            ++format;
  10047c:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  100480:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100484:	8d 48 d0             	lea    -0x30(%rax),%ecx
  100487:	80 f9 09             	cmp    $0x9,%cl
  10048a:	76 13                	jbe    10049f <printer_vprintf+0x162>
            } else if (*format == '*') {
  10048c:	3c 2a                	cmp    $0x2a,%al
  10048e:	74 33                	je     1004c3 <printer_vprintf+0x186>
            ++format;
  100490:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  100493:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  10049a:	e9 34 ff ff ff       	jmpq   1003d3 <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10049f:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  1004a4:	48 83 c2 01          	add    $0x1,%rdx
  1004a8:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  1004ab:	0f be c0             	movsbl %al,%eax
  1004ae:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1004b2:	0f b6 02             	movzbl (%rdx),%eax
  1004b5:	8d 70 d0             	lea    -0x30(%rax),%esi
  1004b8:	40 80 fe 09          	cmp    $0x9,%sil
  1004bc:	76 e6                	jbe    1004a4 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  1004be:	48 89 d3             	mov    %rdx,%rbx
  1004c1:	eb 1c                	jmp    1004df <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  1004c3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004c7:	8b 07                	mov    (%rdi),%eax
  1004c9:	83 f8 2f             	cmp    $0x2f,%eax
  1004cc:	77 23                	ja     1004f1 <printer_vprintf+0x1b4>
  1004ce:	89 c2                	mov    %eax,%edx
  1004d0:	48 03 57 10          	add    0x10(%rdi),%rdx
  1004d4:	83 c0 08             	add    $0x8,%eax
  1004d7:	89 07                	mov    %eax,(%rdi)
  1004d9:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  1004db:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  1004df:	85 c9                	test   %ecx,%ecx
  1004e1:	b8 00 00 00 00       	mov    $0x0,%eax
  1004e6:	0f 49 c1             	cmovns %ecx,%eax
  1004e9:	89 45 9c             	mov    %eax,-0x64(%rbp)
  1004ec:	e9 e2 fe ff ff       	jmpq   1003d3 <printer_vprintf+0x96>
                precision = va_arg(val, int);
  1004f1:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004f5:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004f9:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004fd:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100501:	eb d6                	jmp    1004d9 <printer_vprintf+0x19c>
        switch (*format) {
  100503:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100508:	e9 f3 00 00 00       	jmpq   100600 <printer_vprintf+0x2c3>
            ++format;
  10050d:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  100511:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100516:	e9 bd fe ff ff       	jmpq   1003d8 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10051b:	85 c9                	test   %ecx,%ecx
  10051d:	74 55                	je     100574 <printer_vprintf+0x237>
  10051f:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100523:	8b 07                	mov    (%rdi),%eax
  100525:	83 f8 2f             	cmp    $0x2f,%eax
  100528:	77 38                	ja     100562 <printer_vprintf+0x225>
  10052a:	89 c2                	mov    %eax,%edx
  10052c:	48 03 57 10          	add    0x10(%rdi),%rdx
  100530:	83 c0 08             	add    $0x8,%eax
  100533:	89 07                	mov    %eax,(%rdi)
  100535:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100538:	48 89 d0             	mov    %rdx,%rax
  10053b:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  10053f:	49 89 d0             	mov    %rdx,%r8
  100542:	49 f7 d8             	neg    %r8
  100545:	25 80 00 00 00       	and    $0x80,%eax
  10054a:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10054e:	0b 45 a8             	or     -0x58(%rbp),%eax
  100551:	83 c8 60             	or     $0x60,%eax
  100554:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  100557:	41 bc 30 0f 10 00    	mov    $0x100f30,%r12d
            break;
  10055d:	e9 35 01 00 00       	jmpq   100697 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100562:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100566:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10056a:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10056e:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100572:	eb c1                	jmp    100535 <printer_vprintf+0x1f8>
  100574:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100578:	8b 07                	mov    (%rdi),%eax
  10057a:	83 f8 2f             	cmp    $0x2f,%eax
  10057d:	77 10                	ja     10058f <printer_vprintf+0x252>
  10057f:	89 c2                	mov    %eax,%edx
  100581:	48 03 57 10          	add    0x10(%rdi),%rdx
  100585:	83 c0 08             	add    $0x8,%eax
  100588:	89 07                	mov    %eax,(%rdi)
  10058a:	48 63 12             	movslq (%rdx),%rdx
  10058d:	eb a9                	jmp    100538 <printer_vprintf+0x1fb>
  10058f:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100593:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100597:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10059b:	48 89 47 08          	mov    %rax,0x8(%rdi)
  10059f:	eb e9                	jmp    10058a <printer_vprintf+0x24d>
        int base = 10;
  1005a1:	be 0a 00 00 00       	mov    $0xa,%esi
  1005a6:	eb 58                	jmp    100600 <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1005a8:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005ac:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005b0:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005b4:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005b8:	eb 60                	jmp    10061a <printer_vprintf+0x2dd>
  1005ba:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005be:	8b 07                	mov    (%rdi),%eax
  1005c0:	83 f8 2f             	cmp    $0x2f,%eax
  1005c3:	77 10                	ja     1005d5 <printer_vprintf+0x298>
  1005c5:	89 c2                	mov    %eax,%edx
  1005c7:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005cb:	83 c0 08             	add    $0x8,%eax
  1005ce:	89 07                	mov    %eax,(%rdi)
  1005d0:	44 8b 02             	mov    (%rdx),%r8d
  1005d3:	eb 48                	jmp    10061d <printer_vprintf+0x2e0>
  1005d5:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005d9:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005dd:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005e1:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005e5:	eb e9                	jmp    1005d0 <printer_vprintf+0x293>
  1005e7:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  1005ea:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  1005f1:	bf 10 0f 10 00       	mov    $0x100f10,%edi
  1005f6:	e9 e2 02 00 00       	jmpq   1008dd <printer_vprintf+0x5a0>
            base = 16;
  1005fb:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100600:	85 c9                	test   %ecx,%ecx
  100602:	74 b6                	je     1005ba <printer_vprintf+0x27d>
  100604:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100608:	8b 01                	mov    (%rcx),%eax
  10060a:	83 f8 2f             	cmp    $0x2f,%eax
  10060d:	77 99                	ja     1005a8 <printer_vprintf+0x26b>
  10060f:	89 c2                	mov    %eax,%edx
  100611:	48 03 51 10          	add    0x10(%rcx),%rdx
  100615:	83 c0 08             	add    $0x8,%eax
  100618:	89 01                	mov    %eax,(%rcx)
  10061a:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  10061d:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  100621:	85 f6                	test   %esi,%esi
  100623:	79 c2                	jns    1005e7 <printer_vprintf+0x2aa>
        base = -base;
  100625:	41 89 f1             	mov    %esi,%r9d
  100628:	f7 de                	neg    %esi
  10062a:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  100631:	bf f0 0e 10 00       	mov    $0x100ef0,%edi
  100636:	e9 a2 02 00 00       	jmpq   1008dd <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  10063b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10063f:	8b 07                	mov    (%rdi),%eax
  100641:	83 f8 2f             	cmp    $0x2f,%eax
  100644:	77 1c                	ja     100662 <printer_vprintf+0x325>
  100646:	89 c2                	mov    %eax,%edx
  100648:	48 03 57 10          	add    0x10(%rdi),%rdx
  10064c:	83 c0 08             	add    $0x8,%eax
  10064f:	89 07                	mov    %eax,(%rdi)
  100651:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100654:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  10065b:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100660:	eb c3                	jmp    100625 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  100662:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100666:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10066a:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10066e:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100672:	eb dd                	jmp    100651 <printer_vprintf+0x314>
            data = va_arg(val, char*);
  100674:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100678:	8b 01                	mov    (%rcx),%eax
  10067a:	83 f8 2f             	cmp    $0x2f,%eax
  10067d:	0f 87 a5 01 00 00    	ja     100828 <printer_vprintf+0x4eb>
  100683:	89 c2                	mov    %eax,%edx
  100685:	48 03 51 10          	add    0x10(%rcx),%rdx
  100689:	83 c0 08             	add    $0x8,%eax
  10068c:	89 01                	mov    %eax,(%rcx)
  10068e:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  100691:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  100697:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10069a:	83 e0 20             	and    $0x20,%eax
  10069d:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1006a0:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1006a6:	0f 85 21 02 00 00    	jne    1008cd <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1006ac:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006af:	89 45 88             	mov    %eax,-0x78(%rbp)
  1006b2:	83 e0 60             	and    $0x60,%eax
  1006b5:	83 f8 60             	cmp    $0x60,%eax
  1006b8:	0f 84 54 02 00 00    	je     100912 <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1006be:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006c1:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  1006c4:	48 c7 45 a0 30 0f 10 	movq   $0x100f30,-0x60(%rbp)
  1006cb:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1006cc:	83 f8 21             	cmp    $0x21,%eax
  1006cf:	0f 84 79 02 00 00    	je     10094e <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1006d5:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  1006d8:	89 f8                	mov    %edi,%eax
  1006da:	f7 d0                	not    %eax
  1006dc:	c1 e8 1f             	shr    $0x1f,%eax
  1006df:	89 45 84             	mov    %eax,-0x7c(%rbp)
  1006e2:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1006e6:	0f 85 9e 02 00 00    	jne    10098a <printer_vprintf+0x64d>
  1006ec:	84 c0                	test   %al,%al
  1006ee:	0f 84 96 02 00 00    	je     10098a <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  1006f4:	48 63 f7             	movslq %edi,%rsi
  1006f7:	4c 89 e7             	mov    %r12,%rdi
  1006fa:	e8 63 fb ff ff       	callq  100262 <strnlen>
  1006ff:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  100702:	8b 45 88             	mov    -0x78(%rbp),%eax
  100705:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  100708:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  10070f:	83 f8 22             	cmp    $0x22,%eax
  100712:	0f 84 aa 02 00 00    	je     1009c2 <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100718:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  10071c:	e8 26 fb ff ff       	callq  100247 <strlen>
  100721:	8b 55 9c             	mov    -0x64(%rbp),%edx
  100724:	03 55 98             	add    -0x68(%rbp),%edx
  100727:	44 89 e9             	mov    %r13d,%ecx
  10072a:	29 d1                	sub    %edx,%ecx
  10072c:	29 c1                	sub    %eax,%ecx
  10072e:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  100731:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100734:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100738:	75 2d                	jne    100767 <printer_vprintf+0x42a>
  10073a:	85 c9                	test   %ecx,%ecx
  10073c:	7e 29                	jle    100767 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  10073e:	44 89 fa             	mov    %r15d,%edx
  100741:	be 20 00 00 00       	mov    $0x20,%esi
  100746:	4c 89 f7             	mov    %r14,%rdi
  100749:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10074c:	41 83 ed 01          	sub    $0x1,%r13d
  100750:	45 85 ed             	test   %r13d,%r13d
  100753:	7f e9                	jg     10073e <printer_vprintf+0x401>
  100755:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  100758:	85 ff                	test   %edi,%edi
  10075a:	b8 01 00 00 00       	mov    $0x1,%eax
  10075f:	0f 4f c7             	cmovg  %edi,%eax
  100762:	29 c7                	sub    %eax,%edi
  100764:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  100767:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  10076b:	0f b6 07             	movzbl (%rdi),%eax
  10076e:	84 c0                	test   %al,%al
  100770:	74 22                	je     100794 <printer_vprintf+0x457>
  100772:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100776:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  100779:	0f b6 f0             	movzbl %al,%esi
  10077c:	44 89 fa             	mov    %r15d,%edx
  10077f:	4c 89 f7             	mov    %r14,%rdi
  100782:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  100785:	48 83 c3 01          	add    $0x1,%rbx
  100789:	0f b6 03             	movzbl (%rbx),%eax
  10078c:	84 c0                	test   %al,%al
  10078e:	75 e9                	jne    100779 <printer_vprintf+0x43c>
  100790:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  100794:	8b 45 9c             	mov    -0x64(%rbp),%eax
  100797:	85 c0                	test   %eax,%eax
  100799:	7e 1d                	jle    1007b8 <printer_vprintf+0x47b>
  10079b:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  10079f:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1007a1:	44 89 fa             	mov    %r15d,%edx
  1007a4:	be 30 00 00 00       	mov    $0x30,%esi
  1007a9:	4c 89 f7             	mov    %r14,%rdi
  1007ac:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  1007af:	83 eb 01             	sub    $0x1,%ebx
  1007b2:	75 ed                	jne    1007a1 <printer_vprintf+0x464>
  1007b4:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  1007b8:	8b 45 98             	mov    -0x68(%rbp),%eax
  1007bb:	85 c0                	test   %eax,%eax
  1007bd:	7e 27                	jle    1007e6 <printer_vprintf+0x4a9>
  1007bf:	89 c0                	mov    %eax,%eax
  1007c1:	4c 01 e0             	add    %r12,%rax
  1007c4:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007c8:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  1007cb:	41 0f b6 34 24       	movzbl (%r12),%esi
  1007d0:	44 89 fa             	mov    %r15d,%edx
  1007d3:	4c 89 f7             	mov    %r14,%rdi
  1007d6:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  1007d9:	49 83 c4 01          	add    $0x1,%r12
  1007dd:	49 39 dc             	cmp    %rbx,%r12
  1007e0:	75 e9                	jne    1007cb <printer_vprintf+0x48e>
  1007e2:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  1007e6:	45 85 ed             	test   %r13d,%r13d
  1007e9:	7e 14                	jle    1007ff <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  1007eb:	44 89 fa             	mov    %r15d,%edx
  1007ee:	be 20 00 00 00       	mov    $0x20,%esi
  1007f3:	4c 89 f7             	mov    %r14,%rdi
  1007f6:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  1007f9:	41 83 ed 01          	sub    $0x1,%r13d
  1007fd:	75 ec                	jne    1007eb <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  1007ff:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  100803:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100807:	84 c0                	test   %al,%al
  100809:	0f 84 fe 01 00 00    	je     100a0d <printer_vprintf+0x6d0>
        if (*format != '%') {
  10080f:	3c 25                	cmp    $0x25,%al
  100811:	0f 84 54 fb ff ff    	je     10036b <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100817:	0f b6 f0             	movzbl %al,%esi
  10081a:	44 89 fa             	mov    %r15d,%edx
  10081d:	4c 89 f7             	mov    %r14,%rdi
  100820:	41 ff 16             	callq  *(%r14)
            continue;
  100823:	4c 89 e3             	mov    %r12,%rbx
  100826:	eb d7                	jmp    1007ff <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  100828:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10082c:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100830:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100834:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100838:	e9 51 fe ff ff       	jmpq   10068e <printer_vprintf+0x351>
            color = va_arg(val, int);
  10083d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100841:	8b 07                	mov    (%rdi),%eax
  100843:	83 f8 2f             	cmp    $0x2f,%eax
  100846:	77 10                	ja     100858 <printer_vprintf+0x51b>
  100848:	89 c2                	mov    %eax,%edx
  10084a:	48 03 57 10          	add    0x10(%rdi),%rdx
  10084e:	83 c0 08             	add    $0x8,%eax
  100851:	89 07                	mov    %eax,(%rdi)
  100853:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  100856:	eb a7                	jmp    1007ff <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  100858:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10085c:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100860:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100864:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100868:	eb e9                	jmp    100853 <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  10086a:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10086e:	8b 01                	mov    (%rcx),%eax
  100870:	83 f8 2f             	cmp    $0x2f,%eax
  100873:	77 23                	ja     100898 <printer_vprintf+0x55b>
  100875:	89 c2                	mov    %eax,%edx
  100877:	48 03 51 10          	add    0x10(%rcx),%rdx
  10087b:	83 c0 08             	add    $0x8,%eax
  10087e:	89 01                	mov    %eax,(%rcx)
  100880:	8b 02                	mov    (%rdx),%eax
  100882:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  100885:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  100889:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10088d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  100893:	e9 ff fd ff ff       	jmpq   100697 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  100898:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10089c:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1008a0:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1008a4:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1008a8:	eb d6                	jmp    100880 <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  1008aa:	84 d2                	test   %dl,%dl
  1008ac:	0f 85 39 01 00 00    	jne    1009eb <printer_vprintf+0x6ae>
  1008b2:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  1008b6:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  1008ba:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  1008be:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1008c2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1008c8:	e9 ca fd ff ff       	jmpq   100697 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  1008cd:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  1008d3:	bf 10 0f 10 00       	mov    $0x100f10,%edi
        if (flags & FLAG_NUMERIC) {
  1008d8:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  1008dd:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  1008e1:	4c 89 c1             	mov    %r8,%rcx
  1008e4:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  1008e8:	48 63 f6             	movslq %esi,%rsi
  1008eb:	49 83 ec 01          	sub    $0x1,%r12
  1008ef:	48 89 c8             	mov    %rcx,%rax
  1008f2:	ba 00 00 00 00       	mov    $0x0,%edx
  1008f7:	48 f7 f6             	div    %rsi
  1008fa:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  1008fe:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  100902:	48 89 ca             	mov    %rcx,%rdx
  100905:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  100908:	48 39 d6             	cmp    %rdx,%rsi
  10090b:	76 de                	jbe    1008eb <printer_vprintf+0x5ae>
  10090d:	e9 9a fd ff ff       	jmpq   1006ac <printer_vprintf+0x36f>
                prefix = "-";
  100912:	48 c7 45 a0 24 0d 10 	movq   $0x100d24,-0x60(%rbp)
  100919:	00 
            if (flags & FLAG_NEGATIVE) {
  10091a:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10091d:	a8 80                	test   $0x80,%al
  10091f:	0f 85 b0 fd ff ff    	jne    1006d5 <printer_vprintf+0x398>
                prefix = "+";
  100925:	48 c7 45 a0 1f 0d 10 	movq   $0x100d1f,-0x60(%rbp)
  10092c:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  10092d:	a8 10                	test   $0x10,%al
  10092f:	0f 85 a0 fd ff ff    	jne    1006d5 <printer_vprintf+0x398>
                prefix = " ";
  100935:	a8 08                	test   $0x8,%al
  100937:	ba 30 0f 10 00       	mov    $0x100f30,%edx
  10093c:	b8 2d 0f 10 00       	mov    $0x100f2d,%eax
  100941:	48 0f 44 c2          	cmove  %rdx,%rax
  100945:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100949:	e9 87 fd ff ff       	jmpq   1006d5 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  10094e:	41 8d 41 10          	lea    0x10(%r9),%eax
  100952:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  100957:	0f 85 78 fd ff ff    	jne    1006d5 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  10095d:	4d 85 c0             	test   %r8,%r8
  100960:	75 0d                	jne    10096f <printer_vprintf+0x632>
  100962:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  100969:	0f 84 66 fd ff ff    	je     1006d5 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  10096f:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  100973:	ba 26 0d 10 00       	mov    $0x100d26,%edx
  100978:	b8 21 0d 10 00       	mov    $0x100d21,%eax
  10097d:	48 0f 44 c2          	cmove  %rdx,%rax
  100981:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100985:	e9 4b fd ff ff       	jmpq   1006d5 <printer_vprintf+0x398>
            len = strlen(data);
  10098a:	4c 89 e7             	mov    %r12,%rdi
  10098d:	e8 b5 f8 ff ff       	callq  100247 <strlen>
  100992:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100995:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100999:	0f 84 63 fd ff ff    	je     100702 <printer_vprintf+0x3c5>
  10099f:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1009a3:	0f 84 59 fd ff ff    	je     100702 <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  1009a9:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  1009ac:	89 ca                	mov    %ecx,%edx
  1009ae:	29 c2                	sub    %eax,%edx
  1009b0:	39 c1                	cmp    %eax,%ecx
  1009b2:	b8 00 00 00 00       	mov    $0x0,%eax
  1009b7:	0f 4e d0             	cmovle %eax,%edx
  1009ba:	89 55 9c             	mov    %edx,-0x64(%rbp)
  1009bd:	e9 56 fd ff ff       	jmpq   100718 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  1009c2:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1009c6:	e8 7c f8 ff ff       	callq  100247 <strlen>
  1009cb:	8b 7d 98             	mov    -0x68(%rbp),%edi
  1009ce:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  1009d1:	44 89 e9             	mov    %r13d,%ecx
  1009d4:	29 f9                	sub    %edi,%ecx
  1009d6:	29 c1                	sub    %eax,%ecx
  1009d8:	44 39 ea             	cmp    %r13d,%edx
  1009db:	b8 00 00 00 00       	mov    $0x0,%eax
  1009e0:	0f 4d c8             	cmovge %eax,%ecx
  1009e3:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  1009e6:	e9 2d fd ff ff       	jmpq   100718 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  1009eb:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  1009ee:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1009f2:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1009f6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1009fc:	e9 96 fc ff ff       	jmpq   100697 <printer_vprintf+0x35a>
        int flags = 0;
  100a01:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100a08:	e9 b0 f9 ff ff       	jmpq   1003bd <printer_vprintf+0x80>
}
  100a0d:	48 83 c4 58          	add    $0x58,%rsp
  100a11:	5b                   	pop    %rbx
  100a12:	41 5c                	pop    %r12
  100a14:	41 5d                	pop    %r13
  100a16:	41 5e                	pop    %r14
  100a18:	41 5f                	pop    %r15
  100a1a:	5d                   	pop    %rbp
  100a1b:	c3                   	retq   

0000000000100a1c <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100a1c:	55                   	push   %rbp
  100a1d:	48 89 e5             	mov    %rsp,%rbp
  100a20:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  100a24:	48 c7 45 f0 27 01 10 	movq   $0x100127,-0x10(%rbp)
  100a2b:	00 
        cpos = 0;
  100a2c:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  100a32:	b8 00 00 00 00       	mov    $0x0,%eax
  100a37:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100a3a:	48 63 ff             	movslq %edi,%rdi
  100a3d:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  100a44:	00 
  100a45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100a49:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100a4d:	e8 eb f8 ff ff       	callq  10033d <printer_vprintf>
    return cp.cursor - console;
  100a52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a56:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100a5c:	48 d1 f8             	sar    %rax
}
  100a5f:	c9                   	leaveq 
  100a60:	c3                   	retq   

0000000000100a61 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  100a61:	55                   	push   %rbp
  100a62:	48 89 e5             	mov    %rsp,%rbp
  100a65:	48 83 ec 50          	sub    $0x50,%rsp
  100a69:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a6d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a71:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  100a75:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100a7c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100a80:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100a84:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100a88:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100a8c:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100a90:	e8 87 ff ff ff       	callq  100a1c <console_vprintf>
}
  100a95:	c9                   	leaveq 
  100a96:	c3                   	retq   

0000000000100a97 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100a97:	55                   	push   %rbp
  100a98:	48 89 e5             	mov    %rsp,%rbp
  100a9b:	53                   	push   %rbx
  100a9c:	48 83 ec 28          	sub    $0x28,%rsp
  100aa0:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  100aa3:	48 c7 45 d8 ad 01 10 	movq   $0x1001ad,-0x28(%rbp)
  100aaa:	00 
    sp.s = s;
  100aab:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100aaf:	48 85 f6             	test   %rsi,%rsi
  100ab2:	75 0b                	jne    100abf <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100ab4:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100ab7:	29 d8                	sub    %ebx,%eax
}
  100ab9:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100abd:	c9                   	leaveq 
  100abe:	c3                   	retq   
        sp.end = s + size - 1;
  100abf:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100ac4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100ac8:	be 00 00 00 00       	mov    $0x0,%esi
  100acd:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100ad1:	e8 67 f8 ff ff       	callq  10033d <printer_vprintf>
        *sp.s = 0;
  100ad6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100ada:	c6 00 00             	movb   $0x0,(%rax)
  100add:	eb d5                	jmp    100ab4 <vsnprintf+0x1d>

0000000000100adf <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100adf:	55                   	push   %rbp
  100ae0:	48 89 e5             	mov    %rsp,%rbp
  100ae3:	48 83 ec 50          	sub    $0x50,%rsp
  100ae7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100aeb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100aef:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100af3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100afa:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100afe:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100b02:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100b06:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100b0a:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100b0e:	e8 84 ff ff ff       	callq  100a97 <vsnprintf>
    va_end(val);
    return n;
}
  100b13:	c9                   	leaveq 
  100b14:	c3                   	retq   

0000000000100b15 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b15:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100b1a:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100b1f:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b24:	48 83 c0 02          	add    $0x2,%rax
  100b28:	48 39 d0             	cmp    %rdx,%rax
  100b2b:	75 f2                	jne    100b1f <console_clear+0xa>
    }
    cursorpos = 0;
  100b2d:	c7 05 c5 84 fb ff 00 	movl   $0x0,-0x47b3b(%rip)        # b8ffc <cursorpos>
  100b34:	00 00 00 
}
  100b37:	c3                   	retq   

0000000000100b38 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100b38:	55                   	push   %rbp
  100b39:	48 89 e5             	mov    %rsp,%rbp
  100b3c:	48 83 ec 50          	sub    $0x50,%rsp
  100b40:	49 89 f2             	mov    %rsi,%r10
  100b43:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100b47:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b4b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b4f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100b53:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100b58:	85 ff                	test   %edi,%edi
  100b5a:	78 2e                	js     100b8a <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100b5c:	48 63 ff             	movslq %edi,%rdi
  100b5f:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100b66:	cc cc cc 
  100b69:	48 89 f8             	mov    %rdi,%rax
  100b6c:	48 f7 e2             	mul    %rdx
  100b6f:	48 89 d0             	mov    %rdx,%rax
  100b72:	48 c1 e8 02          	shr    $0x2,%rax
  100b76:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100b7a:	48 01 c2             	add    %rax,%rdx
  100b7d:	48 29 d7             	sub    %rdx,%rdi
  100b80:	0f b6 b7 5d 0f 10 00 	movzbl 0x100f5d(%rdi),%esi
  100b87:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100b8a:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100b91:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100b95:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100b99:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100b9d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100ba1:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100ba5:	4c 89 d2             	mov    %r10,%rdx
  100ba8:	8b 3d 4e 84 fb ff    	mov    -0x47bb2(%rip),%edi        # b8ffc <cursorpos>
  100bae:	e8 69 fe ff ff       	callq  100a1c <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100bb3:	3d 30 07 00 00       	cmp    $0x730,%eax
  100bb8:	ba 00 00 00 00       	mov    $0x0,%edx
  100bbd:	0f 4d c2             	cmovge %edx,%eax
  100bc0:	89 05 36 84 fb ff    	mov    %eax,-0x47bca(%rip)        # b8ffc <cursorpos>
    }
}
  100bc6:	c9                   	leaveq 
  100bc7:	c3                   	retq   

0000000000100bc8 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  100bc8:	55                   	push   %rbp
  100bc9:	48 89 e5             	mov    %rsp,%rbp
  100bcc:	53                   	push   %rbx
  100bcd:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100bd4:	48 89 fb             	mov    %rdi,%rbx
  100bd7:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100bdb:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100bdf:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100be3:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100be7:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100beb:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100bf2:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100bf6:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100bfa:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100bfe:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100c02:	ba 07 00 00 00       	mov    $0x7,%edx
  100c07:	be 27 0f 10 00       	mov    $0x100f27,%esi
  100c0c:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100c13:	e8 ab f5 ff ff       	callq  1001c3 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100c18:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100c1c:	48 89 da             	mov    %rbx,%rdx
  100c1f:	be 99 00 00 00       	mov    $0x99,%esi
  100c24:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100c2b:	e8 67 fe ff ff       	callq  100a97 <vsnprintf>
  100c30:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100c33:	85 d2                	test   %edx,%edx
  100c35:	7e 0f                	jle    100c46 <panic+0x7e>
  100c37:	83 c0 06             	add    $0x6,%eax
  100c3a:	48 98                	cltq   
  100c3c:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100c43:	0a 
  100c44:	75 29                	jne    100c6f <panic+0xa7>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100c46:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  100c4d:	ba 31 0f 10 00       	mov    $0x100f31,%edx
  100c52:	be 00 c0 00 00       	mov    $0xc000,%esi
  100c57:	bf 30 07 00 00       	mov    $0x730,%edi
  100c5c:	b8 00 00 00 00       	mov    $0x0,%eax
  100c61:	e8 fb fd ff ff       	callq  100a61 <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100c66:	bf 00 00 00 00       	mov    $0x0,%edi
  100c6b:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  100c6d:	eb fe                	jmp    100c6d <panic+0xa5>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100c6f:	48 63 c2             	movslq %edx,%rax
  100c72:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100c78:	0f 94 c2             	sete   %dl
  100c7b:	0f b6 d2             	movzbl %dl,%edx
  100c7e:	48 29 d0             	sub    %rdx,%rax
  100c81:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100c88:	ff 
  100c89:	be 2f 0f 10 00       	mov    $0x100f2f,%esi
  100c8e:	e8 f2 f5 ff ff       	callq  100285 <strcpy>
  100c93:	eb b1                	jmp    100c46 <panic+0x7e>

0000000000100c95 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100c95:	55                   	push   %rbp
  100c96:	48 89 e5             	mov    %rsp,%rbp
  100c99:	48 89 f9             	mov    %rdi,%rcx
  100c9c:	41 89 f0             	mov    %esi,%r8d
  100c9f:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100ca2:	ba 38 0f 10 00       	mov    $0x100f38,%edx
  100ca7:	be 00 c0 00 00       	mov    $0xc000,%esi
  100cac:	bf 30 07 00 00       	mov    $0x730,%edi
  100cb1:	b8 00 00 00 00       	mov    $0x0,%eax
  100cb6:	e8 a6 fd ff ff       	callq  100a61 <console_printf>
    asm volatile ("int %0" : /* no result */
  100cbb:	bf 00 00 00 00       	mov    $0x0,%edi
  100cc0:	cd 30                	int    $0x30
 loop: goto loop;
  100cc2:	eb fe                	jmp    100cc2 <assert_fail+0x2d>

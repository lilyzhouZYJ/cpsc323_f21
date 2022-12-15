
obj/p-forkexit.full:     file format elf64-x86-64


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
  100007:	eb 02                	jmp    10000b <process_main+0xb>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  100009:	cd 32                	int    $0x32
    while (1) {
        if (rand() % ALLOC_SLOWDOWN == 0) {
  10000b:	e8 10 03 00 00       	callq  100320 <rand>
  100010:	48 63 d0             	movslq %eax,%rdx
  100013:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  10001a:	48 c1 fa 25          	sar    $0x25,%rdx
  10001e:	89 c1                	mov    %eax,%ecx
  100020:	c1 f9 1f             	sar    $0x1f,%ecx
  100023:	29 ca                	sub    %ecx,%edx
  100025:	6b d2 64             	imul   $0x64,%edx,%edx
  100028:	39 d0                	cmp    %edx,%eax
  10002a:	75 dd                	jne    100009 <process_main+0x9>
// sys_fork()
//    Fork the current process. On success, return the child's process ID to
//    the parent, and return 0 to the child. On failure, return -1.
static inline pid_t sys_fork(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10002c:	cd 34                	int    $0x34
            if (sys_fork() == 0) {
  10002e:	85 c0                	test   %eax,%eax
  100030:	75 d9                	jne    10000b <process_main+0xb>
    asm volatile ("int %1" : "=a" (result)
  100032:	cd 31                	int    $0x31
  100034:	89 c7                	mov    %eax,%edi
  100036:	89 c3                	mov    %eax,%ebx
            sys_yield();
        }
    }

    pid_t p = sys_getpid();
    srand(p);
  100038:	e8 1d 03 00 00       	callq  10035a <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10003d:	b8 17 20 10 00       	mov    $0x102017,%eax
  100042:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100048:	48 89 05 b9 0f 00 00 	mov    %rax,0xfb9(%rip)        # 101008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10004f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100052:	48 83 e8 01          	sub    $0x1,%rax
  100056:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10005c:	48 89 05 9d 0f 00 00 	mov    %rax,0xf9d(%rip)        # 101000 <stack_bottom>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
            heap_top += PAGESIZE;
            if (console[CPOS(24, 0)]) {
  100063:	41 bc 00 80 0b 00    	mov    $0xb8000,%r12d
  100069:	eb 13                	jmp    10007e <process_main+0x7e>
                /* clear "Out of physical memory" msg */
                console_printf(CPOS(24, 0), 0, "\n");
            }
        } else if (x == 8 * p) {
  10006b:	0f 84 a1 00 00 00    	je     100112 <process_main+0x112>
            if (sys_fork() == 0) {
                p = sys_getpid();
            }
        } else if (x == 8 * p + 1) {
  100071:	83 c0 01             	add    $0x1,%eax
  100074:	39 d0                	cmp    %edx,%eax
  100076:	0f 84 a9 00 00 00    	je     100125 <process_main+0x125>
    asm volatile ("int %0" : /* no result */
  10007c:	cd 32                	int    $0x32
        int x = rand() % (8 * ALLOC_SLOWDOWN);
  10007e:	e8 9d 02 00 00       	callq  100320 <rand>
  100083:	48 63 d0             	movslq %eax,%rdx
  100086:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  10008d:	48 c1 fa 28          	sar    $0x28,%rdx
  100091:	89 c1                	mov    %eax,%ecx
  100093:	c1 f9 1f             	sar    $0x1f,%ecx
  100096:	29 ca                	sub    %ecx,%edx
  100098:	69 ca 20 03 00 00    	imul   $0x320,%edx,%ecx
  10009e:	29 c8                	sub    %ecx,%eax
  1000a0:	89 c2                	mov    %eax,%edx
        if (x < 8 * p) {
  1000a2:	8d 04 dd 00 00 00 00 	lea    0x0(,%rbx,8),%eax
  1000a9:	39 d0                	cmp    %edx,%eax
  1000ab:	7e be                	jle    10006b <process_main+0x6b>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  1000ad:	48 8b 3d 54 0f 00 00 	mov    0xf54(%rip),%rdi        # 101008 <heap_top>
  1000b4:	48 3b 3d 45 0f 00 00 	cmp    0xf45(%rip),%rdi        # 101000 <stack_bottom>
  1000bb:	74 6c                	je     100129 <process_main+0x129>
    if(ad >= 0x300000)
  1000bd:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
  1000c3:	75 64                	jne    100129 <process_main+0x129>
  1000c5:	48 81 ff ff ff 2f 00 	cmp    $0x2fffff,%rdi
  1000cc:	77 5b                	ja     100129 <process_main+0x129>
    asm volatile ("int %1" : "=a" (result)
  1000ce:	cd 33                	int    $0x33
  1000d0:	85 c0                	test   %eax,%eax
  1000d2:	78 55                	js     100129 <process_main+0x129>
            *heap_top = p;      /* check we have write access to new page */
  1000d4:	48 8b 05 2d 0f 00 00 	mov    0xf2d(%rip),%rax        # 101008 <heap_top>
  1000db:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  1000dd:	48 81 05 20 0f 00 00 	addq   $0x1000,0xf20(%rip)        # 101008 <heap_top>
  1000e4:	00 10 00 00 
            if (console[CPOS(24, 0)]) {
  1000e8:	66 41 83 bc 24 00 0f 	cmpw   $0x0,0xf00(%r12)
  1000ef:	00 00 00 
  1000f2:	74 8a                	je     10007e <process_main+0x7e>
                console_printf(CPOS(24, 0), 0, "\n");
  1000f4:	ba 70 0b 10 00       	mov    $0x100b70,%edx
  1000f9:	be 00 00 00 00       	mov    $0x0,%esi
  1000fe:	bf 80 07 00 00       	mov    $0x780,%edi
  100103:	b8 00 00 00 00       	mov    $0x0,%eax
  100108:	e8 82 09 00 00       	callq  100a8f <console_printf>
  10010d:	e9 6c ff ff ff       	jmpq   10007e <process_main+0x7e>
    asm volatile ("int %1" : "=a" (result)
  100112:	cd 34                	int    $0x34
            if (sys_fork() == 0) {
  100114:	85 c0                	test   %eax,%eax
  100116:	0f 85 62 ff ff ff    	jne    10007e <process_main+0x7e>
    asm volatile ("int %1" : "=a" (result)
  10011c:	cd 31                	int    $0x31
  10011e:	89 c3                	mov    %eax,%ebx
    return result;
  100120:	e9 59 ff ff ff       	jmpq   10007e <process_main+0x7e>

// sys_exit()
//    Exit this process. Does not return.
static inline void sys_exit(void) __attribute__((noreturn));
static inline void sys_exit(void) {
    asm volatile ("int %0" : /* no result */
  100125:	cd 35                	int    $0x35
                  : "i" (INT_SYS_EXIT)
                  : "cc", "memory");
 spinloop: goto spinloop;       // should never get here
  100127:	eb fe                	jmp    100127 <process_main+0x127>
        }
    }

    // After running out of memory
    while (1) {
        if (rand() % (2 * ALLOC_SLOWDOWN) == 0) {
  100129:	e8 f2 01 00 00       	callq  100320 <rand>
  10012e:	48 63 d0             	movslq %eax,%rdx
  100131:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100138:	48 c1 fa 26          	sar    $0x26,%rdx
  10013c:	89 c1                	mov    %eax,%ecx
  10013e:	c1 f9 1f             	sar    $0x1f,%ecx
  100141:	29 ca                	sub    %ecx,%edx
  100143:	69 d2 c8 00 00 00    	imul   $0xc8,%edx,%edx
  100149:	39 d0                	cmp    %edx,%eax
  10014b:	74 04                	je     100151 <process_main+0x151>
    asm volatile ("int %0" : /* no result */
  10014d:	cd 32                	int    $0x32
}
  10014f:	eb d8                	jmp    100129 <process_main+0x129>
    asm volatile ("int %0" : /* no result */
  100151:	cd 35                	int    $0x35
 spinloop: goto spinloop;       // should never get here
  100153:	eb fe                	jmp    100153 <process_main+0x153>

0000000000100155 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100155:	48 89 f9             	mov    %rdi,%rcx
  100158:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10015a:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  100161:	00 
  100162:	72 08                	jb     10016c <console_putc+0x17>
        cp->cursor = console;
  100164:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  10016b:	00 
    }
    if (c == '\n') {
  10016c:	40 80 fe 0a          	cmp    $0xa,%sil
  100170:	74 16                	je     100188 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  100172:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100176:	48 8d 50 02          	lea    0x2(%rax),%rdx
  10017a:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  10017e:	40 0f b6 f6          	movzbl %sil,%esi
  100182:	09 fe                	or     %edi,%esi
  100184:	66 89 30             	mov    %si,(%rax)
    }
}
  100187:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  100188:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  10018c:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  100193:	4c 89 c6             	mov    %r8,%rsi
  100196:	48 d1 fe             	sar    %rsi
  100199:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1001a0:	66 66 66 
  1001a3:	48 89 f0             	mov    %rsi,%rax
  1001a6:	48 f7 ea             	imul   %rdx
  1001a9:	48 c1 fa 05          	sar    $0x5,%rdx
  1001ad:	49 c1 f8 3f          	sar    $0x3f,%r8
  1001b1:	4c 29 c2             	sub    %r8,%rdx
  1001b4:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  1001b8:	48 c1 e2 04          	shl    $0x4,%rdx
  1001bc:	89 f0                	mov    %esi,%eax
  1001be:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1001c0:	83 cf 20             	or     $0x20,%edi
  1001c3:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1001c7:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  1001cb:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1001cf:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  1001d2:	83 c0 01             	add    $0x1,%eax
  1001d5:	83 f8 50             	cmp    $0x50,%eax
  1001d8:	75 e9                	jne    1001c3 <console_putc+0x6e>
  1001da:	c3                   	retq   

00000000001001db <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1001db:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1001df:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1001e3:	73 0b                	jae    1001f0 <string_putc+0x15>
        *sp->s++ = c;
  1001e5:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1001e9:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  1001ed:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  1001f0:	c3                   	retq   

00000000001001f1 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  1001f1:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001f4:	48 85 d2             	test   %rdx,%rdx
  1001f7:	74 17                	je     100210 <memcpy+0x1f>
  1001f9:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  1001fe:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  100203:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100207:	48 83 c1 01          	add    $0x1,%rcx
  10020b:	48 39 d1             	cmp    %rdx,%rcx
  10020e:	75 ee                	jne    1001fe <memcpy+0xd>
}
  100210:	c3                   	retq   

0000000000100211 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  100211:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  100214:	48 39 fe             	cmp    %rdi,%rsi
  100217:	72 1d                	jb     100236 <memmove+0x25>
        while (n-- > 0) {
  100219:	b9 00 00 00 00       	mov    $0x0,%ecx
  10021e:	48 85 d2             	test   %rdx,%rdx
  100221:	74 12                	je     100235 <memmove+0x24>
            *d++ = *s++;
  100223:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  100227:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  10022b:	48 83 c1 01          	add    $0x1,%rcx
  10022f:	48 39 ca             	cmp    %rcx,%rdx
  100232:	75 ef                	jne    100223 <memmove+0x12>
}
  100234:	c3                   	retq   
  100235:	c3                   	retq   
    if (s < d && s + n > d) {
  100236:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  10023a:	48 39 cf             	cmp    %rcx,%rdi
  10023d:	73 da                	jae    100219 <memmove+0x8>
        while (n-- > 0) {
  10023f:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  100243:	48 85 d2             	test   %rdx,%rdx
  100246:	74 ec                	je     100234 <memmove+0x23>
            *--d = *--s;
  100248:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  10024c:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  10024f:	48 83 e9 01          	sub    $0x1,%rcx
  100253:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  100257:	75 ef                	jne    100248 <memmove+0x37>
  100259:	c3                   	retq   

000000000010025a <memset>:
void* memset(void* v, int c, size_t n) {
  10025a:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10025d:	48 85 d2             	test   %rdx,%rdx
  100260:	74 12                	je     100274 <memset+0x1a>
  100262:	48 01 fa             	add    %rdi,%rdx
  100265:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  100268:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10026b:	48 83 c1 01          	add    $0x1,%rcx
  10026f:	48 39 ca             	cmp    %rcx,%rdx
  100272:	75 f4                	jne    100268 <memset+0xe>
}
  100274:	c3                   	retq   

0000000000100275 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100275:	80 3f 00             	cmpb   $0x0,(%rdi)
  100278:	74 10                	je     10028a <strlen+0x15>
  10027a:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  10027f:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  100283:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  100287:	75 f6                	jne    10027f <strlen+0xa>
  100289:	c3                   	retq   
  10028a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10028f:	c3                   	retq   

0000000000100290 <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  100290:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100293:	ba 00 00 00 00       	mov    $0x0,%edx
  100298:	48 85 f6             	test   %rsi,%rsi
  10029b:	74 11                	je     1002ae <strnlen+0x1e>
  10029d:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  1002a1:	74 0c                	je     1002af <strnlen+0x1f>
        ++n;
  1002a3:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1002a7:	48 39 d0             	cmp    %rdx,%rax
  1002aa:	75 f1                	jne    10029d <strnlen+0xd>
  1002ac:	eb 04                	jmp    1002b2 <strnlen+0x22>
  1002ae:	c3                   	retq   
  1002af:	48 89 d0             	mov    %rdx,%rax
}
  1002b2:	c3                   	retq   

00000000001002b3 <strcpy>:
char* strcpy(char* dst, const char* src) {
  1002b3:	48 89 f8             	mov    %rdi,%rax
  1002b6:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  1002bb:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1002bf:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1002c2:	48 83 c2 01          	add    $0x1,%rdx
  1002c6:	84 c9                	test   %cl,%cl
  1002c8:	75 f1                	jne    1002bb <strcpy+0x8>
}
  1002ca:	c3                   	retq   

00000000001002cb <strcmp>:
    while (*a && *b && *a == *b) {
  1002cb:	0f b6 07             	movzbl (%rdi),%eax
  1002ce:	84 c0                	test   %al,%al
  1002d0:	74 1a                	je     1002ec <strcmp+0x21>
  1002d2:	0f b6 16             	movzbl (%rsi),%edx
  1002d5:	38 c2                	cmp    %al,%dl
  1002d7:	75 13                	jne    1002ec <strcmp+0x21>
  1002d9:	84 d2                	test   %dl,%dl
  1002db:	74 0f                	je     1002ec <strcmp+0x21>
        ++a, ++b;
  1002dd:	48 83 c7 01          	add    $0x1,%rdi
  1002e1:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  1002e5:	0f b6 07             	movzbl (%rdi),%eax
  1002e8:	84 c0                	test   %al,%al
  1002ea:	75 e6                	jne    1002d2 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  1002ec:	3a 06                	cmp    (%rsi),%al
  1002ee:	0f 97 c0             	seta   %al
  1002f1:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  1002f4:	83 d8 00             	sbb    $0x0,%eax
}
  1002f7:	c3                   	retq   

00000000001002f8 <strchr>:
    while (*s && *s != (char) c) {
  1002f8:	0f b6 07             	movzbl (%rdi),%eax
  1002fb:	84 c0                	test   %al,%al
  1002fd:	74 10                	je     10030f <strchr+0x17>
  1002ff:	40 38 f0             	cmp    %sil,%al
  100302:	74 18                	je     10031c <strchr+0x24>
        ++s;
  100304:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  100308:	0f b6 07             	movzbl (%rdi),%eax
  10030b:	84 c0                	test   %al,%al
  10030d:	75 f0                	jne    1002ff <strchr+0x7>
        return NULL;
  10030f:	40 84 f6             	test   %sil,%sil
  100312:	b8 00 00 00 00       	mov    $0x0,%eax
  100317:	48 0f 44 c7          	cmove  %rdi,%rax
}
  10031b:	c3                   	retq   
  10031c:	48 89 f8             	mov    %rdi,%rax
  10031f:	c3                   	retq   

0000000000100320 <rand>:
    if (!rand_seed_set) {
  100320:	83 3d ed 0c 00 00 00 	cmpl   $0x0,0xced(%rip)        # 101014 <rand_seed_set>
  100327:	74 1b                	je     100344 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100329:	69 05 dd 0c 00 00 0d 	imul   $0x19660d,0xcdd(%rip),%eax        # 101010 <rand_seed>
  100330:	66 19 00 
  100333:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100338:	89 05 d2 0c 00 00    	mov    %eax,0xcd2(%rip)        # 101010 <rand_seed>
    return rand_seed & RAND_MAX;
  10033e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100343:	c3                   	retq   
    rand_seed = seed;
  100344:	c7 05 c2 0c 00 00 9e 	movl   $0x30d4879e,0xcc2(%rip)        # 101010 <rand_seed>
  10034b:	87 d4 30 
    rand_seed_set = 1;
  10034e:	c7 05 bc 0c 00 00 01 	movl   $0x1,0xcbc(%rip)        # 101014 <rand_seed_set>
  100355:	00 00 00 
}
  100358:	eb cf                	jmp    100329 <rand+0x9>

000000000010035a <srand>:
    rand_seed = seed;
  10035a:	89 3d b0 0c 00 00    	mov    %edi,0xcb0(%rip)        # 101010 <rand_seed>
    rand_seed_set = 1;
  100360:	c7 05 aa 0c 00 00 01 	movl   $0x1,0xcaa(%rip)        # 101014 <rand_seed_set>
  100367:	00 00 00 
}
  10036a:	c3                   	retq   

000000000010036b <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10036b:	55                   	push   %rbp
  10036c:	48 89 e5             	mov    %rsp,%rbp
  10036f:	41 57                	push   %r15
  100371:	41 56                	push   %r14
  100373:	41 55                	push   %r13
  100375:	41 54                	push   %r12
  100377:	53                   	push   %rbx
  100378:	48 83 ec 58          	sub    $0x58,%rsp
  10037c:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  100380:	0f b6 02             	movzbl (%rdx),%eax
  100383:	84 c0                	test   %al,%al
  100385:	0f 84 b0 06 00 00    	je     100a3b <printer_vprintf+0x6d0>
  10038b:	49 89 fe             	mov    %rdi,%r14
  10038e:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  100391:	41 89 f7             	mov    %esi,%r15d
  100394:	e9 a4 04 00 00       	jmpq   10083d <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  100399:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  10039e:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1003a4:	45 84 e4             	test   %r12b,%r12b
  1003a7:	0f 84 82 06 00 00    	je     100a2f <printer_vprintf+0x6c4>
        int flags = 0;
  1003ad:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  1003b3:	41 0f be f4          	movsbl %r12b,%esi
  1003b7:	bf 71 0d 10 00       	mov    $0x100d71,%edi
  1003bc:	e8 37 ff ff ff       	callq  1002f8 <strchr>
  1003c1:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1003c4:	48 85 c0             	test   %rax,%rax
  1003c7:	74 55                	je     10041e <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  1003c9:	48 81 e9 71 0d 10 00 	sub    $0x100d71,%rcx
  1003d0:	b8 01 00 00 00       	mov    $0x1,%eax
  1003d5:	d3 e0                	shl    %cl,%eax
  1003d7:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1003da:	48 83 c3 01          	add    $0x1,%rbx
  1003de:	44 0f b6 23          	movzbl (%rbx),%r12d
  1003e2:	45 84 e4             	test   %r12b,%r12b
  1003e5:	75 cc                	jne    1003b3 <printer_vprintf+0x48>
  1003e7:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  1003eb:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  1003f1:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  1003f8:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  1003fb:	0f 84 a9 00 00 00    	je     1004aa <printer_vprintf+0x13f>
        int length = 0;
  100401:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  100406:	0f b6 13             	movzbl (%rbx),%edx
  100409:	8d 42 bd             	lea    -0x43(%rdx),%eax
  10040c:	3c 37                	cmp    $0x37,%al
  10040e:	0f 87 c4 04 00 00    	ja     1008d8 <printer_vprintf+0x56d>
  100414:	0f b6 c0             	movzbl %al,%eax
  100417:	ff 24 c5 80 0b 10 00 	jmpq   *0x100b80(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  10041e:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  100422:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  100427:	3c 08                	cmp    $0x8,%al
  100429:	77 2f                	ja     10045a <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10042b:	0f b6 03             	movzbl (%rbx),%eax
  10042e:	8d 50 d0             	lea    -0x30(%rax),%edx
  100431:	80 fa 09             	cmp    $0x9,%dl
  100434:	77 5e                	ja     100494 <printer_vprintf+0x129>
  100436:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  10043c:	48 83 c3 01          	add    $0x1,%rbx
  100440:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100445:	0f be c0             	movsbl %al,%eax
  100448:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10044d:	0f b6 03             	movzbl (%rbx),%eax
  100450:	8d 50 d0             	lea    -0x30(%rax),%edx
  100453:	80 fa 09             	cmp    $0x9,%dl
  100456:	76 e4                	jbe    10043c <printer_vprintf+0xd1>
  100458:	eb 97                	jmp    1003f1 <printer_vprintf+0x86>
        } else if (*format == '*') {
  10045a:	41 80 fc 2a          	cmp    $0x2a,%r12b
  10045e:	75 3f                	jne    10049f <printer_vprintf+0x134>
            width = va_arg(val, int);
  100460:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100464:	8b 07                	mov    (%rdi),%eax
  100466:	83 f8 2f             	cmp    $0x2f,%eax
  100469:	77 17                	ja     100482 <printer_vprintf+0x117>
  10046b:	89 c2                	mov    %eax,%edx
  10046d:	48 03 57 10          	add    0x10(%rdi),%rdx
  100471:	83 c0 08             	add    $0x8,%eax
  100474:	89 07                	mov    %eax,(%rdi)
  100476:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  100479:	48 83 c3 01          	add    $0x1,%rbx
  10047d:	e9 6f ff ff ff       	jmpq   1003f1 <printer_vprintf+0x86>
            width = va_arg(val, int);
  100482:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100486:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10048a:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10048e:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100492:	eb e2                	jmp    100476 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100494:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  10049a:	e9 52 ff ff ff       	jmpq   1003f1 <printer_vprintf+0x86>
        int width = -1;
  10049f:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1004a5:	e9 47 ff ff ff       	jmpq   1003f1 <printer_vprintf+0x86>
            ++format;
  1004aa:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1004ae:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1004b2:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1004b5:	80 f9 09             	cmp    $0x9,%cl
  1004b8:	76 13                	jbe    1004cd <printer_vprintf+0x162>
            } else if (*format == '*') {
  1004ba:	3c 2a                	cmp    $0x2a,%al
  1004bc:	74 33                	je     1004f1 <printer_vprintf+0x186>
            ++format;
  1004be:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1004c1:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1004c8:	e9 34 ff ff ff       	jmpq   100401 <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1004cd:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  1004d2:	48 83 c2 01          	add    $0x1,%rdx
  1004d6:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  1004d9:	0f be c0             	movsbl %al,%eax
  1004dc:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1004e0:	0f b6 02             	movzbl (%rdx),%eax
  1004e3:	8d 70 d0             	lea    -0x30(%rax),%esi
  1004e6:	40 80 fe 09          	cmp    $0x9,%sil
  1004ea:	76 e6                	jbe    1004d2 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  1004ec:	48 89 d3             	mov    %rdx,%rbx
  1004ef:	eb 1c                	jmp    10050d <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  1004f1:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004f5:	8b 07                	mov    (%rdi),%eax
  1004f7:	83 f8 2f             	cmp    $0x2f,%eax
  1004fa:	77 23                	ja     10051f <printer_vprintf+0x1b4>
  1004fc:	89 c2                	mov    %eax,%edx
  1004fe:	48 03 57 10          	add    0x10(%rdi),%rdx
  100502:	83 c0 08             	add    $0x8,%eax
  100505:	89 07                	mov    %eax,(%rdi)
  100507:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  100509:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  10050d:	85 c9                	test   %ecx,%ecx
  10050f:	b8 00 00 00 00       	mov    $0x0,%eax
  100514:	0f 49 c1             	cmovns %ecx,%eax
  100517:	89 45 9c             	mov    %eax,-0x64(%rbp)
  10051a:	e9 e2 fe ff ff       	jmpq   100401 <printer_vprintf+0x96>
                precision = va_arg(val, int);
  10051f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100523:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100527:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10052b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10052f:	eb d6                	jmp    100507 <printer_vprintf+0x19c>
        switch (*format) {
  100531:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100536:	e9 f3 00 00 00       	jmpq   10062e <printer_vprintf+0x2c3>
            ++format;
  10053b:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  10053f:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100544:	e9 bd fe ff ff       	jmpq   100406 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100549:	85 c9                	test   %ecx,%ecx
  10054b:	74 55                	je     1005a2 <printer_vprintf+0x237>
  10054d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100551:	8b 07                	mov    (%rdi),%eax
  100553:	83 f8 2f             	cmp    $0x2f,%eax
  100556:	77 38                	ja     100590 <printer_vprintf+0x225>
  100558:	89 c2                	mov    %eax,%edx
  10055a:	48 03 57 10          	add    0x10(%rdi),%rdx
  10055e:	83 c0 08             	add    $0x8,%eax
  100561:	89 07                	mov    %eax,(%rdi)
  100563:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100566:	48 89 d0             	mov    %rdx,%rax
  100569:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  10056d:	49 89 d0             	mov    %rdx,%r8
  100570:	49 f7 d8             	neg    %r8
  100573:	25 80 00 00 00       	and    $0x80,%eax
  100578:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10057c:	0b 45 a8             	or     -0x58(%rbp),%eax
  10057f:	83 c8 60             	or     $0x60,%eax
  100582:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  100585:	41 bc 71 0b 10 00    	mov    $0x100b71,%r12d
            break;
  10058b:	e9 35 01 00 00       	jmpq   1006c5 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100590:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100594:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100598:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10059c:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005a0:	eb c1                	jmp    100563 <printer_vprintf+0x1f8>
  1005a2:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005a6:	8b 07                	mov    (%rdi),%eax
  1005a8:	83 f8 2f             	cmp    $0x2f,%eax
  1005ab:	77 10                	ja     1005bd <printer_vprintf+0x252>
  1005ad:	89 c2                	mov    %eax,%edx
  1005af:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005b3:	83 c0 08             	add    $0x8,%eax
  1005b6:	89 07                	mov    %eax,(%rdi)
  1005b8:	48 63 12             	movslq (%rdx),%rdx
  1005bb:	eb a9                	jmp    100566 <printer_vprintf+0x1fb>
  1005bd:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005c1:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1005c5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005c9:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1005cd:	eb e9                	jmp    1005b8 <printer_vprintf+0x24d>
        int base = 10;
  1005cf:	be 0a 00 00 00       	mov    $0xa,%esi
  1005d4:	eb 58                	jmp    10062e <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1005d6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005da:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005de:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005e2:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005e6:	eb 60                	jmp    100648 <printer_vprintf+0x2dd>
  1005e8:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005ec:	8b 07                	mov    (%rdi),%eax
  1005ee:	83 f8 2f             	cmp    $0x2f,%eax
  1005f1:	77 10                	ja     100603 <printer_vprintf+0x298>
  1005f3:	89 c2                	mov    %eax,%edx
  1005f5:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005f9:	83 c0 08             	add    $0x8,%eax
  1005fc:	89 07                	mov    %eax,(%rdi)
  1005fe:	44 8b 02             	mov    (%rdx),%r8d
  100601:	eb 48                	jmp    10064b <printer_vprintf+0x2e0>
  100603:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100607:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10060b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10060f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100613:	eb e9                	jmp    1005fe <printer_vprintf+0x293>
  100615:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  100618:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  10061f:	bf 60 0d 10 00       	mov    $0x100d60,%edi
  100624:	e9 e2 02 00 00       	jmpq   10090b <printer_vprintf+0x5a0>
            base = 16;
  100629:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10062e:	85 c9                	test   %ecx,%ecx
  100630:	74 b6                	je     1005e8 <printer_vprintf+0x27d>
  100632:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100636:	8b 01                	mov    (%rcx),%eax
  100638:	83 f8 2f             	cmp    $0x2f,%eax
  10063b:	77 99                	ja     1005d6 <printer_vprintf+0x26b>
  10063d:	89 c2                	mov    %eax,%edx
  10063f:	48 03 51 10          	add    0x10(%rcx),%rdx
  100643:	83 c0 08             	add    $0x8,%eax
  100646:	89 01                	mov    %eax,(%rcx)
  100648:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  10064b:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  10064f:	85 f6                	test   %esi,%esi
  100651:	79 c2                	jns    100615 <printer_vprintf+0x2aa>
        base = -base;
  100653:	41 89 f1             	mov    %esi,%r9d
  100656:	f7 de                	neg    %esi
  100658:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  10065f:	bf 40 0d 10 00       	mov    $0x100d40,%edi
  100664:	e9 a2 02 00 00       	jmpq   10090b <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  100669:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10066d:	8b 07                	mov    (%rdi),%eax
  10066f:	83 f8 2f             	cmp    $0x2f,%eax
  100672:	77 1c                	ja     100690 <printer_vprintf+0x325>
  100674:	89 c2                	mov    %eax,%edx
  100676:	48 03 57 10          	add    0x10(%rdi),%rdx
  10067a:	83 c0 08             	add    $0x8,%eax
  10067d:	89 07                	mov    %eax,(%rdi)
  10067f:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100682:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  100689:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  10068e:	eb c3                	jmp    100653 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  100690:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100694:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100698:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10069c:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1006a0:	eb dd                	jmp    10067f <printer_vprintf+0x314>
            data = va_arg(val, char*);
  1006a2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1006a6:	8b 01                	mov    (%rcx),%eax
  1006a8:	83 f8 2f             	cmp    $0x2f,%eax
  1006ab:	0f 87 a5 01 00 00    	ja     100856 <printer_vprintf+0x4eb>
  1006b1:	89 c2                	mov    %eax,%edx
  1006b3:	48 03 51 10          	add    0x10(%rcx),%rdx
  1006b7:	83 c0 08             	add    $0x8,%eax
  1006ba:	89 01                	mov    %eax,(%rcx)
  1006bc:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1006bf:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1006c5:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006c8:	83 e0 20             	and    $0x20,%eax
  1006cb:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1006ce:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1006d4:	0f 85 21 02 00 00    	jne    1008fb <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1006da:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006dd:	89 45 88             	mov    %eax,-0x78(%rbp)
  1006e0:	83 e0 60             	and    $0x60,%eax
  1006e3:	83 f8 60             	cmp    $0x60,%eax
  1006e6:	0f 84 54 02 00 00    	je     100940 <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1006ec:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006ef:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  1006f2:	48 c7 45 a0 71 0b 10 	movq   $0x100b71,-0x60(%rbp)
  1006f9:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1006fa:	83 f8 21             	cmp    $0x21,%eax
  1006fd:	0f 84 79 02 00 00    	je     10097c <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100703:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  100706:	89 f8                	mov    %edi,%eax
  100708:	f7 d0                	not    %eax
  10070a:	c1 e8 1f             	shr    $0x1f,%eax
  10070d:	89 45 84             	mov    %eax,-0x7c(%rbp)
  100710:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100714:	0f 85 9e 02 00 00    	jne    1009b8 <printer_vprintf+0x64d>
  10071a:	84 c0                	test   %al,%al
  10071c:	0f 84 96 02 00 00    	je     1009b8 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  100722:	48 63 f7             	movslq %edi,%rsi
  100725:	4c 89 e7             	mov    %r12,%rdi
  100728:	e8 63 fb ff ff       	callq  100290 <strnlen>
  10072d:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  100730:	8b 45 88             	mov    -0x78(%rbp),%eax
  100733:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  100736:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  10073d:	83 f8 22             	cmp    $0x22,%eax
  100740:	0f 84 aa 02 00 00    	je     1009f0 <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100746:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  10074a:	e8 26 fb ff ff       	callq  100275 <strlen>
  10074f:	8b 55 9c             	mov    -0x64(%rbp),%edx
  100752:	03 55 98             	add    -0x68(%rbp),%edx
  100755:	44 89 e9             	mov    %r13d,%ecx
  100758:	29 d1                	sub    %edx,%ecx
  10075a:	29 c1                	sub    %eax,%ecx
  10075c:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  10075f:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100762:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100766:	75 2d                	jne    100795 <printer_vprintf+0x42a>
  100768:	85 c9                	test   %ecx,%ecx
  10076a:	7e 29                	jle    100795 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  10076c:	44 89 fa             	mov    %r15d,%edx
  10076f:	be 20 00 00 00       	mov    $0x20,%esi
  100774:	4c 89 f7             	mov    %r14,%rdi
  100777:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10077a:	41 83 ed 01          	sub    $0x1,%r13d
  10077e:	45 85 ed             	test   %r13d,%r13d
  100781:	7f e9                	jg     10076c <printer_vprintf+0x401>
  100783:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  100786:	85 ff                	test   %edi,%edi
  100788:	b8 01 00 00 00       	mov    $0x1,%eax
  10078d:	0f 4f c7             	cmovg  %edi,%eax
  100790:	29 c7                	sub    %eax,%edi
  100792:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  100795:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100799:	0f b6 07             	movzbl (%rdi),%eax
  10079c:	84 c0                	test   %al,%al
  10079e:	74 22                	je     1007c2 <printer_vprintf+0x457>
  1007a0:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007a4:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  1007a7:	0f b6 f0             	movzbl %al,%esi
  1007aa:	44 89 fa             	mov    %r15d,%edx
  1007ad:	4c 89 f7             	mov    %r14,%rdi
  1007b0:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  1007b3:	48 83 c3 01          	add    $0x1,%rbx
  1007b7:	0f b6 03             	movzbl (%rbx),%eax
  1007ba:	84 c0                	test   %al,%al
  1007bc:	75 e9                	jne    1007a7 <printer_vprintf+0x43c>
  1007be:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1007c2:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1007c5:	85 c0                	test   %eax,%eax
  1007c7:	7e 1d                	jle    1007e6 <printer_vprintf+0x47b>
  1007c9:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007cd:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1007cf:	44 89 fa             	mov    %r15d,%edx
  1007d2:	be 30 00 00 00       	mov    $0x30,%esi
  1007d7:	4c 89 f7             	mov    %r14,%rdi
  1007da:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  1007dd:	83 eb 01             	sub    $0x1,%ebx
  1007e0:	75 ed                	jne    1007cf <printer_vprintf+0x464>
  1007e2:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  1007e6:	8b 45 98             	mov    -0x68(%rbp),%eax
  1007e9:	85 c0                	test   %eax,%eax
  1007eb:	7e 27                	jle    100814 <printer_vprintf+0x4a9>
  1007ed:	89 c0                	mov    %eax,%eax
  1007ef:	4c 01 e0             	add    %r12,%rax
  1007f2:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007f6:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  1007f9:	41 0f b6 34 24       	movzbl (%r12),%esi
  1007fe:	44 89 fa             	mov    %r15d,%edx
  100801:	4c 89 f7             	mov    %r14,%rdi
  100804:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  100807:	49 83 c4 01          	add    $0x1,%r12
  10080b:	49 39 dc             	cmp    %rbx,%r12
  10080e:	75 e9                	jne    1007f9 <printer_vprintf+0x48e>
  100810:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  100814:	45 85 ed             	test   %r13d,%r13d
  100817:	7e 14                	jle    10082d <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  100819:	44 89 fa             	mov    %r15d,%edx
  10081c:	be 20 00 00 00       	mov    $0x20,%esi
  100821:	4c 89 f7             	mov    %r14,%rdi
  100824:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  100827:	41 83 ed 01          	sub    $0x1,%r13d
  10082b:	75 ec                	jne    100819 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  10082d:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  100831:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100835:	84 c0                	test   %al,%al
  100837:	0f 84 fe 01 00 00    	je     100a3b <printer_vprintf+0x6d0>
        if (*format != '%') {
  10083d:	3c 25                	cmp    $0x25,%al
  10083f:	0f 84 54 fb ff ff    	je     100399 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100845:	0f b6 f0             	movzbl %al,%esi
  100848:	44 89 fa             	mov    %r15d,%edx
  10084b:	4c 89 f7             	mov    %r14,%rdi
  10084e:	41 ff 16             	callq  *(%r14)
            continue;
  100851:	4c 89 e3             	mov    %r12,%rbx
  100854:	eb d7                	jmp    10082d <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  100856:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10085a:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10085e:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100862:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100866:	e9 51 fe ff ff       	jmpq   1006bc <printer_vprintf+0x351>
            color = va_arg(val, int);
  10086b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10086f:	8b 07                	mov    (%rdi),%eax
  100871:	83 f8 2f             	cmp    $0x2f,%eax
  100874:	77 10                	ja     100886 <printer_vprintf+0x51b>
  100876:	89 c2                	mov    %eax,%edx
  100878:	48 03 57 10          	add    0x10(%rdi),%rdx
  10087c:	83 c0 08             	add    $0x8,%eax
  10087f:	89 07                	mov    %eax,(%rdi)
  100881:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  100884:	eb a7                	jmp    10082d <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  100886:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10088a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10088e:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100892:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100896:	eb e9                	jmp    100881 <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  100898:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10089c:	8b 01                	mov    (%rcx),%eax
  10089e:	83 f8 2f             	cmp    $0x2f,%eax
  1008a1:	77 23                	ja     1008c6 <printer_vprintf+0x55b>
  1008a3:	89 c2                	mov    %eax,%edx
  1008a5:	48 03 51 10          	add    0x10(%rcx),%rdx
  1008a9:	83 c0 08             	add    $0x8,%eax
  1008ac:	89 01                	mov    %eax,(%rcx)
  1008ae:	8b 02                	mov    (%rdx),%eax
  1008b0:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  1008b3:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1008b7:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1008bb:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1008c1:	e9 ff fd ff ff       	jmpq   1006c5 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  1008c6:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1008ca:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1008ce:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1008d2:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1008d6:	eb d6                	jmp    1008ae <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  1008d8:	84 d2                	test   %dl,%dl
  1008da:	0f 85 39 01 00 00    	jne    100a19 <printer_vprintf+0x6ae>
  1008e0:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  1008e4:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  1008e8:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  1008ec:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1008f0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1008f6:	e9 ca fd ff ff       	jmpq   1006c5 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  1008fb:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  100901:	bf 60 0d 10 00       	mov    $0x100d60,%edi
        if (flags & FLAG_NUMERIC) {
  100906:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  10090b:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  10090f:	4c 89 c1             	mov    %r8,%rcx
  100912:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  100916:	48 63 f6             	movslq %esi,%rsi
  100919:	49 83 ec 01          	sub    $0x1,%r12
  10091d:	48 89 c8             	mov    %rcx,%rax
  100920:	ba 00 00 00 00       	mov    $0x0,%edx
  100925:	48 f7 f6             	div    %rsi
  100928:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  10092c:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  100930:	48 89 ca             	mov    %rcx,%rdx
  100933:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  100936:	48 39 d6             	cmp    %rdx,%rsi
  100939:	76 de                	jbe    100919 <printer_vprintf+0x5ae>
  10093b:	e9 9a fd ff ff       	jmpq   1006da <printer_vprintf+0x36f>
                prefix = "-";
  100940:	48 c7 45 a0 77 0b 10 	movq   $0x100b77,-0x60(%rbp)
  100947:	00 
            if (flags & FLAG_NEGATIVE) {
  100948:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10094b:	a8 80                	test   $0x80,%al
  10094d:	0f 85 b0 fd ff ff    	jne    100703 <printer_vprintf+0x398>
                prefix = "+";
  100953:	48 c7 45 a0 72 0b 10 	movq   $0x100b72,-0x60(%rbp)
  10095a:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  10095b:	a8 10                	test   $0x10,%al
  10095d:	0f 85 a0 fd ff ff    	jne    100703 <printer_vprintf+0x398>
                prefix = " ";
  100963:	a8 08                	test   $0x8,%al
  100965:	ba 71 0b 10 00       	mov    $0x100b71,%edx
  10096a:	b8 79 0b 10 00       	mov    $0x100b79,%eax
  10096f:	48 0f 44 c2          	cmove  %rdx,%rax
  100973:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100977:	e9 87 fd ff ff       	jmpq   100703 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  10097c:	41 8d 41 10          	lea    0x10(%r9),%eax
  100980:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  100985:	0f 85 78 fd ff ff    	jne    100703 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  10098b:	4d 85 c0             	test   %r8,%r8
  10098e:	75 0d                	jne    10099d <printer_vprintf+0x632>
  100990:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  100997:	0f 84 66 fd ff ff    	je     100703 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  10099d:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1009a1:	ba 7b 0b 10 00       	mov    $0x100b7b,%edx
  1009a6:	b8 74 0b 10 00       	mov    $0x100b74,%eax
  1009ab:	48 0f 44 c2          	cmove  %rdx,%rax
  1009af:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1009b3:	e9 4b fd ff ff       	jmpq   100703 <printer_vprintf+0x398>
            len = strlen(data);
  1009b8:	4c 89 e7             	mov    %r12,%rdi
  1009bb:	e8 b5 f8 ff ff       	callq  100275 <strlen>
  1009c0:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1009c3:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1009c7:	0f 84 63 fd ff ff    	je     100730 <printer_vprintf+0x3c5>
  1009cd:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1009d1:	0f 84 59 fd ff ff    	je     100730 <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  1009d7:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  1009da:	89 ca                	mov    %ecx,%edx
  1009dc:	29 c2                	sub    %eax,%edx
  1009de:	39 c1                	cmp    %eax,%ecx
  1009e0:	b8 00 00 00 00       	mov    $0x0,%eax
  1009e5:	0f 4e d0             	cmovle %eax,%edx
  1009e8:	89 55 9c             	mov    %edx,-0x64(%rbp)
  1009eb:	e9 56 fd ff ff       	jmpq   100746 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  1009f0:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1009f4:	e8 7c f8 ff ff       	callq  100275 <strlen>
  1009f9:	8b 7d 98             	mov    -0x68(%rbp),%edi
  1009fc:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  1009ff:	44 89 e9             	mov    %r13d,%ecx
  100a02:	29 f9                	sub    %edi,%ecx
  100a04:	29 c1                	sub    %eax,%ecx
  100a06:	44 39 ea             	cmp    %r13d,%edx
  100a09:	b8 00 00 00 00       	mov    $0x0,%eax
  100a0e:	0f 4d c8             	cmovge %eax,%ecx
  100a11:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  100a14:	e9 2d fd ff ff       	jmpq   100746 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  100a19:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100a1c:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  100a20:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100a24:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100a2a:	e9 96 fc ff ff       	jmpq   1006c5 <printer_vprintf+0x35a>
        int flags = 0;
  100a2f:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100a36:	e9 b0 f9 ff ff       	jmpq   1003eb <printer_vprintf+0x80>
}
  100a3b:	48 83 c4 58          	add    $0x58,%rsp
  100a3f:	5b                   	pop    %rbx
  100a40:	41 5c                	pop    %r12
  100a42:	41 5d                	pop    %r13
  100a44:	41 5e                	pop    %r14
  100a46:	41 5f                	pop    %r15
  100a48:	5d                   	pop    %rbp
  100a49:	c3                   	retq   

0000000000100a4a <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100a4a:	55                   	push   %rbp
  100a4b:	48 89 e5             	mov    %rsp,%rbp
  100a4e:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  100a52:	48 c7 45 f0 55 01 10 	movq   $0x100155,-0x10(%rbp)
  100a59:	00 
        cpos = 0;
  100a5a:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  100a60:	b8 00 00 00 00       	mov    $0x0,%eax
  100a65:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100a68:	48 63 ff             	movslq %edi,%rdi
  100a6b:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  100a72:	00 
  100a73:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100a77:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100a7b:	e8 eb f8 ff ff       	callq  10036b <printer_vprintf>
    return cp.cursor - console;
  100a80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a84:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100a8a:	48 d1 f8             	sar    %rax
}
  100a8d:	c9                   	leaveq 
  100a8e:	c3                   	retq   

0000000000100a8f <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  100a8f:	55                   	push   %rbp
  100a90:	48 89 e5             	mov    %rsp,%rbp
  100a93:	48 83 ec 50          	sub    $0x50,%rsp
  100a97:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a9b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a9f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  100aa3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100aaa:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100aae:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100ab2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100ab6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100aba:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100abe:	e8 87 ff ff ff       	callq  100a4a <console_vprintf>
}
  100ac3:	c9                   	leaveq 
  100ac4:	c3                   	retq   

0000000000100ac5 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100ac5:	55                   	push   %rbp
  100ac6:	48 89 e5             	mov    %rsp,%rbp
  100ac9:	53                   	push   %rbx
  100aca:	48 83 ec 28          	sub    $0x28,%rsp
  100ace:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  100ad1:	48 c7 45 d8 db 01 10 	movq   $0x1001db,-0x28(%rbp)
  100ad8:	00 
    sp.s = s;
  100ad9:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100add:	48 85 f6             	test   %rsi,%rsi
  100ae0:	75 0b                	jne    100aed <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100ae2:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100ae5:	29 d8                	sub    %ebx,%eax
}
  100ae7:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100aeb:	c9                   	leaveq 
  100aec:	c3                   	retq   
        sp.end = s + size - 1;
  100aed:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100af2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100af6:	be 00 00 00 00       	mov    $0x0,%esi
  100afb:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100aff:	e8 67 f8 ff ff       	callq  10036b <printer_vprintf>
        *sp.s = 0;
  100b04:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100b08:	c6 00 00             	movb   $0x0,(%rax)
  100b0b:	eb d5                	jmp    100ae2 <vsnprintf+0x1d>

0000000000100b0d <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100b0d:	55                   	push   %rbp
  100b0e:	48 89 e5             	mov    %rsp,%rbp
  100b11:	48 83 ec 50          	sub    $0x50,%rsp
  100b15:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b19:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b1d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100b21:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100b28:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100b2c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100b30:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100b34:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100b38:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100b3c:	e8 84 ff ff ff       	callq  100ac5 <vsnprintf>
    va_end(val);
    return n;
}
  100b41:	c9                   	leaveq 
  100b42:	c3                   	retq   

0000000000100b43 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b43:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100b48:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100b4d:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b52:	48 83 c0 02          	add    $0x2,%rax
  100b56:	48 39 d0             	cmp    %rdx,%rax
  100b59:	75 f2                	jne    100b4d <console_clear+0xa>
    }
    cursorpos = 0;
  100b5b:	c7 05 97 84 fb ff 00 	movl   $0x0,-0x47b69(%rip)        # b8ffc <cursorpos>
  100b62:	00 00 00 
}
  100b65:	c3                   	retq   

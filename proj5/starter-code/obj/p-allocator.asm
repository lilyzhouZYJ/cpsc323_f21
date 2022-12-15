
obj/p-allocator.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:

// These global variables go on the data page.
uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  10000d:	89 c7                	mov    %eax,%edi
  10000f:	e8 93 02 00 00       	callq  1002a7 <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100014:	b8 17 20 10 00       	mov    $0x102017,%eax
  100019:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001f:	48 89 05 e2 0f 00 00 	mov    %rax,0xfe2(%rip)        # 101008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100026:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100029:	48 83 e8 01          	sub    $0x1,%rax
  10002d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100033:	48 89 05 c6 0f 00 00 	mov    %rax,0xfc6(%rip)        # 101000 <stack_bottom>
  10003a:	eb 02                	jmp    10003e <process_main+0x3e>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  10003c:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  10003e:	e8 2a 02 00 00       	callq  10026d <rand>
  100043:	48 63 d0             	movslq %eax,%rdx
  100046:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  10004d:	48 c1 fa 25          	sar    $0x25,%rdx
  100051:	89 c1                	mov    %eax,%ecx
  100053:	c1 f9 1f             	sar    $0x1f,%ecx
  100056:	29 ca                	sub    %ecx,%edx
  100058:	6b d2 64             	imul   $0x64,%edx,%edx
  10005b:	29 d0                	sub    %edx,%eax
  10005d:	39 d8                	cmp    %ebx,%eax
  10005f:	7d db                	jge    10003c <process_main+0x3c>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  100061:	48 8b 3d a0 0f 00 00 	mov    0xfa0(%rip),%rdi        # 101008 <heap_top>
  100068:	48 3b 3d 91 0f 00 00 	cmp    0xf91(%rip),%rdi        # 101000 <stack_bottom>
  10006f:	74 2d                	je     10009e <process_main+0x9e>
    uintptr_t ad = (uintptr_t) addr;
    if(ad % PAGESIZE != 0)
        return -1;
    
    // check that addr is within vm bounds
    if(ad >= 0x300000)
  100071:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
  100077:	75 25                	jne    10009e <process_main+0x9e>
  100079:	48 81 ff ff ff 2f 00 	cmp    $0x2fffff,%rdi
  100080:	77 1c                	ja     10009e <process_main+0x9e>
        return -1;

    int result;
    asm volatile ("int %1" : "=a" (result)
  100082:	cd 33                	int    $0x33
  100084:	85 c0                	test   %eax,%eax
  100086:	78 16                	js     10009e <process_main+0x9e>
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
  100088:	48 8b 05 79 0f 00 00 	mov    0xf79(%rip),%rax        # 101008 <heap_top>
  10008f:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  100091:	48 81 05 6c 0f 00 00 	addq   $0x1000,0xf6c(%rip)        # 101008 <heap_top>
  100098:	00 10 00 00 
  10009c:	eb 9e                	jmp    10003c <process_main+0x3c>
    asm volatile ("int %0" : /* no result */
  10009e:	cd 32                	int    $0x32
  1000a0:	eb fc                	jmp    10009e <process_main+0x9e>

00000000001000a2 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1000a2:	48 89 f9             	mov    %rdi,%rcx
  1000a5:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1000a7:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  1000ae:	00 
  1000af:	72 08                	jb     1000b9 <console_putc+0x17>
        cp->cursor = console;
  1000b1:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  1000b8:	00 
    }
    if (c == '\n') {
  1000b9:	40 80 fe 0a          	cmp    $0xa,%sil
  1000bd:	74 16                	je     1000d5 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  1000bf:	48 8b 41 08          	mov    0x8(%rcx),%rax
  1000c3:	48 8d 50 02          	lea    0x2(%rax),%rdx
  1000c7:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  1000cb:	40 0f b6 f6          	movzbl %sil,%esi
  1000cf:	09 fe                	or     %edi,%esi
  1000d1:	66 89 30             	mov    %si,(%rax)
    }
}
  1000d4:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  1000d5:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  1000d9:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  1000e0:	4c 89 c6             	mov    %r8,%rsi
  1000e3:	48 d1 fe             	sar    %rsi
  1000e6:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1000ed:	66 66 66 
  1000f0:	48 89 f0             	mov    %rsi,%rax
  1000f3:	48 f7 ea             	imul   %rdx
  1000f6:	48 c1 fa 05          	sar    $0x5,%rdx
  1000fa:	49 c1 f8 3f          	sar    $0x3f,%r8
  1000fe:	4c 29 c2             	sub    %r8,%rdx
  100101:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  100105:	48 c1 e2 04          	shl    $0x4,%rdx
  100109:	89 f0                	mov    %esi,%eax
  10010b:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  10010d:	83 cf 20             	or     $0x20,%edi
  100110:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100114:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  100118:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  10011c:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  10011f:	83 c0 01             	add    $0x1,%eax
  100122:	83 f8 50             	cmp    $0x50,%eax
  100125:	75 e9                	jne    100110 <console_putc+0x6e>
  100127:	c3                   	retq   

0000000000100128 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  100128:	48 8b 47 08          	mov    0x8(%rdi),%rax
  10012c:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  100130:	73 0b                	jae    10013d <string_putc+0x15>
        *sp->s++ = c;
  100132:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100136:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  10013a:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  10013d:	c3                   	retq   

000000000010013e <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  10013e:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100141:	48 85 d2             	test   %rdx,%rdx
  100144:	74 17                	je     10015d <memcpy+0x1f>
  100146:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  10014b:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  100150:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100154:	48 83 c1 01          	add    $0x1,%rcx
  100158:	48 39 d1             	cmp    %rdx,%rcx
  10015b:	75 ee                	jne    10014b <memcpy+0xd>
}
  10015d:	c3                   	retq   

000000000010015e <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  10015e:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  100161:	48 39 fe             	cmp    %rdi,%rsi
  100164:	72 1d                	jb     100183 <memmove+0x25>
        while (n-- > 0) {
  100166:	b9 00 00 00 00       	mov    $0x0,%ecx
  10016b:	48 85 d2             	test   %rdx,%rdx
  10016e:	74 12                	je     100182 <memmove+0x24>
            *d++ = *s++;
  100170:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  100174:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  100178:	48 83 c1 01          	add    $0x1,%rcx
  10017c:	48 39 ca             	cmp    %rcx,%rdx
  10017f:	75 ef                	jne    100170 <memmove+0x12>
}
  100181:	c3                   	retq   
  100182:	c3                   	retq   
    if (s < d && s + n > d) {
  100183:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  100187:	48 39 cf             	cmp    %rcx,%rdi
  10018a:	73 da                	jae    100166 <memmove+0x8>
        while (n-- > 0) {
  10018c:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  100190:	48 85 d2             	test   %rdx,%rdx
  100193:	74 ec                	je     100181 <memmove+0x23>
            *--d = *--s;
  100195:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  100199:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  10019c:	48 83 e9 01          	sub    $0x1,%rcx
  1001a0:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  1001a4:	75 ef                	jne    100195 <memmove+0x37>
  1001a6:	c3                   	retq   

00000000001001a7 <memset>:
void* memset(void* v, int c, size_t n) {
  1001a7:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1001aa:	48 85 d2             	test   %rdx,%rdx
  1001ad:	74 12                	je     1001c1 <memset+0x1a>
  1001af:	48 01 fa             	add    %rdi,%rdx
  1001b2:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  1001b5:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1001b8:	48 83 c1 01          	add    $0x1,%rcx
  1001bc:	48 39 ca             	cmp    %rcx,%rdx
  1001bf:	75 f4                	jne    1001b5 <memset+0xe>
}
  1001c1:	c3                   	retq   

00000000001001c2 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  1001c2:	80 3f 00             	cmpb   $0x0,(%rdi)
  1001c5:	74 10                	je     1001d7 <strlen+0x15>
  1001c7:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  1001cc:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  1001d0:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1001d4:	75 f6                	jne    1001cc <strlen+0xa>
  1001d6:	c3                   	retq   
  1001d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1001dc:	c3                   	retq   

00000000001001dd <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  1001dd:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001e0:	ba 00 00 00 00       	mov    $0x0,%edx
  1001e5:	48 85 f6             	test   %rsi,%rsi
  1001e8:	74 11                	je     1001fb <strnlen+0x1e>
  1001ea:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  1001ee:	74 0c                	je     1001fc <strnlen+0x1f>
        ++n;
  1001f0:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001f4:	48 39 d0             	cmp    %rdx,%rax
  1001f7:	75 f1                	jne    1001ea <strnlen+0xd>
  1001f9:	eb 04                	jmp    1001ff <strnlen+0x22>
  1001fb:	c3                   	retq   
  1001fc:	48 89 d0             	mov    %rdx,%rax
}
  1001ff:	c3                   	retq   

0000000000100200 <strcpy>:
char* strcpy(char* dst, const char* src) {
  100200:	48 89 f8             	mov    %rdi,%rax
  100203:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  100208:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  10020c:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  10020f:	48 83 c2 01          	add    $0x1,%rdx
  100213:	84 c9                	test   %cl,%cl
  100215:	75 f1                	jne    100208 <strcpy+0x8>
}
  100217:	c3                   	retq   

0000000000100218 <strcmp>:
    while (*a && *b && *a == *b) {
  100218:	0f b6 07             	movzbl (%rdi),%eax
  10021b:	84 c0                	test   %al,%al
  10021d:	74 1a                	je     100239 <strcmp+0x21>
  10021f:	0f b6 16             	movzbl (%rsi),%edx
  100222:	38 c2                	cmp    %al,%dl
  100224:	75 13                	jne    100239 <strcmp+0x21>
  100226:	84 d2                	test   %dl,%dl
  100228:	74 0f                	je     100239 <strcmp+0x21>
        ++a, ++b;
  10022a:	48 83 c7 01          	add    $0x1,%rdi
  10022e:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  100232:	0f b6 07             	movzbl (%rdi),%eax
  100235:	84 c0                	test   %al,%al
  100237:	75 e6                	jne    10021f <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  100239:	3a 06                	cmp    (%rsi),%al
  10023b:	0f 97 c0             	seta   %al
  10023e:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  100241:	83 d8 00             	sbb    $0x0,%eax
}
  100244:	c3                   	retq   

0000000000100245 <strchr>:
    while (*s && *s != (char) c) {
  100245:	0f b6 07             	movzbl (%rdi),%eax
  100248:	84 c0                	test   %al,%al
  10024a:	74 10                	je     10025c <strchr+0x17>
  10024c:	40 38 f0             	cmp    %sil,%al
  10024f:	74 18                	je     100269 <strchr+0x24>
        ++s;
  100251:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  100255:	0f b6 07             	movzbl (%rdi),%eax
  100258:	84 c0                	test   %al,%al
  10025a:	75 f0                	jne    10024c <strchr+0x7>
        return NULL;
  10025c:	40 84 f6             	test   %sil,%sil
  10025f:	b8 00 00 00 00       	mov    $0x0,%eax
  100264:	48 0f 44 c7          	cmove  %rdi,%rax
}
  100268:	c3                   	retq   
  100269:	48 89 f8             	mov    %rdi,%rax
  10026c:	c3                   	retq   

000000000010026d <rand>:
    if (!rand_seed_set) {
  10026d:	83 3d a0 0d 00 00 00 	cmpl   $0x0,0xda0(%rip)        # 101014 <rand_seed_set>
  100274:	74 1b                	je     100291 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100276:	69 05 90 0d 00 00 0d 	imul   $0x19660d,0xd90(%rip),%eax        # 101010 <rand_seed>
  10027d:	66 19 00 
  100280:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100285:	89 05 85 0d 00 00    	mov    %eax,0xd85(%rip)        # 101010 <rand_seed>
    return rand_seed & RAND_MAX;
  10028b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100290:	c3                   	retq   
    rand_seed = seed;
  100291:	c7 05 75 0d 00 00 9e 	movl   $0x30d4879e,0xd75(%rip)        # 101010 <rand_seed>
  100298:	87 d4 30 
    rand_seed_set = 1;
  10029b:	c7 05 6f 0d 00 00 01 	movl   $0x1,0xd6f(%rip)        # 101014 <rand_seed_set>
  1002a2:	00 00 00 
}
  1002a5:	eb cf                	jmp    100276 <rand+0x9>

00000000001002a7 <srand>:
    rand_seed = seed;
  1002a7:	89 3d 63 0d 00 00    	mov    %edi,0xd63(%rip)        # 101010 <rand_seed>
    rand_seed_set = 1;
  1002ad:	c7 05 5d 0d 00 00 01 	movl   $0x1,0xd5d(%rip)        # 101014 <rand_seed_set>
  1002b4:	00 00 00 
}
  1002b7:	c3                   	retq   

00000000001002b8 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1002b8:	55                   	push   %rbp
  1002b9:	48 89 e5             	mov    %rsp,%rbp
  1002bc:	41 57                	push   %r15
  1002be:	41 56                	push   %r14
  1002c0:	41 55                	push   %r13
  1002c2:	41 54                	push   %r12
  1002c4:	53                   	push   %rbx
  1002c5:	48 83 ec 58          	sub    $0x58,%rsp
  1002c9:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  1002cd:	0f b6 02             	movzbl (%rdx),%eax
  1002d0:	84 c0                	test   %al,%al
  1002d2:	0f 84 b0 06 00 00    	je     100988 <printer_vprintf+0x6d0>
  1002d8:	49 89 fe             	mov    %rdi,%r14
  1002db:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  1002de:	41 89 f7             	mov    %esi,%r15d
  1002e1:	e9 a4 04 00 00       	jmpq   10078a <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  1002e6:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  1002eb:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1002f1:	45 84 e4             	test   %r12b,%r12b
  1002f4:	0f 84 82 06 00 00    	je     10097c <printer_vprintf+0x6c4>
        int flags = 0;
  1002fa:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  100300:	41 0f be f4          	movsbl %r12b,%esi
  100304:	bf c1 0c 10 00       	mov    $0x100cc1,%edi
  100309:	e8 37 ff ff ff       	callq  100245 <strchr>
  10030e:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  100311:	48 85 c0             	test   %rax,%rax
  100314:	74 55                	je     10036b <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  100316:	48 81 e9 c1 0c 10 00 	sub    $0x100cc1,%rcx
  10031d:	b8 01 00 00 00       	mov    $0x1,%eax
  100322:	d3 e0                	shl    %cl,%eax
  100324:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  100327:	48 83 c3 01          	add    $0x1,%rbx
  10032b:	44 0f b6 23          	movzbl (%rbx),%r12d
  10032f:	45 84 e4             	test   %r12b,%r12b
  100332:	75 cc                	jne    100300 <printer_vprintf+0x48>
  100334:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  100338:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  10033e:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  100345:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  100348:	0f 84 a9 00 00 00    	je     1003f7 <printer_vprintf+0x13f>
        int length = 0;
  10034e:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  100353:	0f b6 13             	movzbl (%rbx),%edx
  100356:	8d 42 bd             	lea    -0x43(%rdx),%eax
  100359:	3c 37                	cmp    $0x37,%al
  10035b:	0f 87 c4 04 00 00    	ja     100825 <printer_vprintf+0x56d>
  100361:	0f b6 c0             	movzbl %al,%eax
  100364:	ff 24 c5 d0 0a 10 00 	jmpq   *0x100ad0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  10036b:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  10036f:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  100374:	3c 08                	cmp    $0x8,%al
  100376:	77 2f                	ja     1003a7 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100378:	0f b6 03             	movzbl (%rbx),%eax
  10037b:	8d 50 d0             	lea    -0x30(%rax),%edx
  10037e:	80 fa 09             	cmp    $0x9,%dl
  100381:	77 5e                	ja     1003e1 <printer_vprintf+0x129>
  100383:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  100389:	48 83 c3 01          	add    $0x1,%rbx
  10038d:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100392:	0f be c0             	movsbl %al,%eax
  100395:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10039a:	0f b6 03             	movzbl (%rbx),%eax
  10039d:	8d 50 d0             	lea    -0x30(%rax),%edx
  1003a0:	80 fa 09             	cmp    $0x9,%dl
  1003a3:	76 e4                	jbe    100389 <printer_vprintf+0xd1>
  1003a5:	eb 97                	jmp    10033e <printer_vprintf+0x86>
        } else if (*format == '*') {
  1003a7:	41 80 fc 2a          	cmp    $0x2a,%r12b
  1003ab:	75 3f                	jne    1003ec <printer_vprintf+0x134>
            width = va_arg(val, int);
  1003ad:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1003b1:	8b 07                	mov    (%rdi),%eax
  1003b3:	83 f8 2f             	cmp    $0x2f,%eax
  1003b6:	77 17                	ja     1003cf <printer_vprintf+0x117>
  1003b8:	89 c2                	mov    %eax,%edx
  1003ba:	48 03 57 10          	add    0x10(%rdi),%rdx
  1003be:	83 c0 08             	add    $0x8,%eax
  1003c1:	89 07                	mov    %eax,(%rdi)
  1003c3:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  1003c6:	48 83 c3 01          	add    $0x1,%rbx
  1003ca:	e9 6f ff ff ff       	jmpq   10033e <printer_vprintf+0x86>
            width = va_arg(val, int);
  1003cf:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1003d3:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1003d7:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1003db:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1003df:	eb e2                	jmp    1003c3 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003e1:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1003e7:	e9 52 ff ff ff       	jmpq   10033e <printer_vprintf+0x86>
        int width = -1;
  1003ec:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1003f2:	e9 47 ff ff ff       	jmpq   10033e <printer_vprintf+0x86>
            ++format;
  1003f7:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1003fb:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1003ff:	8d 48 d0             	lea    -0x30(%rax),%ecx
  100402:	80 f9 09             	cmp    $0x9,%cl
  100405:	76 13                	jbe    10041a <printer_vprintf+0x162>
            } else if (*format == '*') {
  100407:	3c 2a                	cmp    $0x2a,%al
  100409:	74 33                	je     10043e <printer_vprintf+0x186>
            ++format;
  10040b:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  10040e:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  100415:	e9 34 ff ff ff       	jmpq   10034e <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10041a:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  10041f:	48 83 c2 01          	add    $0x1,%rdx
  100423:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  100426:	0f be c0             	movsbl %al,%eax
  100429:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10042d:	0f b6 02             	movzbl (%rdx),%eax
  100430:	8d 70 d0             	lea    -0x30(%rax),%esi
  100433:	40 80 fe 09          	cmp    $0x9,%sil
  100437:	76 e6                	jbe    10041f <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  100439:	48 89 d3             	mov    %rdx,%rbx
  10043c:	eb 1c                	jmp    10045a <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  10043e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100442:	8b 07                	mov    (%rdi),%eax
  100444:	83 f8 2f             	cmp    $0x2f,%eax
  100447:	77 23                	ja     10046c <printer_vprintf+0x1b4>
  100449:	89 c2                	mov    %eax,%edx
  10044b:	48 03 57 10          	add    0x10(%rdi),%rdx
  10044f:	83 c0 08             	add    $0x8,%eax
  100452:	89 07                	mov    %eax,(%rdi)
  100454:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  100456:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  10045a:	85 c9                	test   %ecx,%ecx
  10045c:	b8 00 00 00 00       	mov    $0x0,%eax
  100461:	0f 49 c1             	cmovns %ecx,%eax
  100464:	89 45 9c             	mov    %eax,-0x64(%rbp)
  100467:	e9 e2 fe ff ff       	jmpq   10034e <printer_vprintf+0x96>
                precision = va_arg(val, int);
  10046c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100470:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100474:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100478:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10047c:	eb d6                	jmp    100454 <printer_vprintf+0x19c>
        switch (*format) {
  10047e:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100483:	e9 f3 00 00 00       	jmpq   10057b <printer_vprintf+0x2c3>
            ++format;
  100488:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  10048c:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100491:	e9 bd fe ff ff       	jmpq   100353 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100496:	85 c9                	test   %ecx,%ecx
  100498:	74 55                	je     1004ef <printer_vprintf+0x237>
  10049a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10049e:	8b 07                	mov    (%rdi),%eax
  1004a0:	83 f8 2f             	cmp    $0x2f,%eax
  1004a3:	77 38                	ja     1004dd <printer_vprintf+0x225>
  1004a5:	89 c2                	mov    %eax,%edx
  1004a7:	48 03 57 10          	add    0x10(%rdi),%rdx
  1004ab:	83 c0 08             	add    $0x8,%eax
  1004ae:	89 07                	mov    %eax,(%rdi)
  1004b0:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1004b3:	48 89 d0             	mov    %rdx,%rax
  1004b6:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  1004ba:	49 89 d0             	mov    %rdx,%r8
  1004bd:	49 f7 d8             	neg    %r8
  1004c0:	25 80 00 00 00       	and    $0x80,%eax
  1004c5:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1004c9:	0b 45 a8             	or     -0x58(%rbp),%eax
  1004cc:	83 c8 60             	or     $0x60,%eax
  1004cf:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  1004d2:	41 bc c8 0a 10 00    	mov    $0x100ac8,%r12d
            break;
  1004d8:	e9 35 01 00 00       	jmpq   100612 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1004dd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004e1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004e5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004e9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1004ed:	eb c1                	jmp    1004b0 <printer_vprintf+0x1f8>
  1004ef:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004f3:	8b 07                	mov    (%rdi),%eax
  1004f5:	83 f8 2f             	cmp    $0x2f,%eax
  1004f8:	77 10                	ja     10050a <printer_vprintf+0x252>
  1004fa:	89 c2                	mov    %eax,%edx
  1004fc:	48 03 57 10          	add    0x10(%rdi),%rdx
  100500:	83 c0 08             	add    $0x8,%eax
  100503:	89 07                	mov    %eax,(%rdi)
  100505:	48 63 12             	movslq (%rdx),%rdx
  100508:	eb a9                	jmp    1004b3 <printer_vprintf+0x1fb>
  10050a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10050e:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100512:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100516:	48 89 47 08          	mov    %rax,0x8(%rdi)
  10051a:	eb e9                	jmp    100505 <printer_vprintf+0x24d>
        int base = 10;
  10051c:	be 0a 00 00 00       	mov    $0xa,%esi
  100521:	eb 58                	jmp    10057b <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100523:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100527:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10052b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10052f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100533:	eb 60                	jmp    100595 <printer_vprintf+0x2dd>
  100535:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100539:	8b 07                	mov    (%rdi),%eax
  10053b:	83 f8 2f             	cmp    $0x2f,%eax
  10053e:	77 10                	ja     100550 <printer_vprintf+0x298>
  100540:	89 c2                	mov    %eax,%edx
  100542:	48 03 57 10          	add    0x10(%rdi),%rdx
  100546:	83 c0 08             	add    $0x8,%eax
  100549:	89 07                	mov    %eax,(%rdi)
  10054b:	44 8b 02             	mov    (%rdx),%r8d
  10054e:	eb 48                	jmp    100598 <printer_vprintf+0x2e0>
  100550:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100554:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100558:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10055c:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100560:	eb e9                	jmp    10054b <printer_vprintf+0x293>
  100562:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  100565:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  10056c:	bf b0 0c 10 00       	mov    $0x100cb0,%edi
  100571:	e9 e2 02 00 00       	jmpq   100858 <printer_vprintf+0x5a0>
            base = 16;
  100576:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10057b:	85 c9                	test   %ecx,%ecx
  10057d:	74 b6                	je     100535 <printer_vprintf+0x27d>
  10057f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100583:	8b 01                	mov    (%rcx),%eax
  100585:	83 f8 2f             	cmp    $0x2f,%eax
  100588:	77 99                	ja     100523 <printer_vprintf+0x26b>
  10058a:	89 c2                	mov    %eax,%edx
  10058c:	48 03 51 10          	add    0x10(%rcx),%rdx
  100590:	83 c0 08             	add    $0x8,%eax
  100593:	89 01                	mov    %eax,(%rcx)
  100595:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  100598:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  10059c:	85 f6                	test   %esi,%esi
  10059e:	79 c2                	jns    100562 <printer_vprintf+0x2aa>
        base = -base;
  1005a0:	41 89 f1             	mov    %esi,%r9d
  1005a3:	f7 de                	neg    %esi
  1005a5:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  1005ac:	bf 90 0c 10 00       	mov    $0x100c90,%edi
  1005b1:	e9 a2 02 00 00       	jmpq   100858 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  1005b6:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005ba:	8b 07                	mov    (%rdi),%eax
  1005bc:	83 f8 2f             	cmp    $0x2f,%eax
  1005bf:	77 1c                	ja     1005dd <printer_vprintf+0x325>
  1005c1:	89 c2                	mov    %eax,%edx
  1005c3:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005c7:	83 c0 08             	add    $0x8,%eax
  1005ca:	89 07                	mov    %eax,(%rdi)
  1005cc:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1005cf:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  1005d6:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1005db:	eb c3                	jmp    1005a0 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  1005dd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005e1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005e5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005e9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005ed:	eb dd                	jmp    1005cc <printer_vprintf+0x314>
            data = va_arg(val, char*);
  1005ef:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005f3:	8b 01                	mov    (%rcx),%eax
  1005f5:	83 f8 2f             	cmp    $0x2f,%eax
  1005f8:	0f 87 a5 01 00 00    	ja     1007a3 <printer_vprintf+0x4eb>
  1005fe:	89 c2                	mov    %eax,%edx
  100600:	48 03 51 10          	add    0x10(%rcx),%rdx
  100604:	83 c0 08             	add    $0x8,%eax
  100607:	89 01                	mov    %eax,(%rcx)
  100609:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  10060c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  100612:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100615:	83 e0 20             	and    $0x20,%eax
  100618:	89 45 8c             	mov    %eax,-0x74(%rbp)
  10061b:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  100621:	0f 85 21 02 00 00    	jne    100848 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100627:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10062a:	89 45 88             	mov    %eax,-0x78(%rbp)
  10062d:	83 e0 60             	and    $0x60,%eax
  100630:	83 f8 60             	cmp    $0x60,%eax
  100633:	0f 84 54 02 00 00    	je     10088d <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100639:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10063c:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  10063f:	48 c7 45 a0 c8 0a 10 	movq   $0x100ac8,-0x60(%rbp)
  100646:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100647:	83 f8 21             	cmp    $0x21,%eax
  10064a:	0f 84 79 02 00 00    	je     1008c9 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100650:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  100653:	89 f8                	mov    %edi,%eax
  100655:	f7 d0                	not    %eax
  100657:	c1 e8 1f             	shr    $0x1f,%eax
  10065a:	89 45 84             	mov    %eax,-0x7c(%rbp)
  10065d:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100661:	0f 85 9e 02 00 00    	jne    100905 <printer_vprintf+0x64d>
  100667:	84 c0                	test   %al,%al
  100669:	0f 84 96 02 00 00    	je     100905 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  10066f:	48 63 f7             	movslq %edi,%rsi
  100672:	4c 89 e7             	mov    %r12,%rdi
  100675:	e8 63 fb ff ff       	callq  1001dd <strnlen>
  10067a:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  10067d:	8b 45 88             	mov    -0x78(%rbp),%eax
  100680:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  100683:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  10068a:	83 f8 22             	cmp    $0x22,%eax
  10068d:	0f 84 aa 02 00 00    	je     10093d <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100693:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100697:	e8 26 fb ff ff       	callq  1001c2 <strlen>
  10069c:	8b 55 9c             	mov    -0x64(%rbp),%edx
  10069f:	03 55 98             	add    -0x68(%rbp),%edx
  1006a2:	44 89 e9             	mov    %r13d,%ecx
  1006a5:	29 d1                	sub    %edx,%ecx
  1006a7:	29 c1                	sub    %eax,%ecx
  1006a9:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  1006ac:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1006af:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  1006b3:	75 2d                	jne    1006e2 <printer_vprintf+0x42a>
  1006b5:	85 c9                	test   %ecx,%ecx
  1006b7:	7e 29                	jle    1006e2 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  1006b9:	44 89 fa             	mov    %r15d,%edx
  1006bc:	be 20 00 00 00       	mov    $0x20,%esi
  1006c1:	4c 89 f7             	mov    %r14,%rdi
  1006c4:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1006c7:	41 83 ed 01          	sub    $0x1,%r13d
  1006cb:	45 85 ed             	test   %r13d,%r13d
  1006ce:	7f e9                	jg     1006b9 <printer_vprintf+0x401>
  1006d0:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  1006d3:	85 ff                	test   %edi,%edi
  1006d5:	b8 01 00 00 00       	mov    $0x1,%eax
  1006da:	0f 4f c7             	cmovg  %edi,%eax
  1006dd:	29 c7                	sub    %eax,%edi
  1006df:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  1006e2:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1006e6:	0f b6 07             	movzbl (%rdi),%eax
  1006e9:	84 c0                	test   %al,%al
  1006eb:	74 22                	je     10070f <printer_vprintf+0x457>
  1006ed:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1006f1:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  1006f4:	0f b6 f0             	movzbl %al,%esi
  1006f7:	44 89 fa             	mov    %r15d,%edx
  1006fa:	4c 89 f7             	mov    %r14,%rdi
  1006fd:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  100700:	48 83 c3 01          	add    $0x1,%rbx
  100704:	0f b6 03             	movzbl (%rbx),%eax
  100707:	84 c0                	test   %al,%al
  100709:	75 e9                	jne    1006f4 <printer_vprintf+0x43c>
  10070b:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  10070f:	8b 45 9c             	mov    -0x64(%rbp),%eax
  100712:	85 c0                	test   %eax,%eax
  100714:	7e 1d                	jle    100733 <printer_vprintf+0x47b>
  100716:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  10071a:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  10071c:	44 89 fa             	mov    %r15d,%edx
  10071f:	be 30 00 00 00       	mov    $0x30,%esi
  100724:	4c 89 f7             	mov    %r14,%rdi
  100727:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  10072a:	83 eb 01             	sub    $0x1,%ebx
  10072d:	75 ed                	jne    10071c <printer_vprintf+0x464>
  10072f:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  100733:	8b 45 98             	mov    -0x68(%rbp),%eax
  100736:	85 c0                	test   %eax,%eax
  100738:	7e 27                	jle    100761 <printer_vprintf+0x4a9>
  10073a:	89 c0                	mov    %eax,%eax
  10073c:	4c 01 e0             	add    %r12,%rax
  10073f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100743:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  100746:	41 0f b6 34 24       	movzbl (%r12),%esi
  10074b:	44 89 fa             	mov    %r15d,%edx
  10074e:	4c 89 f7             	mov    %r14,%rdi
  100751:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  100754:	49 83 c4 01          	add    $0x1,%r12
  100758:	49 39 dc             	cmp    %rbx,%r12
  10075b:	75 e9                	jne    100746 <printer_vprintf+0x48e>
  10075d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  100761:	45 85 ed             	test   %r13d,%r13d
  100764:	7e 14                	jle    10077a <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  100766:	44 89 fa             	mov    %r15d,%edx
  100769:	be 20 00 00 00       	mov    $0x20,%esi
  10076e:	4c 89 f7             	mov    %r14,%rdi
  100771:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  100774:	41 83 ed 01          	sub    $0x1,%r13d
  100778:	75 ec                	jne    100766 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  10077a:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  10077e:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100782:	84 c0                	test   %al,%al
  100784:	0f 84 fe 01 00 00    	je     100988 <printer_vprintf+0x6d0>
        if (*format != '%') {
  10078a:	3c 25                	cmp    $0x25,%al
  10078c:	0f 84 54 fb ff ff    	je     1002e6 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100792:	0f b6 f0             	movzbl %al,%esi
  100795:	44 89 fa             	mov    %r15d,%edx
  100798:	4c 89 f7             	mov    %r14,%rdi
  10079b:	41 ff 16             	callq  *(%r14)
            continue;
  10079e:	4c 89 e3             	mov    %r12,%rbx
  1007a1:	eb d7                	jmp    10077a <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  1007a3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1007a7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1007ab:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007af:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1007b3:	e9 51 fe ff ff       	jmpq   100609 <printer_vprintf+0x351>
            color = va_arg(val, int);
  1007b8:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1007bc:	8b 07                	mov    (%rdi),%eax
  1007be:	83 f8 2f             	cmp    $0x2f,%eax
  1007c1:	77 10                	ja     1007d3 <printer_vprintf+0x51b>
  1007c3:	89 c2                	mov    %eax,%edx
  1007c5:	48 03 57 10          	add    0x10(%rdi),%rdx
  1007c9:	83 c0 08             	add    $0x8,%eax
  1007cc:	89 07                	mov    %eax,(%rdi)
  1007ce:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  1007d1:	eb a7                	jmp    10077a <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  1007d3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007d7:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1007db:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007df:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1007e3:	eb e9                	jmp    1007ce <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  1007e5:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007e9:	8b 01                	mov    (%rcx),%eax
  1007eb:	83 f8 2f             	cmp    $0x2f,%eax
  1007ee:	77 23                	ja     100813 <printer_vprintf+0x55b>
  1007f0:	89 c2                	mov    %eax,%edx
  1007f2:	48 03 51 10          	add    0x10(%rcx),%rdx
  1007f6:	83 c0 08             	add    $0x8,%eax
  1007f9:	89 01                	mov    %eax,(%rcx)
  1007fb:	8b 02                	mov    (%rdx),%eax
  1007fd:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  100800:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  100804:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100808:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  10080e:	e9 ff fd ff ff       	jmpq   100612 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  100813:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100817:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10081b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10081f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100823:	eb d6                	jmp    1007fb <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  100825:	84 d2                	test   %dl,%dl
  100827:	0f 85 39 01 00 00    	jne    100966 <printer_vprintf+0x6ae>
  10082d:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  100831:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  100835:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  100839:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10083d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100843:	e9 ca fd ff ff       	jmpq   100612 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  100848:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  10084e:	bf b0 0c 10 00       	mov    $0x100cb0,%edi
        if (flags & FLAG_NUMERIC) {
  100853:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  100858:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  10085c:	4c 89 c1             	mov    %r8,%rcx
  10085f:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  100863:	48 63 f6             	movslq %esi,%rsi
  100866:	49 83 ec 01          	sub    $0x1,%r12
  10086a:	48 89 c8             	mov    %rcx,%rax
  10086d:	ba 00 00 00 00       	mov    $0x0,%edx
  100872:	48 f7 f6             	div    %rsi
  100875:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  100879:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  10087d:	48 89 ca             	mov    %rcx,%rdx
  100880:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  100883:	48 39 d6             	cmp    %rdx,%rsi
  100886:	76 de                	jbe    100866 <printer_vprintf+0x5ae>
  100888:	e9 9a fd ff ff       	jmpq   100627 <printer_vprintf+0x36f>
                prefix = "-";
  10088d:	48 c7 45 a0 c5 0a 10 	movq   $0x100ac5,-0x60(%rbp)
  100894:	00 
            if (flags & FLAG_NEGATIVE) {
  100895:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100898:	a8 80                	test   $0x80,%al
  10089a:	0f 85 b0 fd ff ff    	jne    100650 <printer_vprintf+0x398>
                prefix = "+";
  1008a0:	48 c7 45 a0 c0 0a 10 	movq   $0x100ac0,-0x60(%rbp)
  1008a7:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1008a8:	a8 10                	test   $0x10,%al
  1008aa:	0f 85 a0 fd ff ff    	jne    100650 <printer_vprintf+0x398>
                prefix = " ";
  1008b0:	a8 08                	test   $0x8,%al
  1008b2:	ba c8 0a 10 00       	mov    $0x100ac8,%edx
  1008b7:	b8 c7 0a 10 00       	mov    $0x100ac7,%eax
  1008bc:	48 0f 44 c2          	cmove  %rdx,%rax
  1008c0:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1008c4:	e9 87 fd ff ff       	jmpq   100650 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  1008c9:	41 8d 41 10          	lea    0x10(%r9),%eax
  1008cd:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  1008d2:	0f 85 78 fd ff ff    	jne    100650 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  1008d8:	4d 85 c0             	test   %r8,%r8
  1008db:	75 0d                	jne    1008ea <printer_vprintf+0x632>
  1008dd:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  1008e4:	0f 84 66 fd ff ff    	je     100650 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  1008ea:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1008ee:	ba c9 0a 10 00       	mov    $0x100ac9,%edx
  1008f3:	b8 c2 0a 10 00       	mov    $0x100ac2,%eax
  1008f8:	48 0f 44 c2          	cmove  %rdx,%rax
  1008fc:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100900:	e9 4b fd ff ff       	jmpq   100650 <printer_vprintf+0x398>
            len = strlen(data);
  100905:	4c 89 e7             	mov    %r12,%rdi
  100908:	e8 b5 f8 ff ff       	callq  1001c2 <strlen>
  10090d:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100910:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100914:	0f 84 63 fd ff ff    	je     10067d <printer_vprintf+0x3c5>
  10091a:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  10091e:	0f 84 59 fd ff ff    	je     10067d <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  100924:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  100927:	89 ca                	mov    %ecx,%edx
  100929:	29 c2                	sub    %eax,%edx
  10092b:	39 c1                	cmp    %eax,%ecx
  10092d:	b8 00 00 00 00       	mov    $0x0,%eax
  100932:	0f 4e d0             	cmovle %eax,%edx
  100935:	89 55 9c             	mov    %edx,-0x64(%rbp)
  100938:	e9 56 fd ff ff       	jmpq   100693 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  10093d:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100941:	e8 7c f8 ff ff       	callq  1001c2 <strlen>
  100946:	8b 7d 98             	mov    -0x68(%rbp),%edi
  100949:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  10094c:	44 89 e9             	mov    %r13d,%ecx
  10094f:	29 f9                	sub    %edi,%ecx
  100951:	29 c1                	sub    %eax,%ecx
  100953:	44 39 ea             	cmp    %r13d,%edx
  100956:	b8 00 00 00 00       	mov    $0x0,%eax
  10095b:	0f 4d c8             	cmovge %eax,%ecx
  10095e:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  100961:	e9 2d fd ff ff       	jmpq   100693 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  100966:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100969:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  10096d:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100971:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100977:	e9 96 fc ff ff       	jmpq   100612 <printer_vprintf+0x35a>
        int flags = 0;
  10097c:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100983:	e9 b0 f9 ff ff       	jmpq   100338 <printer_vprintf+0x80>
}
  100988:	48 83 c4 58          	add    $0x58,%rsp
  10098c:	5b                   	pop    %rbx
  10098d:	41 5c                	pop    %r12
  10098f:	41 5d                	pop    %r13
  100991:	41 5e                	pop    %r14
  100993:	41 5f                	pop    %r15
  100995:	5d                   	pop    %rbp
  100996:	c3                   	retq   

0000000000100997 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100997:	55                   	push   %rbp
  100998:	48 89 e5             	mov    %rsp,%rbp
  10099b:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  10099f:	48 c7 45 f0 a2 00 10 	movq   $0x1000a2,-0x10(%rbp)
  1009a6:	00 
        cpos = 0;
  1009a7:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  1009ad:	b8 00 00 00 00       	mov    $0x0,%eax
  1009b2:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  1009b5:	48 63 ff             	movslq %edi,%rdi
  1009b8:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  1009bf:	00 
  1009c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1009c4:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  1009c8:	e8 eb f8 ff ff       	callq  1002b8 <printer_vprintf>
    return cp.cursor - console;
  1009cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009d1:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1009d7:	48 d1 f8             	sar    %rax
}
  1009da:	c9                   	leaveq 
  1009db:	c3                   	retq   

00000000001009dc <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  1009dc:	55                   	push   %rbp
  1009dd:	48 89 e5             	mov    %rsp,%rbp
  1009e0:	48 83 ec 50          	sub    $0x50,%rsp
  1009e4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1009e8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1009ec:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  1009f0:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1009f7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1009fb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1009ff:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100a03:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100a07:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100a0b:	e8 87 ff ff ff       	callq  100997 <console_vprintf>
}
  100a10:	c9                   	leaveq 
  100a11:	c3                   	retq   

0000000000100a12 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100a12:	55                   	push   %rbp
  100a13:	48 89 e5             	mov    %rsp,%rbp
  100a16:	53                   	push   %rbx
  100a17:	48 83 ec 28          	sub    $0x28,%rsp
  100a1b:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  100a1e:	48 c7 45 d8 28 01 10 	movq   $0x100128,-0x28(%rbp)
  100a25:	00 
    sp.s = s;
  100a26:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100a2a:	48 85 f6             	test   %rsi,%rsi
  100a2d:	75 0b                	jne    100a3a <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100a2f:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100a32:	29 d8                	sub    %ebx,%eax
}
  100a34:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100a38:	c9                   	leaveq 
  100a39:	c3                   	retq   
        sp.end = s + size - 1;
  100a3a:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100a3f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100a43:	be 00 00 00 00       	mov    $0x0,%esi
  100a48:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100a4c:	e8 67 f8 ff ff       	callq  1002b8 <printer_vprintf>
        *sp.s = 0;
  100a51:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a55:	c6 00 00             	movb   $0x0,(%rax)
  100a58:	eb d5                	jmp    100a2f <vsnprintf+0x1d>

0000000000100a5a <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100a5a:	55                   	push   %rbp
  100a5b:	48 89 e5             	mov    %rsp,%rbp
  100a5e:	48 83 ec 50          	sub    $0x50,%rsp
  100a62:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a66:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a6a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100a6e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100a75:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100a79:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100a7d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100a81:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100a85:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100a89:	e8 84 ff ff ff       	callq  100a12 <vsnprintf>
    va_end(val);
    return n;
}
  100a8e:	c9                   	leaveq 
  100a8f:	c3                   	retq   

0000000000100a90 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a90:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100a95:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100a9a:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a9f:	48 83 c0 02          	add    $0x2,%rax
  100aa3:	48 39 d0             	cmp    %rdx,%rax
  100aa6:	75 f2                	jne    100a9a <console_clear+0xa>
    }
    cursorpos = 0;
  100aa8:	c7 05 4a 85 fb ff 00 	movl   $0x0,-0x47ab6(%rip)        # b8ffc <cursorpos>
  100aaf:	00 00 00 
}
  100ab2:	c3                   	retq   

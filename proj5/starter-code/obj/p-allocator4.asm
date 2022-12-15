
obj/p-allocator4.full:     file format elf64-x86-64


Disassembly of section .text:

00000000001c0000 <process_main>:

// These global variables go on the data page.
uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  1c0000:	55                   	push   %rbp
  1c0001:	48 89 e5             	mov    %rsp,%rbp
  1c0004:	53                   	push   %rbx
  1c0005:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  1c0009:	cd 31                	int    $0x31
  1c000b:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  1c000d:	89 c7                	mov    %eax,%edi
  1c000f:	e8 93 02 00 00       	callq  1c02a7 <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  1c0014:	b8 17 20 1c 00       	mov    $0x1c2017,%eax
  1c0019:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  1c001f:	48 89 05 e2 0f 00 00 	mov    %rax,0xfe2(%rip)        # 1c1008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  1c0026:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  1c0029:	48 83 e8 01          	sub    $0x1,%rax
  1c002d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  1c0033:	48 89 05 c6 0f 00 00 	mov    %rax,0xfc6(%rip)        # 1c1000 <stack_bottom>
  1c003a:	eb 02                	jmp    1c003e <process_main+0x3e>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  1c003c:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  1c003e:	e8 2a 02 00 00       	callq  1c026d <rand>
  1c0043:	48 63 d0             	movslq %eax,%rdx
  1c0046:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1c004d:	48 c1 fa 25          	sar    $0x25,%rdx
  1c0051:	89 c1                	mov    %eax,%ecx
  1c0053:	c1 f9 1f             	sar    $0x1f,%ecx
  1c0056:	29 ca                	sub    %ecx,%edx
  1c0058:	6b d2 64             	imul   $0x64,%edx,%edx
  1c005b:	29 d0                	sub    %edx,%eax
  1c005d:	39 d8                	cmp    %ebx,%eax
  1c005f:	7d db                	jge    1c003c <process_main+0x3c>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  1c0061:	48 8b 3d a0 0f 00 00 	mov    0xfa0(%rip),%rdi        # 1c1008 <heap_top>
  1c0068:	48 3b 3d 91 0f 00 00 	cmp    0xf91(%rip),%rdi        # 1c1000 <stack_bottom>
  1c006f:	74 2d                	je     1c009e <process_main+0x9e>
    uintptr_t ad = (uintptr_t) addr;
    if(ad % PAGESIZE != 0)
        return -1;
    
    // check that addr is within vm bounds
    if(ad >= 0x300000)
  1c0071:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
  1c0077:	75 25                	jne    1c009e <process_main+0x9e>
  1c0079:	48 81 ff ff ff 2f 00 	cmp    $0x2fffff,%rdi
  1c0080:	77 1c                	ja     1c009e <process_main+0x9e>
        return -1;

    int result;
    asm volatile ("int %1" : "=a" (result)
  1c0082:	cd 33                	int    $0x33
  1c0084:	85 c0                	test   %eax,%eax
  1c0086:	78 16                	js     1c009e <process_main+0x9e>
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
  1c0088:	48 8b 05 79 0f 00 00 	mov    0xf79(%rip),%rax        # 1c1008 <heap_top>
  1c008f:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  1c0091:	48 81 05 6c 0f 00 00 	addq   $0x1000,0xf6c(%rip)        # 1c1008 <heap_top>
  1c0098:	00 10 00 00 
  1c009c:	eb 9e                	jmp    1c003c <process_main+0x3c>
    asm volatile ("int %0" : /* no result */
  1c009e:	cd 32                	int    $0x32
  1c00a0:	eb fc                	jmp    1c009e <process_main+0x9e>

00000000001c00a2 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1c00a2:	48 89 f9             	mov    %rdi,%rcx
  1c00a5:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1c00a7:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  1c00ae:	00 
  1c00af:	72 08                	jb     1c00b9 <console_putc+0x17>
        cp->cursor = console;
  1c00b1:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  1c00b8:	00 
    }
    if (c == '\n') {
  1c00b9:	40 80 fe 0a          	cmp    $0xa,%sil
  1c00bd:	74 16                	je     1c00d5 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  1c00bf:	48 8b 41 08          	mov    0x8(%rcx),%rax
  1c00c3:	48 8d 50 02          	lea    0x2(%rax),%rdx
  1c00c7:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  1c00cb:	40 0f b6 f6          	movzbl %sil,%esi
  1c00cf:	09 fe                	or     %edi,%esi
  1c00d1:	66 89 30             	mov    %si,(%rax)
    }
}
  1c00d4:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  1c00d5:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  1c00d9:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  1c00e0:	4c 89 c6             	mov    %r8,%rsi
  1c00e3:	48 d1 fe             	sar    %rsi
  1c00e6:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1c00ed:	66 66 66 
  1c00f0:	48 89 f0             	mov    %rsi,%rax
  1c00f3:	48 f7 ea             	imul   %rdx
  1c00f6:	48 c1 fa 05          	sar    $0x5,%rdx
  1c00fa:	49 c1 f8 3f          	sar    $0x3f,%r8
  1c00fe:	4c 29 c2             	sub    %r8,%rdx
  1c0101:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  1c0105:	48 c1 e2 04          	shl    $0x4,%rdx
  1c0109:	89 f0                	mov    %esi,%eax
  1c010b:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1c010d:	83 cf 20             	or     $0x20,%edi
  1c0110:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c0114:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  1c0118:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1c011c:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  1c011f:	83 c0 01             	add    $0x1,%eax
  1c0122:	83 f8 50             	cmp    $0x50,%eax
  1c0125:	75 e9                	jne    1c0110 <console_putc+0x6e>
  1c0127:	c3                   	retq   

00000000001c0128 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1c0128:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1c012c:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1c0130:	73 0b                	jae    1c013d <string_putc+0x15>
        *sp->s++ = c;
  1c0132:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1c0136:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  1c013a:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  1c013d:	c3                   	retq   

00000000001c013e <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  1c013e:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1c0141:	48 85 d2             	test   %rdx,%rdx
  1c0144:	74 17                	je     1c015d <memcpy+0x1f>
  1c0146:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  1c014b:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  1c0150:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1c0154:	48 83 c1 01          	add    $0x1,%rcx
  1c0158:	48 39 d1             	cmp    %rdx,%rcx
  1c015b:	75 ee                	jne    1c014b <memcpy+0xd>
}
  1c015d:	c3                   	retq   

00000000001c015e <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  1c015e:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  1c0161:	48 39 fe             	cmp    %rdi,%rsi
  1c0164:	72 1d                	jb     1c0183 <memmove+0x25>
        while (n-- > 0) {
  1c0166:	b9 00 00 00 00       	mov    $0x0,%ecx
  1c016b:	48 85 d2             	test   %rdx,%rdx
  1c016e:	74 12                	je     1c0182 <memmove+0x24>
            *d++ = *s++;
  1c0170:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  1c0174:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  1c0178:	48 83 c1 01          	add    $0x1,%rcx
  1c017c:	48 39 ca             	cmp    %rcx,%rdx
  1c017f:	75 ef                	jne    1c0170 <memmove+0x12>
}
  1c0181:	c3                   	retq   
  1c0182:	c3                   	retq   
    if (s < d && s + n > d) {
  1c0183:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  1c0187:	48 39 cf             	cmp    %rcx,%rdi
  1c018a:	73 da                	jae    1c0166 <memmove+0x8>
        while (n-- > 0) {
  1c018c:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  1c0190:	48 85 d2             	test   %rdx,%rdx
  1c0193:	74 ec                	je     1c0181 <memmove+0x23>
            *--d = *--s;
  1c0195:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  1c0199:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  1c019c:	48 83 e9 01          	sub    $0x1,%rcx
  1c01a0:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  1c01a4:	75 ef                	jne    1c0195 <memmove+0x37>
  1c01a6:	c3                   	retq   

00000000001c01a7 <memset>:
void* memset(void* v, int c, size_t n) {
  1c01a7:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1c01aa:	48 85 d2             	test   %rdx,%rdx
  1c01ad:	74 12                	je     1c01c1 <memset+0x1a>
  1c01af:	48 01 fa             	add    %rdi,%rdx
  1c01b2:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  1c01b5:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1c01b8:	48 83 c1 01          	add    $0x1,%rcx
  1c01bc:	48 39 ca             	cmp    %rcx,%rdx
  1c01bf:	75 f4                	jne    1c01b5 <memset+0xe>
}
  1c01c1:	c3                   	retq   

00000000001c01c2 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  1c01c2:	80 3f 00             	cmpb   $0x0,(%rdi)
  1c01c5:	74 10                	je     1c01d7 <strlen+0x15>
  1c01c7:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  1c01cc:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  1c01d0:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1c01d4:	75 f6                	jne    1c01cc <strlen+0xa>
  1c01d6:	c3                   	retq   
  1c01d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1c01dc:	c3                   	retq   

00000000001c01dd <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  1c01dd:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1c01e0:	ba 00 00 00 00       	mov    $0x0,%edx
  1c01e5:	48 85 f6             	test   %rsi,%rsi
  1c01e8:	74 11                	je     1c01fb <strnlen+0x1e>
  1c01ea:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  1c01ee:	74 0c                	je     1c01fc <strnlen+0x1f>
        ++n;
  1c01f0:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1c01f4:	48 39 d0             	cmp    %rdx,%rax
  1c01f7:	75 f1                	jne    1c01ea <strnlen+0xd>
  1c01f9:	eb 04                	jmp    1c01ff <strnlen+0x22>
  1c01fb:	c3                   	retq   
  1c01fc:	48 89 d0             	mov    %rdx,%rax
}
  1c01ff:	c3                   	retq   

00000000001c0200 <strcpy>:
char* strcpy(char* dst, const char* src) {
  1c0200:	48 89 f8             	mov    %rdi,%rax
  1c0203:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  1c0208:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1c020c:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1c020f:	48 83 c2 01          	add    $0x1,%rdx
  1c0213:	84 c9                	test   %cl,%cl
  1c0215:	75 f1                	jne    1c0208 <strcpy+0x8>
}
  1c0217:	c3                   	retq   

00000000001c0218 <strcmp>:
    while (*a && *b && *a == *b) {
  1c0218:	0f b6 07             	movzbl (%rdi),%eax
  1c021b:	84 c0                	test   %al,%al
  1c021d:	74 1a                	je     1c0239 <strcmp+0x21>
  1c021f:	0f b6 16             	movzbl (%rsi),%edx
  1c0222:	38 c2                	cmp    %al,%dl
  1c0224:	75 13                	jne    1c0239 <strcmp+0x21>
  1c0226:	84 d2                	test   %dl,%dl
  1c0228:	74 0f                	je     1c0239 <strcmp+0x21>
        ++a, ++b;
  1c022a:	48 83 c7 01          	add    $0x1,%rdi
  1c022e:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  1c0232:	0f b6 07             	movzbl (%rdi),%eax
  1c0235:	84 c0                	test   %al,%al
  1c0237:	75 e6                	jne    1c021f <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  1c0239:	3a 06                	cmp    (%rsi),%al
  1c023b:	0f 97 c0             	seta   %al
  1c023e:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  1c0241:	83 d8 00             	sbb    $0x0,%eax
}
  1c0244:	c3                   	retq   

00000000001c0245 <strchr>:
    while (*s && *s != (char) c) {
  1c0245:	0f b6 07             	movzbl (%rdi),%eax
  1c0248:	84 c0                	test   %al,%al
  1c024a:	74 10                	je     1c025c <strchr+0x17>
  1c024c:	40 38 f0             	cmp    %sil,%al
  1c024f:	74 18                	je     1c0269 <strchr+0x24>
        ++s;
  1c0251:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  1c0255:	0f b6 07             	movzbl (%rdi),%eax
  1c0258:	84 c0                	test   %al,%al
  1c025a:	75 f0                	jne    1c024c <strchr+0x7>
        return NULL;
  1c025c:	40 84 f6             	test   %sil,%sil
  1c025f:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0264:	48 0f 44 c7          	cmove  %rdi,%rax
}
  1c0268:	c3                   	retq   
  1c0269:	48 89 f8             	mov    %rdi,%rax
  1c026c:	c3                   	retq   

00000000001c026d <rand>:
    if (!rand_seed_set) {
  1c026d:	83 3d a0 0d 00 00 00 	cmpl   $0x0,0xda0(%rip)        # 1c1014 <rand_seed_set>
  1c0274:	74 1b                	je     1c0291 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1c0276:	69 05 90 0d 00 00 0d 	imul   $0x19660d,0xd90(%rip),%eax        # 1c1010 <rand_seed>
  1c027d:	66 19 00 
  1c0280:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1c0285:	89 05 85 0d 00 00    	mov    %eax,0xd85(%rip)        # 1c1010 <rand_seed>
    return rand_seed & RAND_MAX;
  1c028b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1c0290:	c3                   	retq   
    rand_seed = seed;
  1c0291:	c7 05 75 0d 00 00 9e 	movl   $0x30d4879e,0xd75(%rip)        # 1c1010 <rand_seed>
  1c0298:	87 d4 30 
    rand_seed_set = 1;
  1c029b:	c7 05 6f 0d 00 00 01 	movl   $0x1,0xd6f(%rip)        # 1c1014 <rand_seed_set>
  1c02a2:	00 00 00 
}
  1c02a5:	eb cf                	jmp    1c0276 <rand+0x9>

00000000001c02a7 <srand>:
    rand_seed = seed;
  1c02a7:	89 3d 63 0d 00 00    	mov    %edi,0xd63(%rip)        # 1c1010 <rand_seed>
    rand_seed_set = 1;
  1c02ad:	c7 05 5d 0d 00 00 01 	movl   $0x1,0xd5d(%rip)        # 1c1014 <rand_seed_set>
  1c02b4:	00 00 00 
}
  1c02b7:	c3                   	retq   

00000000001c02b8 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1c02b8:	55                   	push   %rbp
  1c02b9:	48 89 e5             	mov    %rsp,%rbp
  1c02bc:	41 57                	push   %r15
  1c02be:	41 56                	push   %r14
  1c02c0:	41 55                	push   %r13
  1c02c2:	41 54                	push   %r12
  1c02c4:	53                   	push   %rbx
  1c02c5:	48 83 ec 58          	sub    $0x58,%rsp
  1c02c9:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  1c02cd:	0f b6 02             	movzbl (%rdx),%eax
  1c02d0:	84 c0                	test   %al,%al
  1c02d2:	0f 84 b0 06 00 00    	je     1c0988 <printer_vprintf+0x6d0>
  1c02d8:	49 89 fe             	mov    %rdi,%r14
  1c02db:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  1c02de:	41 89 f7             	mov    %esi,%r15d
  1c02e1:	e9 a4 04 00 00       	jmpq   1c078a <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  1c02e6:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  1c02eb:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1c02f1:	45 84 e4             	test   %r12b,%r12b
  1c02f4:	0f 84 82 06 00 00    	je     1c097c <printer_vprintf+0x6c4>
        int flags = 0;
  1c02fa:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  1c0300:	41 0f be f4          	movsbl %r12b,%esi
  1c0304:	bf c1 0c 1c 00       	mov    $0x1c0cc1,%edi
  1c0309:	e8 37 ff ff ff       	callq  1c0245 <strchr>
  1c030e:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1c0311:	48 85 c0             	test   %rax,%rax
  1c0314:	74 55                	je     1c036b <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  1c0316:	48 81 e9 c1 0c 1c 00 	sub    $0x1c0cc1,%rcx
  1c031d:	b8 01 00 00 00       	mov    $0x1,%eax
  1c0322:	d3 e0                	shl    %cl,%eax
  1c0324:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1c0327:	48 83 c3 01          	add    $0x1,%rbx
  1c032b:	44 0f b6 23          	movzbl (%rbx),%r12d
  1c032f:	45 84 e4             	test   %r12b,%r12b
  1c0332:	75 cc                	jne    1c0300 <printer_vprintf+0x48>
  1c0334:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  1c0338:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  1c033e:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  1c0345:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  1c0348:	0f 84 a9 00 00 00    	je     1c03f7 <printer_vprintf+0x13f>
        int length = 0;
  1c034e:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  1c0353:	0f b6 13             	movzbl (%rbx),%edx
  1c0356:	8d 42 bd             	lea    -0x43(%rdx),%eax
  1c0359:	3c 37                	cmp    $0x37,%al
  1c035b:	0f 87 c4 04 00 00    	ja     1c0825 <printer_vprintf+0x56d>
  1c0361:	0f b6 c0             	movzbl %al,%eax
  1c0364:	ff 24 c5 d0 0a 1c 00 	jmpq   *0x1c0ad0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  1c036b:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  1c036f:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  1c0374:	3c 08                	cmp    $0x8,%al
  1c0376:	77 2f                	ja     1c03a7 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1c0378:	0f b6 03             	movzbl (%rbx),%eax
  1c037b:	8d 50 d0             	lea    -0x30(%rax),%edx
  1c037e:	80 fa 09             	cmp    $0x9,%dl
  1c0381:	77 5e                	ja     1c03e1 <printer_vprintf+0x129>
  1c0383:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  1c0389:	48 83 c3 01          	add    $0x1,%rbx
  1c038d:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  1c0392:	0f be c0             	movsbl %al,%eax
  1c0395:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1c039a:	0f b6 03             	movzbl (%rbx),%eax
  1c039d:	8d 50 d0             	lea    -0x30(%rax),%edx
  1c03a0:	80 fa 09             	cmp    $0x9,%dl
  1c03a3:	76 e4                	jbe    1c0389 <printer_vprintf+0xd1>
  1c03a5:	eb 97                	jmp    1c033e <printer_vprintf+0x86>
        } else if (*format == '*') {
  1c03a7:	41 80 fc 2a          	cmp    $0x2a,%r12b
  1c03ab:	75 3f                	jne    1c03ec <printer_vprintf+0x134>
            width = va_arg(val, int);
  1c03ad:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c03b1:	8b 07                	mov    (%rdi),%eax
  1c03b3:	83 f8 2f             	cmp    $0x2f,%eax
  1c03b6:	77 17                	ja     1c03cf <printer_vprintf+0x117>
  1c03b8:	89 c2                	mov    %eax,%edx
  1c03ba:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c03be:	83 c0 08             	add    $0x8,%eax
  1c03c1:	89 07                	mov    %eax,(%rdi)
  1c03c3:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  1c03c6:	48 83 c3 01          	add    $0x1,%rbx
  1c03ca:	e9 6f ff ff ff       	jmpq   1c033e <printer_vprintf+0x86>
            width = va_arg(val, int);
  1c03cf:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c03d3:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c03d7:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c03db:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c03df:	eb e2                	jmp    1c03c3 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1c03e1:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1c03e7:	e9 52 ff ff ff       	jmpq   1c033e <printer_vprintf+0x86>
        int width = -1;
  1c03ec:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1c03f2:	e9 47 ff ff ff       	jmpq   1c033e <printer_vprintf+0x86>
            ++format;
  1c03f7:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1c03fb:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1c03ff:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1c0402:	80 f9 09             	cmp    $0x9,%cl
  1c0405:	76 13                	jbe    1c041a <printer_vprintf+0x162>
            } else if (*format == '*') {
  1c0407:	3c 2a                	cmp    $0x2a,%al
  1c0409:	74 33                	je     1c043e <printer_vprintf+0x186>
            ++format;
  1c040b:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1c040e:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1c0415:	e9 34 ff ff ff       	jmpq   1c034e <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1c041a:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  1c041f:	48 83 c2 01          	add    $0x1,%rdx
  1c0423:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  1c0426:	0f be c0             	movsbl %al,%eax
  1c0429:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1c042d:	0f b6 02             	movzbl (%rdx),%eax
  1c0430:	8d 70 d0             	lea    -0x30(%rax),%esi
  1c0433:	40 80 fe 09          	cmp    $0x9,%sil
  1c0437:	76 e6                	jbe    1c041f <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  1c0439:	48 89 d3             	mov    %rdx,%rbx
  1c043c:	eb 1c                	jmp    1c045a <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  1c043e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c0442:	8b 07                	mov    (%rdi),%eax
  1c0444:	83 f8 2f             	cmp    $0x2f,%eax
  1c0447:	77 23                	ja     1c046c <printer_vprintf+0x1b4>
  1c0449:	89 c2                	mov    %eax,%edx
  1c044b:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c044f:	83 c0 08             	add    $0x8,%eax
  1c0452:	89 07                	mov    %eax,(%rdi)
  1c0454:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  1c0456:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  1c045a:	85 c9                	test   %ecx,%ecx
  1c045c:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0461:	0f 49 c1             	cmovns %ecx,%eax
  1c0464:	89 45 9c             	mov    %eax,-0x64(%rbp)
  1c0467:	e9 e2 fe ff ff       	jmpq   1c034e <printer_vprintf+0x96>
                precision = va_arg(val, int);
  1c046c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c0470:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c0474:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c0478:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c047c:	eb d6                	jmp    1c0454 <printer_vprintf+0x19c>
        switch (*format) {
  1c047e:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1c0483:	e9 f3 00 00 00       	jmpq   1c057b <printer_vprintf+0x2c3>
            ++format;
  1c0488:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  1c048c:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  1c0491:	e9 bd fe ff ff       	jmpq   1c0353 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1c0496:	85 c9                	test   %ecx,%ecx
  1c0498:	74 55                	je     1c04ef <printer_vprintf+0x237>
  1c049a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c049e:	8b 07                	mov    (%rdi),%eax
  1c04a0:	83 f8 2f             	cmp    $0x2f,%eax
  1c04a3:	77 38                	ja     1c04dd <printer_vprintf+0x225>
  1c04a5:	89 c2                	mov    %eax,%edx
  1c04a7:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c04ab:	83 c0 08             	add    $0x8,%eax
  1c04ae:	89 07                	mov    %eax,(%rdi)
  1c04b0:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1c04b3:	48 89 d0             	mov    %rdx,%rax
  1c04b6:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  1c04ba:	49 89 d0             	mov    %rdx,%r8
  1c04bd:	49 f7 d8             	neg    %r8
  1c04c0:	25 80 00 00 00       	and    $0x80,%eax
  1c04c5:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1c04c9:	0b 45 a8             	or     -0x58(%rbp),%eax
  1c04cc:	83 c8 60             	or     $0x60,%eax
  1c04cf:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  1c04d2:	41 bc c8 0a 1c 00    	mov    $0x1c0ac8,%r12d
            break;
  1c04d8:	e9 35 01 00 00       	jmpq   1c0612 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1c04dd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c04e1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c04e5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c04e9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c04ed:	eb c1                	jmp    1c04b0 <printer_vprintf+0x1f8>
  1c04ef:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c04f3:	8b 07                	mov    (%rdi),%eax
  1c04f5:	83 f8 2f             	cmp    $0x2f,%eax
  1c04f8:	77 10                	ja     1c050a <printer_vprintf+0x252>
  1c04fa:	89 c2                	mov    %eax,%edx
  1c04fc:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c0500:	83 c0 08             	add    $0x8,%eax
  1c0503:	89 07                	mov    %eax,(%rdi)
  1c0505:	48 63 12             	movslq (%rdx),%rdx
  1c0508:	eb a9                	jmp    1c04b3 <printer_vprintf+0x1fb>
  1c050a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c050e:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1c0512:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c0516:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1c051a:	eb e9                	jmp    1c0505 <printer_vprintf+0x24d>
        int base = 10;
  1c051c:	be 0a 00 00 00       	mov    $0xa,%esi
  1c0521:	eb 58                	jmp    1c057b <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1c0523:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c0527:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c052b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c052f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c0533:	eb 60                	jmp    1c0595 <printer_vprintf+0x2dd>
  1c0535:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c0539:	8b 07                	mov    (%rdi),%eax
  1c053b:	83 f8 2f             	cmp    $0x2f,%eax
  1c053e:	77 10                	ja     1c0550 <printer_vprintf+0x298>
  1c0540:	89 c2                	mov    %eax,%edx
  1c0542:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c0546:	83 c0 08             	add    $0x8,%eax
  1c0549:	89 07                	mov    %eax,(%rdi)
  1c054b:	44 8b 02             	mov    (%rdx),%r8d
  1c054e:	eb 48                	jmp    1c0598 <printer_vprintf+0x2e0>
  1c0550:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c0554:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c0558:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c055c:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c0560:	eb e9                	jmp    1c054b <printer_vprintf+0x293>
  1c0562:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  1c0565:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  1c056c:	bf b0 0c 1c 00       	mov    $0x1c0cb0,%edi
  1c0571:	e9 e2 02 00 00       	jmpq   1c0858 <printer_vprintf+0x5a0>
            base = 16;
  1c0576:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1c057b:	85 c9                	test   %ecx,%ecx
  1c057d:	74 b6                	je     1c0535 <printer_vprintf+0x27d>
  1c057f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c0583:	8b 01                	mov    (%rcx),%eax
  1c0585:	83 f8 2f             	cmp    $0x2f,%eax
  1c0588:	77 99                	ja     1c0523 <printer_vprintf+0x26b>
  1c058a:	89 c2                	mov    %eax,%edx
  1c058c:	48 03 51 10          	add    0x10(%rcx),%rdx
  1c0590:	83 c0 08             	add    $0x8,%eax
  1c0593:	89 01                	mov    %eax,(%rcx)
  1c0595:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  1c0598:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  1c059c:	85 f6                	test   %esi,%esi
  1c059e:	79 c2                	jns    1c0562 <printer_vprintf+0x2aa>
        base = -base;
  1c05a0:	41 89 f1             	mov    %esi,%r9d
  1c05a3:	f7 de                	neg    %esi
  1c05a5:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  1c05ac:	bf 90 0c 1c 00       	mov    $0x1c0c90,%edi
  1c05b1:	e9 a2 02 00 00       	jmpq   1c0858 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  1c05b6:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c05ba:	8b 07                	mov    (%rdi),%eax
  1c05bc:	83 f8 2f             	cmp    $0x2f,%eax
  1c05bf:	77 1c                	ja     1c05dd <printer_vprintf+0x325>
  1c05c1:	89 c2                	mov    %eax,%edx
  1c05c3:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c05c7:	83 c0 08             	add    $0x8,%eax
  1c05ca:	89 07                	mov    %eax,(%rdi)
  1c05cc:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1c05cf:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  1c05d6:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1c05db:	eb c3                	jmp    1c05a0 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  1c05dd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c05e1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c05e5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c05e9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c05ed:	eb dd                	jmp    1c05cc <printer_vprintf+0x314>
            data = va_arg(val, char*);
  1c05ef:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c05f3:	8b 01                	mov    (%rcx),%eax
  1c05f5:	83 f8 2f             	cmp    $0x2f,%eax
  1c05f8:	0f 87 a5 01 00 00    	ja     1c07a3 <printer_vprintf+0x4eb>
  1c05fe:	89 c2                	mov    %eax,%edx
  1c0600:	48 03 51 10          	add    0x10(%rcx),%rdx
  1c0604:	83 c0 08             	add    $0x8,%eax
  1c0607:	89 01                	mov    %eax,(%rcx)
  1c0609:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1c060c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1c0612:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1c0615:	83 e0 20             	and    $0x20,%eax
  1c0618:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1c061b:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1c0621:	0f 85 21 02 00 00    	jne    1c0848 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1c0627:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1c062a:	89 45 88             	mov    %eax,-0x78(%rbp)
  1c062d:	83 e0 60             	and    $0x60,%eax
  1c0630:	83 f8 60             	cmp    $0x60,%eax
  1c0633:	0f 84 54 02 00 00    	je     1c088d <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1c0639:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1c063c:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  1c063f:	48 c7 45 a0 c8 0a 1c 	movq   $0x1c0ac8,-0x60(%rbp)
  1c0646:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1c0647:	83 f8 21             	cmp    $0x21,%eax
  1c064a:	0f 84 79 02 00 00    	je     1c08c9 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1c0650:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  1c0653:	89 f8                	mov    %edi,%eax
  1c0655:	f7 d0                	not    %eax
  1c0657:	c1 e8 1f             	shr    $0x1f,%eax
  1c065a:	89 45 84             	mov    %eax,-0x7c(%rbp)
  1c065d:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1c0661:	0f 85 9e 02 00 00    	jne    1c0905 <printer_vprintf+0x64d>
  1c0667:	84 c0                	test   %al,%al
  1c0669:	0f 84 96 02 00 00    	je     1c0905 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  1c066f:	48 63 f7             	movslq %edi,%rsi
  1c0672:	4c 89 e7             	mov    %r12,%rdi
  1c0675:	e8 63 fb ff ff       	callq  1c01dd <strnlen>
  1c067a:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  1c067d:	8b 45 88             	mov    -0x78(%rbp),%eax
  1c0680:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  1c0683:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1c068a:	83 f8 22             	cmp    $0x22,%eax
  1c068d:	0f 84 aa 02 00 00    	je     1c093d <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  1c0693:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1c0697:	e8 26 fb ff ff       	callq  1c01c2 <strlen>
  1c069c:	8b 55 9c             	mov    -0x64(%rbp),%edx
  1c069f:	03 55 98             	add    -0x68(%rbp),%edx
  1c06a2:	44 89 e9             	mov    %r13d,%ecx
  1c06a5:	29 d1                	sub    %edx,%ecx
  1c06a7:	29 c1                	sub    %eax,%ecx
  1c06a9:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  1c06ac:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1c06af:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  1c06b3:	75 2d                	jne    1c06e2 <printer_vprintf+0x42a>
  1c06b5:	85 c9                	test   %ecx,%ecx
  1c06b7:	7e 29                	jle    1c06e2 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  1c06b9:	44 89 fa             	mov    %r15d,%edx
  1c06bc:	be 20 00 00 00       	mov    $0x20,%esi
  1c06c1:	4c 89 f7             	mov    %r14,%rdi
  1c06c4:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1c06c7:	41 83 ed 01          	sub    $0x1,%r13d
  1c06cb:	45 85 ed             	test   %r13d,%r13d
  1c06ce:	7f e9                	jg     1c06b9 <printer_vprintf+0x401>
  1c06d0:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  1c06d3:	85 ff                	test   %edi,%edi
  1c06d5:	b8 01 00 00 00       	mov    $0x1,%eax
  1c06da:	0f 4f c7             	cmovg  %edi,%eax
  1c06dd:	29 c7                	sub    %eax,%edi
  1c06df:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  1c06e2:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1c06e6:	0f b6 07             	movzbl (%rdi),%eax
  1c06e9:	84 c0                	test   %al,%al
  1c06eb:	74 22                	je     1c070f <printer_vprintf+0x457>
  1c06ed:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1c06f1:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  1c06f4:	0f b6 f0             	movzbl %al,%esi
  1c06f7:	44 89 fa             	mov    %r15d,%edx
  1c06fa:	4c 89 f7             	mov    %r14,%rdi
  1c06fd:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  1c0700:	48 83 c3 01          	add    $0x1,%rbx
  1c0704:	0f b6 03             	movzbl (%rbx),%eax
  1c0707:	84 c0                	test   %al,%al
  1c0709:	75 e9                	jne    1c06f4 <printer_vprintf+0x43c>
  1c070b:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1c070f:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1c0712:	85 c0                	test   %eax,%eax
  1c0714:	7e 1d                	jle    1c0733 <printer_vprintf+0x47b>
  1c0716:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1c071a:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1c071c:	44 89 fa             	mov    %r15d,%edx
  1c071f:	be 30 00 00 00       	mov    $0x30,%esi
  1c0724:	4c 89 f7             	mov    %r14,%rdi
  1c0727:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  1c072a:	83 eb 01             	sub    $0x1,%ebx
  1c072d:	75 ed                	jne    1c071c <printer_vprintf+0x464>
  1c072f:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  1c0733:	8b 45 98             	mov    -0x68(%rbp),%eax
  1c0736:	85 c0                	test   %eax,%eax
  1c0738:	7e 27                	jle    1c0761 <printer_vprintf+0x4a9>
  1c073a:	89 c0                	mov    %eax,%eax
  1c073c:	4c 01 e0             	add    %r12,%rax
  1c073f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1c0743:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  1c0746:	41 0f b6 34 24       	movzbl (%r12),%esi
  1c074b:	44 89 fa             	mov    %r15d,%edx
  1c074e:	4c 89 f7             	mov    %r14,%rdi
  1c0751:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  1c0754:	49 83 c4 01          	add    $0x1,%r12
  1c0758:	49 39 dc             	cmp    %rbx,%r12
  1c075b:	75 e9                	jne    1c0746 <printer_vprintf+0x48e>
  1c075d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  1c0761:	45 85 ed             	test   %r13d,%r13d
  1c0764:	7e 14                	jle    1c077a <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  1c0766:	44 89 fa             	mov    %r15d,%edx
  1c0769:	be 20 00 00 00       	mov    $0x20,%esi
  1c076e:	4c 89 f7             	mov    %r14,%rdi
  1c0771:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  1c0774:	41 83 ed 01          	sub    $0x1,%r13d
  1c0778:	75 ec                	jne    1c0766 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  1c077a:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  1c077e:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1c0782:	84 c0                	test   %al,%al
  1c0784:	0f 84 fe 01 00 00    	je     1c0988 <printer_vprintf+0x6d0>
        if (*format != '%') {
  1c078a:	3c 25                	cmp    $0x25,%al
  1c078c:	0f 84 54 fb ff ff    	je     1c02e6 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  1c0792:	0f b6 f0             	movzbl %al,%esi
  1c0795:	44 89 fa             	mov    %r15d,%edx
  1c0798:	4c 89 f7             	mov    %r14,%rdi
  1c079b:	41 ff 16             	callq  *(%r14)
            continue;
  1c079e:	4c 89 e3             	mov    %r12,%rbx
  1c07a1:	eb d7                	jmp    1c077a <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  1c07a3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c07a7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1c07ab:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c07af:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1c07b3:	e9 51 fe ff ff       	jmpq   1c0609 <printer_vprintf+0x351>
            color = va_arg(val, int);
  1c07b8:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c07bc:	8b 07                	mov    (%rdi),%eax
  1c07be:	83 f8 2f             	cmp    $0x2f,%eax
  1c07c1:	77 10                	ja     1c07d3 <printer_vprintf+0x51b>
  1c07c3:	89 c2                	mov    %eax,%edx
  1c07c5:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c07c9:	83 c0 08             	add    $0x8,%eax
  1c07cc:	89 07                	mov    %eax,(%rdi)
  1c07ce:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  1c07d1:	eb a7                	jmp    1c077a <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  1c07d3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c07d7:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c07db:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c07df:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c07e3:	eb e9                	jmp    1c07ce <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  1c07e5:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c07e9:	8b 01                	mov    (%rcx),%eax
  1c07eb:	83 f8 2f             	cmp    $0x2f,%eax
  1c07ee:	77 23                	ja     1c0813 <printer_vprintf+0x55b>
  1c07f0:	89 c2                	mov    %eax,%edx
  1c07f2:	48 03 51 10          	add    0x10(%rcx),%rdx
  1c07f6:	83 c0 08             	add    $0x8,%eax
  1c07f9:	89 01                	mov    %eax,(%rcx)
  1c07fb:	8b 02                	mov    (%rdx),%eax
  1c07fd:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  1c0800:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1c0804:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1c0808:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1c080e:	e9 ff fd ff ff       	jmpq   1c0612 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  1c0813:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c0817:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1c081b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c081f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1c0823:	eb d6                	jmp    1c07fb <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  1c0825:	84 d2                	test   %dl,%dl
  1c0827:	0f 85 39 01 00 00    	jne    1c0966 <printer_vprintf+0x6ae>
  1c082d:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  1c0831:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  1c0835:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  1c0839:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1c083d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1c0843:	e9 ca fd ff ff       	jmpq   1c0612 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  1c0848:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  1c084e:	bf b0 0c 1c 00       	mov    $0x1c0cb0,%edi
        if (flags & FLAG_NUMERIC) {
  1c0853:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  1c0858:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  1c085c:	4c 89 c1             	mov    %r8,%rcx
  1c085f:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  1c0863:	48 63 f6             	movslq %esi,%rsi
  1c0866:	49 83 ec 01          	sub    $0x1,%r12
  1c086a:	48 89 c8             	mov    %rcx,%rax
  1c086d:	ba 00 00 00 00       	mov    $0x0,%edx
  1c0872:	48 f7 f6             	div    %rsi
  1c0875:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  1c0879:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  1c087d:	48 89 ca             	mov    %rcx,%rdx
  1c0880:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  1c0883:	48 39 d6             	cmp    %rdx,%rsi
  1c0886:	76 de                	jbe    1c0866 <printer_vprintf+0x5ae>
  1c0888:	e9 9a fd ff ff       	jmpq   1c0627 <printer_vprintf+0x36f>
                prefix = "-";
  1c088d:	48 c7 45 a0 c5 0a 1c 	movq   $0x1c0ac5,-0x60(%rbp)
  1c0894:	00 
            if (flags & FLAG_NEGATIVE) {
  1c0895:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1c0898:	a8 80                	test   $0x80,%al
  1c089a:	0f 85 b0 fd ff ff    	jne    1c0650 <printer_vprintf+0x398>
                prefix = "+";
  1c08a0:	48 c7 45 a0 c0 0a 1c 	movq   $0x1c0ac0,-0x60(%rbp)
  1c08a7:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1c08a8:	a8 10                	test   $0x10,%al
  1c08aa:	0f 85 a0 fd ff ff    	jne    1c0650 <printer_vprintf+0x398>
                prefix = " ";
  1c08b0:	a8 08                	test   $0x8,%al
  1c08b2:	ba c8 0a 1c 00       	mov    $0x1c0ac8,%edx
  1c08b7:	b8 c7 0a 1c 00       	mov    $0x1c0ac7,%eax
  1c08bc:	48 0f 44 c2          	cmove  %rdx,%rax
  1c08c0:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1c08c4:	e9 87 fd ff ff       	jmpq   1c0650 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  1c08c9:	41 8d 41 10          	lea    0x10(%r9),%eax
  1c08cd:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  1c08d2:	0f 85 78 fd ff ff    	jne    1c0650 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  1c08d8:	4d 85 c0             	test   %r8,%r8
  1c08db:	75 0d                	jne    1c08ea <printer_vprintf+0x632>
  1c08dd:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  1c08e4:	0f 84 66 fd ff ff    	je     1c0650 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  1c08ea:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1c08ee:	ba c9 0a 1c 00       	mov    $0x1c0ac9,%edx
  1c08f3:	b8 c2 0a 1c 00       	mov    $0x1c0ac2,%eax
  1c08f8:	48 0f 44 c2          	cmove  %rdx,%rax
  1c08fc:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1c0900:	e9 4b fd ff ff       	jmpq   1c0650 <printer_vprintf+0x398>
            len = strlen(data);
  1c0905:	4c 89 e7             	mov    %r12,%rdi
  1c0908:	e8 b5 f8 ff ff       	callq  1c01c2 <strlen>
  1c090d:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1c0910:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1c0914:	0f 84 63 fd ff ff    	je     1c067d <printer_vprintf+0x3c5>
  1c091a:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1c091e:	0f 84 59 fd ff ff    	je     1c067d <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  1c0924:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  1c0927:	89 ca                	mov    %ecx,%edx
  1c0929:	29 c2                	sub    %eax,%edx
  1c092b:	39 c1                	cmp    %eax,%ecx
  1c092d:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0932:	0f 4e d0             	cmovle %eax,%edx
  1c0935:	89 55 9c             	mov    %edx,-0x64(%rbp)
  1c0938:	e9 56 fd ff ff       	jmpq   1c0693 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  1c093d:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1c0941:	e8 7c f8 ff ff       	callq  1c01c2 <strlen>
  1c0946:	8b 7d 98             	mov    -0x68(%rbp),%edi
  1c0949:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  1c094c:	44 89 e9             	mov    %r13d,%ecx
  1c094f:	29 f9                	sub    %edi,%ecx
  1c0951:	29 c1                	sub    %eax,%ecx
  1c0953:	44 39 ea             	cmp    %r13d,%edx
  1c0956:	b8 00 00 00 00       	mov    $0x0,%eax
  1c095b:	0f 4d c8             	cmovge %eax,%ecx
  1c095e:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  1c0961:	e9 2d fd ff ff       	jmpq   1c0693 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  1c0966:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  1c0969:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1c096d:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1c0971:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1c0977:	e9 96 fc ff ff       	jmpq   1c0612 <printer_vprintf+0x35a>
        int flags = 0;
  1c097c:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  1c0983:	e9 b0 f9 ff ff       	jmpq   1c0338 <printer_vprintf+0x80>
}
  1c0988:	48 83 c4 58          	add    $0x58,%rsp
  1c098c:	5b                   	pop    %rbx
  1c098d:	41 5c                	pop    %r12
  1c098f:	41 5d                	pop    %r13
  1c0991:	41 5e                	pop    %r14
  1c0993:	41 5f                	pop    %r15
  1c0995:	5d                   	pop    %rbp
  1c0996:	c3                   	retq   

00000000001c0997 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1c0997:	55                   	push   %rbp
  1c0998:	48 89 e5             	mov    %rsp,%rbp
  1c099b:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  1c099f:	48 c7 45 f0 a2 00 1c 	movq   $0x1c00a2,-0x10(%rbp)
  1c09a6:	00 
        cpos = 0;
  1c09a7:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  1c09ad:	b8 00 00 00 00       	mov    $0x0,%eax
  1c09b2:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  1c09b5:	48 63 ff             	movslq %edi,%rdi
  1c09b8:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  1c09bf:	00 
  1c09c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1c09c4:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  1c09c8:	e8 eb f8 ff ff       	callq  1c02b8 <printer_vprintf>
    return cp.cursor - console;
  1c09cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c09d1:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1c09d7:	48 d1 f8             	sar    %rax
}
  1c09da:	c9                   	leaveq 
  1c09db:	c3                   	retq   

00000000001c09dc <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  1c09dc:	55                   	push   %rbp
  1c09dd:	48 89 e5             	mov    %rsp,%rbp
  1c09e0:	48 83 ec 50          	sub    $0x50,%rsp
  1c09e4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1c09e8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1c09ec:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  1c09f0:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1c09f7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1c09fb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1c09ff:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1c0a03:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1c0a07:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1c0a0b:	e8 87 ff ff ff       	callq  1c0997 <console_vprintf>
}
  1c0a10:	c9                   	leaveq 
  1c0a11:	c3                   	retq   

00000000001c0a12 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1c0a12:	55                   	push   %rbp
  1c0a13:	48 89 e5             	mov    %rsp,%rbp
  1c0a16:	53                   	push   %rbx
  1c0a17:	48 83 ec 28          	sub    $0x28,%rsp
  1c0a1b:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  1c0a1e:	48 c7 45 d8 28 01 1c 	movq   $0x1c0128,-0x28(%rbp)
  1c0a25:	00 
    sp.s = s;
  1c0a26:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  1c0a2a:	48 85 f6             	test   %rsi,%rsi
  1c0a2d:	75 0b                	jne    1c0a3a <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  1c0a2f:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1c0a32:	29 d8                	sub    %ebx,%eax
}
  1c0a34:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1c0a38:	c9                   	leaveq 
  1c0a39:	c3                   	retq   
        sp.end = s + size - 1;
  1c0a3a:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  1c0a3f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1c0a43:	be 00 00 00 00       	mov    $0x0,%esi
  1c0a48:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  1c0a4c:	e8 67 f8 ff ff       	callq  1c02b8 <printer_vprintf>
        *sp.s = 0;
  1c0a51:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1c0a55:	c6 00 00             	movb   $0x0,(%rax)
  1c0a58:	eb d5                	jmp    1c0a2f <vsnprintf+0x1d>

00000000001c0a5a <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1c0a5a:	55                   	push   %rbp
  1c0a5b:	48 89 e5             	mov    %rsp,%rbp
  1c0a5e:	48 83 ec 50          	sub    $0x50,%rsp
  1c0a62:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1c0a66:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1c0a6a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1c0a6e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1c0a75:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1c0a79:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1c0a7d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1c0a81:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  1c0a85:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1c0a89:	e8 84 ff ff ff       	callq  1c0a12 <vsnprintf>
    va_end(val);
    return n;
}
  1c0a8e:	c9                   	leaveq 
  1c0a8f:	c3                   	retq   

00000000001c0a90 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1c0a90:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  1c0a95:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  1c0a9a:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1c0a9f:	48 83 c0 02          	add    $0x2,%rax
  1c0aa3:	48 39 d0             	cmp    %rdx,%rax
  1c0aa6:	75 f2                	jne    1c0a9a <console_clear+0xa>
    }
    cursorpos = 0;
  1c0aa8:	c7 05 4a 85 ef ff 00 	movl   $0x0,-0x107ab6(%rip)        # b8ffc <cursorpos>
  1c0aaf:	00 00 00 
}
  1c0ab2:	c3                   	retq   

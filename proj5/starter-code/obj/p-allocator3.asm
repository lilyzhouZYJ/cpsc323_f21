
obj/p-allocator3.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000180000 <process_main>:

// These global variables go on the data page.
uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  180000:	55                   	push   %rbp
  180001:	48 89 e5             	mov    %rsp,%rbp
  180004:	53                   	push   %rbx
  180005:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  180009:	cd 31                	int    $0x31
  18000b:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  18000d:	89 c7                	mov    %eax,%edi
  18000f:	e8 93 02 00 00       	callq  1802a7 <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  180014:	b8 17 20 18 00       	mov    $0x182017,%eax
  180019:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  18001f:	48 89 05 e2 0f 00 00 	mov    %rax,0xfe2(%rip)        # 181008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  180026:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  180029:	48 83 e8 01          	sub    $0x1,%rax
  18002d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  180033:	48 89 05 c6 0f 00 00 	mov    %rax,0xfc6(%rip)        # 181000 <stack_bottom>
  18003a:	eb 02                	jmp    18003e <process_main+0x3e>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  18003c:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  18003e:	e8 2a 02 00 00       	callq  18026d <rand>
  180043:	48 63 d0             	movslq %eax,%rdx
  180046:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  18004d:	48 c1 fa 25          	sar    $0x25,%rdx
  180051:	89 c1                	mov    %eax,%ecx
  180053:	c1 f9 1f             	sar    $0x1f,%ecx
  180056:	29 ca                	sub    %ecx,%edx
  180058:	6b d2 64             	imul   $0x64,%edx,%edx
  18005b:	29 d0                	sub    %edx,%eax
  18005d:	39 d8                	cmp    %ebx,%eax
  18005f:	7d db                	jge    18003c <process_main+0x3c>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  180061:	48 8b 3d a0 0f 00 00 	mov    0xfa0(%rip),%rdi        # 181008 <heap_top>
  180068:	48 3b 3d 91 0f 00 00 	cmp    0xf91(%rip),%rdi        # 181000 <stack_bottom>
  18006f:	74 2d                	je     18009e <process_main+0x9e>
    uintptr_t ad = (uintptr_t) addr;
    if(ad % PAGESIZE != 0)
        return -1;
    
    // check that addr is within vm bounds
    if(ad >= 0x300000)
  180071:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
  180077:	75 25                	jne    18009e <process_main+0x9e>
  180079:	48 81 ff ff ff 2f 00 	cmp    $0x2fffff,%rdi
  180080:	77 1c                	ja     18009e <process_main+0x9e>
        return -1;

    int result;
    asm volatile ("int %1" : "=a" (result)
  180082:	cd 33                	int    $0x33
  180084:	85 c0                	test   %eax,%eax
  180086:	78 16                	js     18009e <process_main+0x9e>
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
  180088:	48 8b 05 79 0f 00 00 	mov    0xf79(%rip),%rax        # 181008 <heap_top>
  18008f:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  180091:	48 81 05 6c 0f 00 00 	addq   $0x1000,0xf6c(%rip)        # 181008 <heap_top>
  180098:	00 10 00 00 
  18009c:	eb 9e                	jmp    18003c <process_main+0x3c>
    asm volatile ("int %0" : /* no result */
  18009e:	cd 32                	int    $0x32
  1800a0:	eb fc                	jmp    18009e <process_main+0x9e>

00000000001800a2 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1800a2:	48 89 f9             	mov    %rdi,%rcx
  1800a5:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1800a7:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  1800ae:	00 
  1800af:	72 08                	jb     1800b9 <console_putc+0x17>
        cp->cursor = console;
  1800b1:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  1800b8:	00 
    }
    if (c == '\n') {
  1800b9:	40 80 fe 0a          	cmp    $0xa,%sil
  1800bd:	74 16                	je     1800d5 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  1800bf:	48 8b 41 08          	mov    0x8(%rcx),%rax
  1800c3:	48 8d 50 02          	lea    0x2(%rax),%rdx
  1800c7:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  1800cb:	40 0f b6 f6          	movzbl %sil,%esi
  1800cf:	09 fe                	or     %edi,%esi
  1800d1:	66 89 30             	mov    %si,(%rax)
    }
}
  1800d4:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  1800d5:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  1800d9:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  1800e0:	4c 89 c6             	mov    %r8,%rsi
  1800e3:	48 d1 fe             	sar    %rsi
  1800e6:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1800ed:	66 66 66 
  1800f0:	48 89 f0             	mov    %rsi,%rax
  1800f3:	48 f7 ea             	imul   %rdx
  1800f6:	48 c1 fa 05          	sar    $0x5,%rdx
  1800fa:	49 c1 f8 3f          	sar    $0x3f,%r8
  1800fe:	4c 29 c2             	sub    %r8,%rdx
  180101:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  180105:	48 c1 e2 04          	shl    $0x4,%rdx
  180109:	89 f0                	mov    %esi,%eax
  18010b:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  18010d:	83 cf 20             	or     $0x20,%edi
  180110:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  180114:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  180118:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  18011c:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  18011f:	83 c0 01             	add    $0x1,%eax
  180122:	83 f8 50             	cmp    $0x50,%eax
  180125:	75 e9                	jne    180110 <console_putc+0x6e>
  180127:	c3                   	retq   

0000000000180128 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  180128:	48 8b 47 08          	mov    0x8(%rdi),%rax
  18012c:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  180130:	73 0b                	jae    18013d <string_putc+0x15>
        *sp->s++ = c;
  180132:	48 8d 50 01          	lea    0x1(%rax),%rdx
  180136:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  18013a:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  18013d:	c3                   	retq   

000000000018013e <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  18013e:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  180141:	48 85 d2             	test   %rdx,%rdx
  180144:	74 17                	je     18015d <memcpy+0x1f>
  180146:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  18014b:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  180150:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  180154:	48 83 c1 01          	add    $0x1,%rcx
  180158:	48 39 d1             	cmp    %rdx,%rcx
  18015b:	75 ee                	jne    18014b <memcpy+0xd>
}
  18015d:	c3                   	retq   

000000000018015e <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  18015e:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  180161:	48 39 fe             	cmp    %rdi,%rsi
  180164:	72 1d                	jb     180183 <memmove+0x25>
        while (n-- > 0) {
  180166:	b9 00 00 00 00       	mov    $0x0,%ecx
  18016b:	48 85 d2             	test   %rdx,%rdx
  18016e:	74 12                	je     180182 <memmove+0x24>
            *d++ = *s++;
  180170:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  180174:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  180178:	48 83 c1 01          	add    $0x1,%rcx
  18017c:	48 39 ca             	cmp    %rcx,%rdx
  18017f:	75 ef                	jne    180170 <memmove+0x12>
}
  180181:	c3                   	retq   
  180182:	c3                   	retq   
    if (s < d && s + n > d) {
  180183:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  180187:	48 39 cf             	cmp    %rcx,%rdi
  18018a:	73 da                	jae    180166 <memmove+0x8>
        while (n-- > 0) {
  18018c:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  180190:	48 85 d2             	test   %rdx,%rdx
  180193:	74 ec                	je     180181 <memmove+0x23>
            *--d = *--s;
  180195:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  180199:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  18019c:	48 83 e9 01          	sub    $0x1,%rcx
  1801a0:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  1801a4:	75 ef                	jne    180195 <memmove+0x37>
  1801a6:	c3                   	retq   

00000000001801a7 <memset>:
void* memset(void* v, int c, size_t n) {
  1801a7:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1801aa:	48 85 d2             	test   %rdx,%rdx
  1801ad:	74 12                	je     1801c1 <memset+0x1a>
  1801af:	48 01 fa             	add    %rdi,%rdx
  1801b2:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  1801b5:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1801b8:	48 83 c1 01          	add    $0x1,%rcx
  1801bc:	48 39 ca             	cmp    %rcx,%rdx
  1801bf:	75 f4                	jne    1801b5 <memset+0xe>
}
  1801c1:	c3                   	retq   

00000000001801c2 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  1801c2:	80 3f 00             	cmpb   $0x0,(%rdi)
  1801c5:	74 10                	je     1801d7 <strlen+0x15>
  1801c7:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  1801cc:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  1801d0:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1801d4:	75 f6                	jne    1801cc <strlen+0xa>
  1801d6:	c3                   	retq   
  1801d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1801dc:	c3                   	retq   

00000000001801dd <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  1801dd:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1801e0:	ba 00 00 00 00       	mov    $0x0,%edx
  1801e5:	48 85 f6             	test   %rsi,%rsi
  1801e8:	74 11                	je     1801fb <strnlen+0x1e>
  1801ea:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  1801ee:	74 0c                	je     1801fc <strnlen+0x1f>
        ++n;
  1801f0:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1801f4:	48 39 d0             	cmp    %rdx,%rax
  1801f7:	75 f1                	jne    1801ea <strnlen+0xd>
  1801f9:	eb 04                	jmp    1801ff <strnlen+0x22>
  1801fb:	c3                   	retq   
  1801fc:	48 89 d0             	mov    %rdx,%rax
}
  1801ff:	c3                   	retq   

0000000000180200 <strcpy>:
char* strcpy(char* dst, const char* src) {
  180200:	48 89 f8             	mov    %rdi,%rax
  180203:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  180208:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  18020c:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  18020f:	48 83 c2 01          	add    $0x1,%rdx
  180213:	84 c9                	test   %cl,%cl
  180215:	75 f1                	jne    180208 <strcpy+0x8>
}
  180217:	c3                   	retq   

0000000000180218 <strcmp>:
    while (*a && *b && *a == *b) {
  180218:	0f b6 07             	movzbl (%rdi),%eax
  18021b:	84 c0                	test   %al,%al
  18021d:	74 1a                	je     180239 <strcmp+0x21>
  18021f:	0f b6 16             	movzbl (%rsi),%edx
  180222:	38 c2                	cmp    %al,%dl
  180224:	75 13                	jne    180239 <strcmp+0x21>
  180226:	84 d2                	test   %dl,%dl
  180228:	74 0f                	je     180239 <strcmp+0x21>
        ++a, ++b;
  18022a:	48 83 c7 01          	add    $0x1,%rdi
  18022e:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  180232:	0f b6 07             	movzbl (%rdi),%eax
  180235:	84 c0                	test   %al,%al
  180237:	75 e6                	jne    18021f <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  180239:	3a 06                	cmp    (%rsi),%al
  18023b:	0f 97 c0             	seta   %al
  18023e:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  180241:	83 d8 00             	sbb    $0x0,%eax
}
  180244:	c3                   	retq   

0000000000180245 <strchr>:
    while (*s && *s != (char) c) {
  180245:	0f b6 07             	movzbl (%rdi),%eax
  180248:	84 c0                	test   %al,%al
  18024a:	74 10                	je     18025c <strchr+0x17>
  18024c:	40 38 f0             	cmp    %sil,%al
  18024f:	74 18                	je     180269 <strchr+0x24>
        ++s;
  180251:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  180255:	0f b6 07             	movzbl (%rdi),%eax
  180258:	84 c0                	test   %al,%al
  18025a:	75 f0                	jne    18024c <strchr+0x7>
        return NULL;
  18025c:	40 84 f6             	test   %sil,%sil
  18025f:	b8 00 00 00 00       	mov    $0x0,%eax
  180264:	48 0f 44 c7          	cmove  %rdi,%rax
}
  180268:	c3                   	retq   
  180269:	48 89 f8             	mov    %rdi,%rax
  18026c:	c3                   	retq   

000000000018026d <rand>:
    if (!rand_seed_set) {
  18026d:	83 3d a0 0d 00 00 00 	cmpl   $0x0,0xda0(%rip)        # 181014 <rand_seed_set>
  180274:	74 1b                	je     180291 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  180276:	69 05 90 0d 00 00 0d 	imul   $0x19660d,0xd90(%rip),%eax        # 181010 <rand_seed>
  18027d:	66 19 00 
  180280:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  180285:	89 05 85 0d 00 00    	mov    %eax,0xd85(%rip)        # 181010 <rand_seed>
    return rand_seed & RAND_MAX;
  18028b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  180290:	c3                   	retq   
    rand_seed = seed;
  180291:	c7 05 75 0d 00 00 9e 	movl   $0x30d4879e,0xd75(%rip)        # 181010 <rand_seed>
  180298:	87 d4 30 
    rand_seed_set = 1;
  18029b:	c7 05 6f 0d 00 00 01 	movl   $0x1,0xd6f(%rip)        # 181014 <rand_seed_set>
  1802a2:	00 00 00 
}
  1802a5:	eb cf                	jmp    180276 <rand+0x9>

00000000001802a7 <srand>:
    rand_seed = seed;
  1802a7:	89 3d 63 0d 00 00    	mov    %edi,0xd63(%rip)        # 181010 <rand_seed>
    rand_seed_set = 1;
  1802ad:	c7 05 5d 0d 00 00 01 	movl   $0x1,0xd5d(%rip)        # 181014 <rand_seed_set>
  1802b4:	00 00 00 
}
  1802b7:	c3                   	retq   

00000000001802b8 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1802b8:	55                   	push   %rbp
  1802b9:	48 89 e5             	mov    %rsp,%rbp
  1802bc:	41 57                	push   %r15
  1802be:	41 56                	push   %r14
  1802c0:	41 55                	push   %r13
  1802c2:	41 54                	push   %r12
  1802c4:	53                   	push   %rbx
  1802c5:	48 83 ec 58          	sub    $0x58,%rsp
  1802c9:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  1802cd:	0f b6 02             	movzbl (%rdx),%eax
  1802d0:	84 c0                	test   %al,%al
  1802d2:	0f 84 b0 06 00 00    	je     180988 <printer_vprintf+0x6d0>
  1802d8:	49 89 fe             	mov    %rdi,%r14
  1802db:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  1802de:	41 89 f7             	mov    %esi,%r15d
  1802e1:	e9 a4 04 00 00       	jmpq   18078a <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  1802e6:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  1802eb:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1802f1:	45 84 e4             	test   %r12b,%r12b
  1802f4:	0f 84 82 06 00 00    	je     18097c <printer_vprintf+0x6c4>
        int flags = 0;
  1802fa:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  180300:	41 0f be f4          	movsbl %r12b,%esi
  180304:	bf c1 0c 18 00       	mov    $0x180cc1,%edi
  180309:	e8 37 ff ff ff       	callq  180245 <strchr>
  18030e:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  180311:	48 85 c0             	test   %rax,%rax
  180314:	74 55                	je     18036b <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  180316:	48 81 e9 c1 0c 18 00 	sub    $0x180cc1,%rcx
  18031d:	b8 01 00 00 00       	mov    $0x1,%eax
  180322:	d3 e0                	shl    %cl,%eax
  180324:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  180327:	48 83 c3 01          	add    $0x1,%rbx
  18032b:	44 0f b6 23          	movzbl (%rbx),%r12d
  18032f:	45 84 e4             	test   %r12b,%r12b
  180332:	75 cc                	jne    180300 <printer_vprintf+0x48>
  180334:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  180338:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  18033e:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  180345:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  180348:	0f 84 a9 00 00 00    	je     1803f7 <printer_vprintf+0x13f>
        int length = 0;
  18034e:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  180353:	0f b6 13             	movzbl (%rbx),%edx
  180356:	8d 42 bd             	lea    -0x43(%rdx),%eax
  180359:	3c 37                	cmp    $0x37,%al
  18035b:	0f 87 c4 04 00 00    	ja     180825 <printer_vprintf+0x56d>
  180361:	0f b6 c0             	movzbl %al,%eax
  180364:	ff 24 c5 d0 0a 18 00 	jmpq   *0x180ad0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  18036b:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  18036f:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  180374:	3c 08                	cmp    $0x8,%al
  180376:	77 2f                	ja     1803a7 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  180378:	0f b6 03             	movzbl (%rbx),%eax
  18037b:	8d 50 d0             	lea    -0x30(%rax),%edx
  18037e:	80 fa 09             	cmp    $0x9,%dl
  180381:	77 5e                	ja     1803e1 <printer_vprintf+0x129>
  180383:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  180389:	48 83 c3 01          	add    $0x1,%rbx
  18038d:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  180392:	0f be c0             	movsbl %al,%eax
  180395:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  18039a:	0f b6 03             	movzbl (%rbx),%eax
  18039d:	8d 50 d0             	lea    -0x30(%rax),%edx
  1803a0:	80 fa 09             	cmp    $0x9,%dl
  1803a3:	76 e4                	jbe    180389 <printer_vprintf+0xd1>
  1803a5:	eb 97                	jmp    18033e <printer_vprintf+0x86>
        } else if (*format == '*') {
  1803a7:	41 80 fc 2a          	cmp    $0x2a,%r12b
  1803ab:	75 3f                	jne    1803ec <printer_vprintf+0x134>
            width = va_arg(val, int);
  1803ad:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1803b1:	8b 07                	mov    (%rdi),%eax
  1803b3:	83 f8 2f             	cmp    $0x2f,%eax
  1803b6:	77 17                	ja     1803cf <printer_vprintf+0x117>
  1803b8:	89 c2                	mov    %eax,%edx
  1803ba:	48 03 57 10          	add    0x10(%rdi),%rdx
  1803be:	83 c0 08             	add    $0x8,%eax
  1803c1:	89 07                	mov    %eax,(%rdi)
  1803c3:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  1803c6:	48 83 c3 01          	add    $0x1,%rbx
  1803ca:	e9 6f ff ff ff       	jmpq   18033e <printer_vprintf+0x86>
            width = va_arg(val, int);
  1803cf:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1803d3:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1803d7:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1803db:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1803df:	eb e2                	jmp    1803c3 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1803e1:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1803e7:	e9 52 ff ff ff       	jmpq   18033e <printer_vprintf+0x86>
        int width = -1;
  1803ec:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1803f2:	e9 47 ff ff ff       	jmpq   18033e <printer_vprintf+0x86>
            ++format;
  1803f7:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1803fb:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1803ff:	8d 48 d0             	lea    -0x30(%rax),%ecx
  180402:	80 f9 09             	cmp    $0x9,%cl
  180405:	76 13                	jbe    18041a <printer_vprintf+0x162>
            } else if (*format == '*') {
  180407:	3c 2a                	cmp    $0x2a,%al
  180409:	74 33                	je     18043e <printer_vprintf+0x186>
            ++format;
  18040b:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  18040e:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  180415:	e9 34 ff ff ff       	jmpq   18034e <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  18041a:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  18041f:	48 83 c2 01          	add    $0x1,%rdx
  180423:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  180426:	0f be c0             	movsbl %al,%eax
  180429:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  18042d:	0f b6 02             	movzbl (%rdx),%eax
  180430:	8d 70 d0             	lea    -0x30(%rax),%esi
  180433:	40 80 fe 09          	cmp    $0x9,%sil
  180437:	76 e6                	jbe    18041f <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  180439:	48 89 d3             	mov    %rdx,%rbx
  18043c:	eb 1c                	jmp    18045a <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  18043e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  180442:	8b 07                	mov    (%rdi),%eax
  180444:	83 f8 2f             	cmp    $0x2f,%eax
  180447:	77 23                	ja     18046c <printer_vprintf+0x1b4>
  180449:	89 c2                	mov    %eax,%edx
  18044b:	48 03 57 10          	add    0x10(%rdi),%rdx
  18044f:	83 c0 08             	add    $0x8,%eax
  180452:	89 07                	mov    %eax,(%rdi)
  180454:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  180456:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  18045a:	85 c9                	test   %ecx,%ecx
  18045c:	b8 00 00 00 00       	mov    $0x0,%eax
  180461:	0f 49 c1             	cmovns %ecx,%eax
  180464:	89 45 9c             	mov    %eax,-0x64(%rbp)
  180467:	e9 e2 fe ff ff       	jmpq   18034e <printer_vprintf+0x96>
                precision = va_arg(val, int);
  18046c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  180470:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  180474:	48 8d 42 08          	lea    0x8(%rdx),%rax
  180478:	48 89 41 08          	mov    %rax,0x8(%rcx)
  18047c:	eb d6                	jmp    180454 <printer_vprintf+0x19c>
        switch (*format) {
  18047e:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  180483:	e9 f3 00 00 00       	jmpq   18057b <printer_vprintf+0x2c3>
            ++format;
  180488:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  18048c:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  180491:	e9 bd fe ff ff       	jmpq   180353 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  180496:	85 c9                	test   %ecx,%ecx
  180498:	74 55                	je     1804ef <printer_vprintf+0x237>
  18049a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  18049e:	8b 07                	mov    (%rdi),%eax
  1804a0:	83 f8 2f             	cmp    $0x2f,%eax
  1804a3:	77 38                	ja     1804dd <printer_vprintf+0x225>
  1804a5:	89 c2                	mov    %eax,%edx
  1804a7:	48 03 57 10          	add    0x10(%rdi),%rdx
  1804ab:	83 c0 08             	add    $0x8,%eax
  1804ae:	89 07                	mov    %eax,(%rdi)
  1804b0:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1804b3:	48 89 d0             	mov    %rdx,%rax
  1804b6:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  1804ba:	49 89 d0             	mov    %rdx,%r8
  1804bd:	49 f7 d8             	neg    %r8
  1804c0:	25 80 00 00 00       	and    $0x80,%eax
  1804c5:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1804c9:	0b 45 a8             	or     -0x58(%rbp),%eax
  1804cc:	83 c8 60             	or     $0x60,%eax
  1804cf:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  1804d2:	41 bc c8 0a 18 00    	mov    $0x180ac8,%r12d
            break;
  1804d8:	e9 35 01 00 00       	jmpq   180612 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1804dd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1804e1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1804e5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1804e9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1804ed:	eb c1                	jmp    1804b0 <printer_vprintf+0x1f8>
  1804ef:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1804f3:	8b 07                	mov    (%rdi),%eax
  1804f5:	83 f8 2f             	cmp    $0x2f,%eax
  1804f8:	77 10                	ja     18050a <printer_vprintf+0x252>
  1804fa:	89 c2                	mov    %eax,%edx
  1804fc:	48 03 57 10          	add    0x10(%rdi),%rdx
  180500:	83 c0 08             	add    $0x8,%eax
  180503:	89 07                	mov    %eax,(%rdi)
  180505:	48 63 12             	movslq (%rdx),%rdx
  180508:	eb a9                	jmp    1804b3 <printer_vprintf+0x1fb>
  18050a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  18050e:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  180512:	48 8d 42 08          	lea    0x8(%rdx),%rax
  180516:	48 89 47 08          	mov    %rax,0x8(%rdi)
  18051a:	eb e9                	jmp    180505 <printer_vprintf+0x24d>
        int base = 10;
  18051c:	be 0a 00 00 00       	mov    $0xa,%esi
  180521:	eb 58                	jmp    18057b <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  180523:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  180527:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  18052b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  18052f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  180533:	eb 60                	jmp    180595 <printer_vprintf+0x2dd>
  180535:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  180539:	8b 07                	mov    (%rdi),%eax
  18053b:	83 f8 2f             	cmp    $0x2f,%eax
  18053e:	77 10                	ja     180550 <printer_vprintf+0x298>
  180540:	89 c2                	mov    %eax,%edx
  180542:	48 03 57 10          	add    0x10(%rdi),%rdx
  180546:	83 c0 08             	add    $0x8,%eax
  180549:	89 07                	mov    %eax,(%rdi)
  18054b:	44 8b 02             	mov    (%rdx),%r8d
  18054e:	eb 48                	jmp    180598 <printer_vprintf+0x2e0>
  180550:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  180554:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  180558:	48 8d 42 08          	lea    0x8(%rdx),%rax
  18055c:	48 89 41 08          	mov    %rax,0x8(%rcx)
  180560:	eb e9                	jmp    18054b <printer_vprintf+0x293>
  180562:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  180565:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  18056c:	bf b0 0c 18 00       	mov    $0x180cb0,%edi
  180571:	e9 e2 02 00 00       	jmpq   180858 <printer_vprintf+0x5a0>
            base = 16;
  180576:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  18057b:	85 c9                	test   %ecx,%ecx
  18057d:	74 b6                	je     180535 <printer_vprintf+0x27d>
  18057f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  180583:	8b 01                	mov    (%rcx),%eax
  180585:	83 f8 2f             	cmp    $0x2f,%eax
  180588:	77 99                	ja     180523 <printer_vprintf+0x26b>
  18058a:	89 c2                	mov    %eax,%edx
  18058c:	48 03 51 10          	add    0x10(%rcx),%rdx
  180590:	83 c0 08             	add    $0x8,%eax
  180593:	89 01                	mov    %eax,(%rcx)
  180595:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  180598:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  18059c:	85 f6                	test   %esi,%esi
  18059e:	79 c2                	jns    180562 <printer_vprintf+0x2aa>
        base = -base;
  1805a0:	41 89 f1             	mov    %esi,%r9d
  1805a3:	f7 de                	neg    %esi
  1805a5:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  1805ac:	bf 90 0c 18 00       	mov    $0x180c90,%edi
  1805b1:	e9 a2 02 00 00       	jmpq   180858 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  1805b6:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1805ba:	8b 07                	mov    (%rdi),%eax
  1805bc:	83 f8 2f             	cmp    $0x2f,%eax
  1805bf:	77 1c                	ja     1805dd <printer_vprintf+0x325>
  1805c1:	89 c2                	mov    %eax,%edx
  1805c3:	48 03 57 10          	add    0x10(%rdi),%rdx
  1805c7:	83 c0 08             	add    $0x8,%eax
  1805ca:	89 07                	mov    %eax,(%rdi)
  1805cc:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1805cf:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  1805d6:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1805db:	eb c3                	jmp    1805a0 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  1805dd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1805e1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1805e5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1805e9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1805ed:	eb dd                	jmp    1805cc <printer_vprintf+0x314>
            data = va_arg(val, char*);
  1805ef:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1805f3:	8b 01                	mov    (%rcx),%eax
  1805f5:	83 f8 2f             	cmp    $0x2f,%eax
  1805f8:	0f 87 a5 01 00 00    	ja     1807a3 <printer_vprintf+0x4eb>
  1805fe:	89 c2                	mov    %eax,%edx
  180600:	48 03 51 10          	add    0x10(%rcx),%rdx
  180604:	83 c0 08             	add    $0x8,%eax
  180607:	89 01                	mov    %eax,(%rcx)
  180609:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  18060c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  180612:	8b 45 a8             	mov    -0x58(%rbp),%eax
  180615:	83 e0 20             	and    $0x20,%eax
  180618:	89 45 8c             	mov    %eax,-0x74(%rbp)
  18061b:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  180621:	0f 85 21 02 00 00    	jne    180848 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  180627:	8b 45 a8             	mov    -0x58(%rbp),%eax
  18062a:	89 45 88             	mov    %eax,-0x78(%rbp)
  18062d:	83 e0 60             	and    $0x60,%eax
  180630:	83 f8 60             	cmp    $0x60,%eax
  180633:	0f 84 54 02 00 00    	je     18088d <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  180639:	8b 45 a8             	mov    -0x58(%rbp),%eax
  18063c:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  18063f:	48 c7 45 a0 c8 0a 18 	movq   $0x180ac8,-0x60(%rbp)
  180646:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  180647:	83 f8 21             	cmp    $0x21,%eax
  18064a:	0f 84 79 02 00 00    	je     1808c9 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  180650:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  180653:	89 f8                	mov    %edi,%eax
  180655:	f7 d0                	not    %eax
  180657:	c1 e8 1f             	shr    $0x1f,%eax
  18065a:	89 45 84             	mov    %eax,-0x7c(%rbp)
  18065d:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  180661:	0f 85 9e 02 00 00    	jne    180905 <printer_vprintf+0x64d>
  180667:	84 c0                	test   %al,%al
  180669:	0f 84 96 02 00 00    	je     180905 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  18066f:	48 63 f7             	movslq %edi,%rsi
  180672:	4c 89 e7             	mov    %r12,%rdi
  180675:	e8 63 fb ff ff       	callq  1801dd <strnlen>
  18067a:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  18067d:	8b 45 88             	mov    -0x78(%rbp),%eax
  180680:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  180683:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  18068a:	83 f8 22             	cmp    $0x22,%eax
  18068d:	0f 84 aa 02 00 00    	je     18093d <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  180693:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  180697:	e8 26 fb ff ff       	callq  1801c2 <strlen>
  18069c:	8b 55 9c             	mov    -0x64(%rbp),%edx
  18069f:	03 55 98             	add    -0x68(%rbp),%edx
  1806a2:	44 89 e9             	mov    %r13d,%ecx
  1806a5:	29 d1                	sub    %edx,%ecx
  1806a7:	29 c1                	sub    %eax,%ecx
  1806a9:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  1806ac:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1806af:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  1806b3:	75 2d                	jne    1806e2 <printer_vprintf+0x42a>
  1806b5:	85 c9                	test   %ecx,%ecx
  1806b7:	7e 29                	jle    1806e2 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  1806b9:	44 89 fa             	mov    %r15d,%edx
  1806bc:	be 20 00 00 00       	mov    $0x20,%esi
  1806c1:	4c 89 f7             	mov    %r14,%rdi
  1806c4:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1806c7:	41 83 ed 01          	sub    $0x1,%r13d
  1806cb:	45 85 ed             	test   %r13d,%r13d
  1806ce:	7f e9                	jg     1806b9 <printer_vprintf+0x401>
  1806d0:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  1806d3:	85 ff                	test   %edi,%edi
  1806d5:	b8 01 00 00 00       	mov    $0x1,%eax
  1806da:	0f 4f c7             	cmovg  %edi,%eax
  1806dd:	29 c7                	sub    %eax,%edi
  1806df:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  1806e2:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1806e6:	0f b6 07             	movzbl (%rdi),%eax
  1806e9:	84 c0                	test   %al,%al
  1806eb:	74 22                	je     18070f <printer_vprintf+0x457>
  1806ed:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1806f1:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  1806f4:	0f b6 f0             	movzbl %al,%esi
  1806f7:	44 89 fa             	mov    %r15d,%edx
  1806fa:	4c 89 f7             	mov    %r14,%rdi
  1806fd:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  180700:	48 83 c3 01          	add    $0x1,%rbx
  180704:	0f b6 03             	movzbl (%rbx),%eax
  180707:	84 c0                	test   %al,%al
  180709:	75 e9                	jne    1806f4 <printer_vprintf+0x43c>
  18070b:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  18070f:	8b 45 9c             	mov    -0x64(%rbp),%eax
  180712:	85 c0                	test   %eax,%eax
  180714:	7e 1d                	jle    180733 <printer_vprintf+0x47b>
  180716:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  18071a:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  18071c:	44 89 fa             	mov    %r15d,%edx
  18071f:	be 30 00 00 00       	mov    $0x30,%esi
  180724:	4c 89 f7             	mov    %r14,%rdi
  180727:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  18072a:	83 eb 01             	sub    $0x1,%ebx
  18072d:	75 ed                	jne    18071c <printer_vprintf+0x464>
  18072f:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  180733:	8b 45 98             	mov    -0x68(%rbp),%eax
  180736:	85 c0                	test   %eax,%eax
  180738:	7e 27                	jle    180761 <printer_vprintf+0x4a9>
  18073a:	89 c0                	mov    %eax,%eax
  18073c:	4c 01 e0             	add    %r12,%rax
  18073f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  180743:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  180746:	41 0f b6 34 24       	movzbl (%r12),%esi
  18074b:	44 89 fa             	mov    %r15d,%edx
  18074e:	4c 89 f7             	mov    %r14,%rdi
  180751:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  180754:	49 83 c4 01          	add    $0x1,%r12
  180758:	49 39 dc             	cmp    %rbx,%r12
  18075b:	75 e9                	jne    180746 <printer_vprintf+0x48e>
  18075d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  180761:	45 85 ed             	test   %r13d,%r13d
  180764:	7e 14                	jle    18077a <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  180766:	44 89 fa             	mov    %r15d,%edx
  180769:	be 20 00 00 00       	mov    $0x20,%esi
  18076e:	4c 89 f7             	mov    %r14,%rdi
  180771:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  180774:	41 83 ed 01          	sub    $0x1,%r13d
  180778:	75 ec                	jne    180766 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  18077a:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  18077e:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  180782:	84 c0                	test   %al,%al
  180784:	0f 84 fe 01 00 00    	je     180988 <printer_vprintf+0x6d0>
        if (*format != '%') {
  18078a:	3c 25                	cmp    $0x25,%al
  18078c:	0f 84 54 fb ff ff    	je     1802e6 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  180792:	0f b6 f0             	movzbl %al,%esi
  180795:	44 89 fa             	mov    %r15d,%edx
  180798:	4c 89 f7             	mov    %r14,%rdi
  18079b:	41 ff 16             	callq  *(%r14)
            continue;
  18079e:	4c 89 e3             	mov    %r12,%rbx
  1807a1:	eb d7                	jmp    18077a <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  1807a3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1807a7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1807ab:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1807af:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1807b3:	e9 51 fe ff ff       	jmpq   180609 <printer_vprintf+0x351>
            color = va_arg(val, int);
  1807b8:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1807bc:	8b 07                	mov    (%rdi),%eax
  1807be:	83 f8 2f             	cmp    $0x2f,%eax
  1807c1:	77 10                	ja     1807d3 <printer_vprintf+0x51b>
  1807c3:	89 c2                	mov    %eax,%edx
  1807c5:	48 03 57 10          	add    0x10(%rdi),%rdx
  1807c9:	83 c0 08             	add    $0x8,%eax
  1807cc:	89 07                	mov    %eax,(%rdi)
  1807ce:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  1807d1:	eb a7                	jmp    18077a <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  1807d3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1807d7:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1807db:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1807df:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1807e3:	eb e9                	jmp    1807ce <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  1807e5:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1807e9:	8b 01                	mov    (%rcx),%eax
  1807eb:	83 f8 2f             	cmp    $0x2f,%eax
  1807ee:	77 23                	ja     180813 <printer_vprintf+0x55b>
  1807f0:	89 c2                	mov    %eax,%edx
  1807f2:	48 03 51 10          	add    0x10(%rcx),%rdx
  1807f6:	83 c0 08             	add    $0x8,%eax
  1807f9:	89 01                	mov    %eax,(%rcx)
  1807fb:	8b 02                	mov    (%rdx),%eax
  1807fd:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  180800:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  180804:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  180808:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  18080e:	e9 ff fd ff ff       	jmpq   180612 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  180813:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  180817:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  18081b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  18081f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  180823:	eb d6                	jmp    1807fb <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  180825:	84 d2                	test   %dl,%dl
  180827:	0f 85 39 01 00 00    	jne    180966 <printer_vprintf+0x6ae>
  18082d:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  180831:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  180835:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  180839:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  18083d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  180843:	e9 ca fd ff ff       	jmpq   180612 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  180848:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  18084e:	bf b0 0c 18 00       	mov    $0x180cb0,%edi
        if (flags & FLAG_NUMERIC) {
  180853:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  180858:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  18085c:	4c 89 c1             	mov    %r8,%rcx
  18085f:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  180863:	48 63 f6             	movslq %esi,%rsi
  180866:	49 83 ec 01          	sub    $0x1,%r12
  18086a:	48 89 c8             	mov    %rcx,%rax
  18086d:	ba 00 00 00 00       	mov    $0x0,%edx
  180872:	48 f7 f6             	div    %rsi
  180875:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  180879:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  18087d:	48 89 ca             	mov    %rcx,%rdx
  180880:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  180883:	48 39 d6             	cmp    %rdx,%rsi
  180886:	76 de                	jbe    180866 <printer_vprintf+0x5ae>
  180888:	e9 9a fd ff ff       	jmpq   180627 <printer_vprintf+0x36f>
                prefix = "-";
  18088d:	48 c7 45 a0 c5 0a 18 	movq   $0x180ac5,-0x60(%rbp)
  180894:	00 
            if (flags & FLAG_NEGATIVE) {
  180895:	8b 45 a8             	mov    -0x58(%rbp),%eax
  180898:	a8 80                	test   $0x80,%al
  18089a:	0f 85 b0 fd ff ff    	jne    180650 <printer_vprintf+0x398>
                prefix = "+";
  1808a0:	48 c7 45 a0 c0 0a 18 	movq   $0x180ac0,-0x60(%rbp)
  1808a7:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1808a8:	a8 10                	test   $0x10,%al
  1808aa:	0f 85 a0 fd ff ff    	jne    180650 <printer_vprintf+0x398>
                prefix = " ";
  1808b0:	a8 08                	test   $0x8,%al
  1808b2:	ba c8 0a 18 00       	mov    $0x180ac8,%edx
  1808b7:	b8 c7 0a 18 00       	mov    $0x180ac7,%eax
  1808bc:	48 0f 44 c2          	cmove  %rdx,%rax
  1808c0:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1808c4:	e9 87 fd ff ff       	jmpq   180650 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  1808c9:	41 8d 41 10          	lea    0x10(%r9),%eax
  1808cd:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  1808d2:	0f 85 78 fd ff ff    	jne    180650 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  1808d8:	4d 85 c0             	test   %r8,%r8
  1808db:	75 0d                	jne    1808ea <printer_vprintf+0x632>
  1808dd:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  1808e4:	0f 84 66 fd ff ff    	je     180650 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  1808ea:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1808ee:	ba c9 0a 18 00       	mov    $0x180ac9,%edx
  1808f3:	b8 c2 0a 18 00       	mov    $0x180ac2,%eax
  1808f8:	48 0f 44 c2          	cmove  %rdx,%rax
  1808fc:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  180900:	e9 4b fd ff ff       	jmpq   180650 <printer_vprintf+0x398>
            len = strlen(data);
  180905:	4c 89 e7             	mov    %r12,%rdi
  180908:	e8 b5 f8 ff ff       	callq  1801c2 <strlen>
  18090d:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  180910:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  180914:	0f 84 63 fd ff ff    	je     18067d <printer_vprintf+0x3c5>
  18091a:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  18091e:	0f 84 59 fd ff ff    	je     18067d <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  180924:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  180927:	89 ca                	mov    %ecx,%edx
  180929:	29 c2                	sub    %eax,%edx
  18092b:	39 c1                	cmp    %eax,%ecx
  18092d:	b8 00 00 00 00       	mov    $0x0,%eax
  180932:	0f 4e d0             	cmovle %eax,%edx
  180935:	89 55 9c             	mov    %edx,-0x64(%rbp)
  180938:	e9 56 fd ff ff       	jmpq   180693 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  18093d:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  180941:	e8 7c f8 ff ff       	callq  1801c2 <strlen>
  180946:	8b 7d 98             	mov    -0x68(%rbp),%edi
  180949:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  18094c:	44 89 e9             	mov    %r13d,%ecx
  18094f:	29 f9                	sub    %edi,%ecx
  180951:	29 c1                	sub    %eax,%ecx
  180953:	44 39 ea             	cmp    %r13d,%edx
  180956:	b8 00 00 00 00       	mov    $0x0,%eax
  18095b:	0f 4d c8             	cmovge %eax,%ecx
  18095e:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  180961:	e9 2d fd ff ff       	jmpq   180693 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  180966:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  180969:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  18096d:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  180971:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  180977:	e9 96 fc ff ff       	jmpq   180612 <printer_vprintf+0x35a>
        int flags = 0;
  18097c:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  180983:	e9 b0 f9 ff ff       	jmpq   180338 <printer_vprintf+0x80>
}
  180988:	48 83 c4 58          	add    $0x58,%rsp
  18098c:	5b                   	pop    %rbx
  18098d:	41 5c                	pop    %r12
  18098f:	41 5d                	pop    %r13
  180991:	41 5e                	pop    %r14
  180993:	41 5f                	pop    %r15
  180995:	5d                   	pop    %rbp
  180996:	c3                   	retq   

0000000000180997 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  180997:	55                   	push   %rbp
  180998:	48 89 e5             	mov    %rsp,%rbp
  18099b:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  18099f:	48 c7 45 f0 a2 00 18 	movq   $0x1800a2,-0x10(%rbp)
  1809a6:	00 
        cpos = 0;
  1809a7:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  1809ad:	b8 00 00 00 00       	mov    $0x0,%eax
  1809b2:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  1809b5:	48 63 ff             	movslq %edi,%rdi
  1809b8:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  1809bf:	00 
  1809c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1809c4:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  1809c8:	e8 eb f8 ff ff       	callq  1802b8 <printer_vprintf>
    return cp.cursor - console;
  1809cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1809d1:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1809d7:	48 d1 f8             	sar    %rax
}
  1809da:	c9                   	leaveq 
  1809db:	c3                   	retq   

00000000001809dc <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  1809dc:	55                   	push   %rbp
  1809dd:	48 89 e5             	mov    %rsp,%rbp
  1809e0:	48 83 ec 50          	sub    $0x50,%rsp
  1809e4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1809e8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1809ec:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  1809f0:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1809f7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1809fb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1809ff:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  180a03:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  180a07:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  180a0b:	e8 87 ff ff ff       	callq  180997 <console_vprintf>
}
  180a10:	c9                   	leaveq 
  180a11:	c3                   	retq   

0000000000180a12 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  180a12:	55                   	push   %rbp
  180a13:	48 89 e5             	mov    %rsp,%rbp
  180a16:	53                   	push   %rbx
  180a17:	48 83 ec 28          	sub    $0x28,%rsp
  180a1b:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  180a1e:	48 c7 45 d8 28 01 18 	movq   $0x180128,-0x28(%rbp)
  180a25:	00 
    sp.s = s;
  180a26:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  180a2a:	48 85 f6             	test   %rsi,%rsi
  180a2d:	75 0b                	jne    180a3a <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  180a2f:	8b 45 e0             	mov    -0x20(%rbp),%eax
  180a32:	29 d8                	sub    %ebx,%eax
}
  180a34:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  180a38:	c9                   	leaveq 
  180a39:	c3                   	retq   
        sp.end = s + size - 1;
  180a3a:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  180a3f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  180a43:	be 00 00 00 00       	mov    $0x0,%esi
  180a48:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  180a4c:	e8 67 f8 ff ff       	callq  1802b8 <printer_vprintf>
        *sp.s = 0;
  180a51:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  180a55:	c6 00 00             	movb   $0x0,(%rax)
  180a58:	eb d5                	jmp    180a2f <vsnprintf+0x1d>

0000000000180a5a <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  180a5a:	55                   	push   %rbp
  180a5b:	48 89 e5             	mov    %rsp,%rbp
  180a5e:	48 83 ec 50          	sub    $0x50,%rsp
  180a62:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  180a66:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  180a6a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  180a6e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  180a75:	48 8d 45 10          	lea    0x10(%rbp),%rax
  180a79:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  180a7d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  180a81:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  180a85:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  180a89:	e8 84 ff ff ff       	callq  180a12 <vsnprintf>
    va_end(val);
    return n;
}
  180a8e:	c9                   	leaveq 
  180a8f:	c3                   	retq   

0000000000180a90 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  180a90:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  180a95:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  180a9a:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  180a9f:	48 83 c0 02          	add    $0x2,%rax
  180aa3:	48 39 d0             	cmp    %rdx,%rax
  180aa6:	75 f2                	jne    180a9a <console_clear+0xa>
    }
    cursorpos = 0;
  180aa8:	c7 05 4a 85 f3 ff 00 	movl   $0x0,-0xc7ab6(%rip)        # b8ffc <cursorpos>
  180aaf:	00 00 00 
}
  180ab2:	c3                   	retq   

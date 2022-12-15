
obj/p-allocator2.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000140000 <process_main>:

// These global variables go on the data page.
uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  140000:	55                   	push   %rbp
  140001:	48 89 e5             	mov    %rsp,%rbp
  140004:	53                   	push   %rbx
  140005:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  140009:	cd 31                	int    $0x31
  14000b:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  14000d:	89 c7                	mov    %eax,%edi
  14000f:	e8 93 02 00 00       	callq  1402a7 <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  140014:	b8 17 20 14 00       	mov    $0x142017,%eax
  140019:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  14001f:	48 89 05 e2 0f 00 00 	mov    %rax,0xfe2(%rip)        # 141008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  140026:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  140029:	48 83 e8 01          	sub    $0x1,%rax
  14002d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  140033:	48 89 05 c6 0f 00 00 	mov    %rax,0xfc6(%rip)        # 141000 <stack_bottom>
  14003a:	eb 02                	jmp    14003e <process_main+0x3e>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  14003c:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  14003e:	e8 2a 02 00 00       	callq  14026d <rand>
  140043:	48 63 d0             	movslq %eax,%rdx
  140046:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  14004d:	48 c1 fa 25          	sar    $0x25,%rdx
  140051:	89 c1                	mov    %eax,%ecx
  140053:	c1 f9 1f             	sar    $0x1f,%ecx
  140056:	29 ca                	sub    %ecx,%edx
  140058:	6b d2 64             	imul   $0x64,%edx,%edx
  14005b:	29 d0                	sub    %edx,%eax
  14005d:	39 d8                	cmp    %ebx,%eax
  14005f:	7d db                	jge    14003c <process_main+0x3c>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  140061:	48 8b 3d a0 0f 00 00 	mov    0xfa0(%rip),%rdi        # 141008 <heap_top>
  140068:	48 3b 3d 91 0f 00 00 	cmp    0xf91(%rip),%rdi        # 141000 <stack_bottom>
  14006f:	74 2d                	je     14009e <process_main+0x9e>
    uintptr_t ad = (uintptr_t) addr;
    if(ad % PAGESIZE != 0)
        return -1;
    
    // check that addr is within vm bounds
    if(ad >= 0x300000)
  140071:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
  140077:	75 25                	jne    14009e <process_main+0x9e>
  140079:	48 81 ff ff ff 2f 00 	cmp    $0x2fffff,%rdi
  140080:	77 1c                	ja     14009e <process_main+0x9e>
        return -1;

    int result;
    asm volatile ("int %1" : "=a" (result)
  140082:	cd 33                	int    $0x33
  140084:	85 c0                	test   %eax,%eax
  140086:	78 16                	js     14009e <process_main+0x9e>
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
  140088:	48 8b 05 79 0f 00 00 	mov    0xf79(%rip),%rax        # 141008 <heap_top>
  14008f:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  140091:	48 81 05 6c 0f 00 00 	addq   $0x1000,0xf6c(%rip)        # 141008 <heap_top>
  140098:	00 10 00 00 
  14009c:	eb 9e                	jmp    14003c <process_main+0x3c>
    asm volatile ("int %0" : /* no result */
  14009e:	cd 32                	int    $0x32
  1400a0:	eb fc                	jmp    14009e <process_main+0x9e>

00000000001400a2 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1400a2:	48 89 f9             	mov    %rdi,%rcx
  1400a5:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1400a7:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  1400ae:	00 
  1400af:	72 08                	jb     1400b9 <console_putc+0x17>
        cp->cursor = console;
  1400b1:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  1400b8:	00 
    }
    if (c == '\n') {
  1400b9:	40 80 fe 0a          	cmp    $0xa,%sil
  1400bd:	74 16                	je     1400d5 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  1400bf:	48 8b 41 08          	mov    0x8(%rcx),%rax
  1400c3:	48 8d 50 02          	lea    0x2(%rax),%rdx
  1400c7:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  1400cb:	40 0f b6 f6          	movzbl %sil,%esi
  1400cf:	09 fe                	or     %edi,%esi
  1400d1:	66 89 30             	mov    %si,(%rax)
    }
}
  1400d4:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  1400d5:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  1400d9:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  1400e0:	4c 89 c6             	mov    %r8,%rsi
  1400e3:	48 d1 fe             	sar    %rsi
  1400e6:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1400ed:	66 66 66 
  1400f0:	48 89 f0             	mov    %rsi,%rax
  1400f3:	48 f7 ea             	imul   %rdx
  1400f6:	48 c1 fa 05          	sar    $0x5,%rdx
  1400fa:	49 c1 f8 3f          	sar    $0x3f,%r8
  1400fe:	4c 29 c2             	sub    %r8,%rdx
  140101:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  140105:	48 c1 e2 04          	shl    $0x4,%rdx
  140109:	89 f0                	mov    %esi,%eax
  14010b:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  14010d:	83 cf 20             	or     $0x20,%edi
  140110:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  140114:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  140118:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  14011c:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  14011f:	83 c0 01             	add    $0x1,%eax
  140122:	83 f8 50             	cmp    $0x50,%eax
  140125:	75 e9                	jne    140110 <console_putc+0x6e>
  140127:	c3                   	retq   

0000000000140128 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  140128:	48 8b 47 08          	mov    0x8(%rdi),%rax
  14012c:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  140130:	73 0b                	jae    14013d <string_putc+0x15>
        *sp->s++ = c;
  140132:	48 8d 50 01          	lea    0x1(%rax),%rdx
  140136:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  14013a:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  14013d:	c3                   	retq   

000000000014013e <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  14013e:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  140141:	48 85 d2             	test   %rdx,%rdx
  140144:	74 17                	je     14015d <memcpy+0x1f>
  140146:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  14014b:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  140150:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  140154:	48 83 c1 01          	add    $0x1,%rcx
  140158:	48 39 d1             	cmp    %rdx,%rcx
  14015b:	75 ee                	jne    14014b <memcpy+0xd>
}
  14015d:	c3                   	retq   

000000000014015e <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  14015e:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  140161:	48 39 fe             	cmp    %rdi,%rsi
  140164:	72 1d                	jb     140183 <memmove+0x25>
        while (n-- > 0) {
  140166:	b9 00 00 00 00       	mov    $0x0,%ecx
  14016b:	48 85 d2             	test   %rdx,%rdx
  14016e:	74 12                	je     140182 <memmove+0x24>
            *d++ = *s++;
  140170:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  140174:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  140178:	48 83 c1 01          	add    $0x1,%rcx
  14017c:	48 39 ca             	cmp    %rcx,%rdx
  14017f:	75 ef                	jne    140170 <memmove+0x12>
}
  140181:	c3                   	retq   
  140182:	c3                   	retq   
    if (s < d && s + n > d) {
  140183:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  140187:	48 39 cf             	cmp    %rcx,%rdi
  14018a:	73 da                	jae    140166 <memmove+0x8>
        while (n-- > 0) {
  14018c:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  140190:	48 85 d2             	test   %rdx,%rdx
  140193:	74 ec                	je     140181 <memmove+0x23>
            *--d = *--s;
  140195:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  140199:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  14019c:	48 83 e9 01          	sub    $0x1,%rcx
  1401a0:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  1401a4:	75 ef                	jne    140195 <memmove+0x37>
  1401a6:	c3                   	retq   

00000000001401a7 <memset>:
void* memset(void* v, int c, size_t n) {
  1401a7:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1401aa:	48 85 d2             	test   %rdx,%rdx
  1401ad:	74 12                	je     1401c1 <memset+0x1a>
  1401af:	48 01 fa             	add    %rdi,%rdx
  1401b2:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  1401b5:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1401b8:	48 83 c1 01          	add    $0x1,%rcx
  1401bc:	48 39 ca             	cmp    %rcx,%rdx
  1401bf:	75 f4                	jne    1401b5 <memset+0xe>
}
  1401c1:	c3                   	retq   

00000000001401c2 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  1401c2:	80 3f 00             	cmpb   $0x0,(%rdi)
  1401c5:	74 10                	je     1401d7 <strlen+0x15>
  1401c7:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  1401cc:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  1401d0:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1401d4:	75 f6                	jne    1401cc <strlen+0xa>
  1401d6:	c3                   	retq   
  1401d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1401dc:	c3                   	retq   

00000000001401dd <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  1401dd:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1401e0:	ba 00 00 00 00       	mov    $0x0,%edx
  1401e5:	48 85 f6             	test   %rsi,%rsi
  1401e8:	74 11                	je     1401fb <strnlen+0x1e>
  1401ea:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  1401ee:	74 0c                	je     1401fc <strnlen+0x1f>
        ++n;
  1401f0:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1401f4:	48 39 d0             	cmp    %rdx,%rax
  1401f7:	75 f1                	jne    1401ea <strnlen+0xd>
  1401f9:	eb 04                	jmp    1401ff <strnlen+0x22>
  1401fb:	c3                   	retq   
  1401fc:	48 89 d0             	mov    %rdx,%rax
}
  1401ff:	c3                   	retq   

0000000000140200 <strcpy>:
char* strcpy(char* dst, const char* src) {
  140200:	48 89 f8             	mov    %rdi,%rax
  140203:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  140208:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  14020c:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  14020f:	48 83 c2 01          	add    $0x1,%rdx
  140213:	84 c9                	test   %cl,%cl
  140215:	75 f1                	jne    140208 <strcpy+0x8>
}
  140217:	c3                   	retq   

0000000000140218 <strcmp>:
    while (*a && *b && *a == *b) {
  140218:	0f b6 07             	movzbl (%rdi),%eax
  14021b:	84 c0                	test   %al,%al
  14021d:	74 1a                	je     140239 <strcmp+0x21>
  14021f:	0f b6 16             	movzbl (%rsi),%edx
  140222:	38 c2                	cmp    %al,%dl
  140224:	75 13                	jne    140239 <strcmp+0x21>
  140226:	84 d2                	test   %dl,%dl
  140228:	74 0f                	je     140239 <strcmp+0x21>
        ++a, ++b;
  14022a:	48 83 c7 01          	add    $0x1,%rdi
  14022e:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  140232:	0f b6 07             	movzbl (%rdi),%eax
  140235:	84 c0                	test   %al,%al
  140237:	75 e6                	jne    14021f <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  140239:	3a 06                	cmp    (%rsi),%al
  14023b:	0f 97 c0             	seta   %al
  14023e:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  140241:	83 d8 00             	sbb    $0x0,%eax
}
  140244:	c3                   	retq   

0000000000140245 <strchr>:
    while (*s && *s != (char) c) {
  140245:	0f b6 07             	movzbl (%rdi),%eax
  140248:	84 c0                	test   %al,%al
  14024a:	74 10                	je     14025c <strchr+0x17>
  14024c:	40 38 f0             	cmp    %sil,%al
  14024f:	74 18                	je     140269 <strchr+0x24>
        ++s;
  140251:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  140255:	0f b6 07             	movzbl (%rdi),%eax
  140258:	84 c0                	test   %al,%al
  14025a:	75 f0                	jne    14024c <strchr+0x7>
        return NULL;
  14025c:	40 84 f6             	test   %sil,%sil
  14025f:	b8 00 00 00 00       	mov    $0x0,%eax
  140264:	48 0f 44 c7          	cmove  %rdi,%rax
}
  140268:	c3                   	retq   
  140269:	48 89 f8             	mov    %rdi,%rax
  14026c:	c3                   	retq   

000000000014026d <rand>:
    if (!rand_seed_set) {
  14026d:	83 3d a0 0d 00 00 00 	cmpl   $0x0,0xda0(%rip)        # 141014 <rand_seed_set>
  140274:	74 1b                	je     140291 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  140276:	69 05 90 0d 00 00 0d 	imul   $0x19660d,0xd90(%rip),%eax        # 141010 <rand_seed>
  14027d:	66 19 00 
  140280:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  140285:	89 05 85 0d 00 00    	mov    %eax,0xd85(%rip)        # 141010 <rand_seed>
    return rand_seed & RAND_MAX;
  14028b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  140290:	c3                   	retq   
    rand_seed = seed;
  140291:	c7 05 75 0d 00 00 9e 	movl   $0x30d4879e,0xd75(%rip)        # 141010 <rand_seed>
  140298:	87 d4 30 
    rand_seed_set = 1;
  14029b:	c7 05 6f 0d 00 00 01 	movl   $0x1,0xd6f(%rip)        # 141014 <rand_seed_set>
  1402a2:	00 00 00 
}
  1402a5:	eb cf                	jmp    140276 <rand+0x9>

00000000001402a7 <srand>:
    rand_seed = seed;
  1402a7:	89 3d 63 0d 00 00    	mov    %edi,0xd63(%rip)        # 141010 <rand_seed>
    rand_seed_set = 1;
  1402ad:	c7 05 5d 0d 00 00 01 	movl   $0x1,0xd5d(%rip)        # 141014 <rand_seed_set>
  1402b4:	00 00 00 
}
  1402b7:	c3                   	retq   

00000000001402b8 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1402b8:	55                   	push   %rbp
  1402b9:	48 89 e5             	mov    %rsp,%rbp
  1402bc:	41 57                	push   %r15
  1402be:	41 56                	push   %r14
  1402c0:	41 55                	push   %r13
  1402c2:	41 54                	push   %r12
  1402c4:	53                   	push   %rbx
  1402c5:	48 83 ec 58          	sub    $0x58,%rsp
  1402c9:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  1402cd:	0f b6 02             	movzbl (%rdx),%eax
  1402d0:	84 c0                	test   %al,%al
  1402d2:	0f 84 b0 06 00 00    	je     140988 <printer_vprintf+0x6d0>
  1402d8:	49 89 fe             	mov    %rdi,%r14
  1402db:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  1402de:	41 89 f7             	mov    %esi,%r15d
  1402e1:	e9 a4 04 00 00       	jmpq   14078a <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  1402e6:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  1402eb:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1402f1:	45 84 e4             	test   %r12b,%r12b
  1402f4:	0f 84 82 06 00 00    	je     14097c <printer_vprintf+0x6c4>
        int flags = 0;
  1402fa:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  140300:	41 0f be f4          	movsbl %r12b,%esi
  140304:	bf c1 0c 14 00       	mov    $0x140cc1,%edi
  140309:	e8 37 ff ff ff       	callq  140245 <strchr>
  14030e:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  140311:	48 85 c0             	test   %rax,%rax
  140314:	74 55                	je     14036b <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  140316:	48 81 e9 c1 0c 14 00 	sub    $0x140cc1,%rcx
  14031d:	b8 01 00 00 00       	mov    $0x1,%eax
  140322:	d3 e0                	shl    %cl,%eax
  140324:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  140327:	48 83 c3 01          	add    $0x1,%rbx
  14032b:	44 0f b6 23          	movzbl (%rbx),%r12d
  14032f:	45 84 e4             	test   %r12b,%r12b
  140332:	75 cc                	jne    140300 <printer_vprintf+0x48>
  140334:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  140338:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  14033e:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  140345:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  140348:	0f 84 a9 00 00 00    	je     1403f7 <printer_vprintf+0x13f>
        int length = 0;
  14034e:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  140353:	0f b6 13             	movzbl (%rbx),%edx
  140356:	8d 42 bd             	lea    -0x43(%rdx),%eax
  140359:	3c 37                	cmp    $0x37,%al
  14035b:	0f 87 c4 04 00 00    	ja     140825 <printer_vprintf+0x56d>
  140361:	0f b6 c0             	movzbl %al,%eax
  140364:	ff 24 c5 d0 0a 14 00 	jmpq   *0x140ad0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  14036b:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  14036f:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  140374:	3c 08                	cmp    $0x8,%al
  140376:	77 2f                	ja     1403a7 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  140378:	0f b6 03             	movzbl (%rbx),%eax
  14037b:	8d 50 d0             	lea    -0x30(%rax),%edx
  14037e:	80 fa 09             	cmp    $0x9,%dl
  140381:	77 5e                	ja     1403e1 <printer_vprintf+0x129>
  140383:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  140389:	48 83 c3 01          	add    $0x1,%rbx
  14038d:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  140392:	0f be c0             	movsbl %al,%eax
  140395:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  14039a:	0f b6 03             	movzbl (%rbx),%eax
  14039d:	8d 50 d0             	lea    -0x30(%rax),%edx
  1403a0:	80 fa 09             	cmp    $0x9,%dl
  1403a3:	76 e4                	jbe    140389 <printer_vprintf+0xd1>
  1403a5:	eb 97                	jmp    14033e <printer_vprintf+0x86>
        } else if (*format == '*') {
  1403a7:	41 80 fc 2a          	cmp    $0x2a,%r12b
  1403ab:	75 3f                	jne    1403ec <printer_vprintf+0x134>
            width = va_arg(val, int);
  1403ad:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1403b1:	8b 07                	mov    (%rdi),%eax
  1403b3:	83 f8 2f             	cmp    $0x2f,%eax
  1403b6:	77 17                	ja     1403cf <printer_vprintf+0x117>
  1403b8:	89 c2                	mov    %eax,%edx
  1403ba:	48 03 57 10          	add    0x10(%rdi),%rdx
  1403be:	83 c0 08             	add    $0x8,%eax
  1403c1:	89 07                	mov    %eax,(%rdi)
  1403c3:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  1403c6:	48 83 c3 01          	add    $0x1,%rbx
  1403ca:	e9 6f ff ff ff       	jmpq   14033e <printer_vprintf+0x86>
            width = va_arg(val, int);
  1403cf:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1403d3:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1403d7:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1403db:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1403df:	eb e2                	jmp    1403c3 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1403e1:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1403e7:	e9 52 ff ff ff       	jmpq   14033e <printer_vprintf+0x86>
        int width = -1;
  1403ec:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1403f2:	e9 47 ff ff ff       	jmpq   14033e <printer_vprintf+0x86>
            ++format;
  1403f7:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1403fb:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1403ff:	8d 48 d0             	lea    -0x30(%rax),%ecx
  140402:	80 f9 09             	cmp    $0x9,%cl
  140405:	76 13                	jbe    14041a <printer_vprintf+0x162>
            } else if (*format == '*') {
  140407:	3c 2a                	cmp    $0x2a,%al
  140409:	74 33                	je     14043e <printer_vprintf+0x186>
            ++format;
  14040b:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  14040e:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  140415:	e9 34 ff ff ff       	jmpq   14034e <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  14041a:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  14041f:	48 83 c2 01          	add    $0x1,%rdx
  140423:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  140426:	0f be c0             	movsbl %al,%eax
  140429:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  14042d:	0f b6 02             	movzbl (%rdx),%eax
  140430:	8d 70 d0             	lea    -0x30(%rax),%esi
  140433:	40 80 fe 09          	cmp    $0x9,%sil
  140437:	76 e6                	jbe    14041f <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  140439:	48 89 d3             	mov    %rdx,%rbx
  14043c:	eb 1c                	jmp    14045a <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  14043e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  140442:	8b 07                	mov    (%rdi),%eax
  140444:	83 f8 2f             	cmp    $0x2f,%eax
  140447:	77 23                	ja     14046c <printer_vprintf+0x1b4>
  140449:	89 c2                	mov    %eax,%edx
  14044b:	48 03 57 10          	add    0x10(%rdi),%rdx
  14044f:	83 c0 08             	add    $0x8,%eax
  140452:	89 07                	mov    %eax,(%rdi)
  140454:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  140456:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  14045a:	85 c9                	test   %ecx,%ecx
  14045c:	b8 00 00 00 00       	mov    $0x0,%eax
  140461:	0f 49 c1             	cmovns %ecx,%eax
  140464:	89 45 9c             	mov    %eax,-0x64(%rbp)
  140467:	e9 e2 fe ff ff       	jmpq   14034e <printer_vprintf+0x96>
                precision = va_arg(val, int);
  14046c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  140470:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  140474:	48 8d 42 08          	lea    0x8(%rdx),%rax
  140478:	48 89 41 08          	mov    %rax,0x8(%rcx)
  14047c:	eb d6                	jmp    140454 <printer_vprintf+0x19c>
        switch (*format) {
  14047e:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  140483:	e9 f3 00 00 00       	jmpq   14057b <printer_vprintf+0x2c3>
            ++format;
  140488:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  14048c:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  140491:	e9 bd fe ff ff       	jmpq   140353 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  140496:	85 c9                	test   %ecx,%ecx
  140498:	74 55                	je     1404ef <printer_vprintf+0x237>
  14049a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  14049e:	8b 07                	mov    (%rdi),%eax
  1404a0:	83 f8 2f             	cmp    $0x2f,%eax
  1404a3:	77 38                	ja     1404dd <printer_vprintf+0x225>
  1404a5:	89 c2                	mov    %eax,%edx
  1404a7:	48 03 57 10          	add    0x10(%rdi),%rdx
  1404ab:	83 c0 08             	add    $0x8,%eax
  1404ae:	89 07                	mov    %eax,(%rdi)
  1404b0:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1404b3:	48 89 d0             	mov    %rdx,%rax
  1404b6:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  1404ba:	49 89 d0             	mov    %rdx,%r8
  1404bd:	49 f7 d8             	neg    %r8
  1404c0:	25 80 00 00 00       	and    $0x80,%eax
  1404c5:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1404c9:	0b 45 a8             	or     -0x58(%rbp),%eax
  1404cc:	83 c8 60             	or     $0x60,%eax
  1404cf:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  1404d2:	41 bc c8 0a 14 00    	mov    $0x140ac8,%r12d
            break;
  1404d8:	e9 35 01 00 00       	jmpq   140612 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1404dd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1404e1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1404e5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1404e9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1404ed:	eb c1                	jmp    1404b0 <printer_vprintf+0x1f8>
  1404ef:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1404f3:	8b 07                	mov    (%rdi),%eax
  1404f5:	83 f8 2f             	cmp    $0x2f,%eax
  1404f8:	77 10                	ja     14050a <printer_vprintf+0x252>
  1404fa:	89 c2                	mov    %eax,%edx
  1404fc:	48 03 57 10          	add    0x10(%rdi),%rdx
  140500:	83 c0 08             	add    $0x8,%eax
  140503:	89 07                	mov    %eax,(%rdi)
  140505:	48 63 12             	movslq (%rdx),%rdx
  140508:	eb a9                	jmp    1404b3 <printer_vprintf+0x1fb>
  14050a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  14050e:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  140512:	48 8d 42 08          	lea    0x8(%rdx),%rax
  140516:	48 89 47 08          	mov    %rax,0x8(%rdi)
  14051a:	eb e9                	jmp    140505 <printer_vprintf+0x24d>
        int base = 10;
  14051c:	be 0a 00 00 00       	mov    $0xa,%esi
  140521:	eb 58                	jmp    14057b <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  140523:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  140527:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  14052b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  14052f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  140533:	eb 60                	jmp    140595 <printer_vprintf+0x2dd>
  140535:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  140539:	8b 07                	mov    (%rdi),%eax
  14053b:	83 f8 2f             	cmp    $0x2f,%eax
  14053e:	77 10                	ja     140550 <printer_vprintf+0x298>
  140540:	89 c2                	mov    %eax,%edx
  140542:	48 03 57 10          	add    0x10(%rdi),%rdx
  140546:	83 c0 08             	add    $0x8,%eax
  140549:	89 07                	mov    %eax,(%rdi)
  14054b:	44 8b 02             	mov    (%rdx),%r8d
  14054e:	eb 48                	jmp    140598 <printer_vprintf+0x2e0>
  140550:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  140554:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  140558:	48 8d 42 08          	lea    0x8(%rdx),%rax
  14055c:	48 89 41 08          	mov    %rax,0x8(%rcx)
  140560:	eb e9                	jmp    14054b <printer_vprintf+0x293>
  140562:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  140565:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  14056c:	bf b0 0c 14 00       	mov    $0x140cb0,%edi
  140571:	e9 e2 02 00 00       	jmpq   140858 <printer_vprintf+0x5a0>
            base = 16;
  140576:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  14057b:	85 c9                	test   %ecx,%ecx
  14057d:	74 b6                	je     140535 <printer_vprintf+0x27d>
  14057f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  140583:	8b 01                	mov    (%rcx),%eax
  140585:	83 f8 2f             	cmp    $0x2f,%eax
  140588:	77 99                	ja     140523 <printer_vprintf+0x26b>
  14058a:	89 c2                	mov    %eax,%edx
  14058c:	48 03 51 10          	add    0x10(%rcx),%rdx
  140590:	83 c0 08             	add    $0x8,%eax
  140593:	89 01                	mov    %eax,(%rcx)
  140595:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  140598:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  14059c:	85 f6                	test   %esi,%esi
  14059e:	79 c2                	jns    140562 <printer_vprintf+0x2aa>
        base = -base;
  1405a0:	41 89 f1             	mov    %esi,%r9d
  1405a3:	f7 de                	neg    %esi
  1405a5:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  1405ac:	bf 90 0c 14 00       	mov    $0x140c90,%edi
  1405b1:	e9 a2 02 00 00       	jmpq   140858 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  1405b6:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1405ba:	8b 07                	mov    (%rdi),%eax
  1405bc:	83 f8 2f             	cmp    $0x2f,%eax
  1405bf:	77 1c                	ja     1405dd <printer_vprintf+0x325>
  1405c1:	89 c2                	mov    %eax,%edx
  1405c3:	48 03 57 10          	add    0x10(%rdi),%rdx
  1405c7:	83 c0 08             	add    $0x8,%eax
  1405ca:	89 07                	mov    %eax,(%rdi)
  1405cc:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1405cf:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  1405d6:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1405db:	eb c3                	jmp    1405a0 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  1405dd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1405e1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1405e5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1405e9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1405ed:	eb dd                	jmp    1405cc <printer_vprintf+0x314>
            data = va_arg(val, char*);
  1405ef:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1405f3:	8b 01                	mov    (%rcx),%eax
  1405f5:	83 f8 2f             	cmp    $0x2f,%eax
  1405f8:	0f 87 a5 01 00 00    	ja     1407a3 <printer_vprintf+0x4eb>
  1405fe:	89 c2                	mov    %eax,%edx
  140600:	48 03 51 10          	add    0x10(%rcx),%rdx
  140604:	83 c0 08             	add    $0x8,%eax
  140607:	89 01                	mov    %eax,(%rcx)
  140609:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  14060c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  140612:	8b 45 a8             	mov    -0x58(%rbp),%eax
  140615:	83 e0 20             	and    $0x20,%eax
  140618:	89 45 8c             	mov    %eax,-0x74(%rbp)
  14061b:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  140621:	0f 85 21 02 00 00    	jne    140848 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  140627:	8b 45 a8             	mov    -0x58(%rbp),%eax
  14062a:	89 45 88             	mov    %eax,-0x78(%rbp)
  14062d:	83 e0 60             	and    $0x60,%eax
  140630:	83 f8 60             	cmp    $0x60,%eax
  140633:	0f 84 54 02 00 00    	je     14088d <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  140639:	8b 45 a8             	mov    -0x58(%rbp),%eax
  14063c:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  14063f:	48 c7 45 a0 c8 0a 14 	movq   $0x140ac8,-0x60(%rbp)
  140646:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  140647:	83 f8 21             	cmp    $0x21,%eax
  14064a:	0f 84 79 02 00 00    	je     1408c9 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  140650:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  140653:	89 f8                	mov    %edi,%eax
  140655:	f7 d0                	not    %eax
  140657:	c1 e8 1f             	shr    $0x1f,%eax
  14065a:	89 45 84             	mov    %eax,-0x7c(%rbp)
  14065d:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  140661:	0f 85 9e 02 00 00    	jne    140905 <printer_vprintf+0x64d>
  140667:	84 c0                	test   %al,%al
  140669:	0f 84 96 02 00 00    	je     140905 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  14066f:	48 63 f7             	movslq %edi,%rsi
  140672:	4c 89 e7             	mov    %r12,%rdi
  140675:	e8 63 fb ff ff       	callq  1401dd <strnlen>
  14067a:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  14067d:	8b 45 88             	mov    -0x78(%rbp),%eax
  140680:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  140683:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  14068a:	83 f8 22             	cmp    $0x22,%eax
  14068d:	0f 84 aa 02 00 00    	je     14093d <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  140693:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  140697:	e8 26 fb ff ff       	callq  1401c2 <strlen>
  14069c:	8b 55 9c             	mov    -0x64(%rbp),%edx
  14069f:	03 55 98             	add    -0x68(%rbp),%edx
  1406a2:	44 89 e9             	mov    %r13d,%ecx
  1406a5:	29 d1                	sub    %edx,%ecx
  1406a7:	29 c1                	sub    %eax,%ecx
  1406a9:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  1406ac:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1406af:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  1406b3:	75 2d                	jne    1406e2 <printer_vprintf+0x42a>
  1406b5:	85 c9                	test   %ecx,%ecx
  1406b7:	7e 29                	jle    1406e2 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  1406b9:	44 89 fa             	mov    %r15d,%edx
  1406bc:	be 20 00 00 00       	mov    $0x20,%esi
  1406c1:	4c 89 f7             	mov    %r14,%rdi
  1406c4:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1406c7:	41 83 ed 01          	sub    $0x1,%r13d
  1406cb:	45 85 ed             	test   %r13d,%r13d
  1406ce:	7f e9                	jg     1406b9 <printer_vprintf+0x401>
  1406d0:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  1406d3:	85 ff                	test   %edi,%edi
  1406d5:	b8 01 00 00 00       	mov    $0x1,%eax
  1406da:	0f 4f c7             	cmovg  %edi,%eax
  1406dd:	29 c7                	sub    %eax,%edi
  1406df:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  1406e2:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1406e6:	0f b6 07             	movzbl (%rdi),%eax
  1406e9:	84 c0                	test   %al,%al
  1406eb:	74 22                	je     14070f <printer_vprintf+0x457>
  1406ed:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1406f1:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  1406f4:	0f b6 f0             	movzbl %al,%esi
  1406f7:	44 89 fa             	mov    %r15d,%edx
  1406fa:	4c 89 f7             	mov    %r14,%rdi
  1406fd:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  140700:	48 83 c3 01          	add    $0x1,%rbx
  140704:	0f b6 03             	movzbl (%rbx),%eax
  140707:	84 c0                	test   %al,%al
  140709:	75 e9                	jne    1406f4 <printer_vprintf+0x43c>
  14070b:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  14070f:	8b 45 9c             	mov    -0x64(%rbp),%eax
  140712:	85 c0                	test   %eax,%eax
  140714:	7e 1d                	jle    140733 <printer_vprintf+0x47b>
  140716:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  14071a:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  14071c:	44 89 fa             	mov    %r15d,%edx
  14071f:	be 30 00 00 00       	mov    $0x30,%esi
  140724:	4c 89 f7             	mov    %r14,%rdi
  140727:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  14072a:	83 eb 01             	sub    $0x1,%ebx
  14072d:	75 ed                	jne    14071c <printer_vprintf+0x464>
  14072f:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  140733:	8b 45 98             	mov    -0x68(%rbp),%eax
  140736:	85 c0                	test   %eax,%eax
  140738:	7e 27                	jle    140761 <printer_vprintf+0x4a9>
  14073a:	89 c0                	mov    %eax,%eax
  14073c:	4c 01 e0             	add    %r12,%rax
  14073f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  140743:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  140746:	41 0f b6 34 24       	movzbl (%r12),%esi
  14074b:	44 89 fa             	mov    %r15d,%edx
  14074e:	4c 89 f7             	mov    %r14,%rdi
  140751:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  140754:	49 83 c4 01          	add    $0x1,%r12
  140758:	49 39 dc             	cmp    %rbx,%r12
  14075b:	75 e9                	jne    140746 <printer_vprintf+0x48e>
  14075d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  140761:	45 85 ed             	test   %r13d,%r13d
  140764:	7e 14                	jle    14077a <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  140766:	44 89 fa             	mov    %r15d,%edx
  140769:	be 20 00 00 00       	mov    $0x20,%esi
  14076e:	4c 89 f7             	mov    %r14,%rdi
  140771:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  140774:	41 83 ed 01          	sub    $0x1,%r13d
  140778:	75 ec                	jne    140766 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  14077a:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  14077e:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  140782:	84 c0                	test   %al,%al
  140784:	0f 84 fe 01 00 00    	je     140988 <printer_vprintf+0x6d0>
        if (*format != '%') {
  14078a:	3c 25                	cmp    $0x25,%al
  14078c:	0f 84 54 fb ff ff    	je     1402e6 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  140792:	0f b6 f0             	movzbl %al,%esi
  140795:	44 89 fa             	mov    %r15d,%edx
  140798:	4c 89 f7             	mov    %r14,%rdi
  14079b:	41 ff 16             	callq  *(%r14)
            continue;
  14079e:	4c 89 e3             	mov    %r12,%rbx
  1407a1:	eb d7                	jmp    14077a <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  1407a3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1407a7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1407ab:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1407af:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1407b3:	e9 51 fe ff ff       	jmpq   140609 <printer_vprintf+0x351>
            color = va_arg(val, int);
  1407b8:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1407bc:	8b 07                	mov    (%rdi),%eax
  1407be:	83 f8 2f             	cmp    $0x2f,%eax
  1407c1:	77 10                	ja     1407d3 <printer_vprintf+0x51b>
  1407c3:	89 c2                	mov    %eax,%edx
  1407c5:	48 03 57 10          	add    0x10(%rdi),%rdx
  1407c9:	83 c0 08             	add    $0x8,%eax
  1407cc:	89 07                	mov    %eax,(%rdi)
  1407ce:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  1407d1:	eb a7                	jmp    14077a <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  1407d3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1407d7:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1407db:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1407df:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1407e3:	eb e9                	jmp    1407ce <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  1407e5:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1407e9:	8b 01                	mov    (%rcx),%eax
  1407eb:	83 f8 2f             	cmp    $0x2f,%eax
  1407ee:	77 23                	ja     140813 <printer_vprintf+0x55b>
  1407f0:	89 c2                	mov    %eax,%edx
  1407f2:	48 03 51 10          	add    0x10(%rcx),%rdx
  1407f6:	83 c0 08             	add    $0x8,%eax
  1407f9:	89 01                	mov    %eax,(%rcx)
  1407fb:	8b 02                	mov    (%rdx),%eax
  1407fd:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  140800:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  140804:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  140808:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  14080e:	e9 ff fd ff ff       	jmpq   140612 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  140813:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  140817:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  14081b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  14081f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  140823:	eb d6                	jmp    1407fb <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  140825:	84 d2                	test   %dl,%dl
  140827:	0f 85 39 01 00 00    	jne    140966 <printer_vprintf+0x6ae>
  14082d:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  140831:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  140835:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  140839:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  14083d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  140843:	e9 ca fd ff ff       	jmpq   140612 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  140848:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  14084e:	bf b0 0c 14 00       	mov    $0x140cb0,%edi
        if (flags & FLAG_NUMERIC) {
  140853:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  140858:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  14085c:	4c 89 c1             	mov    %r8,%rcx
  14085f:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  140863:	48 63 f6             	movslq %esi,%rsi
  140866:	49 83 ec 01          	sub    $0x1,%r12
  14086a:	48 89 c8             	mov    %rcx,%rax
  14086d:	ba 00 00 00 00       	mov    $0x0,%edx
  140872:	48 f7 f6             	div    %rsi
  140875:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  140879:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  14087d:	48 89 ca             	mov    %rcx,%rdx
  140880:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  140883:	48 39 d6             	cmp    %rdx,%rsi
  140886:	76 de                	jbe    140866 <printer_vprintf+0x5ae>
  140888:	e9 9a fd ff ff       	jmpq   140627 <printer_vprintf+0x36f>
                prefix = "-";
  14088d:	48 c7 45 a0 c5 0a 14 	movq   $0x140ac5,-0x60(%rbp)
  140894:	00 
            if (flags & FLAG_NEGATIVE) {
  140895:	8b 45 a8             	mov    -0x58(%rbp),%eax
  140898:	a8 80                	test   $0x80,%al
  14089a:	0f 85 b0 fd ff ff    	jne    140650 <printer_vprintf+0x398>
                prefix = "+";
  1408a0:	48 c7 45 a0 c0 0a 14 	movq   $0x140ac0,-0x60(%rbp)
  1408a7:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1408a8:	a8 10                	test   $0x10,%al
  1408aa:	0f 85 a0 fd ff ff    	jne    140650 <printer_vprintf+0x398>
                prefix = " ";
  1408b0:	a8 08                	test   $0x8,%al
  1408b2:	ba c8 0a 14 00       	mov    $0x140ac8,%edx
  1408b7:	b8 c7 0a 14 00       	mov    $0x140ac7,%eax
  1408bc:	48 0f 44 c2          	cmove  %rdx,%rax
  1408c0:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1408c4:	e9 87 fd ff ff       	jmpq   140650 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  1408c9:	41 8d 41 10          	lea    0x10(%r9),%eax
  1408cd:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  1408d2:	0f 85 78 fd ff ff    	jne    140650 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  1408d8:	4d 85 c0             	test   %r8,%r8
  1408db:	75 0d                	jne    1408ea <printer_vprintf+0x632>
  1408dd:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  1408e4:	0f 84 66 fd ff ff    	je     140650 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  1408ea:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1408ee:	ba c9 0a 14 00       	mov    $0x140ac9,%edx
  1408f3:	b8 c2 0a 14 00       	mov    $0x140ac2,%eax
  1408f8:	48 0f 44 c2          	cmove  %rdx,%rax
  1408fc:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  140900:	e9 4b fd ff ff       	jmpq   140650 <printer_vprintf+0x398>
            len = strlen(data);
  140905:	4c 89 e7             	mov    %r12,%rdi
  140908:	e8 b5 f8 ff ff       	callq  1401c2 <strlen>
  14090d:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  140910:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  140914:	0f 84 63 fd ff ff    	je     14067d <printer_vprintf+0x3c5>
  14091a:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  14091e:	0f 84 59 fd ff ff    	je     14067d <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  140924:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  140927:	89 ca                	mov    %ecx,%edx
  140929:	29 c2                	sub    %eax,%edx
  14092b:	39 c1                	cmp    %eax,%ecx
  14092d:	b8 00 00 00 00       	mov    $0x0,%eax
  140932:	0f 4e d0             	cmovle %eax,%edx
  140935:	89 55 9c             	mov    %edx,-0x64(%rbp)
  140938:	e9 56 fd ff ff       	jmpq   140693 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  14093d:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  140941:	e8 7c f8 ff ff       	callq  1401c2 <strlen>
  140946:	8b 7d 98             	mov    -0x68(%rbp),%edi
  140949:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  14094c:	44 89 e9             	mov    %r13d,%ecx
  14094f:	29 f9                	sub    %edi,%ecx
  140951:	29 c1                	sub    %eax,%ecx
  140953:	44 39 ea             	cmp    %r13d,%edx
  140956:	b8 00 00 00 00       	mov    $0x0,%eax
  14095b:	0f 4d c8             	cmovge %eax,%ecx
  14095e:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  140961:	e9 2d fd ff ff       	jmpq   140693 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  140966:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  140969:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  14096d:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  140971:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  140977:	e9 96 fc ff ff       	jmpq   140612 <printer_vprintf+0x35a>
        int flags = 0;
  14097c:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  140983:	e9 b0 f9 ff ff       	jmpq   140338 <printer_vprintf+0x80>
}
  140988:	48 83 c4 58          	add    $0x58,%rsp
  14098c:	5b                   	pop    %rbx
  14098d:	41 5c                	pop    %r12
  14098f:	41 5d                	pop    %r13
  140991:	41 5e                	pop    %r14
  140993:	41 5f                	pop    %r15
  140995:	5d                   	pop    %rbp
  140996:	c3                   	retq   

0000000000140997 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  140997:	55                   	push   %rbp
  140998:	48 89 e5             	mov    %rsp,%rbp
  14099b:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  14099f:	48 c7 45 f0 a2 00 14 	movq   $0x1400a2,-0x10(%rbp)
  1409a6:	00 
        cpos = 0;
  1409a7:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  1409ad:	b8 00 00 00 00       	mov    $0x0,%eax
  1409b2:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  1409b5:	48 63 ff             	movslq %edi,%rdi
  1409b8:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  1409bf:	00 
  1409c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1409c4:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  1409c8:	e8 eb f8 ff ff       	callq  1402b8 <printer_vprintf>
    return cp.cursor - console;
  1409cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1409d1:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1409d7:	48 d1 f8             	sar    %rax
}
  1409da:	c9                   	leaveq 
  1409db:	c3                   	retq   

00000000001409dc <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  1409dc:	55                   	push   %rbp
  1409dd:	48 89 e5             	mov    %rsp,%rbp
  1409e0:	48 83 ec 50          	sub    $0x50,%rsp
  1409e4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1409e8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1409ec:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  1409f0:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1409f7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1409fb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1409ff:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  140a03:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  140a07:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  140a0b:	e8 87 ff ff ff       	callq  140997 <console_vprintf>
}
  140a10:	c9                   	leaveq 
  140a11:	c3                   	retq   

0000000000140a12 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  140a12:	55                   	push   %rbp
  140a13:	48 89 e5             	mov    %rsp,%rbp
  140a16:	53                   	push   %rbx
  140a17:	48 83 ec 28          	sub    $0x28,%rsp
  140a1b:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  140a1e:	48 c7 45 d8 28 01 14 	movq   $0x140128,-0x28(%rbp)
  140a25:	00 
    sp.s = s;
  140a26:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  140a2a:	48 85 f6             	test   %rsi,%rsi
  140a2d:	75 0b                	jne    140a3a <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  140a2f:	8b 45 e0             	mov    -0x20(%rbp),%eax
  140a32:	29 d8                	sub    %ebx,%eax
}
  140a34:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  140a38:	c9                   	leaveq 
  140a39:	c3                   	retq   
        sp.end = s + size - 1;
  140a3a:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  140a3f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  140a43:	be 00 00 00 00       	mov    $0x0,%esi
  140a48:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  140a4c:	e8 67 f8 ff ff       	callq  1402b8 <printer_vprintf>
        *sp.s = 0;
  140a51:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  140a55:	c6 00 00             	movb   $0x0,(%rax)
  140a58:	eb d5                	jmp    140a2f <vsnprintf+0x1d>

0000000000140a5a <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  140a5a:	55                   	push   %rbp
  140a5b:	48 89 e5             	mov    %rsp,%rbp
  140a5e:	48 83 ec 50          	sub    $0x50,%rsp
  140a62:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  140a66:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  140a6a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  140a6e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  140a75:	48 8d 45 10          	lea    0x10(%rbp),%rax
  140a79:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  140a7d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  140a81:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  140a85:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  140a89:	e8 84 ff ff ff       	callq  140a12 <vsnprintf>
    va_end(val);
    return n;
}
  140a8e:	c9                   	leaveq 
  140a8f:	c3                   	retq   

0000000000140a90 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  140a90:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  140a95:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  140a9a:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  140a9f:	48 83 c0 02          	add    $0x2,%rax
  140aa3:	48 39 d0             	cmp    %rdx,%rax
  140aa6:	75 f2                	jne    140a9a <console_clear+0xa>
    }
    cursorpos = 0;
  140aa8:	c7 05 4a 85 f7 ff 00 	movl   $0x0,-0x87ab6(%rip)        # b8ffc <cursorpos>
  140aaf:	00 00 00 
}
  140ab2:	c3                   	retq   

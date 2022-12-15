
obj/p-malloc.full:     file format elf64-x86-64


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

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 37 30 10 00       	mov    $0x103037,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 e9 1f 00 00 	mov    %rax,0x1fe9(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 cd 1f 00 00 	mov    %rax,0x1fcd(%rip)        # 102000 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 00 02 00 00       	callq  10023c <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 f0 0f 00 00       	callq  101054 <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100071:	48 89 f9             	mov    %rdi,%rcx
  100074:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100076:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  10007d:	00 
  10007e:	72 08                	jb     100088 <console_putc+0x17>
        cp->cursor = console;
  100080:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  100087:	00 
    }
    if (c == '\n') {
  100088:	40 80 fe 0a          	cmp    $0xa,%sil
  10008c:	74 16                	je     1000a4 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  10008e:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100092:	48 8d 50 02          	lea    0x2(%rax),%rdx
  100096:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  10009a:	40 0f b6 f6          	movzbl %sil,%esi
  10009e:	09 fe                	or     %edi,%esi
  1000a0:	66 89 30             	mov    %si,(%rax)
    }
}
  1000a3:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  1000a4:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  1000a8:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  1000af:	4c 89 c6             	mov    %r8,%rsi
  1000b2:	48 d1 fe             	sar    %rsi
  1000b5:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1000bc:	66 66 66 
  1000bf:	48 89 f0             	mov    %rsi,%rax
  1000c2:	48 f7 ea             	imul   %rdx
  1000c5:	48 c1 fa 05          	sar    $0x5,%rdx
  1000c9:	49 c1 f8 3f          	sar    $0x3f,%r8
  1000cd:	4c 29 c2             	sub    %r8,%rdx
  1000d0:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  1000d4:	48 c1 e2 04          	shl    $0x4,%rdx
  1000d8:	89 f0                	mov    %esi,%eax
  1000da:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1000dc:	83 cf 20             	or     $0x20,%edi
  1000df:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1000e3:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  1000e7:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1000eb:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  1000ee:	83 c0 01             	add    $0x1,%eax
  1000f1:	83 f8 50             	cmp    $0x50,%eax
  1000f4:	75 e9                	jne    1000df <console_putc+0x6e>
  1000f6:	c3                   	retq   

00000000001000f7 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1000f7:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1000fb:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1000ff:	73 0b                	jae    10010c <string_putc+0x15>
        *sp->s++ = c;
  100101:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100105:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  100109:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  10010c:	c3                   	retq   

000000000010010d <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  10010d:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100110:	48 85 d2             	test   %rdx,%rdx
  100113:	74 17                	je     10012c <memcpy+0x1f>
  100115:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  10011a:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  10011f:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100123:	48 83 c1 01          	add    $0x1,%rcx
  100127:	48 39 d1             	cmp    %rdx,%rcx
  10012a:	75 ee                	jne    10011a <memcpy+0xd>
}
  10012c:	c3                   	retq   

000000000010012d <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  10012d:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  100130:	48 39 fe             	cmp    %rdi,%rsi
  100133:	72 1d                	jb     100152 <memmove+0x25>
        while (n-- > 0) {
  100135:	b9 00 00 00 00       	mov    $0x0,%ecx
  10013a:	48 85 d2             	test   %rdx,%rdx
  10013d:	74 12                	je     100151 <memmove+0x24>
            *d++ = *s++;
  10013f:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  100143:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  100147:	48 83 c1 01          	add    $0x1,%rcx
  10014b:	48 39 ca             	cmp    %rcx,%rdx
  10014e:	75 ef                	jne    10013f <memmove+0x12>
}
  100150:	c3                   	retq   
  100151:	c3                   	retq   
    if (s < d && s + n > d) {
  100152:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  100156:	48 39 cf             	cmp    %rcx,%rdi
  100159:	73 da                	jae    100135 <memmove+0x8>
        while (n-- > 0) {
  10015b:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  10015f:	48 85 d2             	test   %rdx,%rdx
  100162:	74 ec                	je     100150 <memmove+0x23>
            *--d = *--s;
  100164:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  100168:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  10016b:	48 83 e9 01          	sub    $0x1,%rcx
  10016f:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  100173:	75 ef                	jne    100164 <memmove+0x37>
  100175:	c3                   	retq   

0000000000100176 <memset>:
void* memset(void* v, int c, size_t n) {
  100176:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100179:	48 85 d2             	test   %rdx,%rdx
  10017c:	74 12                	je     100190 <memset+0x1a>
  10017e:	48 01 fa             	add    %rdi,%rdx
  100181:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  100184:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100187:	48 83 c1 01          	add    $0x1,%rcx
  10018b:	48 39 ca             	cmp    %rcx,%rdx
  10018e:	75 f4                	jne    100184 <memset+0xe>
}
  100190:	c3                   	retq   

0000000000100191 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100191:	80 3f 00             	cmpb   $0x0,(%rdi)
  100194:	74 10                	je     1001a6 <strlen+0x15>
  100196:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  10019b:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  10019f:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1001a3:	75 f6                	jne    10019b <strlen+0xa>
  1001a5:	c3                   	retq   
  1001a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1001ab:	c3                   	retq   

00000000001001ac <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  1001ac:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001af:	ba 00 00 00 00       	mov    $0x0,%edx
  1001b4:	48 85 f6             	test   %rsi,%rsi
  1001b7:	74 11                	je     1001ca <strnlen+0x1e>
  1001b9:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  1001bd:	74 0c                	je     1001cb <strnlen+0x1f>
        ++n;
  1001bf:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001c3:	48 39 d0             	cmp    %rdx,%rax
  1001c6:	75 f1                	jne    1001b9 <strnlen+0xd>
  1001c8:	eb 04                	jmp    1001ce <strnlen+0x22>
  1001ca:	c3                   	retq   
  1001cb:	48 89 d0             	mov    %rdx,%rax
}
  1001ce:	c3                   	retq   

00000000001001cf <strcpy>:
char* strcpy(char* dst, const char* src) {
  1001cf:	48 89 f8             	mov    %rdi,%rax
  1001d2:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  1001d7:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1001db:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1001de:	48 83 c2 01          	add    $0x1,%rdx
  1001e2:	84 c9                	test   %cl,%cl
  1001e4:	75 f1                	jne    1001d7 <strcpy+0x8>
}
  1001e6:	c3                   	retq   

00000000001001e7 <strcmp>:
    while (*a && *b && *a == *b) {
  1001e7:	0f b6 07             	movzbl (%rdi),%eax
  1001ea:	84 c0                	test   %al,%al
  1001ec:	74 1a                	je     100208 <strcmp+0x21>
  1001ee:	0f b6 16             	movzbl (%rsi),%edx
  1001f1:	38 c2                	cmp    %al,%dl
  1001f3:	75 13                	jne    100208 <strcmp+0x21>
  1001f5:	84 d2                	test   %dl,%dl
  1001f7:	74 0f                	je     100208 <strcmp+0x21>
        ++a, ++b;
  1001f9:	48 83 c7 01          	add    $0x1,%rdi
  1001fd:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  100201:	0f b6 07             	movzbl (%rdi),%eax
  100204:	84 c0                	test   %al,%al
  100206:	75 e6                	jne    1001ee <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  100208:	3a 06                	cmp    (%rsi),%al
  10020a:	0f 97 c0             	seta   %al
  10020d:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  100210:	83 d8 00             	sbb    $0x0,%eax
}
  100213:	c3                   	retq   

0000000000100214 <strchr>:
    while (*s && *s != (char) c) {
  100214:	0f b6 07             	movzbl (%rdi),%eax
  100217:	84 c0                	test   %al,%al
  100219:	74 10                	je     10022b <strchr+0x17>
  10021b:	40 38 f0             	cmp    %sil,%al
  10021e:	74 18                	je     100238 <strchr+0x24>
        ++s;
  100220:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  100224:	0f b6 07             	movzbl (%rdi),%eax
  100227:	84 c0                	test   %al,%al
  100229:	75 f0                	jne    10021b <strchr+0x7>
        return NULL;
  10022b:	40 84 f6             	test   %sil,%sil
  10022e:	b8 00 00 00 00       	mov    $0x0,%eax
  100233:	48 0f 44 c7          	cmove  %rdi,%rax
}
  100237:	c3                   	retq   
  100238:	48 89 f8             	mov    %rdi,%rax
  10023b:	c3                   	retq   

000000000010023c <rand>:
    if (!rand_seed_set) {
  10023c:	83 3d d1 1d 00 00 00 	cmpl   $0x0,0x1dd1(%rip)        # 102014 <rand_seed_set>
  100243:	74 1b                	je     100260 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100245:	69 05 c1 1d 00 00 0d 	imul   $0x19660d,0x1dc1(%rip),%eax        # 102010 <rand_seed>
  10024c:	66 19 00 
  10024f:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100254:	89 05 b6 1d 00 00    	mov    %eax,0x1db6(%rip)        # 102010 <rand_seed>
    return rand_seed & RAND_MAX;
  10025a:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10025f:	c3                   	retq   
    rand_seed = seed;
  100260:	c7 05 a6 1d 00 00 9e 	movl   $0x30d4879e,0x1da6(%rip)        # 102010 <rand_seed>
  100267:	87 d4 30 
    rand_seed_set = 1;
  10026a:	c7 05 a0 1d 00 00 01 	movl   $0x1,0x1da0(%rip)        # 102014 <rand_seed_set>
  100271:	00 00 00 
}
  100274:	eb cf                	jmp    100245 <rand+0x9>

0000000000100276 <srand>:
    rand_seed = seed;
  100276:	89 3d 94 1d 00 00    	mov    %edi,0x1d94(%rip)        # 102010 <rand_seed>
    rand_seed_set = 1;
  10027c:	c7 05 8e 1d 00 00 01 	movl   $0x1,0x1d8e(%rip)        # 102014 <rand_seed_set>
  100283:	00 00 00 
}
  100286:	c3                   	retq   

0000000000100287 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100287:	55                   	push   %rbp
  100288:	48 89 e5             	mov    %rsp,%rbp
  10028b:	41 57                	push   %r15
  10028d:	41 56                	push   %r14
  10028f:	41 55                	push   %r13
  100291:	41 54                	push   %r12
  100293:	53                   	push   %rbx
  100294:	48 83 ec 58          	sub    $0x58,%rsp
  100298:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  10029c:	0f b6 02             	movzbl (%rdx),%eax
  10029f:	84 c0                	test   %al,%al
  1002a1:	0f 84 b0 06 00 00    	je     100957 <printer_vprintf+0x6d0>
  1002a7:	49 89 fe             	mov    %rdi,%r14
  1002aa:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  1002ad:	41 89 f7             	mov    %esi,%r15d
  1002b0:	e9 a4 04 00 00       	jmpq   100759 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  1002b5:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  1002ba:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1002c0:	45 84 e4             	test   %r12b,%r12b
  1002c3:	0f 84 82 06 00 00    	je     10094b <printer_vprintf+0x6c4>
        int flags = 0;
  1002c9:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  1002cf:	41 0f be f4          	movsbl %r12b,%esi
  1002d3:	bf b1 15 10 00       	mov    $0x1015b1,%edi
  1002d8:	e8 37 ff ff ff       	callq  100214 <strchr>
  1002dd:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1002e0:	48 85 c0             	test   %rax,%rax
  1002e3:	74 55                	je     10033a <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  1002e5:	48 81 e9 b1 15 10 00 	sub    $0x1015b1,%rcx
  1002ec:	b8 01 00 00 00       	mov    $0x1,%eax
  1002f1:	d3 e0                	shl    %cl,%eax
  1002f3:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1002f6:	48 83 c3 01          	add    $0x1,%rbx
  1002fa:	44 0f b6 23          	movzbl (%rbx),%r12d
  1002fe:	45 84 e4             	test   %r12b,%r12b
  100301:	75 cc                	jne    1002cf <printer_vprintf+0x48>
  100303:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  100307:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  10030d:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  100314:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  100317:	0f 84 a9 00 00 00    	je     1003c6 <printer_vprintf+0x13f>
        int length = 0;
  10031d:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  100322:	0f b6 13             	movzbl (%rbx),%edx
  100325:	8d 42 bd             	lea    -0x43(%rdx),%eax
  100328:	3c 37                	cmp    $0x37,%al
  10032a:	0f 87 c4 04 00 00    	ja     1007f4 <printer_vprintf+0x56d>
  100330:	0f b6 c0             	movzbl %al,%eax
  100333:	ff 24 c5 c0 13 10 00 	jmpq   *0x1013c0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  10033a:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  10033e:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  100343:	3c 08                	cmp    $0x8,%al
  100345:	77 2f                	ja     100376 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100347:	0f b6 03             	movzbl (%rbx),%eax
  10034a:	8d 50 d0             	lea    -0x30(%rax),%edx
  10034d:	80 fa 09             	cmp    $0x9,%dl
  100350:	77 5e                	ja     1003b0 <printer_vprintf+0x129>
  100352:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  100358:	48 83 c3 01          	add    $0x1,%rbx
  10035c:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100361:	0f be c0             	movsbl %al,%eax
  100364:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100369:	0f b6 03             	movzbl (%rbx),%eax
  10036c:	8d 50 d0             	lea    -0x30(%rax),%edx
  10036f:	80 fa 09             	cmp    $0x9,%dl
  100372:	76 e4                	jbe    100358 <printer_vprintf+0xd1>
  100374:	eb 97                	jmp    10030d <printer_vprintf+0x86>
        } else if (*format == '*') {
  100376:	41 80 fc 2a          	cmp    $0x2a,%r12b
  10037a:	75 3f                	jne    1003bb <printer_vprintf+0x134>
            width = va_arg(val, int);
  10037c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100380:	8b 07                	mov    (%rdi),%eax
  100382:	83 f8 2f             	cmp    $0x2f,%eax
  100385:	77 17                	ja     10039e <printer_vprintf+0x117>
  100387:	89 c2                	mov    %eax,%edx
  100389:	48 03 57 10          	add    0x10(%rdi),%rdx
  10038d:	83 c0 08             	add    $0x8,%eax
  100390:	89 07                	mov    %eax,(%rdi)
  100392:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  100395:	48 83 c3 01          	add    $0x1,%rbx
  100399:	e9 6f ff ff ff       	jmpq   10030d <printer_vprintf+0x86>
            width = va_arg(val, int);
  10039e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1003a2:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1003a6:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1003aa:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1003ae:	eb e2                	jmp    100392 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003b0:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1003b6:	e9 52 ff ff ff       	jmpq   10030d <printer_vprintf+0x86>
        int width = -1;
  1003bb:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1003c1:	e9 47 ff ff ff       	jmpq   10030d <printer_vprintf+0x86>
            ++format;
  1003c6:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1003ca:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1003ce:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1003d1:	80 f9 09             	cmp    $0x9,%cl
  1003d4:	76 13                	jbe    1003e9 <printer_vprintf+0x162>
            } else if (*format == '*') {
  1003d6:	3c 2a                	cmp    $0x2a,%al
  1003d8:	74 33                	je     10040d <printer_vprintf+0x186>
            ++format;
  1003da:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1003dd:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1003e4:	e9 34 ff ff ff       	jmpq   10031d <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1003e9:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  1003ee:	48 83 c2 01          	add    $0x1,%rdx
  1003f2:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  1003f5:	0f be c0             	movsbl %al,%eax
  1003f8:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1003fc:	0f b6 02             	movzbl (%rdx),%eax
  1003ff:	8d 70 d0             	lea    -0x30(%rax),%esi
  100402:	40 80 fe 09          	cmp    $0x9,%sil
  100406:	76 e6                	jbe    1003ee <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  100408:	48 89 d3             	mov    %rdx,%rbx
  10040b:	eb 1c                	jmp    100429 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  10040d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100411:	8b 07                	mov    (%rdi),%eax
  100413:	83 f8 2f             	cmp    $0x2f,%eax
  100416:	77 23                	ja     10043b <printer_vprintf+0x1b4>
  100418:	89 c2                	mov    %eax,%edx
  10041a:	48 03 57 10          	add    0x10(%rdi),%rdx
  10041e:	83 c0 08             	add    $0x8,%eax
  100421:	89 07                	mov    %eax,(%rdi)
  100423:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  100425:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  100429:	85 c9                	test   %ecx,%ecx
  10042b:	b8 00 00 00 00       	mov    $0x0,%eax
  100430:	0f 49 c1             	cmovns %ecx,%eax
  100433:	89 45 9c             	mov    %eax,-0x64(%rbp)
  100436:	e9 e2 fe ff ff       	jmpq   10031d <printer_vprintf+0x96>
                precision = va_arg(val, int);
  10043b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10043f:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100443:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100447:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10044b:	eb d6                	jmp    100423 <printer_vprintf+0x19c>
        switch (*format) {
  10044d:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100452:	e9 f3 00 00 00       	jmpq   10054a <printer_vprintf+0x2c3>
            ++format;
  100457:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  10045b:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100460:	e9 bd fe ff ff       	jmpq   100322 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100465:	85 c9                	test   %ecx,%ecx
  100467:	74 55                	je     1004be <printer_vprintf+0x237>
  100469:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10046d:	8b 07                	mov    (%rdi),%eax
  10046f:	83 f8 2f             	cmp    $0x2f,%eax
  100472:	77 38                	ja     1004ac <printer_vprintf+0x225>
  100474:	89 c2                	mov    %eax,%edx
  100476:	48 03 57 10          	add    0x10(%rdi),%rdx
  10047a:	83 c0 08             	add    $0x8,%eax
  10047d:	89 07                	mov    %eax,(%rdi)
  10047f:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100482:	48 89 d0             	mov    %rdx,%rax
  100485:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  100489:	49 89 d0             	mov    %rdx,%r8
  10048c:	49 f7 d8             	neg    %r8
  10048f:	25 80 00 00 00       	and    $0x80,%eax
  100494:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100498:	0b 45 a8             	or     -0x58(%rbp),%eax
  10049b:	83 c8 60             	or     $0x60,%eax
  10049e:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  1004a1:	41 bc b8 13 10 00    	mov    $0x1013b8,%r12d
            break;
  1004a7:	e9 35 01 00 00       	jmpq   1005e1 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1004ac:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004b0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004b4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004b8:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1004bc:	eb c1                	jmp    10047f <printer_vprintf+0x1f8>
  1004be:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004c2:	8b 07                	mov    (%rdi),%eax
  1004c4:	83 f8 2f             	cmp    $0x2f,%eax
  1004c7:	77 10                	ja     1004d9 <printer_vprintf+0x252>
  1004c9:	89 c2                	mov    %eax,%edx
  1004cb:	48 03 57 10          	add    0x10(%rdi),%rdx
  1004cf:	83 c0 08             	add    $0x8,%eax
  1004d2:	89 07                	mov    %eax,(%rdi)
  1004d4:	48 63 12             	movslq (%rdx),%rdx
  1004d7:	eb a9                	jmp    100482 <printer_vprintf+0x1fb>
  1004d9:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004dd:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1004e1:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004e5:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1004e9:	eb e9                	jmp    1004d4 <printer_vprintf+0x24d>
        int base = 10;
  1004eb:	be 0a 00 00 00       	mov    $0xa,%esi
  1004f0:	eb 58                	jmp    10054a <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1004f2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004f6:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004fa:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004fe:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100502:	eb 60                	jmp    100564 <printer_vprintf+0x2dd>
  100504:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100508:	8b 07                	mov    (%rdi),%eax
  10050a:	83 f8 2f             	cmp    $0x2f,%eax
  10050d:	77 10                	ja     10051f <printer_vprintf+0x298>
  10050f:	89 c2                	mov    %eax,%edx
  100511:	48 03 57 10          	add    0x10(%rdi),%rdx
  100515:	83 c0 08             	add    $0x8,%eax
  100518:	89 07                	mov    %eax,(%rdi)
  10051a:	44 8b 02             	mov    (%rdx),%r8d
  10051d:	eb 48                	jmp    100567 <printer_vprintf+0x2e0>
  10051f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100523:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100527:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10052b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10052f:	eb e9                	jmp    10051a <printer_vprintf+0x293>
  100531:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  100534:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  10053b:	bf a0 15 10 00       	mov    $0x1015a0,%edi
  100540:	e9 e2 02 00 00       	jmpq   100827 <printer_vprintf+0x5a0>
            base = 16;
  100545:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10054a:	85 c9                	test   %ecx,%ecx
  10054c:	74 b6                	je     100504 <printer_vprintf+0x27d>
  10054e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100552:	8b 01                	mov    (%rcx),%eax
  100554:	83 f8 2f             	cmp    $0x2f,%eax
  100557:	77 99                	ja     1004f2 <printer_vprintf+0x26b>
  100559:	89 c2                	mov    %eax,%edx
  10055b:	48 03 51 10          	add    0x10(%rcx),%rdx
  10055f:	83 c0 08             	add    $0x8,%eax
  100562:	89 01                	mov    %eax,(%rcx)
  100564:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  100567:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  10056b:	85 f6                	test   %esi,%esi
  10056d:	79 c2                	jns    100531 <printer_vprintf+0x2aa>
        base = -base;
  10056f:	41 89 f1             	mov    %esi,%r9d
  100572:	f7 de                	neg    %esi
  100574:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  10057b:	bf 80 15 10 00       	mov    $0x101580,%edi
  100580:	e9 a2 02 00 00       	jmpq   100827 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  100585:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100589:	8b 07                	mov    (%rdi),%eax
  10058b:	83 f8 2f             	cmp    $0x2f,%eax
  10058e:	77 1c                	ja     1005ac <printer_vprintf+0x325>
  100590:	89 c2                	mov    %eax,%edx
  100592:	48 03 57 10          	add    0x10(%rdi),%rdx
  100596:	83 c0 08             	add    $0x8,%eax
  100599:	89 07                	mov    %eax,(%rdi)
  10059b:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  10059e:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  1005a5:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1005aa:	eb c3                	jmp    10056f <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  1005ac:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005b0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005b4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005b8:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005bc:	eb dd                	jmp    10059b <printer_vprintf+0x314>
            data = va_arg(val, char*);
  1005be:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005c2:	8b 01                	mov    (%rcx),%eax
  1005c4:	83 f8 2f             	cmp    $0x2f,%eax
  1005c7:	0f 87 a5 01 00 00    	ja     100772 <printer_vprintf+0x4eb>
  1005cd:	89 c2                	mov    %eax,%edx
  1005cf:	48 03 51 10          	add    0x10(%rcx),%rdx
  1005d3:	83 c0 08             	add    $0x8,%eax
  1005d6:	89 01                	mov    %eax,(%rcx)
  1005d8:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1005db:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1005e1:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1005e4:	83 e0 20             	and    $0x20,%eax
  1005e7:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1005ea:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1005f0:	0f 85 21 02 00 00    	jne    100817 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1005f6:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1005f9:	89 45 88             	mov    %eax,-0x78(%rbp)
  1005fc:	83 e0 60             	and    $0x60,%eax
  1005ff:	83 f8 60             	cmp    $0x60,%eax
  100602:	0f 84 54 02 00 00    	je     10085c <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100608:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10060b:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  10060e:	48 c7 45 a0 b8 13 10 	movq   $0x1013b8,-0x60(%rbp)
  100615:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100616:	83 f8 21             	cmp    $0x21,%eax
  100619:	0f 84 79 02 00 00    	je     100898 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  10061f:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  100622:	89 f8                	mov    %edi,%eax
  100624:	f7 d0                	not    %eax
  100626:	c1 e8 1f             	shr    $0x1f,%eax
  100629:	89 45 84             	mov    %eax,-0x7c(%rbp)
  10062c:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100630:	0f 85 9e 02 00 00    	jne    1008d4 <printer_vprintf+0x64d>
  100636:	84 c0                	test   %al,%al
  100638:	0f 84 96 02 00 00    	je     1008d4 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  10063e:	48 63 f7             	movslq %edi,%rsi
  100641:	4c 89 e7             	mov    %r12,%rdi
  100644:	e8 63 fb ff ff       	callq  1001ac <strnlen>
  100649:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  10064c:	8b 45 88             	mov    -0x78(%rbp),%eax
  10064f:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  100652:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100659:	83 f8 22             	cmp    $0x22,%eax
  10065c:	0f 84 aa 02 00 00    	je     10090c <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100662:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100666:	e8 26 fb ff ff       	callq  100191 <strlen>
  10066b:	8b 55 9c             	mov    -0x64(%rbp),%edx
  10066e:	03 55 98             	add    -0x68(%rbp),%edx
  100671:	44 89 e9             	mov    %r13d,%ecx
  100674:	29 d1                	sub    %edx,%ecx
  100676:	29 c1                	sub    %eax,%ecx
  100678:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  10067b:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10067e:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100682:	75 2d                	jne    1006b1 <printer_vprintf+0x42a>
  100684:	85 c9                	test   %ecx,%ecx
  100686:	7e 29                	jle    1006b1 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  100688:	44 89 fa             	mov    %r15d,%edx
  10068b:	be 20 00 00 00       	mov    $0x20,%esi
  100690:	4c 89 f7             	mov    %r14,%rdi
  100693:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100696:	41 83 ed 01          	sub    $0x1,%r13d
  10069a:	45 85 ed             	test   %r13d,%r13d
  10069d:	7f e9                	jg     100688 <printer_vprintf+0x401>
  10069f:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  1006a2:	85 ff                	test   %edi,%edi
  1006a4:	b8 01 00 00 00       	mov    $0x1,%eax
  1006a9:	0f 4f c7             	cmovg  %edi,%eax
  1006ac:	29 c7                	sub    %eax,%edi
  1006ae:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  1006b1:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1006b5:	0f b6 07             	movzbl (%rdi),%eax
  1006b8:	84 c0                	test   %al,%al
  1006ba:	74 22                	je     1006de <printer_vprintf+0x457>
  1006bc:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1006c0:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  1006c3:	0f b6 f0             	movzbl %al,%esi
  1006c6:	44 89 fa             	mov    %r15d,%edx
  1006c9:	4c 89 f7             	mov    %r14,%rdi
  1006cc:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  1006cf:	48 83 c3 01          	add    $0x1,%rbx
  1006d3:	0f b6 03             	movzbl (%rbx),%eax
  1006d6:	84 c0                	test   %al,%al
  1006d8:	75 e9                	jne    1006c3 <printer_vprintf+0x43c>
  1006da:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1006de:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1006e1:	85 c0                	test   %eax,%eax
  1006e3:	7e 1d                	jle    100702 <printer_vprintf+0x47b>
  1006e5:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1006e9:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1006eb:	44 89 fa             	mov    %r15d,%edx
  1006ee:	be 30 00 00 00       	mov    $0x30,%esi
  1006f3:	4c 89 f7             	mov    %r14,%rdi
  1006f6:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  1006f9:	83 eb 01             	sub    $0x1,%ebx
  1006fc:	75 ed                	jne    1006eb <printer_vprintf+0x464>
  1006fe:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  100702:	8b 45 98             	mov    -0x68(%rbp),%eax
  100705:	85 c0                	test   %eax,%eax
  100707:	7e 27                	jle    100730 <printer_vprintf+0x4a9>
  100709:	89 c0                	mov    %eax,%eax
  10070b:	4c 01 e0             	add    %r12,%rax
  10070e:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100712:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  100715:	41 0f b6 34 24       	movzbl (%r12),%esi
  10071a:	44 89 fa             	mov    %r15d,%edx
  10071d:	4c 89 f7             	mov    %r14,%rdi
  100720:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  100723:	49 83 c4 01          	add    $0x1,%r12
  100727:	49 39 dc             	cmp    %rbx,%r12
  10072a:	75 e9                	jne    100715 <printer_vprintf+0x48e>
  10072c:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  100730:	45 85 ed             	test   %r13d,%r13d
  100733:	7e 14                	jle    100749 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  100735:	44 89 fa             	mov    %r15d,%edx
  100738:	be 20 00 00 00       	mov    $0x20,%esi
  10073d:	4c 89 f7             	mov    %r14,%rdi
  100740:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  100743:	41 83 ed 01          	sub    $0x1,%r13d
  100747:	75 ec                	jne    100735 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  100749:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  10074d:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100751:	84 c0                	test   %al,%al
  100753:	0f 84 fe 01 00 00    	je     100957 <printer_vprintf+0x6d0>
        if (*format != '%') {
  100759:	3c 25                	cmp    $0x25,%al
  10075b:	0f 84 54 fb ff ff    	je     1002b5 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100761:	0f b6 f0             	movzbl %al,%esi
  100764:	44 89 fa             	mov    %r15d,%edx
  100767:	4c 89 f7             	mov    %r14,%rdi
  10076a:	41 ff 16             	callq  *(%r14)
            continue;
  10076d:	4c 89 e3             	mov    %r12,%rbx
  100770:	eb d7                	jmp    100749 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  100772:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100776:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10077a:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10077e:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100782:	e9 51 fe ff ff       	jmpq   1005d8 <printer_vprintf+0x351>
            color = va_arg(val, int);
  100787:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10078b:	8b 07                	mov    (%rdi),%eax
  10078d:	83 f8 2f             	cmp    $0x2f,%eax
  100790:	77 10                	ja     1007a2 <printer_vprintf+0x51b>
  100792:	89 c2                	mov    %eax,%edx
  100794:	48 03 57 10          	add    0x10(%rdi),%rdx
  100798:	83 c0 08             	add    $0x8,%eax
  10079b:	89 07                	mov    %eax,(%rdi)
  10079d:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  1007a0:	eb a7                	jmp    100749 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  1007a2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007a6:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1007aa:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007ae:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1007b2:	eb e9                	jmp    10079d <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  1007b4:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007b8:	8b 01                	mov    (%rcx),%eax
  1007ba:	83 f8 2f             	cmp    $0x2f,%eax
  1007bd:	77 23                	ja     1007e2 <printer_vprintf+0x55b>
  1007bf:	89 c2                	mov    %eax,%edx
  1007c1:	48 03 51 10          	add    0x10(%rcx),%rdx
  1007c5:	83 c0 08             	add    $0x8,%eax
  1007c8:	89 01                	mov    %eax,(%rcx)
  1007ca:	8b 02                	mov    (%rdx),%eax
  1007cc:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  1007cf:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1007d3:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1007d7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1007dd:	e9 ff fd ff ff       	jmpq   1005e1 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  1007e2:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1007e6:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1007ea:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007ee:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1007f2:	eb d6                	jmp    1007ca <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  1007f4:	84 d2                	test   %dl,%dl
  1007f6:	0f 85 39 01 00 00    	jne    100935 <printer_vprintf+0x6ae>
  1007fc:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  100800:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  100804:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  100808:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10080c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100812:	e9 ca fd ff ff       	jmpq   1005e1 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  100817:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  10081d:	bf a0 15 10 00       	mov    $0x1015a0,%edi
        if (flags & FLAG_NUMERIC) {
  100822:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  100827:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  10082b:	4c 89 c1             	mov    %r8,%rcx
  10082e:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  100832:	48 63 f6             	movslq %esi,%rsi
  100835:	49 83 ec 01          	sub    $0x1,%r12
  100839:	48 89 c8             	mov    %rcx,%rax
  10083c:	ba 00 00 00 00       	mov    $0x0,%edx
  100841:	48 f7 f6             	div    %rsi
  100844:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  100848:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  10084c:	48 89 ca             	mov    %rcx,%rdx
  10084f:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  100852:	48 39 d6             	cmp    %rdx,%rsi
  100855:	76 de                	jbe    100835 <printer_vprintf+0x5ae>
  100857:	e9 9a fd ff ff       	jmpq   1005f6 <printer_vprintf+0x36f>
                prefix = "-";
  10085c:	48 c7 45 a0 b5 13 10 	movq   $0x1013b5,-0x60(%rbp)
  100863:	00 
            if (flags & FLAG_NEGATIVE) {
  100864:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100867:	a8 80                	test   $0x80,%al
  100869:	0f 85 b0 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                prefix = "+";
  10086f:	48 c7 45 a0 b0 13 10 	movq   $0x1013b0,-0x60(%rbp)
  100876:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100877:	a8 10                	test   $0x10,%al
  100879:	0f 85 a0 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                prefix = " ";
  10087f:	a8 08                	test   $0x8,%al
  100881:	ba b8 13 10 00       	mov    $0x1013b8,%edx
  100886:	b8 b7 13 10 00       	mov    $0x1013b7,%eax
  10088b:	48 0f 44 c2          	cmove  %rdx,%rax
  10088f:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100893:	e9 87 fd ff ff       	jmpq   10061f <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  100898:	41 8d 41 10          	lea    0x10(%r9),%eax
  10089c:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  1008a1:	0f 85 78 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  1008a7:	4d 85 c0             	test   %r8,%r8
  1008aa:	75 0d                	jne    1008b9 <printer_vprintf+0x632>
  1008ac:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  1008b3:	0f 84 66 fd ff ff    	je     10061f <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  1008b9:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1008bd:	ba b9 13 10 00       	mov    $0x1013b9,%edx
  1008c2:	b8 b2 13 10 00       	mov    $0x1013b2,%eax
  1008c7:	48 0f 44 c2          	cmove  %rdx,%rax
  1008cb:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1008cf:	e9 4b fd ff ff       	jmpq   10061f <printer_vprintf+0x398>
            len = strlen(data);
  1008d4:	4c 89 e7             	mov    %r12,%rdi
  1008d7:	e8 b5 f8 ff ff       	callq  100191 <strlen>
  1008dc:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1008df:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1008e3:	0f 84 63 fd ff ff    	je     10064c <printer_vprintf+0x3c5>
  1008e9:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1008ed:	0f 84 59 fd ff ff    	je     10064c <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  1008f3:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  1008f6:	89 ca                	mov    %ecx,%edx
  1008f8:	29 c2                	sub    %eax,%edx
  1008fa:	39 c1                	cmp    %eax,%ecx
  1008fc:	b8 00 00 00 00       	mov    $0x0,%eax
  100901:	0f 4e d0             	cmovle %eax,%edx
  100904:	89 55 9c             	mov    %edx,-0x64(%rbp)
  100907:	e9 56 fd ff ff       	jmpq   100662 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  10090c:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100910:	e8 7c f8 ff ff       	callq  100191 <strlen>
  100915:	8b 7d 98             	mov    -0x68(%rbp),%edi
  100918:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  10091b:	44 89 e9             	mov    %r13d,%ecx
  10091e:	29 f9                	sub    %edi,%ecx
  100920:	29 c1                	sub    %eax,%ecx
  100922:	44 39 ea             	cmp    %r13d,%edx
  100925:	b8 00 00 00 00       	mov    $0x0,%eax
  10092a:	0f 4d c8             	cmovge %eax,%ecx
  10092d:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  100930:	e9 2d fd ff ff       	jmpq   100662 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  100935:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100938:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  10093c:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100940:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100946:	e9 96 fc ff ff       	jmpq   1005e1 <printer_vprintf+0x35a>
        int flags = 0;
  10094b:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100952:	e9 b0 f9 ff ff       	jmpq   100307 <printer_vprintf+0x80>
}
  100957:	48 83 c4 58          	add    $0x58,%rsp
  10095b:	5b                   	pop    %rbx
  10095c:	41 5c                	pop    %r12
  10095e:	41 5d                	pop    %r13
  100960:	41 5e                	pop    %r14
  100962:	41 5f                	pop    %r15
  100964:	5d                   	pop    %rbp
  100965:	c3                   	retq   

0000000000100966 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100966:	55                   	push   %rbp
  100967:	48 89 e5             	mov    %rsp,%rbp
  10096a:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  10096e:	48 c7 45 f0 71 00 10 	movq   $0x100071,-0x10(%rbp)
  100975:	00 
        cpos = 0;
  100976:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  10097c:	b8 00 00 00 00       	mov    $0x0,%eax
  100981:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100984:	48 63 ff             	movslq %edi,%rdi
  100987:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  10098e:	00 
  10098f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100993:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100997:	e8 eb f8 ff ff       	callq  100287 <printer_vprintf>
    return cp.cursor - console;
  10099c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009a0:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1009a6:	48 d1 f8             	sar    %rax
}
  1009a9:	c9                   	leaveq 
  1009aa:	c3                   	retq   

00000000001009ab <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  1009ab:	55                   	push   %rbp
  1009ac:	48 89 e5             	mov    %rsp,%rbp
  1009af:	48 83 ec 50          	sub    $0x50,%rsp
  1009b3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1009b7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1009bb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  1009bf:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1009c6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1009ca:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1009ce:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1009d2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1009d6:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1009da:	e8 87 ff ff ff       	callq  100966 <console_vprintf>
}
  1009df:	c9                   	leaveq 
  1009e0:	c3                   	retq   

00000000001009e1 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1009e1:	55                   	push   %rbp
  1009e2:	48 89 e5             	mov    %rsp,%rbp
  1009e5:	53                   	push   %rbx
  1009e6:	48 83 ec 28          	sub    $0x28,%rsp
  1009ea:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  1009ed:	48 c7 45 d8 f7 00 10 	movq   $0x1000f7,-0x28(%rbp)
  1009f4:	00 
    sp.s = s;
  1009f5:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  1009f9:	48 85 f6             	test   %rsi,%rsi
  1009fc:	75 0b                	jne    100a09 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  1009fe:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100a01:	29 d8                	sub    %ebx,%eax
}
  100a03:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100a07:	c9                   	leaveq 
  100a08:	c3                   	retq   
        sp.end = s + size - 1;
  100a09:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100a0e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100a12:	be 00 00 00 00       	mov    $0x0,%esi
  100a17:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100a1b:	e8 67 f8 ff ff       	callq  100287 <printer_vprintf>
        *sp.s = 0;
  100a20:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a24:	c6 00 00             	movb   $0x0,(%rax)
  100a27:	eb d5                	jmp    1009fe <vsnprintf+0x1d>

0000000000100a29 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100a29:	55                   	push   %rbp
  100a2a:	48 89 e5             	mov    %rsp,%rbp
  100a2d:	48 83 ec 50          	sub    $0x50,%rsp
  100a31:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a35:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a39:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100a3d:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100a44:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100a48:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100a4c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100a50:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100a54:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100a58:	e8 84 ff ff ff       	callq  1009e1 <vsnprintf>
    va_end(val);
    return n;
}
  100a5d:	c9                   	leaveq 
  100a5e:	c3                   	retq   

0000000000100a5f <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a5f:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100a64:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100a69:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a6e:	48 83 c0 02          	add    $0x2,%rax
  100a72:	48 39 d0             	cmp    %rdx,%rax
  100a75:	75 f2                	jne    100a69 <console_clear+0xa>
    }
    cursorpos = 0;
  100a77:	c7 05 7b 85 fb ff 00 	movl   $0x0,-0x47a85(%rip)        # b8ffc <cursorpos>
  100a7e:	00 00 00 
}
  100a81:	c3                   	retq   

0000000000100a82 <compare>:

int compare( const void * a, const void * b){
    ptr_with_size * a_ptr = (ptr_with_size *) a;
    ptr_with_size * b_ptr = (ptr_with_size *) b;

    return (int)b_ptr->size - (int)a_ptr->size;
  100a82:	48 8b 46 08          	mov    0x8(%rsi),%rax
  100a86:	2b 47 08             	sub    0x8(%rdi),%eax
}
  100a89:	c3                   	retq   

0000000000100a8a <quicksort>:
typedef int (*__compar_fn_t) (const void *, const void *);

void
quicksort (void *const pbase, size_t total_elems, size_t size,
            __compar_fn_t cmp)
{
  100a8a:	55                   	push   %rbp
  100a8b:	48 89 e5             	mov    %rsp,%rbp
  100a8e:	41 57                	push   %r15
  100a90:	41 56                	push   %r14
  100a92:	41 55                	push   %r13
  100a94:	41 54                	push   %r12
  100a96:	53                   	push   %rbx
  100a97:	48 81 ec 48 04 00 00 	sub    $0x448,%rsp
  100a9e:	48 89 bd a0 fb ff ff 	mov    %rdi,-0x460(%rbp)
  100aa5:	48 89 b5 98 fb ff ff 	mov    %rsi,-0x468(%rbp)
  100aac:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
    char *base_ptr = (char *) pbase;
    const size_t max_thresh = MAX_THRESH * size;
    if (total_elems == 0)
  100ab3:	48 85 f6             	test   %rsi,%rsi
  100ab6:	0f 84 94 03 00 00    	je     100e50 <quicksort+0x3c6>
  100abc:	48 89 f0             	mov    %rsi,%rax
  100abf:	48 89 cb             	mov    %rcx,%rbx
    const size_t max_thresh = MAX_THRESH * size;
  100ac2:	48 8d 0c 95 00 00 00 	lea    0x0(,%rdx,4),%rcx
  100ac9:	00 
  100aca:	48 89 8d a8 fb ff ff 	mov    %rcx,-0x458(%rbp)
	/* Avoid lossage with unsigned arithmetic below.  */
	return;
    if (total_elems > MAX_THRESH)
  100ad1:	48 83 fe 04          	cmp    $0x4,%rsi
  100ad5:	0f 86 bd 02 00 00    	jbe    100d98 <quicksort+0x30e>
    {
	char *lo = base_ptr;
	char *hi = &lo[size * (total_elems - 1)];
  100adb:	48 83 e8 01          	sub    $0x1,%rax
  100adf:	48 0f af c2          	imul   %rdx,%rax
  100ae3:	48 01 f8             	add    %rdi,%rax
  100ae6:	48 89 85 c0 fb ff ff 	mov    %rax,-0x440(%rbp)
	stack_node stack[STACK_SIZE];
	stack_node *top = stack;
	PUSH (NULL, NULL);
  100aed:	48 c7 85 d0 fb ff ff 	movq   $0x0,-0x430(%rbp)
  100af4:	00 00 00 00 
  100af8:	48 c7 85 d8 fb ff ff 	movq   $0x0,-0x428(%rbp)
  100aff:	00 00 00 00 
	char *lo = base_ptr;
  100b03:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
	PUSH (NULL, NULL);
  100b0a:	48 8d 85 e0 fb ff ff 	lea    -0x420(%rbp),%rax
  100b11:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
		goto jump_over;
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
		SWAP (mid, lo, size);
jump_over:;
	  left_ptr  = lo + size;
	  right_ptr = hi - size;
  100b18:	48 f7 da             	neg    %rdx
  100b1b:	49 89 d7             	mov    %rdx,%r15
  100b1e:	e9 8c 01 00 00       	jmpq   100caf <quicksort+0x225>
  100b23:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100b2a:	49 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%rdi
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  100b2f:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  100b36:	4c 89 e8             	mov    %r13,%rax
  100b39:	0f b6 08             	movzbl (%rax),%ecx
  100b3c:	48 83 c0 01          	add    $0x1,%rax
  100b40:	0f b6 32             	movzbl (%rdx),%esi
  100b43:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  100b47:	48 83 c2 01          	add    $0x1,%rdx
  100b4b:	88 4a ff             	mov    %cl,-0x1(%rdx)
  100b4e:	48 39 c7             	cmp    %rax,%rdi
  100b51:	75 e6                	jne    100b39 <quicksort+0xaf>
  100b53:	e9 92 01 00 00       	jmpq   100cea <quicksort+0x260>
  100b58:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100b5f:	4d 8d 64 05 00       	lea    0x0(%r13,%rax,1),%r12
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  100b64:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
		SWAP (mid, hi, size);
  100b6b:	4c 89 e8             	mov    %r13,%rax
  100b6e:	0f b6 08             	movzbl (%rax),%ecx
  100b71:	48 83 c0 01          	add    $0x1,%rax
  100b75:	0f b6 32             	movzbl (%rdx),%esi
  100b78:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  100b7c:	48 83 c2 01          	add    $0x1,%rdx
  100b80:	88 4a ff             	mov    %cl,-0x1(%rdx)
  100b83:	49 39 c4             	cmp    %rax,%r12
  100b86:	75 e6                	jne    100b6e <quicksort+0xe4>
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  100b88:	48 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%rsi
  100b8f:	4c 89 ef             	mov    %r13,%rdi
  100b92:	ff d3                	callq  *%rbx
  100b94:	85 c0                	test   %eax,%eax
  100b96:	0f 89 62 01 00 00    	jns    100cfe <quicksort+0x274>
  100b9c:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  100ba3:	4c 89 e8             	mov    %r13,%rax
  100ba6:	0f b6 08             	movzbl (%rax),%ecx
  100ba9:	48 83 c0 01          	add    $0x1,%rax
  100bad:	0f b6 32             	movzbl (%rdx),%esi
  100bb0:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  100bb4:	48 83 c2 01          	add    $0x1,%rdx
  100bb8:	88 4a ff             	mov    %cl,-0x1(%rdx)
  100bbb:	49 39 c4             	cmp    %rax,%r12
  100bbe:	75 e6                	jne    100ba6 <quicksort+0x11c>
jump_over:;
  100bc0:	e9 39 01 00 00       	jmpq   100cfe <quicksort+0x274>
	  do
	  {
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
		  left_ptr += size;
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
		  right_ptr -= size;
  100bc5:	4d 01 fc             	add    %r15,%r12
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
  100bc8:	4c 89 e6             	mov    %r12,%rsi
  100bcb:	4c 89 ef             	mov    %r13,%rdi
  100bce:	ff d3                	callq  *%rbx
  100bd0:	85 c0                	test   %eax,%eax
  100bd2:	78 f1                	js     100bc5 <quicksort+0x13b>
	      if (left_ptr < right_ptr)
  100bd4:	4d 39 e6             	cmp    %r12,%r14
  100bd7:	72 1c                	jb     100bf5 <quicksort+0x16b>
		  else if (mid == right_ptr)
		      mid = left_ptr;
		  left_ptr += size;
		  right_ptr -= size;
	      }
	      else if (left_ptr == right_ptr)
  100bd9:	74 5e                	je     100c39 <quicksort+0x1af>
		  left_ptr += size;
		  right_ptr -= size;
		  break;
	      }
	  }
	  while (left_ptr <= right_ptr);
  100bdb:	4d 39 e6             	cmp    %r12,%r14
  100bde:	77 63                	ja     100c43 <quicksort+0x1b9>
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
  100be0:	4c 89 ee             	mov    %r13,%rsi
  100be3:	4c 89 f7             	mov    %r14,%rdi
  100be6:	ff d3                	callq  *%rbx
  100be8:	85 c0                	test   %eax,%eax
  100bea:	79 dc                	jns    100bc8 <quicksort+0x13e>
		  left_ptr += size;
  100bec:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  100bf3:	eb eb                	jmp    100be0 <quicksort+0x156>
  100bf5:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100bfc:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
	      if (left_ptr < right_ptr)
  100c00:	4c 89 e2             	mov    %r12,%rdx
  100c03:	4c 89 f0             	mov    %r14,%rax
		  SWAP (left_ptr, right_ptr, size);
  100c06:	0f b6 08             	movzbl (%rax),%ecx
  100c09:	48 83 c0 01          	add    $0x1,%rax
  100c0d:	0f b6 32             	movzbl (%rdx),%esi
  100c10:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  100c14:	48 83 c2 01          	add    $0x1,%rdx
  100c18:	88 4a ff             	mov    %cl,-0x1(%rdx)
  100c1b:	48 39 f8             	cmp    %rdi,%rax
  100c1e:	75 e6                	jne    100c06 <quicksort+0x17c>
		  if (mid == left_ptr)
  100c20:	4d 39 ee             	cmp    %r13,%r14
  100c23:	74 0f                	je     100c34 <quicksort+0x1aa>
		  else if (mid == right_ptr)
  100c25:	4d 39 ec             	cmp    %r13,%r12
  100c28:	4d 0f 44 ee          	cmove  %r14,%r13
		  right_ptr -= size;
  100c2c:	4d 01 fc             	add    %r15,%r12
		  left_ptr += size;
  100c2f:	49 89 fe             	mov    %rdi,%r14
  100c32:	eb a7                	jmp    100bdb <quicksort+0x151>
  100c34:	4d 89 e5             	mov    %r12,%r13
  100c37:	eb f3                	jmp    100c2c <quicksort+0x1a2>
		  left_ptr += size;
  100c39:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
		  right_ptr -= size;
  100c40:	4d 01 fc             	add    %r15,%r12
	  /* Set up pointers for next iteration.  First determine whether
	     left and right partitions are below the threshold size.  If so,
	     ignore one or both.  Otherwise, push the larger partition's
	     bounds on the stack and continue sorting the smaller one. */
	  if ((size_t) (right_ptr - lo) <= max_thresh)
  100c43:	4c 89 e0             	mov    %r12,%rax
  100c46:	48 2b 85 b8 fb ff ff 	sub    -0x448(%rbp),%rax
  100c4d:	48 8b bd a8 fb ff ff 	mov    -0x458(%rbp),%rdi
  100c54:	48 39 f8             	cmp    %rdi,%rax
  100c57:	0f 87 bf 00 00 00    	ja     100d1c <quicksort+0x292>
	  {
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  100c5d:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  100c64:	4c 29 f0             	sub    %r14,%rax
		  /* Ignore both small partitions. */
		  POP (lo, hi);
	      else
		  /* Ignore small left partition. */
		  lo = left_ptr;
  100c67:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  100c6e:	48 39 f8             	cmp    %rdi,%rax
  100c71:	77 28                	ja     100c9b <quicksort+0x211>
		  POP (lo, hi);
  100c73:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  100c7a:	48 8b 78 f0          	mov    -0x10(%rax),%rdi
  100c7e:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
  100c85:	48 8b 78 f8          	mov    -0x8(%rax),%rdi
  100c89:	48 89 bd c0 fb ff ff 	mov    %rdi,-0x440(%rbp)
  100c90:	48 8d 40 f0          	lea    -0x10(%rax),%rax
  100c94:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	while (STACK_NOT_EMPTY)
  100c9b:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  100ca2:	48 39 85 b0 fb ff ff 	cmp    %rax,-0x450(%rbp)
  100ca9:	0f 86 e9 00 00 00    	jbe    100d98 <quicksort+0x30e>
	    char *mid = lo + size * ((hi - lo) / size >> 1);
  100caf:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  100cb6:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  100cbd:	48 29 f8             	sub    %rdi,%rax
  100cc0:	48 8b 8d c8 fb ff ff 	mov    -0x438(%rbp),%rcx
  100cc7:	ba 00 00 00 00       	mov    $0x0,%edx
  100ccc:	48 f7 f1             	div    %rcx
  100ccf:	48 d1 e8             	shr    %rax
  100cd2:	48 0f af c1          	imul   %rcx,%rax
  100cd6:	4c 8d 2c 07          	lea    (%rdi,%rax,1),%r13
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  100cda:	48 89 fe             	mov    %rdi,%rsi
  100cdd:	4c 89 ef             	mov    %r13,%rdi
  100ce0:	ff d3                	callq  *%rbx
  100ce2:	85 c0                	test   %eax,%eax
  100ce4:	0f 88 39 fe ff ff    	js     100b23 <quicksort+0x99>
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  100cea:	4c 89 ee             	mov    %r13,%rsi
  100ced:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  100cf4:	ff d3                	callq  *%rbx
  100cf6:	85 c0                	test   %eax,%eax
  100cf8:	0f 88 5a fe ff ff    	js     100b58 <quicksort+0xce>
	  left_ptr  = lo + size;
  100cfe:	4c 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%r14
  100d05:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
	  right_ptr = hi - size;
  100d0c:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  100d13:	4e 8d 24 38          	lea    (%rax,%r15,1),%r12
  100d17:	e9 c4 fe ff ff       	jmpq   100be0 <quicksort+0x156>
	  }
	  else if ((size_t) (hi - left_ptr) <= max_thresh)
  100d1c:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
  100d23:	4c 29 f2             	sub    %r14,%rdx
  100d26:	48 3b 95 a8 fb ff ff 	cmp    -0x458(%rbp),%rdx
  100d2d:	76 5d                	jbe    100d8c <quicksort+0x302>
	      /* Ignore small right partition. */
	      hi = right_ptr;
	  else if ((right_ptr - lo) > (hi - left_ptr))
  100d2f:	48 39 d0             	cmp    %rdx,%rax
  100d32:	7e 2c                	jle    100d60 <quicksort+0x2d6>
	  {
	      /* Push larger left partition indices. */
	      PUSH (lo, right_ptr);
  100d34:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  100d3b:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  100d42:	48 89 38             	mov    %rdi,(%rax)
  100d45:	4c 89 60 08          	mov    %r12,0x8(%rax)
  100d49:	48 83 c0 10          	add    $0x10,%rax
  100d4d:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      lo = left_ptr;
  100d54:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
  100d5b:	e9 3b ff ff ff       	jmpq   100c9b <quicksort+0x211>
	  }
	  else
	  {
	      /* Push larger right partition indices. */
	      PUSH (left_ptr, hi);
  100d60:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  100d67:	4c 89 30             	mov    %r14,(%rax)
  100d6a:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  100d71:	48 89 78 08          	mov    %rdi,0x8(%rax)
  100d75:	48 83 c0 10          	add    $0x10,%rax
  100d79:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      hi = right_ptr;
  100d80:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  100d87:	e9 0f ff ff ff       	jmpq   100c9b <quicksort+0x211>
	      hi = right_ptr;
  100d8c:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  100d93:	e9 03 ff ff ff       	jmpq   100c9b <quicksort+0x211>
       for partitions below MAX_THRESH size. BASE_PTR points to the beginning
       of the array to sort, and END_PTR points at the very last element in
       the array (*not* one beyond it!). */
#define min(x, y) ((x) < (y) ? (x) : (y))
    {
	char *const end_ptr = &base_ptr[size * (total_elems - 1)];
  100d98:	4c 8b bd 98 fb ff ff 	mov    -0x468(%rbp),%r15
  100d9f:	49 83 ef 01          	sub    $0x1,%r15
  100da3:	48 8b bd c8 fb ff ff 	mov    -0x438(%rbp),%rdi
  100daa:	4c 0f af ff          	imul   %rdi,%r15
  100dae:	4c 8b ad a0 fb ff ff 	mov    -0x460(%rbp),%r13
  100db5:	4d 01 ef             	add    %r13,%r15
	char *tmp_ptr = base_ptr;
	char *thresh = min(end_ptr, base_ptr + max_thresh);
  100db8:	48 8b 85 a8 fb ff ff 	mov    -0x458(%rbp),%rax
  100dbf:	4c 01 e8             	add    %r13,%rax
  100dc2:	49 39 c7             	cmp    %rax,%r15
  100dc5:	49 0f 46 c7          	cmovbe %r15,%rax
	char *run_ptr;
	/* Find smallest element in first threshold and place it at the
	   array's beginning.  This is the smallest array element,
	   and the operation speeds up insertion sort's inner loop. */
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  100dc9:	4d 89 ec             	mov    %r13,%r12
  100dcc:	49 01 fc             	add    %rdi,%r12
  100dcf:	4c 39 e0             	cmp    %r12,%rax
  100dd2:	72 66                	jb     100e3a <quicksort+0x3b0>
  100dd4:	4d 89 e6             	mov    %r12,%r14
	char *tmp_ptr = base_ptr;
  100dd7:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  100dde:	49 89 c4             	mov    %rax,%r12
	    if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100de1:	4c 89 ee             	mov    %r13,%rsi
  100de4:	4c 89 f7             	mov    %r14,%rdi
  100de7:	ff d3                	callq  *%rbx
  100de9:	85 c0                	test   %eax,%eax
  100deb:	4d 0f 48 ee          	cmovs  %r14,%r13
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  100def:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  100df6:	4d 39 f4             	cmp    %r14,%r12
  100df9:	73 e6                	jae    100de1 <quicksort+0x357>
  100dfb:	4c 8b a5 c0 fb ff ff 	mov    -0x440(%rbp),%r12
		tmp_ptr = run_ptr;
	if (tmp_ptr != base_ptr)
  100e02:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100e09:	49 8d 4c 05 00       	lea    0x0(%r13,%rax,1),%rcx
  100e0e:	48 8b 85 a0 fb ff ff 	mov    -0x460(%rbp),%rax
  100e15:	4c 3b ad a0 fb ff ff 	cmp    -0x460(%rbp),%r13
  100e1c:	74 1c                	je     100e3a <quicksort+0x3b0>
	    SWAP (tmp_ptr, base_ptr, size);
  100e1e:	41 0f b6 55 00       	movzbl 0x0(%r13),%edx
  100e23:	49 83 c5 01          	add    $0x1,%r13
  100e27:	0f b6 30             	movzbl (%rax),%esi
  100e2a:	41 88 75 ff          	mov    %sil,-0x1(%r13)
  100e2e:	48 83 c0 01          	add    $0x1,%rax
  100e32:	88 50 ff             	mov    %dl,-0x1(%rax)
  100e35:	49 39 cd             	cmp    %rcx,%r13
  100e38:	75 e4                	jne    100e1e <quicksort+0x394>
	/* Insertion sort, running from left-hand-side up to right-hand-side.  */
	run_ptr = base_ptr + size;
	while ((run_ptr += size) <= end_ptr)
  100e3a:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100e41:	4d 8d 34 04          	lea    (%r12,%rax,1),%r14
	{
	    tmp_ptr = run_ptr - size;
  100e45:	48 f7 d8             	neg    %rax
  100e48:	49 89 c5             	mov    %rax,%r13
	while ((run_ptr += size) <= end_ptr)
  100e4b:	4d 39 f7             	cmp    %r14,%r15
  100e4e:	73 15                	jae    100e65 <quicksort+0x3db>
		    *hi = c;
		}
	    }
	}
    }
}
  100e50:	48 81 c4 48 04 00 00 	add    $0x448,%rsp
  100e57:	5b                   	pop    %rbx
  100e58:	41 5c                	pop    %r12
  100e5a:	41 5d                	pop    %r13
  100e5c:	41 5e                	pop    %r14
  100e5e:	41 5f                	pop    %r15
  100e60:	5d                   	pop    %rbp
  100e61:	c3                   	retq   
		tmp_ptr -= size;
  100e62:	4d 01 ec             	add    %r13,%r12
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100e65:	4c 89 e6             	mov    %r12,%rsi
  100e68:	4c 89 f7             	mov    %r14,%rdi
  100e6b:	ff d3                	callq  *%rbx
  100e6d:	85 c0                	test   %eax,%eax
  100e6f:	78 f1                	js     100e62 <quicksort+0x3d8>
	    tmp_ptr += size;
  100e71:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100e78:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
	    if (tmp_ptr != run_ptr)
  100e7c:	4c 39 f6             	cmp    %r14,%rsi
  100e7f:	75 17                	jne    100e98 <quicksort+0x40e>
	while ((run_ptr += size) <= end_ptr)
  100e81:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100e88:	4c 01 f0             	add    %r14,%rax
  100e8b:	4d 89 f4             	mov    %r14,%r12
  100e8e:	49 39 c7             	cmp    %rax,%r15
  100e91:	72 bd                	jb     100e50 <quicksort+0x3c6>
  100e93:	49 89 c6             	mov    %rax,%r14
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100e96:	eb cd                	jmp    100e65 <quicksort+0x3db>
		while (--trav >= run_ptr)
  100e98:	49 8d 7c 06 ff       	lea    -0x1(%r14,%rax,1),%rdi
  100e9d:	4c 39 f7             	cmp    %r14,%rdi
  100ea0:	72 df                	jb     100e81 <quicksort+0x3f7>
  100ea2:	4d 8d 46 ff          	lea    -0x1(%r14),%r8
  100ea6:	4d 89 c2             	mov    %r8,%r10
  100ea9:	eb 13                	jmp    100ebe <quicksort+0x434>
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100eab:	48 89 f9             	mov    %rdi,%rcx
		    *hi = c;
  100eae:	44 88 09             	mov    %r9b,(%rcx)
		while (--trav >= run_ptr)
  100eb1:	48 83 ef 01          	sub    $0x1,%rdi
  100eb5:	49 83 e8 01          	sub    $0x1,%r8
  100eb9:	49 39 fa             	cmp    %rdi,%r10
  100ebc:	74 c3                	je     100e81 <quicksort+0x3f7>
		    char c = *trav;
  100ebe:	44 0f b6 0f          	movzbl (%rdi),%r9d
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100ec2:	4c 89 c0             	mov    %r8,%rax
  100ec5:	4c 39 c6             	cmp    %r8,%rsi
  100ec8:	77 e1                	ja     100eab <quicksort+0x421>
  100eca:	48 89 fa             	mov    %rdi,%rdx
			*hi = *lo;
  100ecd:	0f b6 08             	movzbl (%rax),%ecx
  100ed0:	88 0a                	mov    %cl,(%rdx)
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100ed2:	48 89 c1             	mov    %rax,%rcx
  100ed5:	4c 01 e8             	add    %r13,%rax
  100ed8:	48 2b 95 c8 fb ff ff 	sub    -0x438(%rbp),%rdx
  100edf:	48 39 c6             	cmp    %rax,%rsi
  100ee2:	76 e9                	jbe    100ecd <quicksort+0x443>
  100ee4:	eb c8                	jmp    100eae <quicksort+0x424>

0000000000100ee6 <addNodeToList>:

/* Add the given block to the given list */
void addNodeToList(struct block_header * header, struct block_header ** list_start){
    if(*list_start == 0) {
  100ee6:	48 8b 16             	mov    (%rsi),%rdx
  100ee9:	48 85 d2             	test   %rdx,%rdx
  100eec:	74 3b                	je     100f29 <addNodeToList+0x43>
        // list is empty
        *list_start = header;
        return;
    }

    if(header < *list_start){
  100eee:	48 39 fa             	cmp    %rdi,%rdx
  100ef1:	77 3a                	ja     100f2d <addNodeToList+0x47>
        *list_start = header;
        return;
    }

    struct block_header * node = *list_start;
    struct block_header * nextNode = node->next;
  100ef3:	48 8b 02             	mov    (%rdx),%rax
    while(nextNode != 0){
  100ef6:	48 85 c0             	test   %rax,%rax
  100ef9:	74 3d                	je     100f38 <addNodeToList+0x52>
        if(node < header && nextNode > header){
  100efb:	48 39 fa             	cmp    %rdi,%rdx
  100efe:	73 05                	jae    100f05 <addNodeToList+0x1f>
  100f00:	48 39 c7             	cmp    %rax,%rdi
  100f03:	72 15                	jb     100f1a <addNodeToList+0x34>
            node->next = header;
            nextNode->prev = header;
            return;
        }
        node = nextNode;
        nextNode = node->next;
  100f05:	48 89 c2             	mov    %rax,%rdx
  100f08:	48 8b 00             	mov    (%rax),%rax
    while(nextNode != 0){
  100f0b:	48 85 c0             	test   %rax,%rax
  100f0e:	74 28                	je     100f38 <addNodeToList+0x52>
        if(node < header && nextNode > header){
  100f10:	48 39 d7             	cmp    %rdx,%rdi
  100f13:	76 f0                	jbe    100f05 <addNodeToList+0x1f>
  100f15:	48 39 c7             	cmp    %rax,%rdi
  100f18:	73 eb                	jae    100f05 <addNodeToList+0x1f>
            header->prev = node;
  100f1a:	48 89 57 08          	mov    %rdx,0x8(%rdi)
            header->next = nextNode;
  100f1e:	48 89 07             	mov    %rax,(%rdi)
            node->next = header;
  100f21:	48 89 3a             	mov    %rdi,(%rdx)
            nextNode->prev = header;
  100f24:	48 89 78 08          	mov    %rdi,0x8(%rax)
            return;
  100f28:	c3                   	retq   
        *list_start = header;
  100f29:	48 89 3e             	mov    %rdi,(%rsi)
        return;
  100f2c:	c3                   	retq   
        header->next = *list_start;
  100f2d:	48 89 17             	mov    %rdx,(%rdi)
        (*list_start)->prev = header;
  100f30:	48 89 7a 08          	mov    %rdi,0x8(%rdx)
        *list_start = header;
  100f34:	48 89 3e             	mov    %rdi,(%rsi)
        return;
  100f37:	c3                   	retq   
    }

    // reached end of list; append header there
    node->next = header;
  100f38:	48 89 3a             	mov    %rdi,(%rdx)
    header->prev = node;
  100f3b:	48 89 57 08          	mov    %rdx,0x8(%rdi)
}
  100f3f:	c3                   	retq   

0000000000100f40 <removeNodeFromList>:


/* Remove the given block from its list */
void removeNodeFromList(struct block_header * header, struct block_header ** list_start){
    if(header == 0) return;
  100f40:	48 85 ff             	test   %rdi,%rdi
  100f43:	74 2c                	je     100f71 <removeNodeFromList+0x31>

    struct block_header * prevNode = header->prev;
  100f45:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    struct block_header * nextNode = header->next;
  100f49:	48 8b 07             	mov    (%rdi),%rax

    if(prevNode)
  100f4c:	48 85 d2             	test   %rdx,%rdx
  100f4f:	74 03                	je     100f54 <removeNodeFromList+0x14>
        prevNode->next = nextNode;
  100f51:	48 89 02             	mov    %rax,(%rdx)
    if(nextNode)
  100f54:	48 85 c0             	test   %rax,%rax
  100f57:	74 04                	je     100f5d <removeNodeFromList+0x1d>
        nextNode->prev = prevNode;
  100f59:	48 89 50 08          	mov    %rdx,0x8(%rax)

    // check if this block is the start of the list
    if(*list_start == header)
  100f5d:	48 39 3e             	cmp    %rdi,(%rsi)
  100f60:	74 10                	je     100f72 <removeNodeFromList+0x32>
        *list_start = nextNode;

    header->next = 0;
  100f62:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    header->prev = 0;
  100f69:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  100f70:	00 
}
  100f71:	c3                   	retq   
        *list_start = nextNode;
  100f72:	48 89 06             	mov    %rax,(%rsi)
  100f75:	eb eb                	jmp    100f62 <removeNodeFromList+0x22>

0000000000100f77 <free>:
/* Free a block */
void free(void *firstbyte) {
    
    // app_printf(0, "free\n");

    if(firstbyte == 0)
  100f77:	48 85 ff             	test   %rdi,%rdi
  100f7a:	74 44                	je     100fc0 <free+0x49>
void free(void *firstbyte) {
  100f7c:	55                   	push   %rbp
  100f7d:	48 89 e5             	mov    %rsp,%rbp
  100f80:	41 54                	push   %r12
  100f82:	53                   	push   %rbx
  100f83:	48 89 fb             	mov    %rdi,%rbx
        return;

    // remove the block from allocated_list
    struct block_header * header = (struct block_header *) ((uintptr_t) firstbyte - HEADER_SIZE);
  100f86:	4c 8d 67 e8          	lea    -0x18(%rdi),%r12
    removeNodeFromList(header, &allocated_list_start);
  100f8a:	be 20 20 10 00       	mov    $0x102020,%esi
  100f8f:	4c 89 e7             	mov    %r12,%rdi
  100f92:	e8 a9 ff ff ff       	callq  100f40 <removeNodeFromList>

    // add the block to free-node list
    header->prev = 0;
  100f97:	48 c7 43 f0 00 00 00 	movq   $0x0,-0x10(%rbx)
  100f9e:	00 
    header->next = 0;
  100f9f:	48 c7 43 e8 00 00 00 	movq   $0x0,-0x18(%rbx)
  100fa6:	00 
    addNodeToList(header, &free_list_start);
  100fa7:	be 28 20 10 00       	mov    $0x102028,%esi
  100fac:	4c 89 e7             	mov    %r12,%rdi
  100faf:	e8 32 ff ff ff       	callq  100ee6 <addNodeToList>

    // app_printf(0, "%x\n", free_list_start);

    number_allocs--;
  100fb4:	83 2d 5d 10 00 00 01 	subl   $0x1,0x105d(%rip)        # 102018 <number_allocs>
}
  100fbb:	5b                   	pop    %rbx
  100fbc:	41 5c                	pop    %r12
  100fbe:	5d                   	pop    %rbp
  100fbf:	c3                   	retq   
  100fc0:	c3                   	retq   

0000000000100fc1 <splitFreeNode>:

/* Split a given block into two,
   given the size of the first part */
void splitFreeNode(struct block_header * node, size_t sz) {
    struct block_header * newNode = (struct block_header *) ((uintptr_t) node + sz);
  100fc1:	48 8d 04 37          	lea    (%rdi,%rsi,1),%rax
    newNode->block_size = node->block_size - sz;
  100fc5:	48 8b 57 10          	mov    0x10(%rdi),%rdx
  100fc9:	48 29 f2             	sub    %rsi,%rdx
  100fcc:	48 89 50 10          	mov    %rdx,0x10(%rax)

    // insert the new block into free-node list
    newNode->next = node->next;
  100fd0:	48 8b 17             	mov    (%rdi),%rdx
  100fd3:	48 89 10             	mov    %rdx,(%rax)
    node->next = newNode;
  100fd6:	48 89 07             	mov    %rax,(%rdi)
    newNode->prev = node;
  100fd9:	48 89 78 08          	mov    %rdi,0x8(%rax)
    if(newNode->next) newNode->next->prev = newNode;     
  100fdd:	48 8b 10             	mov    (%rax),%rdx
  100fe0:	48 85 d2             	test   %rdx,%rdx
  100fe3:	74 04                	je     100fe9 <splitFreeNode+0x28>
  100fe5:	48 89 42 08          	mov    %rax,0x8(%rdx)
}
  100fe9:	c3                   	retq   

0000000000100fea <findFreeNode>:

/* Traverse the free-node list to find a possible block;
   return the start of the block (start of the header) */
struct block_header * findFreeNode(size_t block_size){
  100fea:	55                   	push   %rbp
  100feb:	48 89 e5             	mov    %rsp,%rbp
  100fee:	41 55                	push   %r13
  100ff0:	41 54                	push   %r12
  100ff2:	53                   	push   %rbx
  100ff3:	48 83 ec 08          	sub    $0x8,%rsp
  100ff7:	49 89 fd             	mov    %rdi,%r13
    struct block_header * node = free_list_start;
  100ffa:	48 8b 1d 27 10 00 00 	mov    0x1027(%rip),%rbx        # 102028 <free_list_start>
    while(node != 0){
  101001:	48 85 db             	test   %rbx,%rbx
  101004:	74 30                	je     101036 <findFreeNode+0x4c>
        if(node->block_size >= block_size) {
  101006:	4c 8b 63 10          	mov    0x10(%rbx),%r12
  10100a:	4d 39 ec             	cmp    %r13,%r12
  10100d:	73 0a                	jae    101019 <findFreeNode+0x2f>
            // update block_size
            node->block_size = block_size;

            return node;
        }
        node = node->next;
  10100f:	48 8b 1b             	mov    (%rbx),%rbx
    while(node != 0){
  101012:	48 85 db             	test   %rbx,%rbx
  101015:	75 ef                	jne    101006 <findFreeNode+0x1c>
  101017:	eb 1d                	jmp    101036 <findFreeNode+0x4c>
            if(node->block_size - block_size >= HEADER_SIZE) {
  101019:	4c 89 e0             	mov    %r12,%rax
  10101c:	4c 29 e8             	sub    %r13,%rax
  10101f:	48 83 f8 17          	cmp    $0x17,%rax
  101023:	77 1f                	ja     101044 <findFreeNode+0x5a>
            removeNodeFromList(node, &free_list_start);
  101025:	be 28 20 10 00       	mov    $0x102028,%esi
  10102a:	48 89 df             	mov    %rbx,%rdi
  10102d:	e8 0e ff ff ff       	callq  100f40 <removeNodeFromList>
            node->block_size = block_size;
  101032:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    }
    // no available block is found
    return 0;
}
  101036:	48 89 d8             	mov    %rbx,%rax
  101039:	48 83 c4 08          	add    $0x8,%rsp
  10103d:	5b                   	pop    %rbx
  10103e:	41 5c                	pop    %r12
  101040:	41 5d                	pop    %r13
  101042:	5d                   	pop    %rbp
  101043:	c3                   	retq   
                splitFreeNode(node, block_size);
  101044:	4c 89 ee             	mov    %r13,%rsi
  101047:	48 89 df             	mov    %rbx,%rdi
  10104a:	e8 72 ff ff ff       	callq  100fc1 <splitFreeNode>
  10104f:	4d 89 ec             	mov    %r13,%r12
  101052:	eb d1                	jmp    101025 <findFreeNode+0x3b>

0000000000101054 <malloc>:

void *malloc(uint64_t numbytes) {
  101054:	55                   	push   %rbp
  101055:	48 89 e5             	mov    %rsp,%rbp
  101058:	41 54                	push   %r12
  10105a:	53                   	push   %rbx
    if(numbytes == 0) return NULL;
  10105b:	48 85 ff             	test   %rdi,%rdi
  10105e:	74 72                	je     1010d2 <malloc+0x7e>

    // app_printf(0, "s\n");

    // size of allocated block, after accounting for alignment
    size_t allocatedBlockSize = numbytes + HEADER_SIZE;
  101060:	4c 8d 67 18          	lea    0x18(%rdi),%r12
    // app_printf(0, "%d\n", numbytes);
    if(allocatedBlockSize % ALIGNMENT != 0)
        allocatedBlockSize = (allocatedBlockSize & ~(ALIGNMENT-1)) + ALIGNMENT;
  101064:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
  101068:	49 83 c4 08          	add    $0x8,%r12
  10106c:	48 8d 47 18          	lea    0x18(%rdi),%rax
  101070:	40 f6 c7 07          	test   $0x7,%dil
  101074:	4c 0f 44 e0          	cmove  %rax,%r12

    // go through list of free blocks,
    // and find one that would fit
    struct block_header * target_block = findFreeNode(allocatedBlockSize);
  101078:	4c 89 e7             	mov    %r12,%rdi
  10107b:	e8 6a ff ff ff       	callq  100fea <findFreeNode>
  101080:	48 89 c3             	mov    %rax,%rbx
    if(target_block == 0) {
  101083:	48 85 c0             	test   %rax,%rax
  101086:	74 2f                	je     1010b7 <malloc+0x63>
        // set up block header
        target_block->block_size = allocatedBlockSize;
    }

    // add the block to allocated_list
    target_block->prev = 0;
  101088:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  10108f:	00 
    target_block->next = 0;
  101090:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    addNodeToList(target_block, &allocated_list_start);
  101097:	be 20 20 10 00       	mov    $0x102020,%esi
  10109c:	48 89 df             	mov    %rbx,%rdi
  10109f:	e8 42 fe ff ff       	callq  100ee6 <addNodeToList>

    // return start of payload
    number_allocs++;
  1010a4:	83 05 6d 0f 00 00 01 	addl   $0x1,0xf6d(%rip)        # 102018 <number_allocs>
    
    // app_printf(0, "%d\n", allocatedBlockSize);
    return (void*) ((uintptr_t) target_block + HEADER_SIZE);
  1010ab:	48 83 c3 18          	add    $0x18,%rbx
}
  1010af:	48 89 d8             	mov    %rbx,%rax
  1010b2:	5b                   	pop    %rbx
  1010b3:	41 5c                	pop    %r12
  1010b5:	5d                   	pop    %rbp
  1010b6:	c3                   	retq   
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1010b7:	4c 89 e7             	mov    %r12,%rdi
  1010ba:	cd 3a                	int    $0x3a
  1010bc:	48 89 05 6d 0f 00 00 	mov    %rax,0xf6d(%rip)        # 102030 <result.0>
        if((void *)target_block == (void *) -1) return 0;
  1010c3:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1010c7:	74 e6                	je     1010af <malloc+0x5b>
        target_block->block_size = allocatedBlockSize;
  1010c9:	4c 89 60 10          	mov    %r12,0x10(%rax)
        target_block = (struct block_header *) sbrk(allocatedBlockSize);
  1010cd:	48 89 c3             	mov    %rax,%rbx
  1010d0:	eb b6                	jmp    101088 <malloc+0x34>
    if(numbytes == 0) return NULL;
  1010d2:	bb 00 00 00 00       	mov    $0x0,%ebx
  1010d7:	eb d6                	jmp    1010af <malloc+0x5b>

00000000001010d9 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  1010d9:	55                   	push   %rbp
  1010da:	48 89 e5             	mov    %rsp,%rbp
  1010dd:	41 54                	push   %r12
  1010df:	53                   	push   %rbx
    // malloc
    void * new_payload = malloc(num * sz);
  1010e0:	48 0f af fe          	imul   %rsi,%rdi
  1010e4:	49 89 fc             	mov    %rdi,%r12
  1010e7:	e8 68 ff ff ff       	callq  101054 <malloc>
  1010ec:	48 89 c3             	mov    %rax,%rbx
    if(new_payload == 0)
  1010ef:	48 85 c0             	test   %rax,%rax
  1010f2:	74 10                	je     101104 <calloc+0x2b>
        return 0;

    // fill in 0's
    memset(new_payload, 0, num * sz);
  1010f4:	4c 89 e2             	mov    %r12,%rdx
  1010f7:	be 00 00 00 00       	mov    $0x0,%esi
  1010fc:	48 89 c7             	mov    %rax,%rdi
  1010ff:	e8 72 f0 ff ff       	callq  100176 <memset>

    return new_payload;
}
  101104:	48 89 d8             	mov    %rbx,%rax
  101107:	5b                   	pop    %rbx
  101108:	41 5c                	pop    %r12
  10110a:	5d                   	pop    %rbp
  10110b:	c3                   	retq   

000000000010110c <realloc>:
/*
For realloc(ptr, size), if ptr is NULL, then the call is equivalent to malloc(size), 
for all values of size; if size is equal to zero, and ptr is not NULL, then the call 
is equivalent to free(ptr).
*/
void * realloc(void * ptr, uint64_t sz) {
  10110c:	55                   	push   %rbp
  10110d:	48 89 e5             	mov    %rsp,%rbp
  101110:	41 57                	push   %r15
  101112:	41 56                	push   %r14
  101114:	41 55                	push   %r13
  101116:	41 54                	push   %r12
  101118:	53                   	push   %rbx
  101119:	48 83 ec 08          	sub    $0x8,%rsp
  10111d:	48 89 f3             	mov    %rsi,%rbx
    // edge cases:
    if(ptr == NULL) return malloc(sz);
  101120:	48 85 ff             	test   %rdi,%rdi
  101123:	74 60                	je     101185 <realloc+0x79>
  101125:	49 89 fc             	mov    %rdi,%r12
    if(sz == 0) {
  101128:	48 85 f6             	test   %rsi,%rsi
  10112b:	74 65                	je     101192 <realloc+0x86>
        free(ptr);
        return 0;       // TODO: check return value
    }

    struct block_header * orig_header = (struct block_header *) ((uintptr_t) ptr - HEADER_SIZE);
    size_t origPayloadSz = orig_header->block_size - HEADER_SIZE;
  10112d:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  101131:	4c 8d 68 e8          	lea    -0x18(%rax),%r13
    size_t newPayloadSz = sz;
    if(newPayloadSz % ALIGNMENT != 0)
        newPayloadSz = (newPayloadSz & ~(ALIGNMENT-1)) + ALIGNMENT;
  101135:	48 89 f0             	mov    %rsi,%rax
  101138:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  10113c:	48 83 c0 08          	add    $0x8,%rax
  101140:	40 f6 c6 07          	test   $0x7,%sil
  101144:	48 0f 45 d8          	cmovne %rax,%rbx

    // shrinking?
    if (newPayloadSz <= origPayloadSz) {
  101148:	4c 39 eb             	cmp    %r13,%rbx
  10114b:	77 52                	ja     10119f <realloc+0x93>
        // check if we need to split
        if(origPayloadSz - newPayloadSz >= HEADER_SIZE) {
  10114d:	49 29 dd             	sub    %rbx,%r13
            addNodeToList(free_header, &free_list_start);
            // shrink the allocated block
            orig_header->block_size = newPayloadSz + HEADER_SIZE;
        }

        return ptr;
  101150:	49 89 fe             	mov    %rdi,%r14
        if(origPayloadSz - newPayloadSz >= HEADER_SIZE) {
  101153:	49 83 fd 17          	cmp    $0x17,%r13
  101157:	76 67                	jbe    1011c0 <realloc+0xb4>
            struct block_header * free_header = (struct block_header *) ((uintptr_t) ptr + newPayloadSz);
  101159:	48 8d 3c 1f          	lea    (%rdi,%rbx,1),%rdi
            free_header->block_size = origPayloadSz - newPayloadSz;
  10115d:	4c 89 6f 10          	mov    %r13,0x10(%rdi)
            free_header->next = 0;
  101161:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
            free_header->prev = 0;
  101168:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10116f:	00 
            addNodeToList(free_header, &free_list_start);
  101170:	be 28 20 10 00       	mov    $0x102028,%esi
  101175:	e8 6c fd ff ff       	callq  100ee6 <addNodeToList>
            orig_header->block_size = newPayloadSz + HEADER_SIZE;
  10117a:	48 83 c3 18          	add    $0x18,%rbx
  10117e:	49 89 5c 24 f8       	mov    %rbx,-0x8(%r12)
  101183:	eb 3b                	jmp    1011c0 <realloc+0xb4>
    if(ptr == NULL) return malloc(sz);
  101185:	48 89 f7             	mov    %rsi,%rdi
  101188:	e8 c7 fe ff ff       	callq  101054 <malloc>
  10118d:	49 89 c6             	mov    %rax,%r14
  101190:	eb 2e                	jmp    1011c0 <realloc+0xb4>
        free(ptr);
  101192:	e8 e0 fd ff ff       	callq  100f77 <free>
        return 0;       // TODO: check return value
  101197:	41 be 00 00 00 00    	mov    $0x0,%r14d
  10119d:	eb 21                	jmp    1011c0 <realloc+0xb4>
    }

    // growing:

    // malloc a new block
    void * new_payload = malloc(newPayloadSz);
  10119f:	48 89 df             	mov    %rbx,%rdi
  1011a2:	e8 ad fe ff ff       	callq  101054 <malloc>
  1011a7:	49 89 c6             	mov    %rax,%r14

    // copy the data
    memcpy(new_payload, ptr, origPayloadSz);
  1011aa:	4c 89 ea             	mov    %r13,%rdx
  1011ad:	4c 89 e6             	mov    %r12,%rsi
  1011b0:	48 89 c7             	mov    %rax,%rdi
  1011b3:	e8 55 ef ff ff       	callq  10010d <memcpy>

    // free the original block
    free(ptr);
  1011b8:	4c 89 e7             	mov    %r12,%rdi
  1011bb:	e8 b7 fd ff ff       	callq  100f77 <free>

    // return start of new payload
    return new_payload;
}
  1011c0:	4c 89 f0             	mov    %r14,%rax
  1011c3:	48 83 c4 08          	add    $0x8,%rsp
  1011c7:	5b                   	pop    %rbx
  1011c8:	41 5c                	pop    %r12
  1011ca:	41 5d                	pop    %r13
  1011cc:	41 5e                	pop    %r14
  1011ce:	41 5f                	pop    %r15
  1011d0:	5d                   	pop    %rbp
  1011d1:	c3                   	retq   

00000000001011d2 <defrag>:

void defrag() {
    if(free_list_start == 0) return;
  1011d2:	48 8b 15 4f 0e 00 00 	mov    0xe4f(%rip),%rdx        # 102028 <free_list_start>
  1011d9:	48 85 d2             	test   %rdx,%rdx
  1011dc:	74 08                	je     1011e6 <defrag+0x14>

    // iterate through free-node list
    struct block_header * node = free_list_start;
    struct block_header * nextNode = node->next;
  1011de:	48 8b 02             	mov    (%rdx),%rax
    while(nextNode != 0){
  1011e1:	48 85 c0             	test   %rax,%rax
  1011e4:	75 0c                	jne    1011f2 <defrag+0x20>
        } else {
            node = nextNode;
            nextNode = node->next;
        }
    }
}
  1011e6:	c3                   	retq   
            nextNode = node->next;
  1011e7:	48 89 c2             	mov    %rax,%rdx
  1011ea:	48 8b 00             	mov    (%rax),%rax
    while(nextNode != 0){
  1011ed:	48 85 c0             	test   %rax,%rax
  1011f0:	74 f4                	je     1011e6 <defrag+0x14>
        if((uintptr_t) nextNode - (uintptr_t) node == node->block_size) {
  1011f2:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  1011f6:	48 89 c6             	mov    %rax,%rsi
  1011f9:	48 29 d6             	sub    %rdx,%rsi
  1011fc:	48 39 ce             	cmp    %rcx,%rsi
  1011ff:	75 e6                	jne    1011e7 <defrag+0x15>
            node->block_size += nextNode->block_size;
  101201:	48 03 48 10          	add    0x10(%rax),%rcx
  101205:	48 89 4a 10          	mov    %rcx,0x10(%rdx)
            node->next = nextNode->next;
  101209:	48 8b 00             	mov    (%rax),%rax
  10120c:	48 89 02             	mov    %rax,(%rdx)
            if(nextNode->next) nextNode->next->prev = node;
  10120f:	48 85 c0             	test   %rax,%rax
  101212:	74 04                	je     101218 <defrag+0x46>
  101214:	48 89 50 08          	mov    %rdx,0x8(%rax)
            nextNode = node->next;
  101218:	48 8b 02             	mov    (%rdx),%rax
  10121b:	eb d0                	jmp    1011ed <defrag+0x1b>

000000000010121d <heap_info>:




int heap_info(heap_info_struct * info) {
  10121d:	55                   	push   %rbp
  10121e:	48 89 e5             	mov    %rsp,%rbp
  101221:	41 57                	push   %r15
  101223:	41 56                	push   %r14
  101225:	41 55                	push   %r13
  101227:	41 54                	push   %r12
  101229:	53                   	push   %rbx
  10122a:	48 83 ec 08          	sub    $0x8,%rsp
  10122e:	49 89 fc             	mov    %rdi,%r12
    size_t largest_free_chunk = 0;
    size_t free_space = 0;

    // iterate through free-node list
    // app_printf(0, "%x\n", free_list_start);
    if(free_list_start != 0) {
  101231:	48 8b 05 f0 0d 00 00 	mov    0xdf0(%rip),%rax        # 102028 <free_list_start>
  101238:	48 85 c0             	test   %rax,%rax
  10123b:	74 62                	je     10129f <heap_info+0x82>
    size_t free_space = 0;
  10123d:	be 00 00 00 00       	mov    $0x0,%esi
    size_t largest_free_chunk = 0;
  101242:	b9 00 00 00 00       	mov    $0x0,%ecx
        struct block_header * node = free_list_start;
        while(node != 0){
            free_space += node->block_size;
  101247:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10124b:	48 01 d6             	add    %rdx,%rsi
            if(node->block_size > largest_free_chunk)
  10124e:	48 39 d1             	cmp    %rdx,%rcx
  101251:	48 0f 42 ca          	cmovb  %rdx,%rcx
                largest_free_chunk = node->block_size;
            node = node->next;
  101255:	48 8b 00             	mov    (%rax),%rax
        while(node != 0){
  101258:	48 85 c0             	test   %rax,%rax
  10125b:	75 ea                	jne    101247 <heap_info+0x2a>
        }
    }
    info->free_space = free_space;
  10125d:	41 89 74 24 18       	mov    %esi,0x18(%r12)
    info->largest_free_chunk = largest_free_chunk;
  101262:	41 89 4c 24 1c       	mov    %ecx,0x1c(%r12)


    /* Allocated block stuff */

    // number of allocated blocks
    int num_allocs = (int) number_allocs;
  101267:	44 8b 3d aa 0d 00 00 	mov    0xdaa(%rip),%r15d        # 102018 <number_allocs>

    if(num_allocs == 0){
  10126e:	45 85 ff             	test   %r15d,%r15d
  101271:	75 38                	jne    1012ab <heap_info+0x8e>
        info->num_allocs = 0;
  101273:	41 c7 04 24 00 00 00 	movl   $0x0,(%r12)
  10127a:	00 
        info->size_array = 0;
  10127b:	49 c7 44 24 08 00 00 	movq   $0x0,0x8(%r12)
  101282:	00 00 
        info->ptr_array = 0;
  101284:	49 c7 44 24 10 00 00 	movq   $0x0,0x10(%r12)
  10128b:	00 00 
    info->num_allocs = num_allocs;
    info->size_array = size_array;
    info->ptr_array = ptr_array;

    return 0;
}
  10128d:	44 89 f8             	mov    %r15d,%eax
  101290:	48 83 c4 08          	add    $0x8,%rsp
  101294:	5b                   	pop    %rbx
  101295:	41 5c                	pop    %r12
  101297:	41 5d                	pop    %r13
  101299:	41 5e                	pop    %r14
  10129b:	41 5f                	pop    %r15
  10129d:	5d                   	pop    %rbp
  10129e:	c3                   	retq   
    size_t free_space = 0;
  10129f:	be 00 00 00 00       	mov    $0x0,%esi
    size_t largest_free_chunk = 0;
  1012a4:	b9 00 00 00 00       	mov    $0x0,%ecx
  1012a9:	eb b2                	jmp    10125d <heap_info+0x40>
    ptr_with_size * arr = malloc(num_allocs * sizeof(ptr_with_size));
  1012ab:	4d 63 ef             	movslq %r15d,%r13
  1012ae:	4c 89 ef             	mov    %r13,%rdi
  1012b1:	48 c1 e7 04          	shl    $0x4,%rdi
  1012b5:	e8 9a fd ff ff       	callq  101054 <malloc>
  1012ba:	48 89 c3             	mov    %rax,%rbx
    if(arr == 0) return -1;
  1012bd:	48 85 c0             	test   %rax,%rax
  1012c0:	0f 84 c8 00 00 00    	je     10138e <heap_info+0x171>
    if(allocated_list_start != 0){
  1012c6:	48 8b 05 53 0d 00 00 	mov    0xd53(%rip),%rax        # 102020 <allocated_list_start>
  1012cd:	48 85 c0             	test   %rax,%rax
  1012d0:	74 36                	je     101308 <heap_info+0xeb>
    int index = 0;
  1012d2:	be 00 00 00 00       	mov    $0x0,%esi
  1012d7:	eb 24                	jmp    1012fd <heap_info+0xe0>
                arr[index].ptr = (void*) ((uintptr_t) node + HEADER_SIZE);
  1012d9:	48 63 d6             	movslq %esi,%rdx
  1012dc:	48 c1 e2 04          	shl    $0x4,%rdx
  1012e0:	48 01 da             	add    %rbx,%rdx
  1012e3:	48 89 0a             	mov    %rcx,(%rdx)
                arr[index].size = node->block_size - HEADER_SIZE;
  1012e6:	48 8b 78 10          	mov    0x10(%rax),%rdi
  1012ea:	48 8d 4f e8          	lea    -0x18(%rdi),%rcx
  1012ee:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
                index++;
  1012f2:	83 c6 01             	add    $0x1,%esi
            node = node->next;
  1012f5:	48 8b 00             	mov    (%rax),%rax
        while(node != 0){
  1012f8:	48 85 c0             	test   %rax,%rax
  1012fb:	74 0b                	je     101308 <heap_info+0xeb>
            if((uintptr_t) node + HEADER_SIZE != (uintptr_t) arr) {
  1012fd:	48 8d 48 18          	lea    0x18(%rax),%rcx
  101301:	48 39 cb             	cmp    %rcx,%rbx
  101304:	75 d3                	jne    1012d9 <heap_info+0xbc>
  101306:	eb ed                	jmp    1012f5 <heap_info+0xd8>
    quicksort(arr, num_allocs, sizeof(ptr_with_size), &compare);
  101308:	b9 82 0a 10 00       	mov    $0x100a82,%ecx
  10130d:	ba 10 00 00 00       	mov    $0x10,%edx
  101312:	4c 89 ee             	mov    %r13,%rsi
  101315:	48 89 df             	mov    %rbx,%rdi
  101318:	e8 6d f7 ff ff       	callq  100a8a <quicksort>
    long * size_array = malloc(num_allocs * sizeof(long));
  10131d:	49 c1 e5 03          	shl    $0x3,%r13
  101321:	4c 89 ef             	mov    %r13,%rdi
  101324:	e8 2b fd ff ff       	callq  101054 <malloc>
  101329:	49 89 c6             	mov    %rax,%r14
    void ** ptr_array = malloc(num_allocs * sizeof(void *));
  10132c:	4c 89 ef             	mov    %r13,%rdi
  10132f:	e8 20 fd ff ff       	callq  101054 <malloc>
  101334:	49 89 c5             	mov    %rax,%r13
    if(size_array == 0 || ptr_array == 0) return -1;
  101337:	4d 85 f6             	test   %r14,%r14
  10133a:	74 5d                	je     101399 <heap_info+0x17c>
  10133c:	48 85 c0             	test   %rax,%rax
  10133f:	74 58                	je     101399 <heap_info+0x17c>
    for(int i = 0; i < num_allocs; i++){
  101341:	45 85 ff             	test   %r15d,%r15d
  101344:	7e 27                	jle    10136d <heap_info+0x150>
  101346:	44 89 f9             	mov    %r15d,%ecx
  101349:	48 c1 e1 03          	shl    $0x3,%rcx
  10134d:	b8 00 00 00 00       	mov    $0x0,%eax
        size_array[i] = arr[i].size;
  101352:	48 8b 54 43 08       	mov    0x8(%rbx,%rax,2),%rdx
  101357:	49 89 14 06          	mov    %rdx,(%r14,%rax,1)
        ptr_array[i] = arr[i].ptr;
  10135b:	48 8b 14 43          	mov    (%rbx,%rax,2),%rdx
  10135f:	49 89 54 05 00       	mov    %rdx,0x0(%r13,%rax,1)
    for(int i = 0; i < num_allocs; i++){
  101364:	48 83 c0 08          	add    $0x8,%rax
  101368:	48 39 c1             	cmp    %rax,%rcx
  10136b:	75 e5                	jne    101352 <heap_info+0x135>
    free(arr);
  10136d:	48 89 df             	mov    %rbx,%rdi
  101370:	e8 02 fc ff ff       	callq  100f77 <free>
    info->num_allocs = num_allocs;
  101375:	45 89 3c 24          	mov    %r15d,(%r12)
    info->size_array = size_array;
  101379:	4d 89 74 24 08       	mov    %r14,0x8(%r12)
    info->ptr_array = ptr_array;
  10137e:	4d 89 6c 24 10       	mov    %r13,0x10(%r12)
    return 0;
  101383:	41 bf 00 00 00 00    	mov    $0x0,%r15d
  101389:	e9 ff fe ff ff       	jmpq   10128d <heap_info+0x70>
    if(arr == 0) return -1;
  10138e:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
  101394:	e9 f4 fe ff ff       	jmpq   10128d <heap_info+0x70>
    if(size_array == 0 || ptr_array == 0) return -1;
  101399:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
  10139f:	e9 e9 fe ff ff       	jmpq   10128d <heap_info+0x70>

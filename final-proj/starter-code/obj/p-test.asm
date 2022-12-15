
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:

uint8_t * heap_top;
uint8_t * heap_bottom;
uint8_t * stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100008:	cd 31                	int    $0x31
  10000a:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  10000c:	e8 36 03 00 00       	callq  100347 <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100011:	b8 27 20 10 00       	mov    $0x102027,%eax
  100016:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001c:	48 89 05 ed 0f 00 00 	mov    %rax,0xfed(%rip)        # 101010 <heap_top>
  100023:	48 89 05 de 0f 00 00 	mov    %rax,0xfde(%rip)        # 101008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10002a:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  10002d:	48 83 e8 01          	sub    $0x1,%rax
  100031:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100037:	48 89 05 c2 0f 00 00 	mov    %rax,0xfc2(%rip)        # 101000 <stack_bottom>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  10003e:	bf 00 54 00 00       	mov    $0x5400,%edi
  100043:	cd 3a                	int    $0x3a
  100045:	48 89 05 cc 0f 00 00 	mov    %rax,0xfcc(%rip)        # 101018 <result.0>

    /* move the break forward by 21KB -> ~5 pages */
    assert(sbrk(1024*21) == heap_bottom);
  10004c:	48 39 05 b5 0f 00 00 	cmp    %rax,0xfb5(%rip)        # 101008 <heap_bottom>
  100053:	74 14                	je     100069 <process_main+0x69>
  100055:	ba e0 0c 10 00       	mov    $0x100ce0,%edx
  10005a:	be 15 00 00 00       	mov    $0x15,%esi
  10005f:	bf fd 0c 10 00       	mov    $0x100cfd,%edi
  100064:	e8 48 0c 00 00       	callq  100cb1 <assert_fail>
  100069:	bf 00 00 00 00       	mov    $0x0,%edi
  10006e:	cd 3a                	int    $0x3a
  100070:	48 89 05 a1 0f 00 00 	mov    %rax,0xfa1(%rip)        # 101018 <result.0>

    /* get the new break */
    heap_top = (uint8_t *)sbrk(0);
  100077:	48 89 05 92 0f 00 00 	mov    %rax,0xf92(%rip)        # 101010 <heap_top>

    /* force the pages to be allocated */
    for(size_t i = 0; i < (uintptr_t)(heap_top - heap_bottom); ++i) {
  10007e:	48 8b 15 83 0f 00 00 	mov    0xf83(%rip),%rdx        # 101008 <heap_bottom>
  100085:	48 39 d0             	cmp    %rdx,%rax
  100088:	74 29                	je     1000b3 <process_main+0xb3>
  10008a:	b8 00 00 00 00       	mov    $0x0,%eax
        heap_bottom[i] = 'A';
  10008f:	c6 04 02 41          	movb   $0x41,(%rdx,%rax,1)
        assert(heap_bottom[i] == 'A');
  100093:	48 8b 15 6e 0f 00 00 	mov    0xf6e(%rip),%rdx        # 101008 <heap_bottom>
  10009a:	80 3c 02 41          	cmpb   $0x41,(%rdx,%rax,1)
  10009e:	75 43                	jne    1000e3 <process_main+0xe3>
    for(size_t i = 0; i < (uintptr_t)(heap_top - heap_bottom); ++i) {
  1000a0:	48 83 c0 01          	add    $0x1,%rax
  1000a4:	48 8b 0d 65 0f 00 00 	mov    0xf65(%rip),%rcx        # 101010 <heap_top>
  1000ab:	48 29 d1             	sub    %rdx,%rcx
  1000ae:	48 39 c1             	cmp    %rax,%rcx
  1000b1:	77 dc                	ja     10008f <process_main+0x8f>
  1000b3:	48 c7 c7 00 ac ff ff 	mov    $0xffffffffffffac00,%rdi
  1000ba:	cd 3a                	int    $0x3a
  1000bc:	48 89 05 55 0f 00 00 	mov    %rax,0xf55(%rip)        # 101018 <result.0>
    }

    /* Break unmodied after optimistic allocation, move it back 21KB. */
    assert(sbrk(-1024*21) == heap_top);
  1000c3:	48 8b 15 46 0f 00 00 	mov    0xf46(%rip),%rdx        # 101010 <heap_top>
  1000ca:	48 39 c2             	cmp    %rax,%rdx
  1000cd:	74 28                	je     1000f7 <process_main+0xf7>
  1000cf:	ba 1c 0d 10 00       	mov    $0x100d1c,%edx
  1000d4:	be 21 00 00 00       	mov    $0x21,%esi
  1000d9:	bf fd 0c 10 00       	mov    $0x100cfd,%edi
  1000de:	e8 ce 0b 00 00       	callq  100cb1 <assert_fail>
        assert(heap_bottom[i] == 'A');
  1000e3:	ba 06 0d 10 00       	mov    $0x100d06,%edx
  1000e8:	be 1d 00 00 00       	mov    $0x1d,%esi
  1000ed:	bf fd 0c 10 00       	mov    $0x100cfd,%edi
  1000f2:	e8 ba 0b 00 00       	callq  100cb1 <assert_fail>

    /* check that pages were deallocated */
    for(uintptr_t va = (uintptr_t)heap_bottom; va < (uintptr_t)heap_top; va += 4096) {
  1000f7:	48 8b 35 0a 0f 00 00 	mov    0xf0a(%rip),%rsi        # 101008 <heap_bottom>
  1000fe:	48 39 f2             	cmp    %rsi,%rdx
  100101:	76 1c                	jbe    10011f <process_main+0x11f>
    asm volatile ("int %0" : /* no result */
  100103:	48 8d 7d e8          	lea    -0x18(%rbp),%rdi
  100107:	cd 36                	int    $0x36
        vamapping map;
        mapping(va, &map);
	assert(!(map.perm & PTE_P));
  100109:	f6 45 f8 01          	testb  $0x1,-0x8(%rbp)
  10010d:	75 1f                	jne    10012e <process_main+0x12e>
    for(uintptr_t va = (uintptr_t)heap_bottom; va < (uintptr_t)heap_top; va += 4096) {
  10010f:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
  100116:	48 39 35 f3 0e 00 00 	cmp    %rsi,0xef3(%rip)        # 101010 <heap_top>
  10011d:	77 e8                	ja     100107 <process_main+0x107>
    }

    TEST_PASS();
  10011f:	bf 4b 0d 10 00       	mov    $0x100d4b,%edi
  100124:	b8 00 00 00 00       	mov    $0x0,%eax
  100129:	e8 b5 0a 00 00       	callq  100be3 <kernel_panic>
	assert(!(map.perm & PTE_P));
  10012e:	ba 37 0d 10 00       	mov    $0x100d37,%edx
  100133:	be 27 00 00 00       	mov    $0x27,%esi
  100138:	bf fd 0c 10 00       	mov    $0x100cfd,%edi
  10013d:	e8 6f 0b 00 00       	callq  100cb1 <assert_fail>

0000000000100142 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100142:	48 89 f9             	mov    %rdi,%rcx
  100145:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100147:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  10014e:	00 
  10014f:	72 08                	jb     100159 <console_putc+0x17>
        cp->cursor = console;
  100151:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  100158:	00 
    }
    if (c == '\n') {
  100159:	40 80 fe 0a          	cmp    $0xa,%sil
  10015d:	74 16                	je     100175 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  10015f:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100163:	48 8d 50 02          	lea    0x2(%rax),%rdx
  100167:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  10016b:	40 0f b6 f6          	movzbl %sil,%esi
  10016f:	09 fe                	or     %edi,%esi
  100171:	66 89 30             	mov    %si,(%rax)
    }
}
  100174:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  100175:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  100179:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  100180:	4c 89 c6             	mov    %r8,%rsi
  100183:	48 d1 fe             	sar    %rsi
  100186:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10018d:	66 66 66 
  100190:	48 89 f0             	mov    %rsi,%rax
  100193:	48 f7 ea             	imul   %rdx
  100196:	48 c1 fa 05          	sar    $0x5,%rdx
  10019a:	49 c1 f8 3f          	sar    $0x3f,%r8
  10019e:	4c 29 c2             	sub    %r8,%rdx
  1001a1:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  1001a5:	48 c1 e2 04          	shl    $0x4,%rdx
  1001a9:	89 f0                	mov    %esi,%eax
  1001ab:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1001ad:	83 cf 20             	or     $0x20,%edi
  1001b0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1001b4:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  1001b8:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1001bc:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  1001bf:	83 c0 01             	add    $0x1,%eax
  1001c2:	83 f8 50             	cmp    $0x50,%eax
  1001c5:	75 e9                	jne    1001b0 <console_putc+0x6e>
  1001c7:	c3                   	retq   

00000000001001c8 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1001c8:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1001cc:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1001d0:	73 0b                	jae    1001dd <string_putc+0x15>
        *sp->s++ = c;
  1001d2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1001d6:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  1001da:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  1001dd:	c3                   	retq   

00000000001001de <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  1001de:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001e1:	48 85 d2             	test   %rdx,%rdx
  1001e4:	74 17                	je     1001fd <memcpy+0x1f>
  1001e6:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  1001eb:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  1001f0:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001f4:	48 83 c1 01          	add    $0x1,%rcx
  1001f8:	48 39 d1             	cmp    %rdx,%rcx
  1001fb:	75 ee                	jne    1001eb <memcpy+0xd>
}
  1001fd:	c3                   	retq   

00000000001001fe <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  1001fe:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  100201:	48 39 fe             	cmp    %rdi,%rsi
  100204:	72 1d                	jb     100223 <memmove+0x25>
        while (n-- > 0) {
  100206:	b9 00 00 00 00       	mov    $0x0,%ecx
  10020b:	48 85 d2             	test   %rdx,%rdx
  10020e:	74 12                	je     100222 <memmove+0x24>
            *d++ = *s++;
  100210:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  100214:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  100218:	48 83 c1 01          	add    $0x1,%rcx
  10021c:	48 39 ca             	cmp    %rcx,%rdx
  10021f:	75 ef                	jne    100210 <memmove+0x12>
}
  100221:	c3                   	retq   
  100222:	c3                   	retq   
    if (s < d && s + n > d) {
  100223:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  100227:	48 39 cf             	cmp    %rcx,%rdi
  10022a:	73 da                	jae    100206 <memmove+0x8>
        while (n-- > 0) {
  10022c:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  100230:	48 85 d2             	test   %rdx,%rdx
  100233:	74 ec                	je     100221 <memmove+0x23>
            *--d = *--s;
  100235:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  100239:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  10023c:	48 83 e9 01          	sub    $0x1,%rcx
  100240:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  100244:	75 ef                	jne    100235 <memmove+0x37>
  100246:	c3                   	retq   

0000000000100247 <memset>:
void* memset(void* v, int c, size_t n) {
  100247:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10024a:	48 85 d2             	test   %rdx,%rdx
  10024d:	74 12                	je     100261 <memset+0x1a>
  10024f:	48 01 fa             	add    %rdi,%rdx
  100252:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  100255:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100258:	48 83 c1 01          	add    $0x1,%rcx
  10025c:	48 39 ca             	cmp    %rcx,%rdx
  10025f:	75 f4                	jne    100255 <memset+0xe>
}
  100261:	c3                   	retq   

0000000000100262 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100262:	80 3f 00             	cmpb   $0x0,(%rdi)
  100265:	74 10                	je     100277 <strlen+0x15>
  100267:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  10026c:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  100270:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  100274:	75 f6                	jne    10026c <strlen+0xa>
  100276:	c3                   	retq   
  100277:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10027c:	c3                   	retq   

000000000010027d <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  10027d:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100280:	ba 00 00 00 00       	mov    $0x0,%edx
  100285:	48 85 f6             	test   %rsi,%rsi
  100288:	74 11                	je     10029b <strnlen+0x1e>
  10028a:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  10028e:	74 0c                	je     10029c <strnlen+0x1f>
        ++n;
  100290:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100294:	48 39 d0             	cmp    %rdx,%rax
  100297:	75 f1                	jne    10028a <strnlen+0xd>
  100299:	eb 04                	jmp    10029f <strnlen+0x22>
  10029b:	c3                   	retq   
  10029c:	48 89 d0             	mov    %rdx,%rax
}
  10029f:	c3                   	retq   

00000000001002a0 <strcpy>:
char* strcpy(char* dst, const char* src) {
  1002a0:	48 89 f8             	mov    %rdi,%rax
  1002a3:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  1002a8:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1002ac:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1002af:	48 83 c2 01          	add    $0x1,%rdx
  1002b3:	84 c9                	test   %cl,%cl
  1002b5:	75 f1                	jne    1002a8 <strcpy+0x8>
}
  1002b7:	c3                   	retq   

00000000001002b8 <strcmp>:
    while (*a && *b && *a == *b) {
  1002b8:	0f b6 07             	movzbl (%rdi),%eax
  1002bb:	84 c0                	test   %al,%al
  1002bd:	74 1a                	je     1002d9 <strcmp+0x21>
  1002bf:	0f b6 16             	movzbl (%rsi),%edx
  1002c2:	38 c2                	cmp    %al,%dl
  1002c4:	75 13                	jne    1002d9 <strcmp+0x21>
  1002c6:	84 d2                	test   %dl,%dl
  1002c8:	74 0f                	je     1002d9 <strcmp+0x21>
        ++a, ++b;
  1002ca:	48 83 c7 01          	add    $0x1,%rdi
  1002ce:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  1002d2:	0f b6 07             	movzbl (%rdi),%eax
  1002d5:	84 c0                	test   %al,%al
  1002d7:	75 e6                	jne    1002bf <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  1002d9:	3a 06                	cmp    (%rsi),%al
  1002db:	0f 97 c0             	seta   %al
  1002de:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  1002e1:	83 d8 00             	sbb    $0x0,%eax
}
  1002e4:	c3                   	retq   

00000000001002e5 <strchr>:
    while (*s && *s != (char) c) {
  1002e5:	0f b6 07             	movzbl (%rdi),%eax
  1002e8:	84 c0                	test   %al,%al
  1002ea:	74 10                	je     1002fc <strchr+0x17>
  1002ec:	40 38 f0             	cmp    %sil,%al
  1002ef:	74 18                	je     100309 <strchr+0x24>
        ++s;
  1002f1:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  1002f5:	0f b6 07             	movzbl (%rdi),%eax
  1002f8:	84 c0                	test   %al,%al
  1002fa:	75 f0                	jne    1002ec <strchr+0x7>
        return NULL;
  1002fc:	40 84 f6             	test   %sil,%sil
  1002ff:	b8 00 00 00 00       	mov    $0x0,%eax
  100304:	48 0f 44 c7          	cmove  %rdi,%rax
}
  100308:	c3                   	retq   
  100309:	48 89 f8             	mov    %rdi,%rax
  10030c:	c3                   	retq   

000000000010030d <rand>:
    if (!rand_seed_set) {
  10030d:	83 3d 10 0d 00 00 00 	cmpl   $0x0,0xd10(%rip)        # 101024 <rand_seed_set>
  100314:	74 1b                	je     100331 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100316:	69 05 00 0d 00 00 0d 	imul   $0x19660d,0xd00(%rip),%eax        # 101020 <rand_seed>
  10031d:	66 19 00 
  100320:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100325:	89 05 f5 0c 00 00    	mov    %eax,0xcf5(%rip)        # 101020 <rand_seed>
    return rand_seed & RAND_MAX;
  10032b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100330:	c3                   	retq   
    rand_seed = seed;
  100331:	c7 05 e5 0c 00 00 9e 	movl   $0x30d4879e,0xce5(%rip)        # 101020 <rand_seed>
  100338:	87 d4 30 
    rand_seed_set = 1;
  10033b:	c7 05 df 0c 00 00 01 	movl   $0x1,0xcdf(%rip)        # 101024 <rand_seed_set>
  100342:	00 00 00 
}
  100345:	eb cf                	jmp    100316 <rand+0x9>

0000000000100347 <srand>:
    rand_seed = seed;
  100347:	89 3d d3 0c 00 00    	mov    %edi,0xcd3(%rip)        # 101020 <rand_seed>
    rand_seed_set = 1;
  10034d:	c7 05 cd 0c 00 00 01 	movl   $0x1,0xccd(%rip)        # 101024 <rand_seed_set>
  100354:	00 00 00 
}
  100357:	c3                   	retq   

0000000000100358 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100358:	55                   	push   %rbp
  100359:	48 89 e5             	mov    %rsp,%rbp
  10035c:	41 57                	push   %r15
  10035e:	41 56                	push   %r14
  100360:	41 55                	push   %r13
  100362:	41 54                	push   %r12
  100364:	53                   	push   %rbx
  100365:	48 83 ec 58          	sub    $0x58,%rsp
  100369:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  10036d:	0f b6 02             	movzbl (%rdx),%eax
  100370:	84 c0                	test   %al,%al
  100372:	0f 84 b0 06 00 00    	je     100a28 <printer_vprintf+0x6d0>
  100378:	49 89 fe             	mov    %rdi,%r14
  10037b:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  10037e:	41 89 f7             	mov    %esi,%r15d
  100381:	e9 a4 04 00 00       	jmpq   10082a <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  100386:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  10038b:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  100391:	45 84 e4             	test   %r12b,%r12b
  100394:	0f 84 82 06 00 00    	je     100a1c <printer_vprintf+0x6c4>
        int flags = 0;
  10039a:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  1003a0:	41 0f be f4          	movsbl %r12b,%esi
  1003a4:	bf 61 0f 10 00       	mov    $0x100f61,%edi
  1003a9:	e8 37 ff ff ff       	callq  1002e5 <strchr>
  1003ae:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1003b1:	48 85 c0             	test   %rax,%rax
  1003b4:	74 55                	je     10040b <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  1003b6:	48 81 e9 61 0f 10 00 	sub    $0x100f61,%rcx
  1003bd:	b8 01 00 00 00       	mov    $0x1,%eax
  1003c2:	d3 e0                	shl    %cl,%eax
  1003c4:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1003c7:	48 83 c3 01          	add    $0x1,%rbx
  1003cb:	44 0f b6 23          	movzbl (%rbx),%r12d
  1003cf:	45 84 e4             	test   %r12b,%r12b
  1003d2:	75 cc                	jne    1003a0 <printer_vprintf+0x48>
  1003d4:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  1003d8:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  1003de:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  1003e5:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  1003e8:	0f 84 a9 00 00 00    	je     100497 <printer_vprintf+0x13f>
        int length = 0;
  1003ee:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  1003f3:	0f b6 13             	movzbl (%rbx),%edx
  1003f6:	8d 42 bd             	lea    -0x43(%rdx),%eax
  1003f9:	3c 37                	cmp    $0x37,%al
  1003fb:	0f 87 c4 04 00 00    	ja     1008c5 <printer_vprintf+0x56d>
  100401:	0f b6 c0             	movzbl %al,%eax
  100404:	ff 24 c5 70 0d 10 00 	jmpq   *0x100d70(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  10040b:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  10040f:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  100414:	3c 08                	cmp    $0x8,%al
  100416:	77 2f                	ja     100447 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100418:	0f b6 03             	movzbl (%rbx),%eax
  10041b:	8d 50 d0             	lea    -0x30(%rax),%edx
  10041e:	80 fa 09             	cmp    $0x9,%dl
  100421:	77 5e                	ja     100481 <printer_vprintf+0x129>
  100423:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  100429:	48 83 c3 01          	add    $0x1,%rbx
  10042d:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100432:	0f be c0             	movsbl %al,%eax
  100435:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10043a:	0f b6 03             	movzbl (%rbx),%eax
  10043d:	8d 50 d0             	lea    -0x30(%rax),%edx
  100440:	80 fa 09             	cmp    $0x9,%dl
  100443:	76 e4                	jbe    100429 <printer_vprintf+0xd1>
  100445:	eb 97                	jmp    1003de <printer_vprintf+0x86>
        } else if (*format == '*') {
  100447:	41 80 fc 2a          	cmp    $0x2a,%r12b
  10044b:	75 3f                	jne    10048c <printer_vprintf+0x134>
            width = va_arg(val, int);
  10044d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100451:	8b 07                	mov    (%rdi),%eax
  100453:	83 f8 2f             	cmp    $0x2f,%eax
  100456:	77 17                	ja     10046f <printer_vprintf+0x117>
  100458:	89 c2                	mov    %eax,%edx
  10045a:	48 03 57 10          	add    0x10(%rdi),%rdx
  10045e:	83 c0 08             	add    $0x8,%eax
  100461:	89 07                	mov    %eax,(%rdi)
  100463:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  100466:	48 83 c3 01          	add    $0x1,%rbx
  10046a:	e9 6f ff ff ff       	jmpq   1003de <printer_vprintf+0x86>
            width = va_arg(val, int);
  10046f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100473:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100477:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10047b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10047f:	eb e2                	jmp    100463 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100481:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  100487:	e9 52 ff ff ff       	jmpq   1003de <printer_vprintf+0x86>
        int width = -1;
  10048c:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  100492:	e9 47 ff ff ff       	jmpq   1003de <printer_vprintf+0x86>
            ++format;
  100497:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  10049b:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  10049f:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1004a2:	80 f9 09             	cmp    $0x9,%cl
  1004a5:	76 13                	jbe    1004ba <printer_vprintf+0x162>
            } else if (*format == '*') {
  1004a7:	3c 2a                	cmp    $0x2a,%al
  1004a9:	74 33                	je     1004de <printer_vprintf+0x186>
            ++format;
  1004ab:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1004ae:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1004b5:	e9 34 ff ff ff       	jmpq   1003ee <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1004ba:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  1004bf:	48 83 c2 01          	add    $0x1,%rdx
  1004c3:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  1004c6:	0f be c0             	movsbl %al,%eax
  1004c9:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1004cd:	0f b6 02             	movzbl (%rdx),%eax
  1004d0:	8d 70 d0             	lea    -0x30(%rax),%esi
  1004d3:	40 80 fe 09          	cmp    $0x9,%sil
  1004d7:	76 e6                	jbe    1004bf <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  1004d9:	48 89 d3             	mov    %rdx,%rbx
  1004dc:	eb 1c                	jmp    1004fa <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  1004de:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004e2:	8b 07                	mov    (%rdi),%eax
  1004e4:	83 f8 2f             	cmp    $0x2f,%eax
  1004e7:	77 23                	ja     10050c <printer_vprintf+0x1b4>
  1004e9:	89 c2                	mov    %eax,%edx
  1004eb:	48 03 57 10          	add    0x10(%rdi),%rdx
  1004ef:	83 c0 08             	add    $0x8,%eax
  1004f2:	89 07                	mov    %eax,(%rdi)
  1004f4:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  1004f6:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  1004fa:	85 c9                	test   %ecx,%ecx
  1004fc:	b8 00 00 00 00       	mov    $0x0,%eax
  100501:	0f 49 c1             	cmovns %ecx,%eax
  100504:	89 45 9c             	mov    %eax,-0x64(%rbp)
  100507:	e9 e2 fe ff ff       	jmpq   1003ee <printer_vprintf+0x96>
                precision = va_arg(val, int);
  10050c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100510:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100514:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100518:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10051c:	eb d6                	jmp    1004f4 <printer_vprintf+0x19c>
        switch (*format) {
  10051e:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100523:	e9 f3 00 00 00       	jmpq   10061b <printer_vprintf+0x2c3>
            ++format;
  100528:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  10052c:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100531:	e9 bd fe ff ff       	jmpq   1003f3 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100536:	85 c9                	test   %ecx,%ecx
  100538:	74 55                	je     10058f <printer_vprintf+0x237>
  10053a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10053e:	8b 07                	mov    (%rdi),%eax
  100540:	83 f8 2f             	cmp    $0x2f,%eax
  100543:	77 38                	ja     10057d <printer_vprintf+0x225>
  100545:	89 c2                	mov    %eax,%edx
  100547:	48 03 57 10          	add    0x10(%rdi),%rdx
  10054b:	83 c0 08             	add    $0x8,%eax
  10054e:	89 07                	mov    %eax,(%rdi)
  100550:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100553:	48 89 d0             	mov    %rdx,%rax
  100556:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  10055a:	49 89 d0             	mov    %rdx,%r8
  10055d:	49 f7 d8             	neg    %r8
  100560:	25 80 00 00 00       	and    $0x80,%eax
  100565:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100569:	0b 45 a8             	or     -0x58(%rbp),%eax
  10056c:	83 c8 60             	or     $0x60,%eax
  10056f:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  100572:	41 bc 70 0f 10 00    	mov    $0x100f70,%r12d
            break;
  100578:	e9 35 01 00 00       	jmpq   1006b2 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10057d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100581:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100585:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100589:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10058d:	eb c1                	jmp    100550 <printer_vprintf+0x1f8>
  10058f:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100593:	8b 07                	mov    (%rdi),%eax
  100595:	83 f8 2f             	cmp    $0x2f,%eax
  100598:	77 10                	ja     1005aa <printer_vprintf+0x252>
  10059a:	89 c2                	mov    %eax,%edx
  10059c:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005a0:	83 c0 08             	add    $0x8,%eax
  1005a3:	89 07                	mov    %eax,(%rdi)
  1005a5:	48 63 12             	movslq (%rdx),%rdx
  1005a8:	eb a9                	jmp    100553 <printer_vprintf+0x1fb>
  1005aa:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005ae:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1005b2:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005b6:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1005ba:	eb e9                	jmp    1005a5 <printer_vprintf+0x24d>
        int base = 10;
  1005bc:	be 0a 00 00 00       	mov    $0xa,%esi
  1005c1:	eb 58                	jmp    10061b <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1005c3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005c7:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005cb:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005cf:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005d3:	eb 60                	jmp    100635 <printer_vprintf+0x2dd>
  1005d5:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005d9:	8b 07                	mov    (%rdi),%eax
  1005db:	83 f8 2f             	cmp    $0x2f,%eax
  1005de:	77 10                	ja     1005f0 <printer_vprintf+0x298>
  1005e0:	89 c2                	mov    %eax,%edx
  1005e2:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005e6:	83 c0 08             	add    $0x8,%eax
  1005e9:	89 07                	mov    %eax,(%rdi)
  1005eb:	44 8b 02             	mov    (%rdx),%r8d
  1005ee:	eb 48                	jmp    100638 <printer_vprintf+0x2e0>
  1005f0:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005f4:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005f8:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005fc:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100600:	eb e9                	jmp    1005eb <printer_vprintf+0x293>
  100602:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  100605:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  10060c:	bf 50 0f 10 00       	mov    $0x100f50,%edi
  100611:	e9 e2 02 00 00       	jmpq   1008f8 <printer_vprintf+0x5a0>
            base = 16;
  100616:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10061b:	85 c9                	test   %ecx,%ecx
  10061d:	74 b6                	je     1005d5 <printer_vprintf+0x27d>
  10061f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100623:	8b 01                	mov    (%rcx),%eax
  100625:	83 f8 2f             	cmp    $0x2f,%eax
  100628:	77 99                	ja     1005c3 <printer_vprintf+0x26b>
  10062a:	89 c2                	mov    %eax,%edx
  10062c:	48 03 51 10          	add    0x10(%rcx),%rdx
  100630:	83 c0 08             	add    $0x8,%eax
  100633:	89 01                	mov    %eax,(%rcx)
  100635:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  100638:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  10063c:	85 f6                	test   %esi,%esi
  10063e:	79 c2                	jns    100602 <printer_vprintf+0x2aa>
        base = -base;
  100640:	41 89 f1             	mov    %esi,%r9d
  100643:	f7 de                	neg    %esi
  100645:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  10064c:	bf 30 0f 10 00       	mov    $0x100f30,%edi
  100651:	e9 a2 02 00 00       	jmpq   1008f8 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  100656:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10065a:	8b 07                	mov    (%rdi),%eax
  10065c:	83 f8 2f             	cmp    $0x2f,%eax
  10065f:	77 1c                	ja     10067d <printer_vprintf+0x325>
  100661:	89 c2                	mov    %eax,%edx
  100663:	48 03 57 10          	add    0x10(%rdi),%rdx
  100667:	83 c0 08             	add    $0x8,%eax
  10066a:	89 07                	mov    %eax,(%rdi)
  10066c:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  10066f:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  100676:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  10067b:	eb c3                	jmp    100640 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  10067d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100681:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100685:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100689:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10068d:	eb dd                	jmp    10066c <printer_vprintf+0x314>
            data = va_arg(val, char*);
  10068f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100693:	8b 01                	mov    (%rcx),%eax
  100695:	83 f8 2f             	cmp    $0x2f,%eax
  100698:	0f 87 a5 01 00 00    	ja     100843 <printer_vprintf+0x4eb>
  10069e:	89 c2                	mov    %eax,%edx
  1006a0:	48 03 51 10          	add    0x10(%rcx),%rdx
  1006a4:	83 c0 08             	add    $0x8,%eax
  1006a7:	89 01                	mov    %eax,(%rcx)
  1006a9:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1006ac:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1006b2:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006b5:	83 e0 20             	and    $0x20,%eax
  1006b8:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1006bb:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1006c1:	0f 85 21 02 00 00    	jne    1008e8 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1006c7:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006ca:	89 45 88             	mov    %eax,-0x78(%rbp)
  1006cd:	83 e0 60             	and    $0x60,%eax
  1006d0:	83 f8 60             	cmp    $0x60,%eax
  1006d3:	0f 84 54 02 00 00    	je     10092d <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1006d9:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006dc:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  1006df:	48 c7 45 a0 70 0f 10 	movq   $0x100f70,-0x60(%rbp)
  1006e6:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1006e7:	83 f8 21             	cmp    $0x21,%eax
  1006ea:	0f 84 79 02 00 00    	je     100969 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1006f0:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  1006f3:	89 f8                	mov    %edi,%eax
  1006f5:	f7 d0                	not    %eax
  1006f7:	c1 e8 1f             	shr    $0x1f,%eax
  1006fa:	89 45 84             	mov    %eax,-0x7c(%rbp)
  1006fd:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100701:	0f 85 9e 02 00 00    	jne    1009a5 <printer_vprintf+0x64d>
  100707:	84 c0                	test   %al,%al
  100709:	0f 84 96 02 00 00    	je     1009a5 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  10070f:	48 63 f7             	movslq %edi,%rsi
  100712:	4c 89 e7             	mov    %r12,%rdi
  100715:	e8 63 fb ff ff       	callq  10027d <strnlen>
  10071a:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  10071d:	8b 45 88             	mov    -0x78(%rbp),%eax
  100720:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  100723:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  10072a:	83 f8 22             	cmp    $0x22,%eax
  10072d:	0f 84 aa 02 00 00    	je     1009dd <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100733:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100737:	e8 26 fb ff ff       	callq  100262 <strlen>
  10073c:	8b 55 9c             	mov    -0x64(%rbp),%edx
  10073f:	03 55 98             	add    -0x68(%rbp),%edx
  100742:	44 89 e9             	mov    %r13d,%ecx
  100745:	29 d1                	sub    %edx,%ecx
  100747:	29 c1                	sub    %eax,%ecx
  100749:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  10074c:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10074f:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100753:	75 2d                	jne    100782 <printer_vprintf+0x42a>
  100755:	85 c9                	test   %ecx,%ecx
  100757:	7e 29                	jle    100782 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  100759:	44 89 fa             	mov    %r15d,%edx
  10075c:	be 20 00 00 00       	mov    $0x20,%esi
  100761:	4c 89 f7             	mov    %r14,%rdi
  100764:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100767:	41 83 ed 01          	sub    $0x1,%r13d
  10076b:	45 85 ed             	test   %r13d,%r13d
  10076e:	7f e9                	jg     100759 <printer_vprintf+0x401>
  100770:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  100773:	85 ff                	test   %edi,%edi
  100775:	b8 01 00 00 00       	mov    $0x1,%eax
  10077a:	0f 4f c7             	cmovg  %edi,%eax
  10077d:	29 c7                	sub    %eax,%edi
  10077f:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  100782:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100786:	0f b6 07             	movzbl (%rdi),%eax
  100789:	84 c0                	test   %al,%al
  10078b:	74 22                	je     1007af <printer_vprintf+0x457>
  10078d:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100791:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  100794:	0f b6 f0             	movzbl %al,%esi
  100797:	44 89 fa             	mov    %r15d,%edx
  10079a:	4c 89 f7             	mov    %r14,%rdi
  10079d:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  1007a0:	48 83 c3 01          	add    $0x1,%rbx
  1007a4:	0f b6 03             	movzbl (%rbx),%eax
  1007a7:	84 c0                	test   %al,%al
  1007a9:	75 e9                	jne    100794 <printer_vprintf+0x43c>
  1007ab:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1007af:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1007b2:	85 c0                	test   %eax,%eax
  1007b4:	7e 1d                	jle    1007d3 <printer_vprintf+0x47b>
  1007b6:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007ba:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1007bc:	44 89 fa             	mov    %r15d,%edx
  1007bf:	be 30 00 00 00       	mov    $0x30,%esi
  1007c4:	4c 89 f7             	mov    %r14,%rdi
  1007c7:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  1007ca:	83 eb 01             	sub    $0x1,%ebx
  1007cd:	75 ed                	jne    1007bc <printer_vprintf+0x464>
  1007cf:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  1007d3:	8b 45 98             	mov    -0x68(%rbp),%eax
  1007d6:	85 c0                	test   %eax,%eax
  1007d8:	7e 27                	jle    100801 <printer_vprintf+0x4a9>
  1007da:	89 c0                	mov    %eax,%eax
  1007dc:	4c 01 e0             	add    %r12,%rax
  1007df:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007e3:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  1007e6:	41 0f b6 34 24       	movzbl (%r12),%esi
  1007eb:	44 89 fa             	mov    %r15d,%edx
  1007ee:	4c 89 f7             	mov    %r14,%rdi
  1007f1:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  1007f4:	49 83 c4 01          	add    $0x1,%r12
  1007f8:	49 39 dc             	cmp    %rbx,%r12
  1007fb:	75 e9                	jne    1007e6 <printer_vprintf+0x48e>
  1007fd:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  100801:	45 85 ed             	test   %r13d,%r13d
  100804:	7e 14                	jle    10081a <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  100806:	44 89 fa             	mov    %r15d,%edx
  100809:	be 20 00 00 00       	mov    $0x20,%esi
  10080e:	4c 89 f7             	mov    %r14,%rdi
  100811:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  100814:	41 83 ed 01          	sub    $0x1,%r13d
  100818:	75 ec                	jne    100806 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  10081a:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  10081e:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100822:	84 c0                	test   %al,%al
  100824:	0f 84 fe 01 00 00    	je     100a28 <printer_vprintf+0x6d0>
        if (*format != '%') {
  10082a:	3c 25                	cmp    $0x25,%al
  10082c:	0f 84 54 fb ff ff    	je     100386 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100832:	0f b6 f0             	movzbl %al,%esi
  100835:	44 89 fa             	mov    %r15d,%edx
  100838:	4c 89 f7             	mov    %r14,%rdi
  10083b:	41 ff 16             	callq  *(%r14)
            continue;
  10083e:	4c 89 e3             	mov    %r12,%rbx
  100841:	eb d7                	jmp    10081a <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  100843:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100847:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10084b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10084f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100853:	e9 51 fe ff ff       	jmpq   1006a9 <printer_vprintf+0x351>
            color = va_arg(val, int);
  100858:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10085c:	8b 07                	mov    (%rdi),%eax
  10085e:	83 f8 2f             	cmp    $0x2f,%eax
  100861:	77 10                	ja     100873 <printer_vprintf+0x51b>
  100863:	89 c2                	mov    %eax,%edx
  100865:	48 03 57 10          	add    0x10(%rdi),%rdx
  100869:	83 c0 08             	add    $0x8,%eax
  10086c:	89 07                	mov    %eax,(%rdi)
  10086e:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  100871:	eb a7                	jmp    10081a <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  100873:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100877:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10087b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10087f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100883:	eb e9                	jmp    10086e <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  100885:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100889:	8b 01                	mov    (%rcx),%eax
  10088b:	83 f8 2f             	cmp    $0x2f,%eax
  10088e:	77 23                	ja     1008b3 <printer_vprintf+0x55b>
  100890:	89 c2                	mov    %eax,%edx
  100892:	48 03 51 10          	add    0x10(%rcx),%rdx
  100896:	83 c0 08             	add    $0x8,%eax
  100899:	89 01                	mov    %eax,(%rcx)
  10089b:	8b 02                	mov    (%rdx),%eax
  10089d:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  1008a0:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1008a4:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1008a8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1008ae:	e9 ff fd ff ff       	jmpq   1006b2 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  1008b3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1008b7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1008bb:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1008bf:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1008c3:	eb d6                	jmp    10089b <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  1008c5:	84 d2                	test   %dl,%dl
  1008c7:	0f 85 39 01 00 00    	jne    100a06 <printer_vprintf+0x6ae>
  1008cd:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  1008d1:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  1008d5:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  1008d9:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1008dd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1008e3:	e9 ca fd ff ff       	jmpq   1006b2 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  1008e8:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  1008ee:	bf 50 0f 10 00       	mov    $0x100f50,%edi
        if (flags & FLAG_NUMERIC) {
  1008f3:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  1008f8:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  1008fc:	4c 89 c1             	mov    %r8,%rcx
  1008ff:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  100903:	48 63 f6             	movslq %esi,%rsi
  100906:	49 83 ec 01          	sub    $0x1,%r12
  10090a:	48 89 c8             	mov    %rcx,%rax
  10090d:	ba 00 00 00 00       	mov    $0x0,%edx
  100912:	48 f7 f6             	div    %rsi
  100915:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  100919:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  10091d:	48 89 ca             	mov    %rcx,%rdx
  100920:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  100923:	48 39 d6             	cmp    %rdx,%rsi
  100926:	76 de                	jbe    100906 <printer_vprintf+0x5ae>
  100928:	e9 9a fd ff ff       	jmpq   1006c7 <printer_vprintf+0x36f>
                prefix = "-";
  10092d:	48 c7 45 a0 64 0d 10 	movq   $0x100d64,-0x60(%rbp)
  100934:	00 
            if (flags & FLAG_NEGATIVE) {
  100935:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100938:	a8 80                	test   $0x80,%al
  10093a:	0f 85 b0 fd ff ff    	jne    1006f0 <printer_vprintf+0x398>
                prefix = "+";
  100940:	48 c7 45 a0 5f 0d 10 	movq   $0x100d5f,-0x60(%rbp)
  100947:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100948:	a8 10                	test   $0x10,%al
  10094a:	0f 85 a0 fd ff ff    	jne    1006f0 <printer_vprintf+0x398>
                prefix = " ";
  100950:	a8 08                	test   $0x8,%al
  100952:	ba 70 0f 10 00       	mov    $0x100f70,%edx
  100957:	b8 6d 0f 10 00       	mov    $0x100f6d,%eax
  10095c:	48 0f 44 c2          	cmove  %rdx,%rax
  100960:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100964:	e9 87 fd ff ff       	jmpq   1006f0 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  100969:	41 8d 41 10          	lea    0x10(%r9),%eax
  10096d:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  100972:	0f 85 78 fd ff ff    	jne    1006f0 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  100978:	4d 85 c0             	test   %r8,%r8
  10097b:	75 0d                	jne    10098a <printer_vprintf+0x632>
  10097d:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  100984:	0f 84 66 fd ff ff    	je     1006f0 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  10098a:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  10098e:	ba 66 0d 10 00       	mov    $0x100d66,%edx
  100993:	b8 61 0d 10 00       	mov    $0x100d61,%eax
  100998:	48 0f 44 c2          	cmove  %rdx,%rax
  10099c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1009a0:	e9 4b fd ff ff       	jmpq   1006f0 <printer_vprintf+0x398>
            len = strlen(data);
  1009a5:	4c 89 e7             	mov    %r12,%rdi
  1009a8:	e8 b5 f8 ff ff       	callq  100262 <strlen>
  1009ad:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1009b0:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1009b4:	0f 84 63 fd ff ff    	je     10071d <printer_vprintf+0x3c5>
  1009ba:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1009be:	0f 84 59 fd ff ff    	je     10071d <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  1009c4:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  1009c7:	89 ca                	mov    %ecx,%edx
  1009c9:	29 c2                	sub    %eax,%edx
  1009cb:	39 c1                	cmp    %eax,%ecx
  1009cd:	b8 00 00 00 00       	mov    $0x0,%eax
  1009d2:	0f 4e d0             	cmovle %eax,%edx
  1009d5:	89 55 9c             	mov    %edx,-0x64(%rbp)
  1009d8:	e9 56 fd ff ff       	jmpq   100733 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  1009dd:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1009e1:	e8 7c f8 ff ff       	callq  100262 <strlen>
  1009e6:	8b 7d 98             	mov    -0x68(%rbp),%edi
  1009e9:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  1009ec:	44 89 e9             	mov    %r13d,%ecx
  1009ef:	29 f9                	sub    %edi,%ecx
  1009f1:	29 c1                	sub    %eax,%ecx
  1009f3:	44 39 ea             	cmp    %r13d,%edx
  1009f6:	b8 00 00 00 00       	mov    $0x0,%eax
  1009fb:	0f 4d c8             	cmovge %eax,%ecx
  1009fe:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  100a01:	e9 2d fd ff ff       	jmpq   100733 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  100a06:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100a09:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  100a0d:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100a11:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100a17:	e9 96 fc ff ff       	jmpq   1006b2 <printer_vprintf+0x35a>
        int flags = 0;
  100a1c:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100a23:	e9 b0 f9 ff ff       	jmpq   1003d8 <printer_vprintf+0x80>
}
  100a28:	48 83 c4 58          	add    $0x58,%rsp
  100a2c:	5b                   	pop    %rbx
  100a2d:	41 5c                	pop    %r12
  100a2f:	41 5d                	pop    %r13
  100a31:	41 5e                	pop    %r14
  100a33:	41 5f                	pop    %r15
  100a35:	5d                   	pop    %rbp
  100a36:	c3                   	retq   

0000000000100a37 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100a37:	55                   	push   %rbp
  100a38:	48 89 e5             	mov    %rsp,%rbp
  100a3b:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  100a3f:	48 c7 45 f0 42 01 10 	movq   $0x100142,-0x10(%rbp)
  100a46:	00 
        cpos = 0;
  100a47:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  100a4d:	b8 00 00 00 00       	mov    $0x0,%eax
  100a52:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100a55:	48 63 ff             	movslq %edi,%rdi
  100a58:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  100a5f:	00 
  100a60:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100a64:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100a68:	e8 eb f8 ff ff       	callq  100358 <printer_vprintf>
    return cp.cursor - console;
  100a6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a71:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100a77:	48 d1 f8             	sar    %rax
}
  100a7a:	c9                   	leaveq 
  100a7b:	c3                   	retq   

0000000000100a7c <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  100a7c:	55                   	push   %rbp
  100a7d:	48 89 e5             	mov    %rsp,%rbp
  100a80:	48 83 ec 50          	sub    $0x50,%rsp
  100a84:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a88:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a8c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  100a90:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100a97:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100a9b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100a9f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100aa3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100aa7:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100aab:	e8 87 ff ff ff       	callq  100a37 <console_vprintf>
}
  100ab0:	c9                   	leaveq 
  100ab1:	c3                   	retq   

0000000000100ab2 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100ab2:	55                   	push   %rbp
  100ab3:	48 89 e5             	mov    %rsp,%rbp
  100ab6:	53                   	push   %rbx
  100ab7:	48 83 ec 28          	sub    $0x28,%rsp
  100abb:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  100abe:	48 c7 45 d8 c8 01 10 	movq   $0x1001c8,-0x28(%rbp)
  100ac5:	00 
    sp.s = s;
  100ac6:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100aca:	48 85 f6             	test   %rsi,%rsi
  100acd:	75 0b                	jne    100ada <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100acf:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100ad2:	29 d8                	sub    %ebx,%eax
}
  100ad4:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100ad8:	c9                   	leaveq 
  100ad9:	c3                   	retq   
        sp.end = s + size - 1;
  100ada:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100adf:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100ae3:	be 00 00 00 00       	mov    $0x0,%esi
  100ae8:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100aec:	e8 67 f8 ff ff       	callq  100358 <printer_vprintf>
        *sp.s = 0;
  100af1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100af5:	c6 00 00             	movb   $0x0,(%rax)
  100af8:	eb d5                	jmp    100acf <vsnprintf+0x1d>

0000000000100afa <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100afa:	55                   	push   %rbp
  100afb:	48 89 e5             	mov    %rsp,%rbp
  100afe:	48 83 ec 50          	sub    $0x50,%rsp
  100b02:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b06:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b0a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100b0e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100b15:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100b19:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100b1d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100b21:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100b25:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100b29:	e8 84 ff ff ff       	callq  100ab2 <vsnprintf>
    va_end(val);
    return n;
}
  100b2e:	c9                   	leaveq 
  100b2f:	c3                   	retq   

0000000000100b30 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b30:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100b35:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100b3a:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b3f:	48 83 c0 02          	add    $0x2,%rax
  100b43:	48 39 d0             	cmp    %rdx,%rax
  100b46:	75 f2                	jne    100b3a <console_clear+0xa>
    }
    cursorpos = 0;
  100b48:	c7 05 aa 84 fb ff 00 	movl   $0x0,-0x47b56(%rip)        # b8ffc <cursorpos>
  100b4f:	00 00 00 
}
  100b52:	c3                   	retq   

0000000000100b53 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100b53:	55                   	push   %rbp
  100b54:	48 89 e5             	mov    %rsp,%rbp
  100b57:	48 83 ec 50          	sub    $0x50,%rsp
  100b5b:	49 89 f2             	mov    %rsi,%r10
  100b5e:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100b62:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b66:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b6a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100b6e:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100b73:	85 ff                	test   %edi,%edi
  100b75:	78 2e                	js     100ba5 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100b77:	48 63 ff             	movslq %edi,%rdi
  100b7a:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100b81:	cc cc cc 
  100b84:	48 89 f8             	mov    %rdi,%rax
  100b87:	48 f7 e2             	mul    %rdx
  100b8a:	48 89 d0             	mov    %rdx,%rax
  100b8d:	48 c1 e8 02          	shr    $0x2,%rax
  100b91:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100b95:	48 01 c2             	add    %rax,%rdx
  100b98:	48 29 d7             	sub    %rdx,%rdi
  100b9b:	0f b6 b7 9d 0f 10 00 	movzbl 0x100f9d(%rdi),%esi
  100ba2:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100ba5:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100bac:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100bb0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100bb4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100bb8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100bbc:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100bc0:	4c 89 d2             	mov    %r10,%rdx
  100bc3:	8b 3d 33 84 fb ff    	mov    -0x47bcd(%rip),%edi        # b8ffc <cursorpos>
  100bc9:	e8 69 fe ff ff       	callq  100a37 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100bce:	3d 30 07 00 00       	cmp    $0x730,%eax
  100bd3:	ba 00 00 00 00       	mov    $0x0,%edx
  100bd8:	0f 4d c2             	cmovge %edx,%eax
  100bdb:	89 05 1b 84 fb ff    	mov    %eax,-0x47be5(%rip)        # b8ffc <cursorpos>
    }
}
  100be1:	c9                   	leaveq 
  100be2:	c3                   	retq   

0000000000100be3 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  100be3:	55                   	push   %rbp
  100be4:	48 89 e5             	mov    %rsp,%rbp
  100be7:	53                   	push   %rbx
  100be8:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100bef:	48 89 fb             	mov    %rdi,%rbx
  100bf2:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100bf6:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100bfa:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100bfe:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100c02:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100c06:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100c0d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100c11:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100c15:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100c19:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100c1d:	ba 07 00 00 00       	mov    $0x7,%edx
  100c22:	be 67 0f 10 00       	mov    $0x100f67,%esi
  100c27:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100c2e:	e8 ab f5 ff ff       	callq  1001de <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100c33:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100c37:	48 89 da             	mov    %rbx,%rdx
  100c3a:	be 99 00 00 00       	mov    $0x99,%esi
  100c3f:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100c46:	e8 67 fe ff ff       	callq  100ab2 <vsnprintf>
  100c4b:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100c4e:	85 d2                	test   %edx,%edx
  100c50:	7e 0f                	jle    100c61 <kernel_panic+0x7e>
  100c52:	83 c0 06             	add    $0x6,%eax
  100c55:	48 98                	cltq   
  100c57:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100c5e:	0a 
  100c5f:	75 2a                	jne    100c8b <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100c61:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  100c68:	48 89 d9             	mov    %rbx,%rcx
  100c6b:	ba 71 0f 10 00       	mov    $0x100f71,%edx
  100c70:	be 00 c0 00 00       	mov    $0xc000,%esi
  100c75:	bf 30 07 00 00       	mov    $0x730,%edi
  100c7a:	b8 00 00 00 00       	mov    $0x0,%eax
  100c7f:	e8 f8 fd ff ff       	callq  100a7c <console_printf>
    asm volatile ("int %0" : /* no result */
  100c84:	48 89 df             	mov    %rbx,%rdi
  100c87:	cd 30                	int    $0x30
 loop: goto loop;
  100c89:	eb fe                	jmp    100c89 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100c8b:	48 63 c2             	movslq %edx,%rax
  100c8e:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100c94:	0f 94 c2             	sete   %dl
  100c97:	0f b6 d2             	movzbl %dl,%edx
  100c9a:	48 29 d0             	sub    %rdx,%rax
  100c9d:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100ca4:	ff 
  100ca5:	be 6f 0f 10 00       	mov    $0x100f6f,%esi
  100caa:	e8 f1 f5 ff ff       	callq  1002a0 <strcpy>
  100caf:	eb b0                	jmp    100c61 <kernel_panic+0x7e>

0000000000100cb1 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100cb1:	55                   	push   %rbp
  100cb2:	48 89 e5             	mov    %rsp,%rbp
  100cb5:	48 89 f9             	mov    %rdi,%rcx
  100cb8:	41 89 f0             	mov    %esi,%r8d
  100cbb:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100cbe:	ba 78 0f 10 00       	mov    $0x100f78,%edx
  100cc3:	be 00 c0 00 00       	mov    $0xc000,%esi
  100cc8:	bf 30 07 00 00       	mov    $0x730,%edi
  100ccd:	b8 00 00 00 00       	mov    $0x0,%eax
  100cd2:	e8 a5 fd ff ff       	callq  100a7c <console_printf>
    asm volatile ("int %0" : /* no result */
  100cd7:	bf 00 00 00 00       	mov    $0x0,%edi
  100cdc:	cd 30                	int    $0x30
 loop: goto loop;
  100cde:	eb fe                	jmp    100cde <assert_fail+0x2d>

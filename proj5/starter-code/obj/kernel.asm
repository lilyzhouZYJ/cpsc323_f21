
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	pushq  $0x0
        popfq
   4000c:	9d                   	popfq  
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 09 02 00 00       	jmpq   40236 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	pushq  $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	pushq  $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	pushq  $0x0
        pushq $32
   40038:	6a 20                	pushq  $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	pushq  $0x0
        pushq $48
   4003e:	6a 30                	pushq  $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	pushq  $0x0
        pushq $49
   40044:	6a 31                	pushq  $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	pushq  $0x0
        pushq $50
   4004a:	6a 32                	pushq  $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	pushq  $0x0
        pushq $51
   40050:	6a 33                	pushq  $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	pushq  $0x0
        pushq $52
   40056:	6a 34                	pushq  $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	pushq  $0x0
        pushq $53
   4005c:	6a 35                	pushq  $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	pushq  $0x0
        pushq $54
   40062:	6a 36                	pushq  $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	pushq  $0x0
        pushq $55
   40068:	6a 37                	pushq  $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	pushq  $0x0
        pushq $56
   4006e:	6a 38                	pushq  $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	pushq  $0x0
        pushq $57
   40074:	6a 39                	pushq  $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	pushq  $0x0
        pushq $58
   4007a:	6a 3a                	pushq  $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	pushq  $0x0
        pushq $59
   40080:	6a 3b                	pushq  $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	pushq  $0x0
        pushq $60
   40086:	6a 3c                	pushq  $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	pushq  $0x0
        pushq $61
   4008c:	6a 3d                	pushq  $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	pushq  $0x0
        pushq $62
   40092:	6a 3e                	pushq  $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	pushq  $0x0
        pushq $63
   40098:	6a 3f                	pushq  $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	pushq  $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	pushq  %gs
        pushq %fs
   400a2:	0f a0                	pushq  %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 d2 0d 00 00       	callq  40e95 <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	popq   %fs
        popq %gs
   400df:	0f a9                	popq   %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <getAvailablePhysicalPage>:
void processExit(pid_t pid);

// gets the next available physical page,
// using pageinfo array;
// returns -1 if no page is available
intptr_t getAvailablePhysicalPage(void){
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 10          	sub    $0x10,%rsp
    intptr_t physicalPage = -1;
   4016f:	48 c7 45 f8 ff ff ff 	movq   $0xffffffffffffffff,-0x8(%rbp)
   40176:	ff 
    for(int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++){
   40177:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4017e:	eb 35                	jmp    401b5 <getAvailablePhysicalPage+0x4e>
        if(pageinfo[i].refcount == 0 && pageinfo[i].owner == PO_FREE){
   40180:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40183:	48 98                	cltq   
   40185:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   4018c:	00 
   4018d:	84 c0                	test   %al,%al
   4018f:	75 20                	jne    401b1 <getAvailablePhysicalPage+0x4a>
   40191:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40194:	48 98                	cltq   
   40196:	0f b6 84 00 40 fe 04 	movzbl 0x4fe40(%rax,%rax,1),%eax
   4019d:	00 
   4019e:	84 c0                	test   %al,%al
   401a0:	75 0f                	jne    401b1 <getAvailablePhysicalPage+0x4a>
            // found available page
            physicalPage = PAGEADDRESS(i);
   401a2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   401a5:	48 98                	cltq   
   401a7:	48 c1 e0 0c          	shl    $0xc,%rax
   401ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
            break;
   401af:	eb 0d                	jmp    401be <getAvailablePhysicalPage+0x57>
    for(int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++){
   401b1:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   401b5:	81 7d f4 ff 01 00 00 	cmpl   $0x1ff,-0xc(%rbp)
   401bc:	7e c2                	jle    40180 <getAvailablePhysicalPage+0x19>
        }
    }
    return physicalPage;
   401be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   401c2:	c9                   	leaveq 
   401c3:	c3                   	retq   

00000000000401c4 <freeFailedPagetable>:

/* Helper function */
// If failed to allocate all 5 pages for the pagetable,
// need to free whatever has been allocated so far.
void freeFailedPagetable(x86_64_pagetable* pagetables[], int count){
   401c4:	55                   	push   %rbp
   401c5:	48 89 e5             	mov    %rsp,%rbp
   401c8:	48 83 ec 20          	sub    $0x20,%rsp
   401cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   401d0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    for(int i = 0; i < count; i++){
   401d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401da:	eb 4e                	jmp    4022a <freeFailedPagetable+0x66>
        pageinfo[PAGENUMBER(pagetables[i])].refcount = 0;
   401dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401df:	48 98                	cltq   
   401e1:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   401e8:	00 
   401e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401ed:	48 01 d0             	add    %rdx,%rax
   401f0:	48 8b 00             	mov    (%rax),%rax
   401f3:	48 c1 e8 0c          	shr    $0xc,%rax
   401f7:	48 98                	cltq   
   401f9:	c6 84 00 41 fe 04 00 	movb   $0x0,0x4fe41(%rax,%rax,1)
   40200:	00 
        pageinfo[PAGENUMBER(pagetables[i])].owner = PO_FREE;
   40201:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40204:	48 98                	cltq   
   40206:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   4020d:	00 
   4020e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40212:	48 01 d0             	add    %rdx,%rax
   40215:	48 8b 00             	mov    (%rax),%rax
   40218:	48 c1 e8 0c          	shr    $0xc,%rax
   4021c:	48 98                	cltq   
   4021e:	c6 84 00 40 fe 04 00 	movb   $0x0,0x4fe40(%rax,%rax,1)
   40225:	00 
    for(int i = 0; i < count; i++){
   40226:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4022a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4022d:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
   40230:	7c aa                	jl     401dc <freeFailedPagetable+0x18>
    }
}
   40232:	90                   	nop
   40233:	90                   	nop
   40234:	c9                   	leaveq 
   40235:	c3                   	retq   

0000000000040236 <kernel>:
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

static void process_setup(pid_t pid, int program_number);

void kernel(const char* command) {
   40236:	55                   	push   %rbp
   40237:	48 89 e5             	mov    %rsp,%rbp
   4023a:	48 83 ec 20          	sub    $0x20,%rsp
   4023e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40242:	e8 ce 1b 00 00       	callq  41e15 <hardware_init>
    pageinfo_init();
   40247:	e8 76 12 00 00       	callq  414c2 <pageinfo_init>
    console_clear();
   4024c:	e8 f8 3f 00 00       	callq  44249 <console_clear>
    timer_init(HZ);
   40251:	bf 64 00 00 00       	mov    $0x64,%edi
   40256:	e8 aa 20 00 00       	callq  42305 <timer_init>

    // isolate kernel memory
    virtual_memory_map(kernel_pagetable, 0, 0, PROC_START_ADDR, PTE_P | PTE_W);
   4025b:	48 8b 05 9e 1d 01 00 	mov    0x11d9e(%rip),%rax        # 52000 <kernel_pagetable>
   40262:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40268:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4026d:	ba 00 00 00 00       	mov    $0x0,%edx
   40272:	be 00 00 00 00       	mov    $0x0,%esi
   40277:	48 89 c7             	mov    %rax,%rdi
   4027a:	e8 d4 2d 00 00       	callq  43053 <virtual_memory_map>
    // except the console memory page
    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR, PAGESIZE, PTE_P | PTE_W | PTE_U);
   4027f:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   40284:	be 00 80 0b 00       	mov    $0xb8000,%esi
   40289:	48 8b 05 70 1d 01 00 	mov    0x11d70(%rip),%rax        # 52000 <kernel_pagetable>
   40290:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40296:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4029b:	48 89 c7             	mov    %rax,%rdi
   4029e:	e8 b0 2d 00 00       	callq  43053 <virtual_memory_map>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   402a3:	ba 00 0e 00 00       	mov    $0xe00,%edx
   402a8:	be 00 00 00 00       	mov    $0x0,%esi
   402ad:	bf 20 f0 04 00       	mov    $0x4f020,%edi
   402b2:	e8 a9 36 00 00       	callq  43960 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   402b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   402be:	eb 44                	jmp    40304 <kernel+0xce>
        processes[i].p_pid = i;
   402c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402c3:	48 63 d0             	movslq %eax,%rdx
   402c6:	48 89 d0             	mov    %rdx,%rax
   402c9:	48 c1 e0 03          	shl    $0x3,%rax
   402cd:	48 29 d0             	sub    %rdx,%rax
   402d0:	48 c1 e0 05          	shl    $0x5,%rax
   402d4:	48 8d 90 20 f0 04 00 	lea    0x4f020(%rax),%rdx
   402db:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402de:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   402e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402e3:	48 63 d0             	movslq %eax,%rdx
   402e6:	48 89 d0             	mov    %rdx,%rax
   402e9:	48 c1 e0 03          	shl    $0x3,%rax
   402ed:	48 29 d0             	sub    %rdx,%rax
   402f0:	48 c1 e0 05          	shl    $0x5,%rax
   402f4:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   402fa:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   40300:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40304:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40308:	7e b6                	jle    402c0 <kernel+0x8a>
    }

    if (command && strcmp(command, "fork") == 0) {
   4030a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4030f:	74 29                	je     4033a <kernel+0x104>
   40311:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40315:	be 80 42 04 00       	mov    $0x44280,%esi
   4031a:	48 89 c7             	mov    %rax,%rdi
   4031d:	e8 af 36 00 00       	callq  439d1 <strcmp>
   40322:	85 c0                	test   %eax,%eax
   40324:	75 14                	jne    4033a <kernel+0x104>
        process_setup(1, 4);
   40326:	be 04 00 00 00       	mov    $0x4,%esi
   4032b:	bf 01 00 00 00       	mov    $0x1,%edi
   40330:	e8 d1 00 00 00       	callq  40406 <process_setup>
   40335:	e9 c2 00 00 00       	jmpq   403fc <kernel+0x1c6>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4033a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4033f:	74 29                	je     4036a <kernel+0x134>
   40341:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40345:	be 85 42 04 00       	mov    $0x44285,%esi
   4034a:	48 89 c7             	mov    %rax,%rdi
   4034d:	e8 7f 36 00 00       	callq  439d1 <strcmp>
   40352:	85 c0                	test   %eax,%eax
   40354:	75 14                	jne    4036a <kernel+0x134>
        process_setup(1, 5);
   40356:	be 05 00 00 00       	mov    $0x5,%esi
   4035b:	bf 01 00 00 00       	mov    $0x1,%edi
   40360:	e8 a1 00 00 00       	callq  40406 <process_setup>
   40365:	e9 92 00 00 00       	jmpq   403fc <kernel+0x1c6>
    } else if (command && strcmp(command, "test") == 0) {
   4036a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4036f:	74 26                	je     40397 <kernel+0x161>
   40371:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40375:	be 8e 42 04 00       	mov    $0x4428e,%esi
   4037a:	48 89 c7             	mov    %rax,%rdi
   4037d:	e8 4f 36 00 00       	callq  439d1 <strcmp>
   40382:	85 c0                	test   %eax,%eax
   40384:	75 11                	jne    40397 <kernel+0x161>
        process_setup(1, 6);
   40386:	be 06 00 00 00       	mov    $0x6,%esi
   4038b:	bf 01 00 00 00       	mov    $0x1,%edi
   40390:	e8 71 00 00 00       	callq  40406 <process_setup>
   40395:	eb 65                	jmp    403fc <kernel+0x1c6>
    } else if (command && strcmp(command, "test2") == 0) {
   40397:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4039c:	74 39                	je     403d7 <kernel+0x1a1>
   4039e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   403a2:	be 93 42 04 00       	mov    $0x44293,%esi
   403a7:	48 89 c7             	mov    %rax,%rdi
   403aa:	e8 22 36 00 00       	callq  439d1 <strcmp>
   403af:	85 c0                	test   %eax,%eax
   403b1:	75 24                	jne    403d7 <kernel+0x1a1>
        for (pid_t i = 1; i <= 2; ++i) {
   403b3:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   403ba:	eb 13                	jmp    403cf <kernel+0x199>
            process_setup(i, 6);
   403bc:	8b 45 f8             	mov    -0x8(%rbp),%eax
   403bf:	be 06 00 00 00       	mov    $0x6,%esi
   403c4:	89 c7                	mov    %eax,%edi
   403c6:	e8 3b 00 00 00       	callq  40406 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   403cb:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   403cf:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   403d3:	7e e7                	jle    403bc <kernel+0x186>
   403d5:	eb 25                	jmp    403fc <kernel+0x1c6>
        }
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
   403d7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
   403de:	eb 16                	jmp    403f6 <kernel+0x1c0>
            process_setup(i, i - 1);
   403e0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   403e3:	8d 50 ff             	lea    -0x1(%rax),%edx
   403e6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   403e9:	89 d6                	mov    %edx,%esi
   403eb:	89 c7                	mov    %eax,%edi
   403ed:	e8 14 00 00 00       	callq  40406 <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   403f2:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   403f6:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   403fa:	7e e4                	jle    403e0 <kernel+0x1aa>
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
   403fc:	bf 00 f1 04 00       	mov    $0x4f100,%edi
   40401:	e8 5f 10 00 00       	callq  41465 <run>

0000000000040406 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   40406:	55                   	push   %rbp
   40407:	48 89 e5             	mov    %rsp,%rbp
   4040a:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4040e:	89 7d 8c             	mov    %edi,-0x74(%rbp)
   40411:	89 75 88             	mov    %esi,-0x78(%rbp)
    process_init(&processes[pid], 0);
   40414:	8b 45 8c             	mov    -0x74(%rbp),%eax
   40417:	48 63 d0             	movslq %eax,%rdx
   4041a:	48 89 d0             	mov    %rdx,%rax
   4041d:	48 c1 e0 03          	shl    $0x3,%rax
   40421:	48 29 d0             	sub    %rdx,%rax
   40424:	48 c1 e0 05          	shl    $0x5,%rax
   40428:	48 05 20 f0 04 00    	add    $0x4f020,%rax
   4042e:	be 00 00 00 00       	mov    $0x0,%esi
   40433:	48 89 c7             	mov    %rax,%rdi
   40436:	e8 5c 21 00 00       	callq  42597 <process_init>
    // pagetables[1] - L2
    // pagetables[2] - L3
    // pagetables[3] - L4
    // pagetables[4] - L4
    x86_64_pagetable* pagetables[5];
    int count = 0;
   4043b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    for(int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++){
   40442:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   40449:	eb 68                	jmp    404b3 <process_setup+0xad>
        if(pageinfo[i].refcount == 0){
   4044b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4044e:	48 98                	cltq   
   40450:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   40457:	00 
   40458:	84 c0                	test   %al,%al
   4045a:	75 53                	jne    404af <process_setup+0xa9>
            // found available page
            pagetables[count] = (x86_64_pagetable *) PAGEADDRESS(i);
   4045c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4045f:	48 98                	cltq   
   40461:	48 c1 e0 0c          	shl    $0xc,%rax
   40465:	48 89 c2             	mov    %rax,%rdx
   40468:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4046b:	48 98                	cltq   
   4046d:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
            assert(assign_physical_page((uintptr_t)pagetables[count], pid) == 0);
   40472:	8b 45 8c             	mov    -0x74(%rbp),%eax
   40475:	0f be c0             	movsbl %al,%eax
   40478:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4047b:	48 63 d2             	movslq %edx,%rdx
   4047e:	48 8b 54 d5 a8       	mov    -0x58(%rbp,%rdx,8),%rdx
   40483:	89 c6                	mov    %eax,%esi
   40485:	48 89 d7             	mov    %rdx,%rdi
   40488:	e8 a3 02 00 00       	callq  40730 <assign_physical_page>
   4048d:	85 c0                	test   %eax,%eax
   4048f:	74 14                	je     404a5 <process_setup+0x9f>
   40491:	ba a0 42 04 00       	mov    $0x442a0,%edx
   40496:	be ac 00 00 00       	mov    $0xac,%esi
   4049b:	bf dd 42 04 00       	mov    $0x442dd,%edi
   404a0:	e8 af 28 00 00       	callq  42d54 <assert_fail>
            count++;
   404a5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
            if(count == 5)
   404a9:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
   404ad:	74 0f                	je     404be <process_setup+0xb8>
    for(int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++){
   404af:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   404b3:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   404ba:	7e 8f                	jle    4044b <process_setup+0x45>
   404bc:	eb 01                	jmp    404bf <process_setup+0xb9>
                break;
   404be:	90                   	nop
        }
    }        

    if(count < 5) {
   404bf:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
   404c3:	7f 16                	jg     404db <process_setup+0xd5>
        freeFailedPagetable(pagetables, count);
   404c5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   404c8:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   404cc:	89 d6                	mov    %edx,%esi
   404ce:	48 89 c7             	mov    %rax,%rdi
   404d1:	e8 ee fc ff ff       	callq  401c4 <freeFailedPagetable>
        return;
   404d6:	e9 53 02 00 00       	jmpq   4072e <process_setup+0x328>
    }

    // initialize to 0
    for(int i = 0; i < 5; i++)
   404db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   404e2:	eb 20                	jmp    40504 <process_setup+0xfe>
        memset(pagetables[i], 0, PAGESIZE);
   404e4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   404e7:	48 98                	cltq   
   404e9:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   404ee:	ba 00 10 00 00       	mov    $0x1000,%edx
   404f3:	be 00 00 00 00       	mov    $0x0,%esi
   404f8:	48 89 c7             	mov    %rax,%rdi
   404fb:	e8 60 34 00 00       	callq  43960 <memset>
    for(int i = 0; i < 5; i++)
   40500:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40504:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   40508:	7e da                	jle    404e4 <process_setup+0xde>

    // connect the pagetable pages
    pagetables[0]->entry[0] =
        (x86_64_pageentry_t) pagetables[1] | PTE_P | PTE_W | PTE_U;
   4050a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4050e:	48 89 c2             	mov    %rax,%rdx
    pagetables[0]->entry[0] =
   40511:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
        (x86_64_pageentry_t) pagetables[1] | PTE_P | PTE_W | PTE_U;
   40515:	48 83 ca 07          	or     $0x7,%rdx
    pagetables[0]->entry[0] =
   40519:	48 89 10             	mov    %rdx,(%rax)
    pagetables[1]->entry[0] =
        (x86_64_pageentry_t) pagetables[2] | PTE_P | PTE_W | PTE_U;
   4051c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40520:	48 89 c2             	mov    %rax,%rdx
    pagetables[1]->entry[0] =
   40523:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
        (x86_64_pageentry_t) pagetables[2] | PTE_P | PTE_W | PTE_U;
   40527:	48 83 ca 07          	or     $0x7,%rdx
    pagetables[1]->entry[0] =
   4052b:	48 89 10             	mov    %rdx,(%rax)
    pagetables[2]->entry[0] =
        (x86_64_pageentry_t) pagetables[3] | PTE_P | PTE_W | PTE_U;
   4052e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40532:	48 89 c2             	mov    %rax,%rdx
    pagetables[2]->entry[0] =
   40535:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
        (x86_64_pageentry_t) pagetables[3] | PTE_P | PTE_W | PTE_U;
   40539:	48 83 ca 07          	or     $0x7,%rdx
    pagetables[2]->entry[0] =
   4053d:	48 89 10             	mov    %rdx,(%rax)
    pagetables[2]->entry[1] =
        (x86_64_pageentry_t) pagetables[4] | PTE_P | PTE_W | PTE_U;
   40540:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40544:	48 89 c2             	mov    %rax,%rdx
    pagetables[2]->entry[1] =
   40547:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
        (x86_64_pageentry_t) pagetables[4] | PTE_P | PTE_W | PTE_U;
   4054b:	48 83 ca 07          	or     $0x7,%rdx
    pagetables[2]->entry[1] =
   4054f:	48 89 50 08          	mov    %rdx,0x8(%rax)

    // copy mappings from kernel page table
    for(uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE){
   40553:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
   4055a:	00 
   4055b:	eb 59                	jmp    405b6 <process_setup+0x1b0>
        vamapping map = virtual_memory_lookup(kernel_pagetable, va);
   4055d:	48 8b 0d 9c 1a 01 00 	mov    0x11a9c(%rip),%rcx        # 52000 <kernel_pagetable>
   40564:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   40568:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4056c:	48 89 ce             	mov    %rcx,%rsi
   4056f:	48 89 c7             	mov    %rax,%rdi
   40572:	e8 91 2e 00 00       	callq  43408 <virtual_memory_lookup>
        assert(virtual_memory_map(pagetables[0], va, map.pa, PAGESIZE, map.perm) == 0);
   40577:	8b 4d a0             	mov    -0x60(%rbp),%ecx
   4057a:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   4057e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40582:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40586:	41 89 c8             	mov    %ecx,%r8d
   40589:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4058e:	48 89 c7             	mov    %rax,%rdi
   40591:	e8 bd 2a 00 00       	callq  43053 <virtual_memory_map>
   40596:	85 c0                	test   %eax,%eax
   40598:	74 14                	je     405ae <process_setup+0x1a8>
   4059a:	ba e8 42 04 00       	mov    $0x442e8,%edx
   4059f:	be c9 00 00 00       	mov    $0xc9,%esi
   405a4:	bf dd 42 04 00       	mov    $0x442dd,%edi
   405a9:	e8 a6 27 00 00       	callq  42d54 <assert_fail>
    for(uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE){
   405ae:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   405b5:	00 
   405b6:	48 81 7d e8 ff ff 0f 	cmpq   $0xfffff,-0x18(%rbp)
   405bd:	00 
   405be:	76 9d                	jbe    4055d <process_setup+0x157>
    }

    // set this process to point to the page table
    processes[pid].p_pagetable = pagetables[0];
   405c0:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   405c4:	8b 45 8c             	mov    -0x74(%rbp),%eax
   405c7:	48 63 c8             	movslq %eax,%rcx
   405ca:	48 89 c8             	mov    %rcx,%rax
   405cd:	48 c1 e0 03          	shl    $0x3,%rax
   405d1:	48 29 c8             	sub    %rcx,%rax
   405d4:	48 c1 e0 05          	shl    $0x5,%rax
   405d8:	48 05 f0 f0 04 00    	add    $0x4f0f0,%rax
   405de:	48 89 10             	mov    %rdx,(%rax)

    int r = program_load(&processes[pid], program_number, NULL);
   405e1:	8b 45 8c             	mov    -0x74(%rbp),%eax
   405e4:	48 63 d0             	movslq %eax,%rdx
   405e7:	48 89 d0             	mov    %rdx,%rax
   405ea:	48 c1 e0 03          	shl    $0x3,%rax
   405ee:	48 29 d0             	sub    %rdx,%rax
   405f1:	48 c1 e0 05          	shl    $0x5,%rax
   405f5:	48 8d 88 20 f0 04 00 	lea    0x4f020(%rax),%rcx
   405fc:	8b 45 88             	mov    -0x78(%rbp),%eax
   405ff:	ba 00 00 00 00       	mov    $0x0,%edx
   40604:	89 c6                	mov    %eax,%esi
   40606:	48 89 cf             	mov    %rcx,%rdi
   40609:	e8 f1 2e 00 00       	callq  434ff <program_load>
   4060e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    assert(r >= 0);
   40611:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   40615:	79 14                	jns    4062b <process_setup+0x225>
   40617:	ba 2f 43 04 00       	mov    $0x4432f,%edx
   4061c:	be d0 00 00 00       	mov    $0xd0,%esi
   40621:	bf dd 42 04 00       	mov    $0x442dd,%edi
   40626:	e8 29 27 00 00       	callq  42d54 <assert_fail>

    // processes[pid].p_registers.reg_rsp = PROC_START_ADDR + PROC_SIZE * pid;
    // change: stack of each process starts from address 0x300000 == MEMSIZE_VIRTUAL
    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL;
   4062b:	8b 45 8c             	mov    -0x74(%rbp),%eax
   4062e:	48 63 d0             	movslq %eax,%rdx
   40631:	48 89 d0             	mov    %rdx,%rax
   40634:	48 c1 e0 03          	shl    $0x3,%rax
   40638:	48 29 d0             	sub    %rdx,%rax
   4063b:	48 c1 e0 05          	shl    $0x5,%rax
   4063f:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   40645:	48 c7 00 00 00 30 00 	movq   $0x300000,(%rax)
    uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
   4064c:	8b 45 8c             	mov    -0x74(%rbp),%eax
   4064f:	48 63 d0             	movslq %eax,%rdx
   40652:	48 89 d0             	mov    %rdx,%rax
   40655:	48 c1 e0 03          	shl    $0x3,%rax
   40659:	48 29 d0             	sub    %rdx,%rax
   4065c:	48 c1 e0 05          	shl    $0x5,%rax
   40660:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   40666:	48 8b 00             	mov    (%rax),%rax
   40669:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   4066f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // get physical page for the stack page
    intptr_t pPage = getAvailablePhysicalPage();
   40673:	e8 ef fa ff ff       	callq  40167 <getAvailablePhysicalPage>
   40678:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if(pPage == -1){
   4067c:	48 83 7d d0 ff       	cmpq   $0xffffffffffffffff,-0x30(%rbp)
   40681:	75 0f                	jne    40692 <process_setup+0x28c>
        // console_printf(CPOS(23, 0), 0xC000, "%s\n", "no more space");
        processExit(pid);
   40683:	8b 45 8c             	mov    -0x74(%rbp),%eax
   40686:	89 c7                	mov    %eax,%edi
   40688:	e8 d0 07 00 00       	callq  40e5d <processExit>
        return;
   4068d:	e9 9c 00 00 00       	jmpq   4072e <process_setup+0x328>
    }

    assert(assign_physical_page(pPage, pid) == 0);
   40692:	8b 45 8c             	mov    -0x74(%rbp),%eax
   40695:	0f be d0             	movsbl %al,%edx
   40698:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4069c:	89 d6                	mov    %edx,%esi
   4069e:	48 89 c7             	mov    %rax,%rdi
   406a1:	e8 8a 00 00 00       	callq  40730 <assign_physical_page>
   406a6:	85 c0                	test   %eax,%eax
   406a8:	74 14                	je     406be <process_setup+0x2b8>
   406aa:	ba 38 43 04 00       	mov    $0x44338,%edx
   406af:	be df 00 00 00       	mov    $0xdf,%esi
   406b4:	bf dd 42 04 00       	mov    $0x442dd,%edi
   406b9:	e8 96 26 00 00       	callq  42d54 <assert_fail>
    assert(virtual_memory_map(processes[pid].p_pagetable, stack_page, pPage,
   406be:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   406c2:	8b 45 8c             	mov    -0x74(%rbp),%eax
   406c5:	48 63 c8             	movslq %eax,%rcx
   406c8:	48 89 c8             	mov    %rcx,%rax
   406cb:	48 c1 e0 03          	shl    $0x3,%rax
   406cf:	48 29 c8             	sub    %rcx,%rax
   406d2:	48 c1 e0 05          	shl    $0x5,%rax
   406d6:	48 05 f0 f0 04 00    	add    $0x4f0f0,%rax
   406dc:	48 8b 00             	mov    (%rax),%rax
   406df:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   406e3:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   406e9:	b9 00 10 00 00       	mov    $0x1000,%ecx
   406ee:	48 89 c7             	mov    %rax,%rdi
   406f1:	e8 5d 29 00 00       	callq  43053 <virtual_memory_map>
   406f6:	85 c0                	test   %eax,%eax
   406f8:	74 14                	je     4070e <process_setup+0x308>
   406fa:	ba 60 43 04 00       	mov    $0x44360,%edx
   406ff:	be e0 00 00 00       	mov    $0xe0,%esi
   40704:	bf dd 42 04 00       	mov    $0x442dd,%edi
   40709:	e8 46 26 00 00       	callq  42d54 <assert_fail>
                       PAGESIZE, PTE_P | PTE_W | PTE_U) == 0);
    processes[pid].p_state = P_RUNNABLE;
   4070e:	8b 45 8c             	mov    -0x74(%rbp),%eax
   40711:	48 63 d0             	movslq %eax,%rdx
   40714:	48 89 d0             	mov    %rdx,%rax
   40717:	48 c1 e0 03          	shl    $0x3,%rax
   4071b:	48 29 d0             	sub    %rdx,%rax
   4071e:	48 c1 e0 05          	shl    $0x5,%rax
   40722:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   40728:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   4072e:	c9                   	leaveq 
   4072f:	c3                   	retq   

0000000000040730 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40730:	55                   	push   %rbp
   40731:	48 89 e5             	mov    %rsp,%rbp
   40734:	48 83 ec 10          	sub    $0x10,%rsp
   40738:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4073c:	89 f0                	mov    %esi,%eax
   4073e:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   40741:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40745:	25 ff 0f 00 00       	and    $0xfff,%eax
   4074a:	48 85 c0             	test   %rax,%rax
   4074d:	75 20                	jne    4076f <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   4074f:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40756:	00 
   40757:	77 16                	ja     4076f <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40759:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4075d:	48 c1 e8 0c          	shr    $0xc,%rax
   40761:	48 98                	cltq   
   40763:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   4076a:	00 
   4076b:	84 c0                	test   %al,%al
   4076d:	74 07                	je     40776 <assign_physical_page+0x46>
        return -1;
   4076f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40774:	eb 2c                	jmp    407a2 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   40776:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4077a:	48 c1 e8 0c          	shr    $0xc,%rax
   4077e:	48 98                	cltq   
   40780:	c6 84 00 41 fe 04 00 	movb   $0x1,0x4fe41(%rax,%rax,1)
   40787:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40788:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4078c:	48 c1 e8 0c          	shr    $0xc,%rax
   40790:	48 98                	cltq   
   40792:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40796:	88 94 00 40 fe 04 00 	mov    %dl,0x4fe40(%rax,%rax,1)
        return 0;
   4079d:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   407a2:	c9                   	leaveq 
   407a3:	c3                   	retq   

00000000000407a4 <syscall_mapping>:

void syscall_mapping(proc* p){
   407a4:	55                   	push   %rbp
   407a5:	48 89 e5             	mov    %rsp,%rbp
   407a8:	48 83 ec 70          	sub    $0x70,%rsp
   407ac:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   407b0:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407b4:	48 8b 40 38          	mov    0x38(%rax),%rax
   407b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   407bc:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407c0:	48 8b 40 30          	mov    0x30(%rax),%rax
   407c4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   407c8:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407cc:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407d3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   407d7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407db:	48 89 ce             	mov    %rcx,%rsi
   407de:	48 89 c7             	mov    %rax,%rdi
   407e1:	e8 22 2c 00 00       	callq  43408 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   407e6:	8b 45 e0             	mov    -0x20(%rbp),%eax
   407e9:	48 98                	cltq   
   407eb:	83 e0 06             	and    $0x6,%eax
   407ee:	48 83 f8 06          	cmp    $0x6,%rax
   407f2:	75 73                	jne    40867 <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   407f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   407f8:	48 83 c0 17          	add    $0x17,%rax
   407fc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40800:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40804:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4080b:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4080f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40813:	48 89 ce             	mov    %rcx,%rsi
   40816:	48 89 c7             	mov    %rax,%rdi
   40819:	e8 ea 2b 00 00       	callq  43408 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   4081e:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40821:	48 98                	cltq   
   40823:	83 e0 03             	and    $0x3,%eax
   40826:	48 83 f8 03          	cmp    $0x3,%rax
   4082a:	75 3e                	jne    4086a <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   4082c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40830:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40837:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4083b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4083f:	48 89 ce             	mov    %rcx,%rsi
   40842:	48 89 c7             	mov    %rax,%rdi
   40845:	e8 be 2b 00 00       	callq  43408 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   4084a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4084e:	48 89 c1             	mov    %rax,%rcx
   40851:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40855:	ba 18 00 00 00       	mov    $0x18,%edx
   4085a:	48 89 c6             	mov    %rax,%rsi
   4085d:	48 89 cf             	mov    %rcx,%rdi
   40860:	e8 92 30 00 00       	callq  438f7 <memcpy>
   40865:	eb 04                	jmp    4086b <syscall_mapping+0xc7>
	return;
   40867:	90                   	nop
   40868:	eb 01                	jmp    4086b <syscall_mapping+0xc7>
	return;
   4086a:	90                   	nop
}
   4086b:	c9                   	leaveq 
   4086c:	c3                   	retq   

000000000004086d <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   4086d:	55                   	push   %rbp
   4086e:	48 89 e5             	mov    %rsp,%rbp
   40871:	48 83 ec 18          	sub    $0x18,%rsp
   40875:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40879:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4087d:	48 8b 40 38          	mov    0x38(%rax),%rax
   40881:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40884:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40888:	75 14                	jne    4089e <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   4088a:	0f b6 05 6f 57 00 00 	movzbl 0x576f(%rip),%eax        # 46000 <disp_global>
   40891:	84 c0                	test   %al,%al
   40893:	0f 94 c0             	sete   %al
   40896:	88 05 64 57 00 00    	mov    %al,0x5764(%rip)        # 46000 <disp_global>
   4089c:	eb 36                	jmp    408d4 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   4089e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   408a2:	78 2f                	js     408d3 <syscall_mem_tog+0x66>
   408a4:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   408a8:	7f 29                	jg     408d3 <syscall_mem_tog+0x66>
   408aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408ae:	8b 00                	mov    (%rax),%eax
   408b0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   408b3:	75 1e                	jne    408d3 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   408b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408b9:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   408c0:	84 c0                	test   %al,%al
   408c2:	0f 94 c0             	sete   %al
   408c5:	89 c2                	mov    %eax,%edx
   408c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408cb:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   408d1:	eb 01                	jmp    408d4 <syscall_mem_tog+0x67>
            return;
   408d3:	90                   	nop
    }
}
   408d4:	c9                   	leaveq 
   408d5:	c3                   	retq   

00000000000408d6 <createChildPagetable>:

/* helper function */
int createChildPagetable(pid_t pid){
   408d6:	55                   	push   %rbp
   408d7:	48 89 e5             	mov    %rsp,%rbp
   408da:	48 83 ec 60          	sub    $0x60,%rsp
   408de:	89 7d ac             	mov    %edi,-0x54(%rbp)
    // set up 5 pages for pagetables
    x86_64_pagetable* pagetables[5];
    int count = 0;
   408e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    for(int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++){
   408e8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   408ef:	eb 7a                	jmp    4096b <createChildPagetable+0x95>
        if(pageinfo[i].refcount == 0){
   408f1:	8b 45 f8             	mov    -0x8(%rbp),%eax
   408f4:	48 98                	cltq   
   408f6:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   408fd:	00 
   408fe:	84 c0                	test   %al,%al
   40900:	75 65                	jne    40967 <createChildPagetable+0x91>
            // found available page
            pagetables[count] = (x86_64_pagetable *) PAGEADDRESS(i);
   40902:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40905:	48 98                	cltq   
   40907:	48 c1 e0 0c          	shl    $0xc,%rax
   4090b:	48 89 c2             	mov    %rax,%rdx
   4090e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40911:	48 98                	cltq   
   40913:	48 89 54 c5 c8       	mov    %rdx,-0x38(%rbp,%rax,8)
            if(assign_physical_page((uintptr_t) pagetables[count], pid) < 0)
   40918:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4091b:	0f be c0             	movsbl %al,%eax
   4091e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40921:	48 63 d2             	movslq %edx,%rdx
   40924:	48 8b 54 d5 c8       	mov    -0x38(%rbp,%rdx,8),%rdx
   40929:	89 c6                	mov    %eax,%esi
   4092b:	48 89 d7             	mov    %rdx,%rdi
   4092e:	e8 fd fd ff ff       	callq  40730 <assign_physical_page>
   40933:	85 c0                	test   %eax,%eax
   40935:	79 0a                	jns    40941 <createChildPagetable+0x6b>
                return -1;
   40937:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4093c:	e9 2a 01 00 00       	jmpq   40a6b <createChildPagetable+0x195>
            memset(pagetables[count], 0, PAGESIZE);
   40941:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40944:	48 98                	cltq   
   40946:	48 8b 44 c5 c8       	mov    -0x38(%rbp,%rax,8),%rax
   4094b:	ba 00 10 00 00       	mov    $0x1000,%edx
   40950:	be 00 00 00 00       	mov    $0x0,%esi
   40955:	48 89 c7             	mov    %rax,%rdi
   40958:	e8 03 30 00 00       	callq  43960 <memset>
            count++;
   4095d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
            if(count == 5)
   40961:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
   40965:	74 13                	je     4097a <createChildPagetable+0xa4>
    for(int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++){
   40967:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4096b:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   40972:	0f 8e 79 ff ff ff    	jle    408f1 <createChildPagetable+0x1b>
   40978:	eb 01                	jmp    4097b <createChildPagetable+0xa5>
                break;
   4097a:	90                   	nop
        }
    }

    if(count < 5) {
   4097b:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
   4097f:	7f 1b                	jg     4099c <createChildPagetable+0xc6>
        freeFailedPagetable(pagetables, count);
   40981:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40984:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   40988:	89 d6                	mov    %edx,%esi
   4098a:	48 89 c7             	mov    %rax,%rdi
   4098d:	e8 32 f8 ff ff       	callq  401c4 <freeFailedPagetable>
        return -1;
   40992:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40997:	e9 cf 00 00 00       	jmpq   40a6b <createChildPagetable+0x195>
    }

    // connect the pagetable pages
    pagetables[0]->entry[0] =
        (x86_64_pageentry_t) pagetables[1] | PTE_P | PTE_W | PTE_U;
   4099c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   409a0:	48 89 c2             	mov    %rax,%rdx
    pagetables[0]->entry[0] =
   409a3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
        (x86_64_pageentry_t) pagetables[1] | PTE_P | PTE_W | PTE_U;
   409a7:	48 83 ca 07          	or     $0x7,%rdx
    pagetables[0]->entry[0] =
   409ab:	48 89 10             	mov    %rdx,(%rax)
    pagetables[1]->entry[0] =
        (x86_64_pageentry_t) pagetables[2] | PTE_P | PTE_W | PTE_U;
   409ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   409b2:	48 89 c2             	mov    %rax,%rdx
    pagetables[1]->entry[0] =
   409b5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
        (x86_64_pageentry_t) pagetables[2] | PTE_P | PTE_W | PTE_U;
   409b9:	48 83 ca 07          	or     $0x7,%rdx
    pagetables[1]->entry[0] =
   409bd:	48 89 10             	mov    %rdx,(%rax)
    pagetables[2]->entry[0] =
        (x86_64_pageentry_t) pagetables[3] | PTE_P | PTE_W | PTE_U;
   409c0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   409c4:	48 89 c2             	mov    %rax,%rdx
    pagetables[2]->entry[0] =
   409c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
        (x86_64_pageentry_t) pagetables[3] | PTE_P | PTE_W | PTE_U;
   409cb:	48 83 ca 07          	or     $0x7,%rdx
    pagetables[2]->entry[0] =
   409cf:	48 89 10             	mov    %rdx,(%rax)
    pagetables[2]->entry[1] =
        (x86_64_pageentry_t) pagetables[4] | PTE_P | PTE_W | PTE_U;
   409d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   409d6:	48 89 c2             	mov    %rax,%rdx
    pagetables[2]->entry[1] =
   409d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
        (x86_64_pageentry_t) pagetables[4] | PTE_P | PTE_W | PTE_U;
   409dd:	48 83 ca 07          	or     $0x7,%rdx
    pagetables[2]->entry[1] =
   409e1:	48 89 50 08          	mov    %rdx,0x8(%rax)

    // copy mappings from kernel page table
    for(uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE){
   409e5:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   409ec:	00 
   409ed:	eb 4c                	jmp    40a3b <createChildPagetable+0x165>
        vamapping map = virtual_memory_lookup(kernel_pagetable, va);
   409ef:	48 8b 0d 0a 16 01 00 	mov    0x1160a(%rip),%rcx        # 52000 <kernel_pagetable>
   409f6:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   409fa:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   409fe:	48 89 ce             	mov    %rcx,%rsi
   40a01:	48 89 c7             	mov    %rax,%rdi
   40a04:	e8 ff 29 00 00       	callq  43408 <virtual_memory_lookup>
        if(virtual_memory_map(pagetables[0], va, map.pa, PAGESIZE, map.perm) < 0)
   40a09:	8b 4d c0             	mov    -0x40(%rbp),%ecx
   40a0c:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   40a10:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40a14:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40a18:	41 89 c8             	mov    %ecx,%r8d
   40a1b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40a20:	48 89 c7             	mov    %rax,%rdi
   40a23:	e8 2b 26 00 00       	callq  43053 <virtual_memory_map>
   40a28:	85 c0                	test   %eax,%eax
   40a2a:	79 07                	jns    40a33 <createChildPagetable+0x15d>
            return -1;
   40a2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40a31:	eb 38                	jmp    40a6b <createChildPagetable+0x195>
    for(uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE){
   40a33:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   40a3a:	00 
   40a3b:	48 81 7d f0 ff ff 0f 	cmpq   $0xfffff,-0x10(%rbp)
   40a42:	00 
   40a43:	76 aa                	jbe    409ef <createChildPagetable+0x119>
    }

    // set this process to point to the page table
    processes[pid].p_pagetable = pagetables[0];
   40a45:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40a49:	8b 45 ac             	mov    -0x54(%rbp),%eax
   40a4c:	48 63 c8             	movslq %eax,%rcx
   40a4f:	48 89 c8             	mov    %rcx,%rax
   40a52:	48 c1 e0 03          	shl    $0x3,%rax
   40a56:	48 29 c8             	sub    %rcx,%rax
   40a59:	48 c1 e0 05          	shl    $0x5,%rax
   40a5d:	48 05 f0 f0 04 00    	add    $0x4f0f0,%rax
   40a63:	48 89 10             	mov    %rdx,(%rax)

    // if(pid == 3)
    //     log_printf("page num is %d, owner is %d\n", PAGENUMBER(processes[pid].p_pagetable), pid);

    return 0;
   40a66:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40a6b:	c9                   	leaveq 
   40a6c:	c3                   	retq   

0000000000040a6d <copyAppPage>:

/* Helper function: copies application page data from parent */
// returns -1 on failure
int copyAppPage(x86_64_pagetable* parent_ptable, x86_64_pagetable* child_ptable, pid_t childPid){
   40a6d:	55                   	push   %rbp
   40a6e:	48 89 e5             	mov    %rsp,%rbp
   40a71:	48 83 ec 50          	sub    $0x50,%rsp
   40a75:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   40a79:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   40a7d:	89 55 bc             	mov    %edx,-0x44(%rbp)
    // Whenever the parent process has an application-writable
    // page at virtual address V, then fork must allocate a new 
    // physical page P; copy the data from the parent’s page into 
    // P, using memcpy; and finally map page P at address V in the
    // child process’s page table.
    for(uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE){
   40a80:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   40a87:	00 
   40a88:	e9 3f 01 00 00       	jmpq   40bcc <copyAppPage+0x15f>
        vamapping memmap = virtual_memory_lookup(parent_ptable, va);
   40a8d:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40a91:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40a95:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40a99:	48 89 ce             	mov    %rcx,%rsi
   40a9c:	48 89 c7             	mov    %rax,%rdi
   40a9f:	e8 64 29 00 00       	callq  43408 <virtual_memory_lookup>
        if((memmap.perm & PTE_U) && (memmap.perm & PTE_W) && (memmap.perm & PTE_P)) {
   40aa4:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40aa7:	48 98                	cltq   
   40aa9:	83 e0 04             	and    $0x4,%eax
   40aac:	48 85 c0             	test   %rax,%rax
   40aaf:	0f 84 a6 00 00 00    	je     40b5b <copyAppPage+0xee>
   40ab5:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40ab8:	48 98                	cltq   
   40aba:	83 e0 02             	and    $0x2,%eax
   40abd:	48 85 c0             	test   %rax,%rax
   40ac0:	0f 84 95 00 00 00    	je     40b5b <copyAppPage+0xee>
   40ac6:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40ac9:	48 98                	cltq   
   40acb:	83 e0 01             	and    $0x1,%eax
   40ace:	48 85 c0             	test   %rax,%rax
   40ad1:	0f 84 84 00 00 00    	je     40b5b <copyAppPage+0xee>
            // allocate new physical page P
            intptr_t pPage = getAvailablePhysicalPage();
   40ad7:	e8 8b f6 ff ff       	callq  40167 <getAvailablePhysicalPage>
   40adc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
            if(pPage == -1)
   40ae0:	48 83 7d f0 ff       	cmpq   $0xffffffffffffffff,-0x10(%rbp)
   40ae5:	75 0a                	jne    40af1 <copyAppPage+0x84>
                return -1;
   40ae7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40aec:	e9 ee 00 00 00       	jmpq   40bdf <copyAppPage+0x172>

            // assign page to process
            if(assign_physical_page((uintptr_t) pPage, childPid) < 0)
   40af1:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40af4:	0f be d0             	movsbl %al,%edx
   40af7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40afb:	89 d6                	mov    %edx,%esi
   40afd:	48 89 c7             	mov    %rax,%rdi
   40b00:	e8 2b fc ff ff       	callq  40730 <assign_physical_page>
   40b05:	85 c0                	test   %eax,%eax
   40b07:	79 0a                	jns    40b13 <copyAppPage+0xa6>
                return -1;
   40b09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40b0e:	e9 cc 00 00 00       	jmpq   40bdf <copyAppPage+0x172>

            // copy data from parent's page into P
            memcpy((void *) pPage, (void *) memmap.pa, PAGESIZE);
   40b13:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40b17:	48 89 c1             	mov    %rax,%rcx
   40b1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40b1e:	ba 00 10 00 00       	mov    $0x1000,%edx
   40b23:	48 89 ce             	mov    %rcx,%rsi
   40b26:	48 89 c7             	mov    %rax,%rdi
   40b29:	e8 c9 2d 00 00       	callq  438f7 <memcpy>

            // map pPage at address va in the child process's page table
            if(virtual_memory_map(child_ptable, va, pPage, PAGESIZE, PTE_U | PTE_W | PTE_P) < 0)
   40b2e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40b32:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40b36:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40b3a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40b40:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40b45:	48 89 c7             	mov    %rax,%rdi
   40b48:	e8 06 25 00 00       	callq  43053 <virtual_memory_map>
   40b4d:	85 c0                	test   %eax,%eax
   40b4f:	79 72                	jns    40bc3 <copyAppPage+0x156>
                return -1;
   40b51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40b56:	e9 84 00 00 00       	jmpq   40bdf <copyAppPage+0x172>
        } else if ((memmap.perm & PTE_U) && (memmap.perm & PTE_P)){
   40b5b:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40b5e:	48 98                	cltq   
   40b60:	83 e0 04             	and    $0x4,%eax
   40b63:	48 85 c0             	test   %rax,%rax
   40b66:	74 5c                	je     40bc4 <copyAppPage+0x157>
   40b68:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40b6b:	48 98                	cltq   
   40b6d:	83 e0 01             	and    $0x1,%eax
   40b70:	48 85 c0             	test   %rax,%rax
   40b73:	74 4f                	je     40bc4 <copyAppPage+0x157>
            // not writable; shared data
            // do not need to copy; but need to increment refcount
            pageinfo[PAGENUMBER(memmap.pa)].refcount++;
   40b75:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40b79:	48 c1 e8 0c          	shr    $0xc,%rax
   40b7d:	89 c2                	mov    %eax,%edx
   40b7f:	48 63 c2             	movslq %edx,%rax
   40b82:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   40b89:	00 
   40b8a:	83 c0 01             	add    $0x1,%eax
   40b8d:	89 c1                	mov    %eax,%ecx
   40b8f:	48 63 c2             	movslq %edx,%rax
   40b92:	88 8c 00 41 fe 04 00 	mov    %cl,0x4fe41(%rax,%rax,1)
            if(virtual_memory_map(child_ptable, va, memmap.pa, PAGESIZE, PTE_U | PTE_P) < 0)
   40b99:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40b9d:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40ba1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40ba5:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   40bab:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40bb0:	48 89 c7             	mov    %rax,%rdi
   40bb3:	e8 9b 24 00 00       	callq  43053 <virtual_memory_map>
   40bb8:	85 c0                	test   %eax,%eax
   40bba:	79 08                	jns    40bc4 <copyAppPage+0x157>
                return -1;
   40bbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40bc1:	eb 1c                	jmp    40bdf <copyAppPage+0x172>
        if((memmap.perm & PTE_U) && (memmap.perm & PTE_W) && (memmap.perm & PTE_P)) {
   40bc3:	90                   	nop
    for(uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE){
   40bc4:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40bcb:	00 
   40bcc:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40bd3:	00 
   40bd4:	0f 86 b3 fe ff ff    	jbe    40a8d <copyAppPage+0x20>
        }
    }

    return 0;
   40bda:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40bdf:	c9                   	leaveq 
   40be0:	c3                   	retq   

0000000000040be1 <cleanUpPagetable>:


/* Helper function: clean up page talbe */
void cleanUpPagetable(x86_64_pagetable * pt, int level){
   40be1:	55                   	push   %rbp
   40be2:	48 89 e5             	mov    %rsp,%rbp
   40be5:	48 83 ec 20          	sub    $0x20,%rsp
   40be9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40bed:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // log_printf("in cleanUpPageTable, page number is %d, level is %d\n", PAGENUMBER(pt), level);
    if (level < 3) {
   40bf0:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40bf4:	7f 5b                	jg     40c51 <cleanUpPagetable+0x70>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40bf6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40bfd:	eb 49                	jmp    40c48 <cleanUpPagetable+0x67>
            if (PTE_ADDR(pt->entry[index])) {
   40bff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40c03:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40c06:	48 63 d2             	movslq %edx,%rdx
   40c09:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40c0d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40c13:	48 85 c0             	test   %rax,%rax
   40c16:	74 2c                	je     40c44 <cleanUpPagetable+0x63>
                x86_64_pagetable* nextpt = (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40c18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40c1c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40c1f:	48 63 d2             	movslq %edx,%rdx
   40c22:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40c26:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40c2c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                cleanUpPagetable(nextpt, level+1);
   40c30:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40c33:	8d 50 01             	lea    0x1(%rax),%edx
   40c36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40c3a:	89 d6                	mov    %edx,%esi
   40c3c:	48 89 c7             	mov    %rax,%rdi
   40c3f:	e8 9d ff ff ff       	callq  40be1 <cleanUpPagetable>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40c44:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40c48:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40c4f:	7e ae                	jle    40bff <cleanUpPagetable+0x1e>
            }
        }
    }

    // clean up this page
    memset(pt, 0, PAGESIZE);
   40c51:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40c55:	ba 00 10 00 00       	mov    $0x1000,%edx
   40c5a:	be 00 00 00 00       	mov    $0x0,%esi
   40c5f:	48 89 c7             	mov    %rax,%rdi
   40c62:	e8 f9 2c 00 00       	callq  43960 <memset>
    pageinfo[PAGENUMBER(pt)].refcount = 0;
   40c67:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40c6b:	48 c1 e8 0c          	shr    $0xc,%rax
   40c6f:	48 98                	cltq   
   40c71:	c6 84 00 41 fe 04 00 	movb   $0x0,0x4fe41(%rax,%rax,1)
   40c78:	00 
    pageinfo[PAGENUMBER(pt)].owner = PO_FREE;
   40c79:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40c7d:	48 c1 e8 0c          	shr    $0xc,%rax
   40c81:	48 98                	cltq   
   40c83:	c6 84 00 40 fe 04 00 	movb   $0x0,0x4fe40(%rax,%rax,1)
   40c8a:	00 

    // log_printf("exiting cleanUpPagetable for page number %d\n", PAGENUMBER(pt));
}
   40c8b:	90                   	nop
   40c8c:	c9                   	leaveq 
   40c8d:	c3                   	retq   

0000000000040c8e <cleanUpProcessPages>:

/* Helper function */
// Clean up a process’s code, data, heap, and stack pages,
// as well as the pages used for its page table pages
void cleanUpProcessPages(pid_t pid){
   40c8e:	55                   	push   %rbp
   40c8f:	48 89 e5             	mov    %rsp,%rbp
   40c92:	48 83 ec 40          	sub    $0x40,%rsp
   40c96:	89 7d cc             	mov    %edi,-0x34(%rbp)
    x86_64_pagetable * ptable = processes[pid].p_pagetable;
   40c99:	8b 45 cc             	mov    -0x34(%rbp),%eax
   40c9c:	48 63 d0             	movslq %eax,%rdx
   40c9f:	48 89 d0             	mov    %rdx,%rax
   40ca2:	48 c1 e0 03          	shl    $0x3,%rax
   40ca6:	48 29 d0             	sub    %rdx,%rax
   40ca9:	48 c1 e0 05          	shl    $0x5,%rax
   40cad:	48 05 f0 f0 04 00    	add    $0x4f0f0,%rax
   40cb3:	48 8b 00             	mov    (%rax),%rax
   40cb6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(ptable == 0) return;
   40cba:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   40cbf:	0f 84 95 01 00 00    	je     40e5a <cleanUpProcessPages+0x1cc>

    // log_printf("in cleanUpProcessPages, ptable is %x\n", ptable);

    for(uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE){
   40cc5:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   40ccc:	00 
   40ccd:	e9 67 01 00 00       	jmpq   40e39 <cleanUpProcessPages+0x1ab>
        // log_printf("in loop, about to to go in virtual_memory_lookup\n");
        vamapping map = virtual_memory_lookup(ptable, va);
   40cd2:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40cd6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40cda:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   40cde:	48 89 ce             	mov    %rcx,%rsi
   40ce1:	48 89 c7             	mov    %rax,%rdi
   40ce4:	e8 1f 27 00 00       	callq  43408 <virtual_memory_lookup>
        // log_printf("in loop: map.pa is %x\n", map.pa);
        if((map.perm & PTE_W) && (map.perm & PTE_U) && (map.perm & PTE_P)){
   40ce9:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40cec:	48 98                	cltq   
   40cee:	83 e0 02             	and    $0x2,%eax
   40cf1:	48 85 c0             	test   %rax,%rax
   40cf4:	0f 84 a3 00 00 00    	je     40d9d <cleanUpProcessPages+0x10f>
   40cfa:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40cfd:	48 98                	cltq   
   40cff:	83 e0 04             	and    $0x4,%eax
   40d02:	48 85 c0             	test   %rax,%rax
   40d05:	0f 84 92 00 00 00    	je     40d9d <cleanUpProcessPages+0x10f>
   40d0b:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40d0e:	48 98                	cltq   
   40d10:	83 e0 01             	and    $0x1,%eax
   40d13:	48 85 c0             	test   %rax,%rax
   40d16:	0f 84 81 00 00 00    	je     40d9d <cleanUpProcessPages+0x10f>
            // if(!(pageinfo[PAGENUMBER(map.pa)].refcount != 0 && pageinfo[PAGENUMBER(map.pa)].owner == pid)){
            //     log_printf("pagenumber %d, refcount %d, owner %d\n", PAGENUMBER(map.pa),
            //     pageinfo[PAGENUMBER(map.pa)].refcount, 
            //     pageinfo[PAGENUMBER(map.pa)].owner);
            // }
            assert(pageinfo[PAGENUMBER(map.pa)].refcount != 0);
   40d1c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d20:	48 c1 e8 0c          	shr    $0xc,%rax
   40d24:	48 98                	cltq   
   40d26:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   40d2d:	00 
   40d2e:	84 c0                	test   %al,%al
   40d30:	75 14                	jne    40d46 <cleanUpProcessPages+0xb8>
   40d32:	ba c8 43 04 00       	mov    $0x443c8,%edx
   40d37:	be 99 01 00 00       	mov    $0x199,%esi
   40d3c:	bf dd 42 04 00       	mov    $0x442dd,%edi
   40d41:	e8 0e 20 00 00       	callq  42d54 <assert_fail>
            assert(pageinfo[PAGENUMBER(map.pa)].owner == pid);
   40d46:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d4a:	48 c1 e8 0c          	shr    $0xc,%rax
   40d4e:	48 98                	cltq   
   40d50:	0f b6 84 00 40 fe 04 	movzbl 0x4fe40(%rax,%rax,1),%eax
   40d57:	00 
   40d58:	0f be c0             	movsbl %al,%eax
   40d5b:	39 45 cc             	cmp    %eax,-0x34(%rbp)
   40d5e:	74 14                	je     40d74 <cleanUpProcessPages+0xe6>
   40d60:	ba f8 43 04 00       	mov    $0x443f8,%edx
   40d65:	be 9a 01 00 00       	mov    $0x19a,%esi
   40d6a:	bf dd 42 04 00       	mov    $0x442dd,%edi
   40d6f:	e8 e0 1f 00 00       	callq  42d54 <assert_fail>
            pageinfo[PAGENUMBER(map.pa)].refcount = 0;
   40d74:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d78:	48 c1 e8 0c          	shr    $0xc,%rax
   40d7c:	48 98                	cltq   
   40d7e:	c6 84 00 41 fe 04 00 	movb   $0x0,0x4fe41(%rax,%rax,1)
   40d85:	00 
            pageinfo[PAGENUMBER(map.pa)].owner = PO_FREE;
   40d86:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d8a:	48 c1 e8 0c          	shr    $0xc,%rax
   40d8e:	48 98                	cltq   
   40d90:	c6 84 00 40 fe 04 00 	movb   $0x0,0x4fe40(%rax,%rax,1)
   40d97:	00 
   40d98:	e9 94 00 00 00       	jmpq   40e31 <cleanUpProcessPages+0x1a3>
        } else if((map.perm & PTE_U) && (map.perm & PTE_P)){
   40d9d:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40da0:	48 98                	cltq   
   40da2:	83 e0 04             	and    $0x4,%eax
   40da5:	48 85 c0             	test   %rax,%rax
   40da8:	0f 84 83 00 00 00    	je     40e31 <cleanUpProcessPages+0x1a3>
   40dae:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40db1:	48 98                	cltq   
   40db3:	83 e0 01             	and    $0x1,%eax
   40db6:	48 85 c0             	test   %rax,%rax
   40db9:	74 76                	je     40e31 <cleanUpProcessPages+0x1a3>
            // not writable page; shared
            assert(pageinfo[PAGENUMBER(map.pa)].refcount > 0);
   40dbb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40dbf:	48 c1 e8 0c          	shr    $0xc,%rax
   40dc3:	48 98                	cltq   
   40dc5:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   40dcc:	00 
   40dcd:	84 c0                	test   %al,%al
   40dcf:	7f 14                	jg     40de5 <cleanUpProcessPages+0x157>
   40dd1:	ba 28 44 04 00       	mov    $0x44428,%edx
   40dd6:	be 9f 01 00 00       	mov    $0x19f,%esi
   40ddb:	bf dd 42 04 00       	mov    $0x442dd,%edi
   40de0:	e8 6f 1f 00 00       	callq  42d54 <assert_fail>
            pageinfo[PAGENUMBER(map.pa)].refcount--;
   40de5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40de9:	48 c1 e8 0c          	shr    $0xc,%rax
   40ded:	89 c2                	mov    %eax,%edx
   40def:	48 63 c2             	movslq %edx,%rax
   40df2:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   40df9:	00 
   40dfa:	83 e8 01             	sub    $0x1,%eax
   40dfd:	89 c1                	mov    %eax,%ecx
   40dff:	48 63 c2             	movslq %edx,%rax
   40e02:	88 8c 00 41 fe 04 00 	mov    %cl,0x4fe41(%rax,%rax,1)
            if(pageinfo[PAGENUMBER(map.pa)].refcount == 0)
   40e09:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e0d:	48 c1 e8 0c          	shr    $0xc,%rax
   40e11:	48 98                	cltq   
   40e13:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   40e1a:	00 
   40e1b:	84 c0                	test   %al,%al
   40e1d:	75 12                	jne    40e31 <cleanUpProcessPages+0x1a3>
                pageinfo[PAGENUMBER(map.pa)].owner = PO_FREE;
   40e1f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e23:	48 c1 e8 0c          	shr    $0xc,%rax
   40e27:	48 98                	cltq   
   40e29:	c6 84 00 40 fe 04 00 	movb   $0x0,0x4fe40(%rax,%rax,1)
   40e30:	00 
    for(uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE){
   40e31:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e38:	00 
   40e39:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40e40:	00 
   40e41:	0f 86 8b fe ff ff    	jbe    40cd2 <cleanUpProcessPages+0x44>
        }
    }

    // clean up page table
    cleanUpPagetable(ptable, 0);
   40e47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40e4b:	be 00 00 00 00       	mov    $0x0,%esi
   40e50:	48 89 c7             	mov    %rax,%rdi
   40e53:	e8 89 fd ff ff       	callq  40be1 <cleanUpPagetable>
   40e58:	eb 01                	jmp    40e5b <cleanUpProcessPages+0x1cd>
    if(ptable == 0) return;
   40e5a:	90                   	nop
}
   40e5b:	c9                   	leaveq 
   40e5c:	c3                   	retq   

0000000000040e5d <processExit>:

/* Helper function */
// Exits from the given process
void processExit(pid_t pid){
   40e5d:	55                   	push   %rbp
   40e5e:	48 89 e5             	mov    %rsp,%rbp
   40e61:	48 83 ec 10          	sub    $0x10,%rsp
   40e65:	89 7d fc             	mov    %edi,-0x4(%rbp)
    // free all its memory
    cleanUpProcessPages(pid);
   40e68:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e6b:	89 c7                	mov    %eax,%edi
   40e6d:	e8 1c fe ff ff       	callq  40c8e <cleanUpProcessPages>

    // mark process as free
    processes[pid].p_state = P_FREE;
   40e72:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e75:	48 63 d0             	movslq %eax,%rdx
   40e78:	48 89 d0             	mov    %rdx,%rax
   40e7b:	48 c1 e0 03          	shl    $0x3,%rax
   40e7f:	48 29 d0             	sub    %rdx,%rax
   40e82:	48 c1 e0 05          	shl    $0x5,%rax
   40e86:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   40e8c:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
}
   40e92:	90                   	nop
   40e93:	c9                   	leaveq 
   40e94:	c3                   	retq   

0000000000040e95 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40e95:	55                   	push   %rbp
   40e96:	48 89 e5             	mov    %rsp,%rbp
   40e99:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   40ea0:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40ea7:	48 8b 05 52 e1 00 00 	mov    0xe152(%rip),%rax        # 4f000 <current>
   40eae:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   40eb5:	48 83 c0 08          	add    $0x8,%rax
   40eb9:	48 89 d6             	mov    %rdx,%rsi
   40ebc:	ba 18 00 00 00       	mov    $0x18,%edx
   40ec1:	48 89 c7             	mov    %rax,%rdi
   40ec4:	48 89 d1             	mov    %rdx,%rcx
   40ec7:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40eca:	48 8b 05 2f 11 01 00 	mov    0x1112f(%rip),%rax        # 52000 <kernel_pagetable>
   40ed1:	48 89 c7             	mov    %rax,%rdi
   40ed4:	e8 49 20 00 00       	callq  42f22 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    // log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40ed9:	8b 05 1d 81 07 00    	mov    0x7811d(%rip),%eax        # b8ffc <cursorpos>
   40edf:	89 c7                	mov    %eax,%edi
   40ee1:	e8 70 17 00 00       	callq  42656 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40ee6:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40eed:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40ef4:	48 83 f8 0e          	cmp    $0xe,%rax
   40ef8:	74 14                	je     40f0e <exception+0x79>
   40efa:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40f01:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40f08:	48 83 f8 0d          	cmp    $0xd,%rax
   40f0c:	75 16                	jne    40f24 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40f0e:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40f15:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40f1c:	83 e0 04             	and    $0x4,%eax
   40f1f:	48 85 c0             	test   %rax,%rax
   40f22:	74 1a                	je     40f3e <exception+0xa9>
    {
        check_virtual_memory();
   40f24:	e8 30 09 00 00       	callq  41859 <check_virtual_memory>
        if(disp_global){
   40f29:	0f b6 05 d0 50 00 00 	movzbl 0x50d0(%rip),%eax        # 46000 <disp_global>
   40f30:	84 c0                	test   %al,%al
   40f32:	74 0a                	je     40f3e <exception+0xa9>
            memshow_physical();
   40f34:	e8 98 0a 00 00       	callq  419d1 <memshow_physical>
            memshow_virtual_animate();
   40f39:	e8 be 0d 00 00       	callq  41cfc <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40f3e:	e8 f0 1b 00 00       	callq  42b33 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40f43:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40f4a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40f51:	48 83 e8 0e          	sub    $0xe,%rax
   40f55:	48 83 f8 2a          	cmp    $0x2a,%rax
   40f59:	0f 87 5b 04 00 00    	ja     413ba <exception+0x525>
   40f5f:	48 8b 04 c5 80 45 04 	mov    0x44580(,%rax,8),%rax
   40f66:	00 
   40f67:	ff e0                	jmpq   *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40f69:	48 8b 05 90 e0 00 00 	mov    0xe090(%rip),%rax        # 4f000 <current>
   40f70:	48 8b 40 38          	mov    0x38(%rax),%rax
   40f74:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
		if((void *)addr == NULL)
   40f78:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40f7d:	75 0f                	jne    40f8e <exception+0xf9>
		    panic(NULL);
   40f7f:	bf 00 00 00 00       	mov    $0x0,%edi
   40f84:	b8 00 00 00 00       	mov    $0x0,%eax
   40f89:	e8 e6 1c 00 00       	callq  42c74 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40f8e:	48 8b 05 6b e0 00 00 	mov    0xe06b(%rip),%rax        # 4f000 <current>
   40f95:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40f9c:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   40fa0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40fa4:	48 89 ce             	mov    %rcx,%rsi
   40fa7:	48 89 c7             	mov    %rax,%rdi
   40faa:	e8 59 24 00 00       	callq  43408 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40faf:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40fb3:	48 89 c1             	mov    %rax,%rcx
   40fb6:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   40fbd:	ba a0 00 00 00       	mov    $0xa0,%edx
   40fc2:	48 89 ce             	mov    %rcx,%rsi
   40fc5:	48 89 c7             	mov    %rax,%rdi
   40fc8:	e8 2a 29 00 00       	callq  438f7 <memcpy>
		panic(msg);
   40fcd:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   40fd4:	48 89 c7             	mov    %rax,%rdi
   40fd7:	b8 00 00 00 00       	mov    $0x0,%eax
   40fdc:	e8 93 1c 00 00       	callq  42c74 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40fe1:	48 8b 05 18 e0 00 00 	mov    0xe018(%rip),%rax        # 4f000 <current>
   40fe8:	8b 10                	mov    (%rax),%edx
   40fea:	48 8b 05 0f e0 00 00 	mov    0xe00f(%rip),%rax        # 4f000 <current>
   40ff1:	48 63 d2             	movslq %edx,%rdx
   40ff4:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40ff8:	e9 cd 03 00 00       	jmpq   413ca <exception+0x535>

    case INT_SYS_YIELD:
        schedule();
   40ffd:	e8 f1 03 00 00       	callq  413f3 <schedule>
        break;                  /* will not be reached */
   41002:	e9 c3 03 00 00       	jmpq   413ca <exception+0x535>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t addr = current->p_registers.reg_rdi;
   41007:	48 8b 05 f2 df 00 00 	mov    0xdff2(%rip),%rax        # 4f000 <current>
   4100e:	48 8b 40 38          	mov    0x38(%rax),%rax
   41012:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

        // get available physical page
        intptr_t physicalPage = getAvailablePhysicalPage();
   41016:	e8 4c f1 ff ff       	callq  40167 <getAvailablePhysicalPage>
   4101b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if(physicalPage == -1) {
   4101f:	48 83 7d e8 ff       	cmpq   $0xffffffffffffffff,-0x18(%rbp)
   41024:	75 14                	jne    4103a <exception+0x1a5>
            current->p_registers.reg_rax = -1;
   41026:	48 8b 05 d3 df 00 00 	mov    0xdfd3(%rip),%rax        # 4f000 <current>
   4102d:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   41034:	ff 
            break;
   41035:	e9 90 03 00 00       	jmpq   413ca <exception+0x535>
        }

        assert(assign_physical_page(physicalPage, current->p_pid) == 0);
   4103a:	48 8b 05 bf df 00 00 	mov    0xdfbf(%rip),%rax        # 4f000 <current>
   41041:	8b 00                	mov    (%rax),%eax
   41043:	0f be d0             	movsbl %al,%edx
   41046:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4104a:	89 d6                	mov    %edx,%esi
   4104c:	48 89 c7             	mov    %rax,%rdi
   4104f:	e8 dc f6 ff ff       	callq  40730 <assign_physical_page>
   41054:	85 c0                	test   %eax,%eax
   41056:	74 14                	je     4106c <exception+0x1d7>
   41058:	ba 58 44 04 00       	mov    $0x44458,%edx
   4105d:	be ff 01 00 00       	mov    $0x1ff,%esi
   41062:	bf dd 42 04 00       	mov    $0x442dd,%edi
   41067:	e8 e8 1c 00 00       	callq  42d54 <assert_fail>
        assert(virtual_memory_map(current->p_pagetable, addr, physicalPage,
   4106c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   41070:	48 8b 05 89 df 00 00 	mov    0xdf89(%rip),%rax        # 4f000 <current>
   41077:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4107e:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   41082:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   41088:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4108d:	48 89 c7             	mov    %rax,%rdi
   41090:	e8 be 1f 00 00       	callq  43053 <virtual_memory_map>
   41095:	85 c0                	test   %eax,%eax
   41097:	74 14                	je     410ad <exception+0x218>
   41099:	ba 90 44 04 00       	mov    $0x44490,%edx
   4109e:	be 00 02 00 00       	mov    $0x200,%esi
   410a3:	bf dd 42 04 00       	mov    $0x442dd,%edi
   410a8:	e8 a7 1c 00 00       	callq  42d54 <assert_fail>
                               PAGESIZE, PTE_P | PTE_W | PTE_U) == 0);
        current->p_registers.reg_rax = 0;
   410ad:	48 8b 05 4c df 00 00 	mov    0xdf4c(%rip),%rax        # 4f000 <current>
   410b4:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   410bb:	00 
        break;
   410bc:	e9 09 03 00 00       	jmpq   413ca <exception+0x535>
    }

    /* implement fork */
    case INT_SYS_FORK: {
        // note that process 0 should not be used
        int pid = 0;
   410c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
        for( ; pid < NPROC; pid++){
   410c8:	eb 2d                	jmp    410f7 <exception+0x262>
            if(pid == 0)
   410ca:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   410ce:	74 22                	je     410f2 <exception+0x25d>
                continue;
            if(processes[pid].p_state == P_FREE){
   410d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410d3:	48 63 d0             	movslq %eax,%rdx
   410d6:	48 89 d0             	mov    %rdx,%rax
   410d9:	48 c1 e0 03          	shl    $0x3,%rax
   410dd:	48 29 d0             	sub    %rdx,%rax
   410e0:	48 c1 e0 05          	shl    $0x5,%rax
   410e4:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   410ea:	8b 00                	mov    (%rax),%eax
   410ec:	85 c0                	test   %eax,%eax
   410ee:	74 0f                	je     410ff <exception+0x26a>
   410f0:	eb 01                	jmp    410f3 <exception+0x25e>
                continue;
   410f2:	90                   	nop
        for( ; pid < NPROC; pid++){
   410f3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   410f7:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   410fb:	7e cd                	jle    410ca <exception+0x235>
   410fd:	eb 01                	jmp    41100 <exception+0x26b>
                // found free process
                break;
   410ff:	90                   	nop
            }
        }

        if(pid == 0){
   41100:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41104:	75 14                	jne    4111a <exception+0x285>
            // no free process found
            current->p_registers.reg_rax = -1;
   41106:	48 8b 05 f3 de 00 00 	mov    0xdef3(%rip),%rax        # 4f000 <current>
   4110d:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   41114:	ff 
            break;
   41115:	e9 b0 02 00 00       	jmpq   413ca <exception+0x535>
        }

        processes[pid].p_state = P_RUNNABLE;
   4111a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4111d:	48 63 d0             	movslq %eax,%rdx
   41120:	48 89 d0             	mov    %rdx,%rax
   41123:	48 c1 e0 03          	shl    $0x3,%rax
   41127:	48 29 d0             	sub    %rdx,%rax
   4112a:	48 c1 e0 05          	shl    $0x5,%rax
   4112e:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   41134:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
        processes[pid].p_pid = pid;
   4113a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4113d:	48 63 d0             	movslq %eax,%rdx
   41140:	48 89 d0             	mov    %rdx,%rax
   41143:	48 c1 e0 03          	shl    $0x3,%rax
   41147:	48 29 d0             	sub    %rdx,%rax
   4114a:	48 c1 e0 05          	shl    $0x5,%rax
   4114e:	48 8d 90 20 f0 04 00 	lea    0x4f020(%rax),%rdx
   41155:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41158:	89 02                	mov    %eax,(%rdx)

        // create page table for child process
        if(createChildPagetable(pid) == -1){
   4115a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4115d:	89 c7                	mov    %eax,%edi
   4115f:	e8 72 f7 ff ff       	callq  408d6 <createChildPagetable>
   41164:	83 f8 ff             	cmp    $0xffffffff,%eax
   41167:	75 34                	jne    4119d <exception+0x308>
            // log_printf("child page table failed to allocate for pid %d\n", pid);
            processes[pid].p_state = P_FREE;
   41169:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4116c:	48 63 d0             	movslq %eax,%rdx
   4116f:	48 89 d0             	mov    %rdx,%rax
   41172:	48 c1 e0 03          	shl    $0x3,%rax
   41176:	48 29 d0             	sub    %rdx,%rax
   41179:	48 c1 e0 05          	shl    $0x5,%rax
   4117d:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   41183:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
            current->p_registers.reg_rax = -1;
   41189:	48 8b 05 70 de 00 00 	mov    0xde70(%rip),%rax        # 4f000 <current>
   41190:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   41197:	ff 
            break;
   41198:	e9 2d 02 00 00       	jmpq   413ca <exception+0x535>
        }

        // copy parent application pages to child
        if(copyAppPage(current->p_pagetable, processes[pid].p_pagetable, pid) == -1){
   4119d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411a0:	48 63 d0             	movslq %eax,%rdx
   411a3:	48 89 d0             	mov    %rdx,%rax
   411a6:	48 c1 e0 03          	shl    $0x3,%rax
   411aa:	48 29 d0             	sub    %rdx,%rax
   411ad:	48 c1 e0 05          	shl    $0x5,%rax
   411b1:	48 05 f0 f0 04 00    	add    $0x4f0f0,%rax
   411b7:	48 8b 08             	mov    (%rax),%rcx
   411ba:	48 8b 05 3f de 00 00 	mov    0xde3f(%rip),%rax        # 4f000 <current>
   411c1:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   411c8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411cb:	48 89 ce             	mov    %rcx,%rsi
   411ce:	48 89 c7             	mov    %rax,%rdi
   411d1:	e8 97 f8 ff ff       	callq  40a6d <copyAppPage>
   411d6:	83 f8 ff             	cmp    $0xffffffff,%eax
   411d9:	75 1e                	jne    411f9 <exception+0x364>
            processExit(pid);
   411db:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411de:	89 c7                	mov    %eax,%edi
   411e0:	e8 78 fc ff ff       	callq  40e5d <processExit>
            current->p_registers.reg_rax = -1;
   411e5:	48 8b 05 14 de 00 00 	mov    0xde14(%rip),%rax        # 4f000 <current>
   411ec:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   411f3:	ff 
            break;
   411f4:	e9 d1 01 00 00       	jmpq   413ca <exception+0x535>
        }

        // copy registers from parent
        memcpy(&(processes[pid].p_registers), &(current->p_registers), sizeof(x86_64_registers));
   411f9:	48 8b 05 00 de 00 00 	mov    0xde00(%rip),%rax        # 4f000 <current>
   41200:	48 8d 48 08          	lea    0x8(%rax),%rcx
   41204:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41207:	48 63 d0             	movslq %eax,%rdx
   4120a:	48 89 d0             	mov    %rdx,%rax
   4120d:	48 c1 e0 03          	shl    $0x3,%rax
   41211:	48 29 d0             	sub    %rdx,%rax
   41214:	48 c1 e0 05          	shl    $0x5,%rax
   41218:	48 05 20 f0 04 00    	add    $0x4f020,%rax
   4121e:	48 83 c0 08          	add    $0x8,%rax
   41222:	ba c0 00 00 00       	mov    $0xc0,%edx
   41227:	48 89 ce             	mov    %rcx,%rsi
   4122a:	48 89 c7             	mov    %rax,%rdi
   4122d:	e8 c5 26 00 00       	callq  438f7 <memcpy>

        // set return values of fork
        current->p_registers.reg_rax = pid;
   41232:	48 8b 05 c7 dd 00 00 	mov    0xddc7(%rip),%rax        # 4f000 <current>
   41239:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4123c:	48 63 d2             	movslq %edx,%rdx
   4123f:	48 89 50 08          	mov    %rdx,0x8(%rax)
        processes[pid].p_registers.reg_rax = 0;
   41243:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41246:	48 63 d0             	movslq %eax,%rdx
   41249:	48 89 d0             	mov    %rdx,%rax
   4124c:	48 c1 e0 03          	shl    $0x3,%rax
   41250:	48 29 d0             	sub    %rdx,%rax
   41253:	48 c1 e0 05          	shl    $0x5,%rax
   41257:	48 05 28 f0 04 00    	add    $0x4f028,%rax
   4125d:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

        // log_printf("pid %d has been forked\n", pid);
        break;
   41264:	e9 61 01 00 00       	jmpq   413ca <exception+0x535>

    /* implements exit */
    case INT_SYS_EXIT: {
        // log_printf("pid %d exiting\n", current->p_pid);

        processExit(current->p_pid);
   41269:	48 8b 05 90 dd 00 00 	mov    0xdd90(%rip),%rax        # 4f000 <current>
   41270:	8b 00                	mov    (%rax),%eax
   41272:	89 c7                	mov    %eax,%edi
   41274:	e8 e4 fb ff ff       	callq  40e5d <processExit>

        break;
   41279:	e9 4c 01 00 00       	jmpq   413ca <exception+0x535>
    }    

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   4127e:	48 8b 05 7b dd 00 00 	mov    0xdd7b(%rip),%rax        # 4f000 <current>
   41285:	48 89 c7             	mov    %rax,%rdi
   41288:	e8 17 f5 ff ff       	callq  407a4 <syscall_mapping>
            break;
   4128d:	e9 38 01 00 00       	jmpq   413ca <exception+0x535>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   41292:	48 8b 05 67 dd 00 00 	mov    0xdd67(%rip),%rax        # 4f000 <current>
   41299:	48 89 c7             	mov    %rax,%rdi
   4129c:	e8 cc f5 ff ff       	callq  4086d <syscall_mem_tog>
	    break;
   412a1:	e9 24 01 00 00       	jmpq   413ca <exception+0x535>
	}

    case INT_TIMER:
        ++ticks;
   412a6:	8b 05 74 eb 00 00    	mov    0xeb74(%rip),%eax        # 4fe20 <ticks>
   412ac:	83 c0 01             	add    $0x1,%eax
   412af:	89 05 6b eb 00 00    	mov    %eax,0xeb6b(%rip)        # 4fe20 <ticks>
        schedule();
   412b5:	e8 39 01 00 00       	callq  413f3 <schedule>
        break;                  /* will not be reached */
   412ba:	e9 0b 01 00 00       	jmpq   413ca <exception+0x535>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   412bf:	0f 20 d0             	mov    %cr2,%rax
   412c2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    return val;
   412c6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   412ca:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   412ce:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   412d5:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   412dc:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   412df:	48 85 c0             	test   %rax,%rax
   412e2:	74 07                	je     412eb <exception+0x456>
   412e4:	b8 f3 44 04 00       	mov    $0x444f3,%eax
   412e9:	eb 05                	jmp    412f0 <exception+0x45b>
   412eb:	b8 f9 44 04 00       	mov    $0x444f9,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   412f0:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   412f4:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   412fb:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   41302:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   41305:	48 85 c0             	test   %rax,%rax
   41308:	74 07                	je     41311 <exception+0x47c>
   4130a:	b8 fe 44 04 00       	mov    $0x444fe,%eax
   4130f:	eb 05                	jmp    41316 <exception+0x481>
   41311:	b8 11 45 04 00       	mov    $0x44511,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   41316:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   4131a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   41321:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   41328:	83 e0 04             	and    $0x4,%eax
   4132b:	48 85 c0             	test   %rax,%rax
   4132e:	75 2f                	jne    4135f <exception+0x4ca>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   41330:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   41337:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   4133e:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41342:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   41346:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4134a:	49 89 f0             	mov    %rsi,%r8
   4134d:	48 89 c6             	mov    %rax,%rsi
   41350:	bf 20 45 04 00       	mov    $0x44520,%edi
   41355:	b8 00 00 00 00       	mov    $0x0,%eax
   4135a:	e8 15 19 00 00       	callq  42c74 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   4135f:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   41366:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   4136d:	48 8b 05 8c dc 00 00 	mov    0xdc8c(%rip),%rax        # 4f000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   41374:	8b 00                	mov    (%rax),%eax
   41376:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   4137a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4137e:	52                   	push   %rdx
   4137f:	ff 75 c8             	pushq  -0x38(%rbp)
   41382:	49 89 f1             	mov    %rsi,%r9
   41385:	49 89 c8             	mov    %rcx,%r8
   41388:	89 c1                	mov    %eax,%ecx
   4138a:	ba 50 45 04 00       	mov    $0x44550,%edx
   4138f:	be 00 0c 00 00       	mov    $0xc00,%esi
   41394:	bf 80 07 00 00       	mov    $0x780,%edi
   41399:	b8 00 00 00 00       	mov    $0x0,%eax
   4139e:	e8 f2 2d 00 00       	callq  44195 <console_printf>
   413a3:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   413a7:	48 8b 05 52 dc 00 00 	mov    0xdc52(%rip),%rax        # 4f000 <current>
   413ae:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   413b5:	00 00 00 
        break;
   413b8:	eb 10                	jmp    413ca <exception+0x535>
    }

    default:
        default_exception(current);
   413ba:	48 8b 05 3f dc 00 00 	mov    0xdc3f(%rip),%rax        # 4f000 <current>
   413c1:	48 89 c7             	mov    %rax,%rdi
   413c4:	e8 bb 19 00 00       	callq  42d84 <default_exception>
        break;                  /* will not be reached */
   413c9:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   413ca:	48 8b 05 2f dc 00 00 	mov    0xdc2f(%rip),%rax        # 4f000 <current>
   413d1:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   413d7:	83 f8 01             	cmp    $0x1,%eax
   413da:	75 0f                	jne    413eb <exception+0x556>
        run(current);
   413dc:	48 8b 05 1d dc 00 00 	mov    0xdc1d(%rip),%rax        # 4f000 <current>
   413e3:	48 89 c7             	mov    %rax,%rdi
   413e6:	e8 7a 00 00 00       	callq  41465 <run>
    } else {
        schedule();
   413eb:	e8 03 00 00 00       	callq  413f3 <schedule>
    }
}
   413f0:	90                   	nop
   413f1:	c9                   	leaveq 
   413f2:	c3                   	retq   

00000000000413f3 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   413f3:	55                   	push   %rbp
   413f4:	48 89 e5             	mov    %rsp,%rbp
   413f7:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   413fb:	48 8b 05 fe db 00 00 	mov    0xdbfe(%rip),%rax        # 4f000 <current>
   41402:	8b 00                	mov    (%rax),%eax
   41404:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   41407:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4140a:	83 c0 01             	add    $0x1,%eax
   4140d:	99                   	cltd   
   4140e:	c1 ea 1c             	shr    $0x1c,%edx
   41411:	01 d0                	add    %edx,%eax
   41413:	83 e0 0f             	and    $0xf,%eax
   41416:	29 d0                	sub    %edx,%eax
   41418:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   4141b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4141e:	48 63 d0             	movslq %eax,%rdx
   41421:	48 89 d0             	mov    %rdx,%rax
   41424:	48 c1 e0 03          	shl    $0x3,%rax
   41428:	48 29 d0             	sub    %rdx,%rax
   4142b:	48 c1 e0 05          	shl    $0x5,%rax
   4142f:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   41435:	8b 00                	mov    (%rax),%eax
   41437:	83 f8 01             	cmp    $0x1,%eax
   4143a:	75 22                	jne    4145e <schedule+0x6b>
            run(&processes[pid]);
   4143c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4143f:	48 63 d0             	movslq %eax,%rdx
   41442:	48 89 d0             	mov    %rdx,%rax
   41445:	48 c1 e0 03          	shl    $0x3,%rax
   41449:	48 29 d0             	sub    %rdx,%rax
   4144c:	48 c1 e0 05          	shl    $0x5,%rax
   41450:	48 05 20 f0 04 00    	add    $0x4f020,%rax
   41456:	48 89 c7             	mov    %rax,%rdi
   41459:	e8 07 00 00 00       	callq  41465 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   4145e:	e8 d0 16 00 00       	callq  42b33 <check_keyboard>
        pid = (pid + 1) % NPROC;
   41463:	eb a2                	jmp    41407 <schedule+0x14>

0000000000041465 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   41465:	55                   	push   %rbp
   41466:	48 89 e5             	mov    %rsp,%rbp
   41469:	48 83 ec 10          	sub    $0x10,%rsp
   4146d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   41471:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41475:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   4147b:	83 f8 01             	cmp    $0x1,%eax
   4147e:	74 14                	je     41494 <run+0x2f>
   41480:	ba d8 46 04 00       	mov    $0x446d8,%edx
   41485:	be 8b 02 00 00       	mov    $0x28b,%esi
   4148a:	bf dd 42 04 00       	mov    $0x442dd,%edi
   4148f:	e8 c0 18 00 00       	callq  42d54 <assert_fail>
    current = p;
   41494:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41498:	48 89 05 61 db 00 00 	mov    %rax,0xdb61(%rip)        # 4f000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   4149f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414a3:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   414aa:	48 89 c7             	mov    %rax,%rdi
   414ad:	e8 70 1a 00 00       	callq  42f22 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   414b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414b6:	48 83 c0 08          	add    $0x8,%rax
   414ba:	48 89 c7             	mov    %rax,%rdi
   414bd:	e8 01 ec ff ff       	callq  400c3 <exception_return>

00000000000414c2 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   414c2:	55                   	push   %rbp
   414c3:	48 89 e5             	mov    %rsp,%rbp
   414c6:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   414ca:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   414d1:	00 
   414d2:	e9 81 00 00 00       	jmpq   41558 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   414d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414db:	48 89 c7             	mov    %rax,%rdi
   414de:	e8 ef 0e 00 00       	callq  423d2 <physical_memory_isreserved>
   414e3:	85 c0                	test   %eax,%eax
   414e5:	74 09                	je     414f0 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   414e7:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   414ee:	eb 2f                	jmp    4151f <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   414f0:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   414f7:	00 
   414f8:	76 0b                	jbe    41505 <pageinfo_init+0x43>
   414fa:	b8 08 80 05 00       	mov    $0x58008,%eax
   414ff:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41503:	72 0a                	jb     4150f <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   41505:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   4150c:	00 
   4150d:	75 09                	jne    41518 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   4150f:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   41516:	eb 07                	jmp    4151f <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   41518:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4151f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41523:	48 c1 e8 0c          	shr    $0xc,%rax
   41527:	89 c1                	mov    %eax,%ecx
   41529:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4152c:	89 c2                	mov    %eax,%edx
   4152e:	48 63 c1             	movslq %ecx,%rax
   41531:	88 94 00 40 fe 04 00 	mov    %dl,0x4fe40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   41538:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4153c:	0f 95 c2             	setne  %dl
   4153f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41543:	48 c1 e8 0c          	shr    $0xc,%rax
   41547:	48 98                	cltq   
   41549:	88 94 00 41 fe 04 00 	mov    %dl,0x4fe41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   41550:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41557:	00 
   41558:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4155f:	00 
   41560:	0f 86 71 ff ff ff    	jbe    414d7 <pageinfo_init+0x15>
    }
}
   41566:	90                   	nop
   41567:	90                   	nop
   41568:	c9                   	leaveq 
   41569:	c3                   	retq   

000000000004156a <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   4156a:	55                   	push   %rbp
   4156b:	48 89 e5             	mov    %rsp,%rbp
   4156e:	48 83 ec 50          	sub    $0x50,%rsp
   41572:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   41576:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4157a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41580:	48 89 c2             	mov    %rax,%rdx
   41583:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   41587:	48 39 c2             	cmp    %rax,%rdx
   4158a:	74 14                	je     415a0 <check_page_table_mappings+0x36>
   4158c:	ba f8 46 04 00       	mov    $0x446f8,%edx
   41591:	be b5 02 00 00       	mov    $0x2b5,%esi
   41596:	bf dd 42 04 00       	mov    $0x442dd,%edi
   4159b:	e8 b4 17 00 00       	callq  42d54 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   415a0:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   415a7:	00 
   415a8:	e9 9a 00 00 00       	jmpq   41647 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   415ad:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   415b1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   415b5:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   415b9:	48 89 ce             	mov    %rcx,%rsi
   415bc:	48 89 c7             	mov    %rax,%rdi
   415bf:	e8 44 1e 00 00       	callq  43408 <virtual_memory_lookup>
        if (vam.pa != va) {
   415c4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   415c8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   415cc:	74 27                	je     415f5 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   415ce:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   415d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   415d6:	49 89 d0             	mov    %rdx,%r8
   415d9:	48 89 c1             	mov    %rax,%rcx
   415dc:	ba 17 47 04 00       	mov    $0x44717,%edx
   415e1:	be 00 c0 00 00       	mov    $0xc000,%esi
   415e6:	bf e0 06 00 00       	mov    $0x6e0,%edi
   415eb:	b8 00 00 00 00       	mov    $0x0,%eax
   415f0:	e8 a0 2b 00 00       	callq  44195 <console_printf>
        }
        assert(vam.pa == va);
   415f5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   415f9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   415fd:	74 14                	je     41613 <check_page_table_mappings+0xa9>
   415ff:	ba 21 47 04 00       	mov    $0x44721,%edx
   41604:	be be 02 00 00       	mov    $0x2be,%esi
   41609:	bf dd 42 04 00       	mov    $0x442dd,%edi
   4160e:	e8 41 17 00 00       	callq  42d54 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   41613:	b8 00 60 04 00       	mov    $0x46000,%eax
   41618:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4161c:	72 21                	jb     4163f <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   4161e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41621:	48 98                	cltq   
   41623:	83 e0 02             	and    $0x2,%eax
   41626:	48 85 c0             	test   %rax,%rax
   41629:	75 14                	jne    4163f <check_page_table_mappings+0xd5>
   4162b:	ba 2e 47 04 00       	mov    $0x4472e,%edx
   41630:	be c0 02 00 00       	mov    $0x2c0,%esi
   41635:	bf dd 42 04 00       	mov    $0x442dd,%edi
   4163a:	e8 15 17 00 00       	callq  42d54 <assert_fail>
         va += PAGESIZE) {
   4163f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41646:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41647:	b8 08 80 05 00       	mov    $0x58008,%eax
   4164c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41650:	0f 82 57 ff ff ff    	jb     415ad <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41656:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   4165d:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   4165e:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   41662:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41666:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   4166a:	48 89 ce             	mov    %rcx,%rsi
   4166d:	48 89 c7             	mov    %rax,%rdi
   41670:	e8 93 1d 00 00       	callq  43408 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   41675:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41679:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4167d:	74 14                	je     41693 <check_page_table_mappings+0x129>
   4167f:	ba 3f 47 04 00       	mov    $0x4473f,%edx
   41684:	be c7 02 00 00       	mov    $0x2c7,%esi
   41689:	bf dd 42 04 00       	mov    $0x442dd,%edi
   4168e:	e8 c1 16 00 00       	callq  42d54 <assert_fail>
    assert(vam.perm & PTE_W);
   41693:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41696:	48 98                	cltq   
   41698:	83 e0 02             	and    $0x2,%eax
   4169b:	48 85 c0             	test   %rax,%rax
   4169e:	75 14                	jne    416b4 <check_page_table_mappings+0x14a>
   416a0:	ba 2e 47 04 00       	mov    $0x4472e,%edx
   416a5:	be c8 02 00 00       	mov    $0x2c8,%esi
   416aa:	bf dd 42 04 00       	mov    $0x442dd,%edi
   416af:	e8 a0 16 00 00       	callq  42d54 <assert_fail>
}
   416b4:	90                   	nop
   416b5:	c9                   	leaveq 
   416b6:	c3                   	retq   

00000000000416b7 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   416b7:	55                   	push   %rbp
   416b8:	48 89 e5             	mov    %rsp,%rbp
   416bb:	48 83 ec 20          	sub    $0x20,%rsp
   416bf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   416c3:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   416c6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   416c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   416cc:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   416d3:	48 8b 05 26 09 01 00 	mov    0x10926(%rip),%rax        # 52000 <kernel_pagetable>
   416da:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   416de:	75 67                	jne    41747 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   416e0:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   416e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   416ee:	eb 51                	jmp    41741 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   416f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   416f3:	48 63 d0             	movslq %eax,%rdx
   416f6:	48 89 d0             	mov    %rdx,%rax
   416f9:	48 c1 e0 03          	shl    $0x3,%rax
   416fd:	48 29 d0             	sub    %rdx,%rax
   41700:	48 c1 e0 05          	shl    $0x5,%rax
   41704:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   4170a:	8b 00                	mov    (%rax),%eax
   4170c:	85 c0                	test   %eax,%eax
   4170e:	74 2d                	je     4173d <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41710:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41713:	48 63 d0             	movslq %eax,%rdx
   41716:	48 89 d0             	mov    %rdx,%rax
   41719:	48 c1 e0 03          	shl    $0x3,%rax
   4171d:	48 29 d0             	sub    %rdx,%rax
   41720:	48 c1 e0 05          	shl    $0x5,%rax
   41724:	48 05 f0 f0 04 00    	add    $0x4f0f0,%rax
   4172a:	48 8b 10             	mov    (%rax),%rdx
   4172d:	48 8b 05 cc 08 01 00 	mov    0x108cc(%rip),%rax        # 52000 <kernel_pagetable>
   41734:	48 39 c2             	cmp    %rax,%rdx
   41737:	75 04                	jne    4173d <check_page_table_ownership+0x86>
                ++expected_refcount;
   41739:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4173d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41741:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41745:	7e a9                	jle    416f0 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41747:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   4174a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4174d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41751:	be 00 00 00 00       	mov    $0x0,%esi
   41756:	48 89 c7             	mov    %rax,%rdi
   41759:	e8 03 00 00 00       	callq  41761 <check_page_table_ownership_level>
}
   4175e:	90                   	nop
   4175f:	c9                   	leaveq 
   41760:	c3                   	retq   

0000000000041761 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   41761:	55                   	push   %rbp
   41762:	48 89 e5             	mov    %rsp,%rbp
   41765:	48 83 ec 30          	sub    $0x30,%rsp
   41769:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4176d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41770:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41773:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41776:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4177a:	48 c1 e8 0c          	shr    $0xc,%rax
   4177e:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41783:	7e 14                	jle    41799 <check_page_table_ownership_level+0x38>
   41785:	ba 50 47 04 00       	mov    $0x44750,%edx
   4178a:	be e5 02 00 00       	mov    $0x2e5,%esi
   4178f:	bf dd 42 04 00       	mov    $0x442dd,%edi
   41794:	e8 bb 15 00 00       	callq  42d54 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41799:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4179d:	48 c1 e8 0c          	shr    $0xc,%rax
   417a1:	48 98                	cltq   
   417a3:	0f b6 84 00 40 fe 04 	movzbl 0x4fe40(%rax,%rax,1),%eax
   417aa:	00 
   417ab:	0f be c0             	movsbl %al,%eax
   417ae:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   417b1:	74 14                	je     417c7 <check_page_table_ownership_level+0x66>
   417b3:	ba 68 47 04 00       	mov    $0x44768,%edx
   417b8:	be e6 02 00 00       	mov    $0x2e6,%esi
   417bd:	bf dd 42 04 00       	mov    $0x442dd,%edi
   417c2:	e8 8d 15 00 00       	callq  42d54 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   417c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   417cb:	48 c1 e8 0c          	shr    $0xc,%rax
   417cf:	48 98                	cltq   
   417d1:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   417d8:	00 
   417d9:	0f be c0             	movsbl %al,%eax
   417dc:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   417df:	74 14                	je     417f5 <check_page_table_ownership_level+0x94>
   417e1:	ba 90 47 04 00       	mov    $0x44790,%edx
   417e6:	be e7 02 00 00       	mov    $0x2e7,%esi
   417eb:	bf dd 42 04 00       	mov    $0x442dd,%edi
   417f0:	e8 5f 15 00 00       	callq  42d54 <assert_fail>
    if (level < 3) {
   417f5:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   417f9:	7f 5b                	jg     41856 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   417fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41802:	eb 49                	jmp    4184d <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   41804:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41808:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4180b:	48 63 d2             	movslq %edx,%rdx
   4180e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41812:	48 85 c0             	test   %rax,%rax
   41815:	74 32                	je     41849 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41817:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4181b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4181e:	48 63 d2             	movslq %edx,%rdx
   41821:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41825:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4182b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4182f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41832:	8d 70 01             	lea    0x1(%rax),%esi
   41835:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41838:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4183c:	b9 01 00 00 00       	mov    $0x1,%ecx
   41841:	48 89 c7             	mov    %rax,%rdi
   41844:	e8 18 ff ff ff       	callq  41761 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41849:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4184d:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41854:	7e ae                	jle    41804 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41856:	90                   	nop
   41857:	c9                   	leaveq 
   41858:	c3                   	retq   

0000000000041859 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41859:	55                   	push   %rbp
   4185a:	48 89 e5             	mov    %rsp,%rbp
   4185d:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41861:	8b 05 81 d8 00 00    	mov    0xd881(%rip),%eax        # 4f0e8 <processes+0xc8>
   41867:	85 c0                	test   %eax,%eax
   41869:	74 14                	je     4187f <check_virtual_memory+0x26>
   4186b:	ba c0 47 04 00       	mov    $0x447c0,%edx
   41870:	be fa 02 00 00       	mov    $0x2fa,%esi
   41875:	bf dd 42 04 00       	mov    $0x442dd,%edi
   4187a:	e8 d5 14 00 00       	callq  42d54 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4187f:	48 8b 05 7a 07 01 00 	mov    0x1077a(%rip),%rax        # 52000 <kernel_pagetable>
   41886:	48 89 c7             	mov    %rax,%rdi
   41889:	e8 dc fc ff ff       	callq  4156a <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4188e:	48 8b 05 6b 07 01 00 	mov    0x1076b(%rip),%rax        # 52000 <kernel_pagetable>
   41895:	be ff ff ff ff       	mov    $0xffffffff,%esi
   4189a:	48 89 c7             	mov    %rax,%rdi
   4189d:	e8 15 fe ff ff       	callq  416b7 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   418a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   418a9:	e9 9c 00 00 00       	jmpq   4194a <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   418ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418b1:	48 63 d0             	movslq %eax,%rdx
   418b4:	48 89 d0             	mov    %rdx,%rax
   418b7:	48 c1 e0 03          	shl    $0x3,%rax
   418bb:	48 29 d0             	sub    %rdx,%rax
   418be:	48 c1 e0 05          	shl    $0x5,%rax
   418c2:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   418c8:	8b 00                	mov    (%rax),%eax
   418ca:	85 c0                	test   %eax,%eax
   418cc:	74 78                	je     41946 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   418ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418d1:	48 63 d0             	movslq %eax,%rdx
   418d4:	48 89 d0             	mov    %rdx,%rax
   418d7:	48 c1 e0 03          	shl    $0x3,%rax
   418db:	48 29 d0             	sub    %rdx,%rax
   418de:	48 c1 e0 05          	shl    $0x5,%rax
   418e2:	48 05 f0 f0 04 00    	add    $0x4f0f0,%rax
   418e8:	48 8b 10             	mov    (%rax),%rdx
   418eb:	48 8b 05 0e 07 01 00 	mov    0x1070e(%rip),%rax        # 52000 <kernel_pagetable>
   418f2:	48 39 c2             	cmp    %rax,%rdx
   418f5:	74 4f                	je     41946 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   418f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418fa:	48 63 d0             	movslq %eax,%rdx
   418fd:	48 89 d0             	mov    %rdx,%rax
   41900:	48 c1 e0 03          	shl    $0x3,%rax
   41904:	48 29 d0             	sub    %rdx,%rax
   41907:	48 c1 e0 05          	shl    $0x5,%rax
   4190b:	48 05 f0 f0 04 00    	add    $0x4f0f0,%rax
   41911:	48 8b 00             	mov    (%rax),%rax
   41914:	48 89 c7             	mov    %rax,%rdi
   41917:	e8 4e fc ff ff       	callq  4156a <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4191c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4191f:	48 63 d0             	movslq %eax,%rdx
   41922:	48 89 d0             	mov    %rdx,%rax
   41925:	48 c1 e0 03          	shl    $0x3,%rax
   41929:	48 29 d0             	sub    %rdx,%rax
   4192c:	48 c1 e0 05          	shl    $0x5,%rax
   41930:	48 05 f0 f0 04 00    	add    $0x4f0f0,%rax
   41936:	48 8b 00             	mov    (%rax),%rax
   41939:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4193c:	89 d6                	mov    %edx,%esi
   4193e:	48 89 c7             	mov    %rax,%rdi
   41941:	e8 71 fd ff ff       	callq  416b7 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41946:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4194a:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4194e:	0f 8e 5a ff ff ff    	jle    418ae <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41954:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4195b:	eb 67                	jmp    419c4 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4195d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41960:	48 98                	cltq   
   41962:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   41969:	00 
   4196a:	84 c0                	test   %al,%al
   4196c:	7e 52                	jle    419c0 <check_virtual_memory+0x167>
   4196e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41971:	48 98                	cltq   
   41973:	0f b6 84 00 40 fe 04 	movzbl 0x4fe40(%rax,%rax,1),%eax
   4197a:	00 
   4197b:	84 c0                	test   %al,%al
   4197d:	78 41                	js     419c0 <check_virtual_memory+0x167>
            // if(processes[pageinfo[pn].owner].p_state == P_FREE)
            //     log_printf("pagenum = %d, refcount = %d, owner = %d\n", pn, pageinfo[pn].refcount, pageinfo[pn].owner);
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4197f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41982:	48 98                	cltq   
   41984:	0f b6 84 00 40 fe 04 	movzbl 0x4fe40(%rax,%rax,1),%eax
   4198b:	00 
   4198c:	0f be c0             	movsbl %al,%eax
   4198f:	48 63 d0             	movslq %eax,%rdx
   41992:	48 89 d0             	mov    %rdx,%rax
   41995:	48 c1 e0 03          	shl    $0x3,%rax
   41999:	48 29 d0             	sub    %rdx,%rax
   4199c:	48 c1 e0 05          	shl    $0x5,%rax
   419a0:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   419a6:	8b 00                	mov    (%rax),%eax
   419a8:	85 c0                	test   %eax,%eax
   419aa:	75 14                	jne    419c0 <check_virtual_memory+0x167>
   419ac:	ba e0 47 04 00       	mov    $0x447e0,%edx
   419b1:	be 13 03 00 00       	mov    $0x313,%esi
   419b6:	bf dd 42 04 00       	mov    $0x442dd,%edi
   419bb:	e8 94 13 00 00       	callq  42d54 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   419c0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   419c4:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   419cb:	7e 90                	jle    4195d <check_virtual_memory+0x104>
        }
    }
}
   419cd:	90                   	nop
   419ce:	90                   	nop
   419cf:	c9                   	leaveq 
   419d0:	c3                   	retq   

00000000000419d1 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   419d1:	55                   	push   %rbp
   419d2:	48 89 e5             	mov    %rsp,%rbp
   419d5:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   419d9:	ba 46 48 04 00       	mov    $0x44846,%edx
   419de:	be 00 0f 00 00       	mov    $0xf00,%esi
   419e3:	bf 20 00 00 00       	mov    $0x20,%edi
   419e8:	b8 00 00 00 00       	mov    $0x0,%eax
   419ed:	e8 a3 27 00 00       	callq  44195 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   419f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   419f9:	e9 f4 00 00 00       	jmpq   41af2 <memshow_physical+0x121>
        if (pn % 64 == 0) {
   419fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a01:	83 e0 3f             	and    $0x3f,%eax
   41a04:	85 c0                	test   %eax,%eax
   41a06:	75 3e                	jne    41a46 <memshow_physical+0x75>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41a08:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a0b:	c1 e0 0c             	shl    $0xc,%eax
   41a0e:	89 c2                	mov    %eax,%edx
   41a10:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a13:	8d 48 3f             	lea    0x3f(%rax),%ecx
   41a16:	85 c0                	test   %eax,%eax
   41a18:	0f 48 c1             	cmovs  %ecx,%eax
   41a1b:	c1 f8 06             	sar    $0x6,%eax
   41a1e:	8d 48 01             	lea    0x1(%rax),%ecx
   41a21:	89 c8                	mov    %ecx,%eax
   41a23:	c1 e0 02             	shl    $0x2,%eax
   41a26:	01 c8                	add    %ecx,%eax
   41a28:	c1 e0 04             	shl    $0x4,%eax
   41a2b:	83 c0 03             	add    $0x3,%eax
   41a2e:	89 d1                	mov    %edx,%ecx
   41a30:	ba 56 48 04 00       	mov    $0x44856,%edx
   41a35:	be 00 0f 00 00       	mov    $0xf00,%esi
   41a3a:	89 c7                	mov    %eax,%edi
   41a3c:	b8 00 00 00 00       	mov    $0x0,%eax
   41a41:	e8 4f 27 00 00       	callq  44195 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41a46:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a49:	48 98                	cltq   
   41a4b:	0f b6 84 00 40 fe 04 	movzbl 0x4fe40(%rax,%rax,1),%eax
   41a52:	00 
   41a53:	0f be c0             	movsbl %al,%eax
   41a56:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41a59:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a5c:	48 98                	cltq   
   41a5e:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   41a65:	00 
   41a66:	84 c0                	test   %al,%al
   41a68:	75 07                	jne    41a71 <memshow_physical+0xa0>
            owner = PO_FREE;
   41a6a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41a71:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41a74:	83 c0 02             	add    $0x2,%eax
   41a77:	48 98                	cltq   
   41a79:	0f b7 84 00 20 48 04 	movzwl 0x44820(%rax,%rax,1),%eax
   41a80:	00 
   41a81:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41a85:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a88:	48 98                	cltq   
   41a8a:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   41a91:	00 
   41a92:	3c 01                	cmp    $0x1,%al
   41a94:	7e 1a                	jle    41ab0 <memshow_physical+0xdf>
   41a96:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41a9b:	48 c1 e8 0c          	shr    $0xc,%rax
   41a9f:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41aa2:	74 0c                	je     41ab0 <memshow_physical+0xdf>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41aa4:	b8 53 00 00 00       	mov    $0x53,%eax
   41aa9:	80 cc 0f             	or     $0xf,%ah
   41aac:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41ab0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ab3:	8d 50 3f             	lea    0x3f(%rax),%edx
   41ab6:	85 c0                	test   %eax,%eax
   41ab8:	0f 48 c2             	cmovs  %edx,%eax
   41abb:	c1 f8 06             	sar    $0x6,%eax
   41abe:	8d 50 01             	lea    0x1(%rax),%edx
   41ac1:	89 d0                	mov    %edx,%eax
   41ac3:	c1 e0 02             	shl    $0x2,%eax
   41ac6:	01 d0                	add    %edx,%eax
   41ac8:	c1 e0 04             	shl    $0x4,%eax
   41acb:	89 c1                	mov    %eax,%ecx
   41acd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ad0:	99                   	cltd   
   41ad1:	c1 ea 1a             	shr    $0x1a,%edx
   41ad4:	01 d0                	add    %edx,%eax
   41ad6:	83 e0 3f             	and    $0x3f,%eax
   41ad9:	29 d0                	sub    %edx,%eax
   41adb:	83 c0 0c             	add    $0xc,%eax
   41ade:	01 c8                	add    %ecx,%eax
   41ae0:	48 98                	cltq   
   41ae2:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41ae6:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   41aed:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41aee:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41af2:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41af9:	0f 8e ff fe ff ff    	jle    419fe <memshow_physical+0x2d>
    }
}
   41aff:	90                   	nop
   41b00:	90                   	nop
   41b01:	c9                   	leaveq 
   41b02:	c3                   	retq   

0000000000041b03 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41b03:	55                   	push   %rbp
   41b04:	48 89 e5             	mov    %rsp,%rbp
   41b07:	48 83 ec 40          	sub    $0x40,%rsp
   41b0b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41b0f:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41b13:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41b17:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41b1d:	48 89 c2             	mov    %rax,%rdx
   41b20:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41b24:	48 39 c2             	cmp    %rax,%rdx
   41b27:	74 14                	je     41b3d <memshow_virtual+0x3a>
   41b29:	ba 60 48 04 00       	mov    $0x44860,%edx
   41b2e:	be 44 03 00 00       	mov    $0x344,%esi
   41b33:	bf dd 42 04 00       	mov    $0x442dd,%edi
   41b38:	e8 17 12 00 00       	callq  42d54 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41b3d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41b41:	48 89 c1             	mov    %rax,%rcx
   41b44:	ba 8d 48 04 00       	mov    $0x4488d,%edx
   41b49:	be 00 0f 00 00       	mov    $0xf00,%esi
   41b4e:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41b53:	b8 00 00 00 00       	mov    $0x0,%eax
   41b58:	e8 38 26 00 00       	callq  44195 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41b5d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41b64:	00 
   41b65:	e9 80 01 00 00       	jmpq   41cea <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41b6a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41b6e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41b72:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41b76:	48 89 ce             	mov    %rcx,%rsi
   41b79:	48 89 c7             	mov    %rax,%rdi
   41b7c:	e8 87 18 00 00       	callq  43408 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41b81:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41b84:	85 c0                	test   %eax,%eax
   41b86:	79 0b                	jns    41b93 <memshow_virtual+0x90>
            color = ' ';
   41b88:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41b8e:	e9 d7 00 00 00       	jmpq   41c6a <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41b93:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41b97:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41b9d:	76 14                	jbe    41bb3 <memshow_virtual+0xb0>
   41b9f:	ba aa 48 04 00       	mov    $0x448aa,%edx
   41ba4:	be 4d 03 00 00       	mov    $0x34d,%esi
   41ba9:	bf dd 42 04 00       	mov    $0x442dd,%edi
   41bae:	e8 a1 11 00 00       	callq  42d54 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41bb3:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41bb6:	48 98                	cltq   
   41bb8:	0f b6 84 00 40 fe 04 	movzbl 0x4fe40(%rax,%rax,1),%eax
   41bbf:	00 
   41bc0:	0f be c0             	movsbl %al,%eax
   41bc3:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41bc6:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41bc9:	48 98                	cltq   
   41bcb:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   41bd2:	00 
   41bd3:	84 c0                	test   %al,%al
   41bd5:	75 07                	jne    41bde <memshow_virtual+0xdb>
                owner = PO_FREE;
   41bd7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41bde:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41be1:	83 c0 02             	add    $0x2,%eax
   41be4:	48 98                	cltq   
   41be6:	0f b7 84 00 20 48 04 	movzwl 0x44820(%rax,%rax,1),%eax
   41bed:	00 
   41bee:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41bf2:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41bf5:	48 98                	cltq   
   41bf7:	83 e0 04             	and    $0x4,%eax
   41bfa:	48 85 c0             	test   %rax,%rax
   41bfd:	74 27                	je     41c26 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41bff:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c03:	c1 e0 04             	shl    $0x4,%eax
   41c06:	66 25 00 f0          	and    $0xf000,%ax
   41c0a:	89 c2                	mov    %eax,%edx
   41c0c:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c10:	c1 f8 04             	sar    $0x4,%eax
   41c13:	66 25 00 0f          	and    $0xf00,%ax
   41c17:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41c19:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c1d:	0f b6 c0             	movzbl %al,%eax
   41c20:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41c22:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41c26:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41c29:	48 98                	cltq   
   41c2b:	0f b6 84 00 41 fe 04 	movzbl 0x4fe41(%rax,%rax,1),%eax
   41c32:	00 
   41c33:	3c 01                	cmp    $0x1,%al
   41c35:	7e 33                	jle    41c6a <memshow_virtual+0x167>
   41c37:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41c3c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41c40:	74 28                	je     41c6a <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41c42:	b8 53 00 00 00       	mov    $0x53,%eax
   41c47:	89 c2                	mov    %eax,%edx
   41c49:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c4d:	66 25 00 f0          	and    $0xf000,%ax
   41c51:	09 d0                	or     %edx,%eax
   41c53:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41c57:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41c5a:	48 98                	cltq   
   41c5c:	83 e0 04             	and    $0x4,%eax
   41c5f:	48 85 c0             	test   %rax,%rax
   41c62:	75 06                	jne    41c6a <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41c64:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41c6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c6e:	48 c1 e8 0c          	shr    $0xc,%rax
   41c72:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41c75:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41c78:	83 e0 3f             	and    $0x3f,%eax
   41c7b:	85 c0                	test   %eax,%eax
   41c7d:	75 34                	jne    41cb3 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41c7f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41c82:	c1 e8 06             	shr    $0x6,%eax
   41c85:	89 c2                	mov    %eax,%edx
   41c87:	89 d0                	mov    %edx,%eax
   41c89:	c1 e0 02             	shl    $0x2,%eax
   41c8c:	01 d0                	add    %edx,%eax
   41c8e:	c1 e0 04             	shl    $0x4,%eax
   41c91:	05 73 03 00 00       	add    $0x373,%eax
   41c96:	89 c7                	mov    %eax,%edi
   41c98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c9c:	48 89 c1             	mov    %rax,%rcx
   41c9f:	ba 56 48 04 00       	mov    $0x44856,%edx
   41ca4:	be 00 0f 00 00       	mov    $0xf00,%esi
   41ca9:	b8 00 00 00 00       	mov    $0x0,%eax
   41cae:	e8 e2 24 00 00       	callq  44195 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41cb3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41cb6:	c1 e8 06             	shr    $0x6,%eax
   41cb9:	89 c2                	mov    %eax,%edx
   41cbb:	89 d0                	mov    %edx,%eax
   41cbd:	c1 e0 02             	shl    $0x2,%eax
   41cc0:	01 d0                	add    %edx,%eax
   41cc2:	c1 e0 04             	shl    $0x4,%eax
   41cc5:	89 c2                	mov    %eax,%edx
   41cc7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41cca:	83 e0 3f             	and    $0x3f,%eax
   41ccd:	01 d0                	add    %edx,%eax
   41ccf:	05 7c 03 00 00       	add    $0x37c,%eax
   41cd4:	89 c2                	mov    %eax,%edx
   41cd6:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41cda:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41ce1:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41ce2:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41ce9:	00 
   41cea:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41cf1:	00 
   41cf2:	0f 86 72 fe ff ff    	jbe    41b6a <memshow_virtual+0x67>
    }
}
   41cf8:	90                   	nop
   41cf9:	90                   	nop
   41cfa:	c9                   	leaveq 
   41cfb:	c3                   	retq   

0000000000041cfc <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41cfc:	55                   	push   %rbp
   41cfd:	48 89 e5             	mov    %rsp,%rbp
   41d00:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41d04:	8b 05 36 e5 00 00    	mov    0xe536(%rip),%eax        # 50240 <last_ticks.1>
   41d0a:	85 c0                	test   %eax,%eax
   41d0c:	74 13                	je     41d21 <memshow_virtual_animate+0x25>
   41d0e:	8b 05 0c e1 00 00    	mov    0xe10c(%rip),%eax        # 4fe20 <ticks>
   41d14:	8b 15 26 e5 00 00    	mov    0xe526(%rip),%edx        # 50240 <last_ticks.1>
   41d1a:	29 d0                	sub    %edx,%eax
   41d1c:	83 f8 31             	cmp    $0x31,%eax
   41d1f:	76 2c                	jbe    41d4d <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41d21:	8b 05 f9 e0 00 00    	mov    0xe0f9(%rip),%eax        # 4fe20 <ticks>
   41d27:	89 05 13 e5 00 00    	mov    %eax,0xe513(%rip)        # 50240 <last_ticks.1>
        ++showing;
   41d2d:	8b 05 d1 42 00 00    	mov    0x42d1(%rip),%eax        # 46004 <showing.0>
   41d33:	83 c0 01             	add    $0x1,%eax
   41d36:	89 05 c8 42 00 00    	mov    %eax,0x42c8(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41d3c:	eb 0f                	jmp    41d4d <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   41d3e:	8b 05 c0 42 00 00    	mov    0x42c0(%rip),%eax        # 46004 <showing.0>
   41d44:	83 c0 01             	add    $0x1,%eax
   41d47:	89 05 b7 42 00 00    	mov    %eax,0x42b7(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41d4d:	8b 05 b1 42 00 00    	mov    0x42b1(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41d53:	83 f8 20             	cmp    $0x20,%eax
   41d56:	7f 2e                	jg     41d86 <memshow_virtual_animate+0x8a>
   41d58:	8b 05 a6 42 00 00    	mov    0x42a6(%rip),%eax        # 46004 <showing.0>
   41d5e:	99                   	cltd   
   41d5f:	c1 ea 1c             	shr    $0x1c,%edx
   41d62:	01 d0                	add    %edx,%eax
   41d64:	83 e0 0f             	and    $0xf,%eax
   41d67:	29 d0                	sub    %edx,%eax
   41d69:	48 63 d0             	movslq %eax,%rdx
   41d6c:	48 89 d0             	mov    %rdx,%rax
   41d6f:	48 c1 e0 03          	shl    $0x3,%rax
   41d73:	48 29 d0             	sub    %rdx,%rax
   41d76:	48 c1 e0 05          	shl    $0x5,%rax
   41d7a:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   41d80:	8b 00                	mov    (%rax),%eax
   41d82:	85 c0                	test   %eax,%eax
   41d84:	74 b8                	je     41d3e <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41d86:	8b 05 78 42 00 00    	mov    0x4278(%rip),%eax        # 46004 <showing.0>
   41d8c:	99                   	cltd   
   41d8d:	c1 ea 1c             	shr    $0x1c,%edx
   41d90:	01 d0                	add    %edx,%eax
   41d92:	83 e0 0f             	and    $0xf,%eax
   41d95:	29 d0                	sub    %edx,%eax
   41d97:	89 05 67 42 00 00    	mov    %eax,0x4267(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41d9d:	8b 05 61 42 00 00    	mov    0x4261(%rip),%eax        # 46004 <showing.0>
   41da3:	48 63 d0             	movslq %eax,%rdx
   41da6:	48 89 d0             	mov    %rdx,%rax
   41da9:	48 c1 e0 03          	shl    $0x3,%rax
   41dad:	48 29 d0             	sub    %rdx,%rax
   41db0:	48 c1 e0 05          	shl    $0x5,%rax
   41db4:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   41dba:	8b 00                	mov    (%rax),%eax
   41dbc:	85 c0                	test   %eax,%eax
   41dbe:	74 52                	je     41e12 <memshow_virtual_animate+0x116>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41dc0:	8b 15 3e 42 00 00    	mov    0x423e(%rip),%edx        # 46004 <showing.0>
   41dc6:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41dca:	89 d1                	mov    %edx,%ecx
   41dcc:	ba c4 48 04 00       	mov    $0x448c4,%edx
   41dd1:	be 04 00 00 00       	mov    $0x4,%esi
   41dd6:	48 89 c7             	mov    %rax,%rdi
   41dd9:	b8 00 00 00 00       	mov    $0x0,%eax
   41dde:	e8 30 24 00 00       	callq  44213 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41de3:	8b 05 1b 42 00 00    	mov    0x421b(%rip),%eax        # 46004 <showing.0>
   41de9:	48 63 d0             	movslq %eax,%rdx
   41dec:	48 89 d0             	mov    %rdx,%rax
   41def:	48 c1 e0 03          	shl    $0x3,%rax
   41df3:	48 29 d0             	sub    %rdx,%rax
   41df6:	48 c1 e0 05          	shl    $0x5,%rax
   41dfa:	48 05 f0 f0 04 00    	add    $0x4f0f0,%rax
   41e00:	48 8b 00             	mov    (%rax),%rax
   41e03:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41e07:	48 89 d6             	mov    %rdx,%rsi
   41e0a:	48 89 c7             	mov    %rax,%rdi
   41e0d:	e8 f1 fc ff ff       	callq  41b03 <memshow_virtual>
    }
}
   41e12:	90                   	nop
   41e13:	c9                   	leaveq 
   41e14:	c3                   	retq   

0000000000041e15 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41e15:	55                   	push   %rbp
   41e16:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41e19:	e8 53 01 00 00       	callq  41f71 <segments_init>
    interrupt_init();
   41e1e:	e8 d4 03 00 00       	callq  421f7 <interrupt_init>
    virtual_memory_init();
   41e23:	e8 e7 0f 00 00       	callq  42e0f <virtual_memory_init>
}
   41e28:	90                   	nop
   41e29:	5d                   	pop    %rbp
   41e2a:	c3                   	retq   

0000000000041e2b <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41e2b:	55                   	push   %rbp
   41e2c:	48 89 e5             	mov    %rsp,%rbp
   41e2f:	48 83 ec 18          	sub    $0x18,%rsp
   41e33:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e37:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41e3b:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41e3e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41e41:	48 98                	cltq   
   41e43:	48 c1 e0 2d          	shl    $0x2d,%rax
   41e47:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41e4b:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41e52:	90 00 00 
   41e55:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41e58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e5c:	48 89 10             	mov    %rdx,(%rax)
}
   41e5f:	90                   	nop
   41e60:	c9                   	leaveq 
   41e61:	c3                   	retq   

0000000000041e62 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41e62:	55                   	push   %rbp
   41e63:	48 89 e5             	mov    %rsp,%rbp
   41e66:	48 83 ec 28          	sub    $0x28,%rsp
   41e6a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e6e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41e72:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41e75:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41e79:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41e7d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41e81:	48 c1 e0 10          	shl    $0x10,%rax
   41e85:	48 89 c2             	mov    %rax,%rdx
   41e88:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41e8f:	00 00 00 
   41e92:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41e95:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41e99:	48 c1 e0 20          	shl    $0x20,%rax
   41e9d:	48 89 c1             	mov    %rax,%rcx
   41ea0:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41ea7:	00 00 ff 
   41eaa:	48 21 c8             	and    %rcx,%rax
   41ead:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41eb0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41eb4:	48 83 e8 01          	sub    $0x1,%rax
   41eb8:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41ebb:	48 09 d0             	or     %rdx,%rax
        | type
   41ebe:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41ec2:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41ec5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41ec8:	48 98                	cltq   
   41eca:	48 c1 e0 2d          	shl    $0x2d,%rax
   41ece:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41ed1:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41ed8:	80 00 00 
   41edb:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41ede:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ee2:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41ee5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ee9:	48 83 c0 08          	add    $0x8,%rax
   41eed:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41ef1:	48 c1 ea 20          	shr    $0x20,%rdx
   41ef5:	48 89 10             	mov    %rdx,(%rax)
}
   41ef8:	90                   	nop
   41ef9:	c9                   	leaveq 
   41efa:	c3                   	retq   

0000000000041efb <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41efb:	55                   	push   %rbp
   41efc:	48 89 e5             	mov    %rsp,%rbp
   41eff:	48 83 ec 20          	sub    $0x20,%rsp
   41f03:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41f07:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41f0b:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41f0e:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41f12:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41f16:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41f19:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41f1d:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41f20:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41f23:	48 98                	cltq   
   41f25:	48 c1 e0 2d          	shl    $0x2d,%rax
   41f29:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41f2c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41f30:	48 c1 e0 20          	shl    $0x20,%rax
   41f34:	48 89 c1             	mov    %rax,%rcx
   41f37:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41f3e:	00 ff ff 
   41f41:	48 21 c8             	and    %rcx,%rax
   41f44:	48 09 c2             	or     %rax,%rdx
   41f47:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41f4e:	80 00 00 
   41f51:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41f54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f58:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41f5b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41f5f:	48 c1 e8 20          	shr    $0x20,%rax
   41f63:	48 89 c2             	mov    %rax,%rdx
   41f66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f6a:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41f6e:	90                   	nop
   41f6f:	c9                   	leaveq 
   41f70:	c3                   	retq   

0000000000041f71 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41f71:	55                   	push   %rbp
   41f72:	48 89 e5             	mov    %rsp,%rbp
   41f75:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41f79:	48 c7 05 dc e2 00 00 	movq   $0x0,0xe2dc(%rip)        # 50260 <segments>
   41f80:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41f84:	ba 00 00 00 00       	mov    $0x0,%edx
   41f89:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41f90:	08 20 00 
   41f93:	48 89 c6             	mov    %rax,%rsi
   41f96:	bf 68 02 05 00       	mov    $0x50268,%edi
   41f9b:	e8 8b fe ff ff       	callq  41e2b <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41fa0:	ba 03 00 00 00       	mov    $0x3,%edx
   41fa5:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41fac:	08 20 00 
   41faf:	48 89 c6             	mov    %rax,%rsi
   41fb2:	bf 70 02 05 00       	mov    $0x50270,%edi
   41fb7:	e8 6f fe ff ff       	callq  41e2b <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41fbc:	ba 00 00 00 00       	mov    $0x0,%edx
   41fc1:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41fc8:	02 00 00 
   41fcb:	48 89 c6             	mov    %rax,%rsi
   41fce:	bf 78 02 05 00       	mov    $0x50278,%edi
   41fd3:	e8 53 fe ff ff       	callq  41e2b <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41fd8:	ba 03 00 00 00       	mov    $0x3,%edx
   41fdd:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41fe4:	02 00 00 
   41fe7:	48 89 c6             	mov    %rax,%rsi
   41fea:	bf 80 02 05 00       	mov    $0x50280,%edi
   41fef:	e8 37 fe ff ff       	callq  41e2b <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41ff4:	b8 a0 12 05 00       	mov    $0x512a0,%eax
   41ff9:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41fff:	48 89 c1             	mov    %rax,%rcx
   42002:	ba 00 00 00 00       	mov    $0x0,%edx
   42007:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   4200e:	09 00 00 
   42011:	48 89 c6             	mov    %rax,%rsi
   42014:	bf 88 02 05 00       	mov    $0x50288,%edi
   42019:	e8 44 fe ff ff       	callq  41e62 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   4201e:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   42024:	b8 60 02 05 00       	mov    $0x50260,%eax
   42029:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   4202d:	ba 60 00 00 00       	mov    $0x60,%edx
   42032:	be 00 00 00 00       	mov    $0x0,%esi
   42037:	bf a0 12 05 00       	mov    $0x512a0,%edi
   4203c:	e8 1f 19 00 00       	callq  43960 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   42041:	48 c7 05 58 f2 00 00 	movq   $0x80000,0xf258(%rip)        # 512a4 <kernel_task_descriptor+0x4>
   42048:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   4204c:	ba 00 10 00 00       	mov    $0x1000,%edx
   42051:	be 00 00 00 00       	mov    $0x0,%esi
   42056:	bf a0 02 05 00       	mov    $0x502a0,%edi
   4205b:	e8 00 19 00 00       	callq  43960 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   42060:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   42067:	eb 30                	jmp    42099 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   42069:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4206e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42071:	48 c1 e0 04          	shl    $0x4,%rax
   42075:	48 05 a0 02 05 00    	add    $0x502a0,%rax
   4207b:	48 89 d1             	mov    %rdx,%rcx
   4207e:	ba 00 00 00 00       	mov    $0x0,%edx
   42083:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4208a:	0e 00 00 
   4208d:	48 89 c7             	mov    %rax,%rdi
   42090:	e8 66 fe ff ff       	callq  41efb <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   42095:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42099:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   420a0:	76 c7                	jbe    42069 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   420a2:	b8 36 00 04 00       	mov    $0x40036,%eax
   420a7:	48 89 c1             	mov    %rax,%rcx
   420aa:	ba 00 00 00 00       	mov    $0x0,%edx
   420af:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   420b6:	0e 00 00 
   420b9:	48 89 c6             	mov    %rax,%rsi
   420bc:	bf a0 04 05 00       	mov    $0x504a0,%edi
   420c1:	e8 35 fe ff ff       	callq  41efb <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   420c6:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   420cb:	48 89 c1             	mov    %rax,%rcx
   420ce:	ba 00 00 00 00       	mov    $0x0,%edx
   420d3:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   420da:	0e 00 00 
   420dd:	48 89 c6             	mov    %rax,%rsi
   420e0:	bf 70 03 05 00       	mov    $0x50370,%edi
   420e5:	e8 11 fe ff ff       	callq  41efb <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   420ea:	b8 32 00 04 00       	mov    $0x40032,%eax
   420ef:	48 89 c1             	mov    %rax,%rcx
   420f2:	ba 00 00 00 00       	mov    $0x0,%edx
   420f7:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   420fe:	0e 00 00 
   42101:	48 89 c6             	mov    %rax,%rsi
   42104:	bf 80 03 05 00       	mov    $0x50380,%edi
   42109:	e8 ed fd ff ff       	callq  41efb <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4210e:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   42115:	eb 3e                	jmp    42155 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   42117:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4211a:	83 e8 30             	sub    $0x30,%eax
   4211d:	89 c0                	mov    %eax,%eax
   4211f:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   42126:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   42127:	48 89 c2             	mov    %rax,%rdx
   4212a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4212d:	48 c1 e0 04          	shl    $0x4,%rax
   42131:	48 05 a0 02 05 00    	add    $0x502a0,%rax
   42137:	48 89 d1             	mov    %rdx,%rcx
   4213a:	ba 03 00 00 00       	mov    $0x3,%edx
   4213f:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   42146:	0e 00 00 
   42149:	48 89 c7             	mov    %rax,%rdi
   4214c:	e8 aa fd ff ff       	callq  41efb <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   42151:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42155:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   42159:	76 bc                	jbe    42117 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4215b:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   42161:	b8 a0 02 05 00       	mov    $0x502a0,%eax
   42166:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   4216a:	b8 28 00 00 00       	mov    $0x28,%eax
   4216f:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   42173:	0f 00 d8             	ltr    %ax
   42176:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4217a:	0f 20 c0             	mov    %cr0,%rax
   4217d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   42181:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   42185:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   42188:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   4218f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42192:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   42195:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42198:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   4219c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   421a0:	0f 22 c0             	mov    %rax,%cr0
}
   421a3:	90                   	nop
    lcr0(cr0);
}
   421a4:	90                   	nop
   421a5:	c9                   	leaveq 
   421a6:	c3                   	retq   

00000000000421a7 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   421a7:	55                   	push   %rbp
   421a8:	48 89 e5             	mov    %rsp,%rbp
   421ab:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   421af:	0f b7 05 4a f1 00 00 	movzwl 0xf14a(%rip),%eax        # 51300 <interrupts_enabled>
   421b6:	f7 d0                	not    %eax
   421b8:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   421bc:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   421c0:	0f b6 c0             	movzbl %al,%eax
   421c3:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   421ca:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421cd:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   421d1:	8b 55 f0             	mov    -0x10(%rbp),%edx
   421d4:	ee                   	out    %al,(%dx)
}
   421d5:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   421d6:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   421da:	66 c1 e8 08          	shr    $0x8,%ax
   421de:	0f b6 c0             	movzbl %al,%eax
   421e1:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   421e8:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421eb:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   421ef:	8b 55 f8             	mov    -0x8(%rbp),%edx
   421f2:	ee                   	out    %al,(%dx)
}
   421f3:	90                   	nop
}
   421f4:	90                   	nop
   421f5:	c9                   	leaveq 
   421f6:	c3                   	retq   

00000000000421f7 <interrupt_init>:

void interrupt_init(void) {
   421f7:	55                   	push   %rbp
   421f8:	48 89 e5             	mov    %rsp,%rbp
   421fb:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   421ff:	66 c7 05 f8 f0 00 00 	movw   $0x0,0xf0f8(%rip)        # 51300 <interrupts_enabled>
   42206:	00 00 
    interrupt_mask();
   42208:	e8 9a ff ff ff       	callq  421a7 <interrupt_mask>
   4220d:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   42214:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42218:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   4221c:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   4221f:	ee                   	out    %al,(%dx)
}
   42220:	90                   	nop
   42221:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   42228:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4222c:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   42230:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42233:	ee                   	out    %al,(%dx)
}
   42234:	90                   	nop
   42235:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   4223c:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42240:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   42244:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   42247:	ee                   	out    %al,(%dx)
}
   42248:	90                   	nop
   42249:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   42250:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42254:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   42258:	8b 55 bc             	mov    -0x44(%rbp),%edx
   4225b:	ee                   	out    %al,(%dx)
}
   4225c:	90                   	nop
   4225d:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   42264:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42268:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   4226c:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   4226f:	ee                   	out    %al,(%dx)
}
   42270:	90                   	nop
   42271:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   42278:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4227c:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   42280:	8b 55 cc             	mov    -0x34(%rbp),%edx
   42283:	ee                   	out    %al,(%dx)
}
   42284:	90                   	nop
   42285:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   4228c:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42290:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   42294:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   42297:	ee                   	out    %al,(%dx)
}
   42298:	90                   	nop
   42299:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   422a0:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422a4:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   422a8:	8b 55 dc             	mov    -0x24(%rbp),%edx
   422ab:	ee                   	out    %al,(%dx)
}
   422ac:	90                   	nop
   422ad:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   422b4:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422b8:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   422bc:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   422bf:	ee                   	out    %al,(%dx)
}
   422c0:	90                   	nop
   422c1:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   422c8:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422cc:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   422d0:	8b 55 ec             	mov    -0x14(%rbp),%edx
   422d3:	ee                   	out    %al,(%dx)
}
   422d4:	90                   	nop
   422d5:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   422dc:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422e0:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   422e4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   422e7:	ee                   	out    %al,(%dx)
}
   422e8:	90                   	nop
   422e9:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   422f0:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422f4:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   422f8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   422fb:	ee                   	out    %al,(%dx)
}
   422fc:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   422fd:	e8 a5 fe ff ff       	callq  421a7 <interrupt_mask>
}
   42302:	90                   	nop
   42303:	c9                   	leaveq 
   42304:	c3                   	retq   

0000000000042305 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   42305:	55                   	push   %rbp
   42306:	48 89 e5             	mov    %rsp,%rbp
   42309:	48 83 ec 28          	sub    $0x28,%rsp
   4230d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   42310:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42314:	0f 8e 9f 00 00 00    	jle    423b9 <timer_init+0xb4>
   4231a:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   42321:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42325:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42329:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4232c:	ee                   	out    %al,(%dx)
}
   4232d:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   4232e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42331:	89 c2                	mov    %eax,%edx
   42333:	c1 ea 1f             	shr    $0x1f,%edx
   42336:	01 d0                	add    %edx,%eax
   42338:	d1 f8                	sar    %eax
   4233a:	05 de 34 12 00       	add    $0x1234de,%eax
   4233f:	99                   	cltd   
   42340:	f7 7d dc             	idivl  -0x24(%rbp)
   42343:	89 c2                	mov    %eax,%edx
   42345:	89 d0                	mov    %edx,%eax
   42347:	c1 f8 1f             	sar    $0x1f,%eax
   4234a:	c1 e8 18             	shr    $0x18,%eax
   4234d:	89 c1                	mov    %eax,%ecx
   4234f:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   42352:	0f b6 c0             	movzbl %al,%eax
   42355:	29 c8                	sub    %ecx,%eax
   42357:	0f b6 c0             	movzbl %al,%eax
   4235a:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   42361:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42364:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42368:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4236b:	ee                   	out    %al,(%dx)
}
   4236c:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   4236d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42370:	89 c2                	mov    %eax,%edx
   42372:	c1 ea 1f             	shr    $0x1f,%edx
   42375:	01 d0                	add    %edx,%eax
   42377:	d1 f8                	sar    %eax
   42379:	05 de 34 12 00       	add    $0x1234de,%eax
   4237e:	99                   	cltd   
   4237f:	f7 7d dc             	idivl  -0x24(%rbp)
   42382:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42388:	85 c0                	test   %eax,%eax
   4238a:	0f 48 c2             	cmovs  %edx,%eax
   4238d:	c1 f8 08             	sar    $0x8,%eax
   42390:	0f b6 c0             	movzbl %al,%eax
   42393:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   4239a:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4239d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   423a1:	8b 55 fc             	mov    -0x4(%rbp),%edx
   423a4:	ee                   	out    %al,(%dx)
}
   423a5:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   423a6:	0f b7 05 53 ef 00 00 	movzwl 0xef53(%rip),%eax        # 51300 <interrupts_enabled>
   423ad:	83 c8 01             	or     $0x1,%eax
   423b0:	66 89 05 49 ef 00 00 	mov    %ax,0xef49(%rip)        # 51300 <interrupts_enabled>
   423b7:	eb 11                	jmp    423ca <timer_init+0xc5>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   423b9:	0f b7 05 40 ef 00 00 	movzwl 0xef40(%rip),%eax        # 51300 <interrupts_enabled>
   423c0:	83 e0 fe             	and    $0xfffffffe,%eax
   423c3:	66 89 05 36 ef 00 00 	mov    %ax,0xef36(%rip)        # 51300 <interrupts_enabled>
    }
    interrupt_mask();
   423ca:	e8 d8 fd ff ff       	callq  421a7 <interrupt_mask>
}
   423cf:	90                   	nop
   423d0:	c9                   	leaveq 
   423d1:	c3                   	retq   

00000000000423d2 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   423d2:	55                   	push   %rbp
   423d3:	48 89 e5             	mov    %rsp,%rbp
   423d6:	48 83 ec 08          	sub    $0x8,%rsp
   423da:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   423de:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   423e3:	74 14                	je     423f9 <physical_memory_isreserved+0x27>
   423e5:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   423ec:	00 
   423ed:	76 11                	jbe    42400 <physical_memory_isreserved+0x2e>
   423ef:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   423f6:	00 
   423f7:	77 07                	ja     42400 <physical_memory_isreserved+0x2e>
   423f9:	b8 01 00 00 00       	mov    $0x1,%eax
   423fe:	eb 05                	jmp    42405 <physical_memory_isreserved+0x33>
   42400:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42405:	c9                   	leaveq 
   42406:	c3                   	retq   

0000000000042407 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   42407:	55                   	push   %rbp
   42408:	48 89 e5             	mov    %rsp,%rbp
   4240b:	48 83 ec 10          	sub    $0x10,%rsp
   4240f:	89 7d fc             	mov    %edi,-0x4(%rbp)
   42412:	89 75 f8             	mov    %esi,-0x8(%rbp)
   42415:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   42418:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4241b:	c1 e0 10             	shl    $0x10,%eax
   4241e:	89 c2                	mov    %eax,%edx
   42420:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42423:	c1 e0 0b             	shl    $0xb,%eax
   42426:	09 c2                	or     %eax,%edx
   42428:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4242b:	c1 e0 08             	shl    $0x8,%eax
   4242e:	09 d0                	or     %edx,%eax
}
   42430:	c9                   	leaveq 
   42431:	c3                   	retq   

0000000000042432 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   42432:	55                   	push   %rbp
   42433:	48 89 e5             	mov    %rsp,%rbp
   42436:	48 83 ec 18          	sub    $0x18,%rsp
   4243a:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4243d:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   42440:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42443:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42446:	09 d0                	or     %edx,%eax
   42448:	0d 00 00 00 80       	or     $0x80000000,%eax
   4244d:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   42454:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42457:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4245a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4245d:	ef                   	out    %eax,(%dx)
}
   4245e:	90                   	nop
   4245f:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42466:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42469:	89 c2                	mov    %eax,%edx
   4246b:	ed                   	in     (%dx),%eax
   4246c:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   4246f:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   42472:	c9                   	leaveq 
   42473:	c3                   	retq   

0000000000042474 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   42474:	55                   	push   %rbp
   42475:	48 89 e5             	mov    %rsp,%rbp
   42478:	48 83 ec 28          	sub    $0x28,%rsp
   4247c:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4247f:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42482:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42489:	eb 73                	jmp    424fe <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   4248b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   42492:	eb 60                	jmp    424f4 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   42494:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4249b:	eb 4a                	jmp    424e7 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   4249d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   424a0:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   424a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   424a6:	89 ce                	mov    %ecx,%esi
   424a8:	89 c7                	mov    %eax,%edi
   424aa:	e8 58 ff ff ff       	callq  42407 <pci_make_configaddr>
   424af:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   424b2:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424b5:	be 00 00 00 00       	mov    $0x0,%esi
   424ba:	89 c7                	mov    %eax,%edi
   424bc:	e8 71 ff ff ff       	callq  42432 <pci_config_readl>
   424c1:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   424c4:	8b 45 d8             	mov    -0x28(%rbp),%eax
   424c7:	c1 e0 10             	shl    $0x10,%eax
   424ca:	0b 45 dc             	or     -0x24(%rbp),%eax
   424cd:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   424d0:	75 05                	jne    424d7 <pci_find_device+0x63>
                    return configaddr;
   424d2:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424d5:	eb 35                	jmp    4250c <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   424d7:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   424db:	75 06                	jne    424e3 <pci_find_device+0x6f>
   424dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   424e1:	74 0c                	je     424ef <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   424e3:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   424e7:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   424eb:	75 b0                	jne    4249d <pci_find_device+0x29>
   424ed:	eb 01                	jmp    424f0 <pci_find_device+0x7c>
                    break;
   424ef:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   424f0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   424f4:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   424f8:	75 9a                	jne    42494 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   424fa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   424fe:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42505:	75 84                	jne    4248b <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   42507:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   4250c:	c9                   	leaveq 
   4250d:	c3                   	retq   

000000000004250e <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   4250e:	55                   	push   %rbp
   4250f:	48 89 e5             	mov    %rsp,%rbp
   42512:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42516:	be 13 71 00 00       	mov    $0x7113,%esi
   4251b:	bf 86 80 00 00       	mov    $0x8086,%edi
   42520:	e8 4f ff ff ff       	callq  42474 <pci_find_device>
   42525:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   42528:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4252c:	78 30                	js     4255e <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   4252e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42531:	be 40 00 00 00       	mov    $0x40,%esi
   42536:	89 c7                	mov    %eax,%edi
   42538:	e8 f5 fe ff ff       	callq  42432 <pci_config_readl>
   4253d:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42542:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42545:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42548:	83 c0 04             	add    $0x4,%eax
   4254b:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4254e:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42554:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42558:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4255b:	66 ef                	out    %ax,(%dx)
}
   4255d:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   4255e:	ba e0 48 04 00       	mov    $0x448e0,%edx
   42563:	be 00 c0 00 00       	mov    $0xc000,%esi
   42568:	bf 80 07 00 00       	mov    $0x780,%edi
   4256d:	b8 00 00 00 00       	mov    $0x0,%eax
   42572:	e8 1e 1c 00 00       	callq  44195 <console_printf>
 spinloop: goto spinloop;
   42577:	eb fe                	jmp    42577 <poweroff+0x69>

0000000000042579 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   42579:	55                   	push   %rbp
   4257a:	48 89 e5             	mov    %rsp,%rbp
   4257d:	48 83 ec 10          	sub    $0x10,%rsp
   42581:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42588:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4258c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42590:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42593:	ee                   	out    %al,(%dx)
}
   42594:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   42595:	eb fe                	jmp    42595 <reboot+0x1c>

0000000000042597 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42597:	55                   	push   %rbp
   42598:	48 89 e5             	mov    %rsp,%rbp
   4259b:	48 83 ec 10          	sub    $0x10,%rsp
   4259f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425a3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   425a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425aa:	48 83 c0 08          	add    $0x8,%rax
   425ae:	ba c0 00 00 00       	mov    $0xc0,%edx
   425b3:	be 00 00 00 00       	mov    $0x0,%esi
   425b8:	48 89 c7             	mov    %rax,%rdi
   425bb:	e8 a0 13 00 00       	callq  43960 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   425c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425c4:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   425cb:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   425cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425d1:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   425d8:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   425dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425e0:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   425e7:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   425eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425ef:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   425f6:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   425f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425fc:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   42603:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42607:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4260a:	83 e0 01             	and    $0x1,%eax
   4260d:	85 c0                	test   %eax,%eax
   4260f:	74 1c                	je     4262d <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   42611:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42615:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4261c:	80 cc 30             	or     $0x30,%ah
   4261f:	48 89 c2             	mov    %rax,%rdx
   42622:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42626:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   4262d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42630:	83 e0 02             	and    $0x2,%eax
   42633:	85 c0                	test   %eax,%eax
   42635:	74 1c                	je     42653 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42637:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4263b:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42642:	80 e4 fd             	and    $0xfd,%ah
   42645:	48 89 c2             	mov    %rax,%rdx
   42648:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4264c:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   42653:	90                   	nop
   42654:	c9                   	leaveq 
   42655:	c3                   	retq   

0000000000042656 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42656:	55                   	push   %rbp
   42657:	48 89 e5             	mov    %rsp,%rbp
   4265a:	48 83 ec 28          	sub    $0x28,%rsp
   4265e:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42661:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42665:	78 09                	js     42670 <console_show_cursor+0x1a>
   42667:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4266e:	7e 07                	jle    42677 <console_show_cursor+0x21>
        cpos = 0;
   42670:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42677:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4267e:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42682:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42686:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42689:	ee                   	out    %al,(%dx)
}
   4268a:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   4268b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4268e:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42694:	85 c0                	test   %eax,%eax
   42696:	0f 48 c2             	cmovs  %edx,%eax
   42699:	c1 f8 08             	sar    $0x8,%eax
   4269c:	0f b6 c0             	movzbl %al,%eax
   4269f:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   426a6:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426a9:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   426ad:	8b 55 ec             	mov    -0x14(%rbp),%edx
   426b0:	ee                   	out    %al,(%dx)
}
   426b1:	90                   	nop
   426b2:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   426b9:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426bd:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   426c1:	8b 55 f4             	mov    -0xc(%rbp),%edx
   426c4:	ee                   	out    %al,(%dx)
}
   426c5:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   426c6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   426c9:	99                   	cltd   
   426ca:	c1 ea 18             	shr    $0x18,%edx
   426cd:	01 d0                	add    %edx,%eax
   426cf:	0f b6 c0             	movzbl %al,%eax
   426d2:	29 d0                	sub    %edx,%eax
   426d4:	0f b6 c0             	movzbl %al,%eax
   426d7:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   426de:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426e1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   426e5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   426e8:	ee                   	out    %al,(%dx)
}
   426e9:	90                   	nop
}
   426ea:	90                   	nop
   426eb:	c9                   	leaveq 
   426ec:	c3                   	retq   

00000000000426ed <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   426ed:	55                   	push   %rbp
   426ee:	48 89 e5             	mov    %rsp,%rbp
   426f1:	48 83 ec 20          	sub    $0x20,%rsp
   426f5:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   426fc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   426ff:	89 c2                	mov    %eax,%edx
   42701:	ec                   	in     (%dx),%al
   42702:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42705:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   42709:	0f b6 c0             	movzbl %al,%eax
   4270c:	83 e0 01             	and    $0x1,%eax
   4270f:	85 c0                	test   %eax,%eax
   42711:	75 0a                	jne    4271d <keyboard_readc+0x30>
        return -1;
   42713:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42718:	e9 e7 01 00 00       	jmpq   42904 <keyboard_readc+0x217>
   4271d:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42724:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42727:	89 c2                	mov    %eax,%edx
   42729:	ec                   	in     (%dx),%al
   4272a:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   4272d:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42731:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42734:	0f b6 05 c7 eb 00 00 	movzbl 0xebc7(%rip),%eax        # 51302 <last_escape.2>
   4273b:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   4273e:	c6 05 bd eb 00 00 00 	movb   $0x0,0xebbd(%rip)        # 51302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42745:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42749:	75 11                	jne    4275c <keyboard_readc+0x6f>
        last_escape = 0x80;
   4274b:	c6 05 b0 eb 00 00 80 	movb   $0x80,0xebb0(%rip)        # 51302 <last_escape.2>
        return 0;
   42752:	b8 00 00 00 00       	mov    $0x0,%eax
   42757:	e9 a8 01 00 00       	jmpq   42904 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4275c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42760:	84 c0                	test   %al,%al
   42762:	79 60                	jns    427c4 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   42764:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42768:	83 e0 7f             	and    $0x7f,%eax
   4276b:	89 c2                	mov    %eax,%edx
   4276d:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42771:	09 d0                	or     %edx,%eax
   42773:	48 98                	cltq   
   42775:	0f b6 80 00 49 04 00 	movzbl 0x44900(%rax),%eax
   4277c:	0f b6 c0             	movzbl %al,%eax
   4277f:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42782:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42789:	7e 2f                	jle    427ba <keyboard_readc+0xcd>
   4278b:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42792:	7f 26                	jg     427ba <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42794:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42797:	2d fa 00 00 00       	sub    $0xfa,%eax
   4279c:	ba 01 00 00 00       	mov    $0x1,%edx
   427a1:	89 c1                	mov    %eax,%ecx
   427a3:	d3 e2                	shl    %cl,%edx
   427a5:	89 d0                	mov    %edx,%eax
   427a7:	f7 d0                	not    %eax
   427a9:	89 c2                	mov    %eax,%edx
   427ab:	0f b6 05 51 eb 00 00 	movzbl 0xeb51(%rip),%eax        # 51303 <modifiers.1>
   427b2:	21 d0                	and    %edx,%eax
   427b4:	88 05 49 eb 00 00    	mov    %al,0xeb49(%rip)        # 51303 <modifiers.1>
        }
        return 0;
   427ba:	b8 00 00 00 00       	mov    $0x0,%eax
   427bf:	e9 40 01 00 00       	jmpq   42904 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   427c4:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   427c8:	0a 45 fa             	or     -0x6(%rbp),%al
   427cb:	0f b6 c0             	movzbl %al,%eax
   427ce:	48 98                	cltq   
   427d0:	0f b6 80 00 49 04 00 	movzbl 0x44900(%rax),%eax
   427d7:	0f b6 c0             	movzbl %al,%eax
   427da:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   427dd:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   427e1:	7e 57                	jle    4283a <keyboard_readc+0x14d>
   427e3:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   427e7:	7f 51                	jg     4283a <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   427e9:	0f b6 05 13 eb 00 00 	movzbl 0xeb13(%rip),%eax        # 51303 <modifiers.1>
   427f0:	0f b6 c0             	movzbl %al,%eax
   427f3:	83 e0 02             	and    $0x2,%eax
   427f6:	85 c0                	test   %eax,%eax
   427f8:	74 09                	je     42803 <keyboard_readc+0x116>
            ch -= 0x60;
   427fa:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   427fe:	e9 fd 00 00 00       	jmpq   42900 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42803:	0f b6 05 f9 ea 00 00 	movzbl 0xeaf9(%rip),%eax        # 51303 <modifiers.1>
   4280a:	0f b6 c0             	movzbl %al,%eax
   4280d:	83 e0 01             	and    $0x1,%eax
   42810:	85 c0                	test   %eax,%eax
   42812:	0f 94 c2             	sete   %dl
   42815:	0f b6 05 e7 ea 00 00 	movzbl 0xeae7(%rip),%eax        # 51303 <modifiers.1>
   4281c:	0f b6 c0             	movzbl %al,%eax
   4281f:	83 e0 08             	and    $0x8,%eax
   42822:	85 c0                	test   %eax,%eax
   42824:	0f 94 c0             	sete   %al
   42827:	31 d0                	xor    %edx,%eax
   42829:	84 c0                	test   %al,%al
   4282b:	0f 84 cf 00 00 00    	je     42900 <keyboard_readc+0x213>
            ch -= 0x20;
   42831:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42835:	e9 c6 00 00 00       	jmpq   42900 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4283a:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42841:	7e 30                	jle    42873 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42843:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42846:	2d fa 00 00 00       	sub    $0xfa,%eax
   4284b:	ba 01 00 00 00       	mov    $0x1,%edx
   42850:	89 c1                	mov    %eax,%ecx
   42852:	d3 e2                	shl    %cl,%edx
   42854:	89 d0                	mov    %edx,%eax
   42856:	89 c2                	mov    %eax,%edx
   42858:	0f b6 05 a4 ea 00 00 	movzbl 0xeaa4(%rip),%eax        # 51303 <modifiers.1>
   4285f:	31 d0                	xor    %edx,%eax
   42861:	88 05 9c ea 00 00    	mov    %al,0xea9c(%rip)        # 51303 <modifiers.1>
        ch = 0;
   42867:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4286e:	e9 8e 00 00 00       	jmpq   42901 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42873:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4287a:	7e 2d                	jle    428a9 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4287c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4287f:	2d fa 00 00 00       	sub    $0xfa,%eax
   42884:	ba 01 00 00 00       	mov    $0x1,%edx
   42889:	89 c1                	mov    %eax,%ecx
   4288b:	d3 e2                	shl    %cl,%edx
   4288d:	89 d0                	mov    %edx,%eax
   4288f:	89 c2                	mov    %eax,%edx
   42891:	0f b6 05 6b ea 00 00 	movzbl 0xea6b(%rip),%eax        # 51303 <modifiers.1>
   42898:	09 d0                	or     %edx,%eax
   4289a:	88 05 63 ea 00 00    	mov    %al,0xea63(%rip)        # 51303 <modifiers.1>
        ch = 0;
   428a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   428a7:	eb 58                	jmp    42901 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   428a9:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   428ad:	7e 31                	jle    428e0 <keyboard_readc+0x1f3>
   428af:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   428b6:	7f 28                	jg     428e0 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   428b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   428bb:	8d 50 80             	lea    -0x80(%rax),%edx
   428be:	0f b6 05 3e ea 00 00 	movzbl 0xea3e(%rip),%eax        # 51303 <modifiers.1>
   428c5:	0f b6 c0             	movzbl %al,%eax
   428c8:	83 e0 03             	and    $0x3,%eax
   428cb:	48 98                	cltq   
   428cd:	48 63 d2             	movslq %edx,%rdx
   428d0:	0f b6 84 90 00 4a 04 	movzbl 0x44a00(%rax,%rdx,4),%eax
   428d7:	00 
   428d8:	0f b6 c0             	movzbl %al,%eax
   428db:	89 45 fc             	mov    %eax,-0x4(%rbp)
   428de:	eb 21                	jmp    42901 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   428e0:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   428e4:	7f 1b                	jg     42901 <keyboard_readc+0x214>
   428e6:	0f b6 05 16 ea 00 00 	movzbl 0xea16(%rip),%eax        # 51303 <modifiers.1>
   428ed:	0f b6 c0             	movzbl %al,%eax
   428f0:	83 e0 02             	and    $0x2,%eax
   428f3:	85 c0                	test   %eax,%eax
   428f5:	74 0a                	je     42901 <keyboard_readc+0x214>
        ch = 0;
   428f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   428fe:	eb 01                	jmp    42901 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42900:	90                   	nop
    }

    return ch;
   42901:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42904:	c9                   	leaveq 
   42905:	c3                   	retq   

0000000000042906 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42906:	55                   	push   %rbp
   42907:	48 89 e5             	mov    %rsp,%rbp
   4290a:	48 83 ec 20          	sub    $0x20,%rsp
   4290e:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42915:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42918:	89 c2                	mov    %eax,%edx
   4291a:	ec                   	in     (%dx),%al
   4291b:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4291e:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42925:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42928:	89 c2                	mov    %eax,%edx
   4292a:	ec                   	in     (%dx),%al
   4292b:	88 45 eb             	mov    %al,-0x15(%rbp)
   4292e:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42935:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42938:	89 c2                	mov    %eax,%edx
   4293a:	ec                   	in     (%dx),%al
   4293b:	88 45 f3             	mov    %al,-0xd(%rbp)
   4293e:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42945:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42948:	89 c2                	mov    %eax,%edx
   4294a:	ec                   	in     (%dx),%al
   4294b:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4294e:	90                   	nop
   4294f:	c9                   	leaveq 
   42950:	c3                   	retq   

0000000000042951 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42951:	55                   	push   %rbp
   42952:	48 89 e5             	mov    %rsp,%rbp
   42955:	48 83 ec 40          	sub    $0x40,%rsp
   42959:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4295d:	89 f0                	mov    %esi,%eax
   4295f:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42962:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42965:	8b 05 99 e9 00 00    	mov    0xe999(%rip),%eax        # 51304 <initialized.0>
   4296b:	85 c0                	test   %eax,%eax
   4296d:	75 1e                	jne    4298d <parallel_port_putc+0x3c>
   4296f:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42976:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4297a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4297e:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42981:	ee                   	out    %al,(%dx)
}
   42982:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42983:	c7 05 77 e9 00 00 01 	movl   $0x1,0xe977(%rip)        # 51304 <initialized.0>
   4298a:	00 00 00 
    }

    for (int i = 0;
   4298d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42994:	eb 09                	jmp    4299f <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42996:	e8 6b ff ff ff       	callq  42906 <delay>
         ++i) {
   4299b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   4299f:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   429a6:	7f 18                	jg     429c0 <parallel_port_putc+0x6f>
   429a8:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   429af:	8b 45 f0             	mov    -0x10(%rbp),%eax
   429b2:	89 c2                	mov    %eax,%edx
   429b4:	ec                   	in     (%dx),%al
   429b5:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   429b8:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   429bc:	84 c0                	test   %al,%al
   429be:	79 d6                	jns    42996 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   429c0:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   429c4:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   429cb:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   429ce:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   429d2:	8b 55 d8             	mov    -0x28(%rbp),%edx
   429d5:	ee                   	out    %al,(%dx)
}
   429d6:	90                   	nop
   429d7:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   429de:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   429e2:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   429e6:	8b 55 e0             	mov    -0x20(%rbp),%edx
   429e9:	ee                   	out    %al,(%dx)
}
   429ea:	90                   	nop
   429eb:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   429f2:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   429f6:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   429fa:	8b 55 e8             	mov    -0x18(%rbp),%edx
   429fd:	ee                   	out    %al,(%dx)
}
   429fe:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   429ff:	90                   	nop
   42a00:	c9                   	leaveq 
   42a01:	c3                   	retq   

0000000000042a02 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42a02:	55                   	push   %rbp
   42a03:	48 89 e5             	mov    %rsp,%rbp
   42a06:	48 83 ec 20          	sub    $0x20,%rsp
   42a0a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42a0e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42a12:	48 c7 45 f8 51 29 04 	movq   $0x42951,-0x8(%rbp)
   42a19:	00 
    printer_vprintf(&p, 0, format, val);
   42a1a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42a1e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42a22:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42a26:	be 00 00 00 00       	mov    $0x0,%esi
   42a2b:	48 89 c7             	mov    %rax,%rdi
   42a2e:	e8 3e 10 00 00       	callq  43a71 <printer_vprintf>
}
   42a33:	90                   	nop
   42a34:	c9                   	leaveq 
   42a35:	c3                   	retq   

0000000000042a36 <log_printf>:

void log_printf(const char* format, ...) {
   42a36:	55                   	push   %rbp
   42a37:	48 89 e5             	mov    %rsp,%rbp
   42a3a:	48 83 ec 60          	sub    $0x60,%rsp
   42a3e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42a42:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42a46:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42a4a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42a4e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42a52:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42a56:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42a5d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42a61:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42a65:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42a69:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42a6d:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42a71:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42a75:	48 89 d6             	mov    %rdx,%rsi
   42a78:	48 89 c7             	mov    %rax,%rdi
   42a7b:	e8 82 ff ff ff       	callq  42a02 <log_vprintf>
    va_end(val);
}
   42a80:	90                   	nop
   42a81:	c9                   	leaveq 
   42a82:	c3                   	retq   

0000000000042a83 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42a83:	55                   	push   %rbp
   42a84:	48 89 e5             	mov    %rsp,%rbp
   42a87:	48 83 ec 40          	sub    $0x40,%rsp
   42a8b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42a8e:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42a91:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42a95:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42a99:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42a9d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42aa1:	48 8b 0a             	mov    (%rdx),%rcx
   42aa4:	48 89 08             	mov    %rcx,(%rax)
   42aa7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42aab:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42aaf:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42ab3:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42ab7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42abb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42abf:	48 89 d6             	mov    %rdx,%rsi
   42ac2:	48 89 c7             	mov    %rax,%rdi
   42ac5:	e8 38 ff ff ff       	callq  42a02 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42aca:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42ace:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42ad2:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42ad5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42ad8:	89 c7                	mov    %eax,%edi
   42ada:	e8 71 16 00 00       	callq  44150 <console_vprintf>
}
   42adf:	c9                   	leaveq 
   42ae0:	c3                   	retq   

0000000000042ae1 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42ae1:	55                   	push   %rbp
   42ae2:	48 89 e5             	mov    %rsp,%rbp
   42ae5:	48 83 ec 60          	sub    $0x60,%rsp
   42ae9:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42aec:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42aef:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42af3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42af7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42afb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42aff:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42b06:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42b0a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42b0e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42b12:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42b16:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42b1a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42b1e:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42b21:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b24:	89 c7                	mov    %eax,%edi
   42b26:	e8 58 ff ff ff       	callq  42a83 <error_vprintf>
   42b2b:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42b2e:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42b31:	c9                   	leaveq 
   42b32:	c3                   	retq   

0000000000042b33 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42b33:	55                   	push   %rbp
   42b34:	48 89 e5             	mov    %rsp,%rbp
   42b37:	53                   	push   %rbx
   42b38:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42b3c:	e8 ac fb ff ff       	callq  426ed <keyboard_readc>
   42b41:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42b44:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42b48:	74 1c                	je     42b66 <check_keyboard+0x33>
   42b4a:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42b4e:	74 16                	je     42b66 <check_keyboard+0x33>
   42b50:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42b54:	74 10                	je     42b66 <check_keyboard+0x33>
   42b56:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42b5a:	74 0a                	je     42b66 <check_keyboard+0x33>
   42b5c:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42b60:	0f 85 e9 00 00 00    	jne    42c4f <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42b66:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42b6d:	00 
        memset(pt, 0, PAGESIZE * 3);
   42b6e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b72:	ba 00 30 00 00       	mov    $0x3000,%edx
   42b77:	be 00 00 00 00       	mov    $0x0,%esi
   42b7c:	48 89 c7             	mov    %rax,%rdi
   42b7f:	e8 dc 0d 00 00       	callq  43960 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42b84:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b88:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42b8f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b93:	48 05 00 10 00 00    	add    $0x1000,%rax
   42b99:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42ba0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ba4:	48 05 00 20 00 00    	add    $0x2000,%rax
   42baa:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42bb1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bb5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42bb9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42bbd:	0f 22 d8             	mov    %rax,%cr3
}
   42bc0:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42bc1:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42bc8:	48 c7 45 e8 58 4a 04 	movq   $0x44a58,-0x18(%rbp)
   42bcf:	00 
        if (c == 'a') {
   42bd0:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42bd4:	75 0a                	jne    42be0 <check_keyboard+0xad>
            argument = "allocator";
   42bd6:	48 c7 45 e8 5d 4a 04 	movq   $0x44a5d,-0x18(%rbp)
   42bdd:	00 
   42bde:	eb 2e                	jmp    42c0e <check_keyboard+0xdb>
        } else if (c == 'e') {
   42be0:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42be4:	75 0a                	jne    42bf0 <check_keyboard+0xbd>
            argument = "forkexit";
   42be6:	48 c7 45 e8 67 4a 04 	movq   $0x44a67,-0x18(%rbp)
   42bed:	00 
   42bee:	eb 1e                	jmp    42c0e <check_keyboard+0xdb>
        }
        else if (c == 't'){
   42bf0:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42bf4:	75 0a                	jne    42c00 <check_keyboard+0xcd>
            argument = "test";
   42bf6:	48 c7 45 e8 70 4a 04 	movq   $0x44a70,-0x18(%rbp)
   42bfd:	00 
   42bfe:	eb 0e                	jmp    42c0e <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42c00:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42c04:	75 08                	jne    42c0e <check_keyboard+0xdb>
            argument = "test2";
   42c06:	48 c7 45 e8 75 4a 04 	movq   $0x44a75,-0x18(%rbp)
   42c0d:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42c0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c12:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42c16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c1b:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42c1f:	76 14                	jbe    42c35 <check_keyboard+0x102>
   42c21:	ba 7b 4a 04 00       	mov    $0x44a7b,%edx
   42c26:	be 5c 02 00 00       	mov    $0x25c,%esi
   42c2b:	bf 97 4a 04 00       	mov    $0x44a97,%edi
   42c30:	e8 1f 01 00 00       	callq  42d54 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42c35:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c39:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42c3c:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42c40:	48 89 c3             	mov    %rax,%rbx
   42c43:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42c48:	e9 b3 d3 ff ff       	jmpq   40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42c4d:	eb 11                	jmp    42c60 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42c4f:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42c53:	74 06                	je     42c5b <check_keyboard+0x128>
   42c55:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42c59:	75 05                	jne    42c60 <check_keyboard+0x12d>
        poweroff();
   42c5b:	e8 ae f8 ff ff       	callq  4250e <poweroff>
    }
    return c;
   42c60:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42c63:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42c67:	c9                   	leaveq 
   42c68:	c3                   	retq   

0000000000042c69 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42c69:	55                   	push   %rbp
   42c6a:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42c6d:	e8 c1 fe ff ff       	callq  42b33 <check_keyboard>
   42c72:	eb f9                	jmp    42c6d <fail+0x4>

0000000000042c74 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42c74:	55                   	push   %rbp
   42c75:	48 89 e5             	mov    %rsp,%rbp
   42c78:	48 83 ec 60          	sub    $0x60,%rsp
   42c7c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42c80:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42c84:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42c88:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42c8c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42c90:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42c94:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42c9b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42c9f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42ca3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42ca7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42cab:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42cb0:	0f 84 80 00 00 00    	je     42d36 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42cb6:	ba a4 4a 04 00       	mov    $0x44aa4,%edx
   42cbb:	be 00 c0 00 00       	mov    $0xc000,%esi
   42cc0:	bf 30 07 00 00       	mov    $0x730,%edi
   42cc5:	b8 00 00 00 00       	mov    $0x0,%eax
   42cca:	e8 12 fe ff ff       	callq  42ae1 <error_printf>
   42ccf:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42cd2:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42cd6:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42cda:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42cdd:	be 00 c0 00 00       	mov    $0xc000,%esi
   42ce2:	89 c7                	mov    %eax,%edi
   42ce4:	e8 9a fd ff ff       	callq  42a83 <error_vprintf>
   42ce9:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42cec:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42cef:	48 63 c1             	movslq %ecx,%rax
   42cf2:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42cf9:	48 c1 e8 20          	shr    $0x20,%rax
   42cfd:	c1 f8 05             	sar    $0x5,%eax
   42d00:	89 ce                	mov    %ecx,%esi
   42d02:	c1 fe 1f             	sar    $0x1f,%esi
   42d05:	29 f0                	sub    %esi,%eax
   42d07:	89 c2                	mov    %eax,%edx
   42d09:	89 d0                	mov    %edx,%eax
   42d0b:	c1 e0 02             	shl    $0x2,%eax
   42d0e:	01 d0                	add    %edx,%eax
   42d10:	c1 e0 04             	shl    $0x4,%eax
   42d13:	29 c1                	sub    %eax,%ecx
   42d15:	89 ca                	mov    %ecx,%edx
   42d17:	85 d2                	test   %edx,%edx
   42d19:	74 34                	je     42d4f <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42d1b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d1e:	ba ac 4a 04 00       	mov    $0x44aac,%edx
   42d23:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d28:	89 c7                	mov    %eax,%edi
   42d2a:	b8 00 00 00 00       	mov    $0x0,%eax
   42d2f:	e8 ad fd ff ff       	callq  42ae1 <error_printf>
   42d34:	eb 19                	jmp    42d4f <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42d36:	ba ae 4a 04 00       	mov    $0x44aae,%edx
   42d3b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d40:	bf 30 07 00 00       	mov    $0x730,%edi
   42d45:	b8 00 00 00 00       	mov    $0x0,%eax
   42d4a:	e8 92 fd ff ff       	callq  42ae1 <error_printf>
    }

    va_end(val);
    fail();
   42d4f:	e8 15 ff ff ff       	callq  42c69 <fail>

0000000000042d54 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42d54:	55                   	push   %rbp
   42d55:	48 89 e5             	mov    %rsp,%rbp
   42d58:	48 83 ec 20          	sub    $0x20,%rsp
   42d5c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42d60:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42d63:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42d67:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42d6b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42d6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d72:	48 89 c6             	mov    %rax,%rsi
   42d75:	bf b4 4a 04 00       	mov    $0x44ab4,%edi
   42d7a:	b8 00 00 00 00       	mov    $0x0,%eax
   42d7f:	e8 f0 fe ff ff       	callq  42c74 <panic>

0000000000042d84 <default_exception>:
}

void default_exception(proc* p){
   42d84:	55                   	push   %rbp
   42d85:	48 89 e5             	mov    %rsp,%rbp
   42d88:	48 83 ec 20          	sub    $0x20,%rsp
   42d8c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42d90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d94:	48 83 c0 08          	add    $0x8,%rax
   42d98:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42d9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42da0:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42da7:	48 89 c6             	mov    %rax,%rsi
   42daa:	bf d2 4a 04 00       	mov    $0x44ad2,%edi
   42daf:	b8 00 00 00 00       	mov    $0x0,%eax
   42db4:	e8 bb fe ff ff       	callq  42c74 <panic>

0000000000042db9 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42db9:	55                   	push   %rbp
   42dba:	48 89 e5             	mov    %rsp,%rbp
   42dbd:	48 83 ec 10          	sub    $0x10,%rsp
   42dc1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42dc5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42dc8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42dcc:	78 06                	js     42dd4 <pageindex+0x1b>
   42dce:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42dd2:	7e 14                	jle    42de8 <pageindex+0x2f>
   42dd4:	ba f0 4a 04 00       	mov    $0x44af0,%edx
   42dd9:	be 1e 00 00 00       	mov    $0x1e,%esi
   42dde:	bf 09 4b 04 00       	mov    $0x44b09,%edi
   42de3:	e8 6c ff ff ff       	callq  42d54 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42de8:	b8 03 00 00 00       	mov    $0x3,%eax
   42ded:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42df0:	89 c2                	mov    %eax,%edx
   42df2:	89 d0                	mov    %edx,%eax
   42df4:	c1 e0 03             	shl    $0x3,%eax
   42df7:	01 d0                	add    %edx,%eax
   42df9:	83 c0 0c             	add    $0xc,%eax
   42dfc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e00:	89 c1                	mov    %eax,%ecx
   42e02:	48 d3 ea             	shr    %cl,%rdx
   42e05:	48 89 d0             	mov    %rdx,%rax
   42e08:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42e0d:	c9                   	leaveq 
   42e0e:	c3                   	retq   

0000000000042e0f <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42e0f:	55                   	push   %rbp
   42e10:	48 89 e5             	mov    %rsp,%rbp
   42e13:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42e17:	48 c7 05 de f1 00 00 	movq   $0x53000,0xf1de(%rip)        # 52000 <kernel_pagetable>
   42e1e:	00 30 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42e22:	ba 00 50 00 00       	mov    $0x5000,%edx
   42e27:	be 00 00 00 00       	mov    $0x0,%esi
   42e2c:	bf 00 30 05 00       	mov    $0x53000,%edi
   42e31:	e8 2a 0b 00 00       	callq  43960 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42e36:	b8 00 40 05 00       	mov    $0x54000,%eax
   42e3b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42e3f:	48 89 05 ba 01 01 00 	mov    %rax,0x101ba(%rip)        # 53000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42e46:	b8 00 50 05 00       	mov    $0x55000,%eax
   42e4b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42e4f:	48 89 05 aa 11 01 00 	mov    %rax,0x111aa(%rip)        # 54000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42e56:	b8 00 60 05 00       	mov    $0x56000,%eax
   42e5b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42e5f:	48 89 05 9a 21 01 00 	mov    %rax,0x1219a(%rip)        # 55000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42e66:	b8 00 70 05 00       	mov    $0x57000,%eax
   42e6b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42e6f:	48 89 05 92 21 01 00 	mov    %rax,0x12192(%rip)        # 55008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42e76:	48 8b 05 83 f1 00 00 	mov    0xf183(%rip),%rax        # 52000 <kernel_pagetable>
   42e7d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42e83:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42e88:	ba 00 00 00 00       	mov    $0x0,%edx
   42e8d:	be 00 00 00 00       	mov    $0x0,%esi
   42e92:	48 89 c7             	mov    %rax,%rdi
   42e95:	e8 b9 01 00 00       	callq  43053 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42e9a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42ea1:	00 
   42ea2:	eb 62                	jmp    42f06 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42ea4:	48 8b 0d 55 f1 00 00 	mov    0xf155(%rip),%rcx        # 52000 <kernel_pagetable>
   42eab:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42eaf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42eb3:	48 89 ce             	mov    %rcx,%rsi
   42eb6:	48 89 c7             	mov    %rax,%rdi
   42eb9:	e8 4a 05 00 00       	callq  43408 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   42ebe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ec2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42ec6:	74 14                	je     42edc <virtual_memory_init+0xcd>
   42ec8:	ba 12 4b 04 00       	mov    $0x44b12,%edx
   42ecd:	be 2d 00 00 00       	mov    $0x2d,%esi
   42ed2:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   42ed7:	e8 78 fe ff ff       	callq  42d54 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42edc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42edf:	48 98                	cltq   
   42ee1:	83 e0 03             	and    $0x3,%eax
   42ee4:	48 83 f8 03          	cmp    $0x3,%rax
   42ee8:	74 14                	je     42efe <virtual_memory_init+0xef>
   42eea:	ba 28 4b 04 00       	mov    $0x44b28,%edx
   42eef:	be 2e 00 00 00       	mov    $0x2e,%esi
   42ef4:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   42ef9:	e8 56 fe ff ff       	callq  42d54 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42efe:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42f05:	00 
   42f06:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42f0d:	00 
   42f0e:	76 94                	jbe    42ea4 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42f10:	48 8b 05 e9 f0 00 00 	mov    0xf0e9(%rip),%rax        # 52000 <kernel_pagetable>
   42f17:	48 89 c7             	mov    %rax,%rdi
   42f1a:	e8 03 00 00 00       	callq  42f22 <set_pagetable>
}
   42f1f:	90                   	nop
   42f20:	c9                   	leaveq 
   42f21:	c3                   	retq   

0000000000042f22 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42f22:	55                   	push   %rbp
   42f23:	48 89 e5             	mov    %rsp,%rbp
   42f26:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42f2a:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42f2e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42f32:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f37:	48 85 c0             	test   %rax,%rax
   42f3a:	74 14                	je     42f50 <set_pagetable+0x2e>
   42f3c:	ba 55 4b 04 00       	mov    $0x44b55,%edx
   42f41:	be 3d 00 00 00       	mov    $0x3d,%esi
   42f46:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   42f4b:	e8 04 fe ff ff       	callq  42d54 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42f50:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42f55:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42f59:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42f5d:	48 89 ce             	mov    %rcx,%rsi
   42f60:	48 89 c7             	mov    %rax,%rdi
   42f63:	e8 a0 04 00 00       	callq  43408 <virtual_memory_lookup>
   42f68:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42f6c:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42f71:	48 39 d0             	cmp    %rdx,%rax
   42f74:	74 14                	je     42f8a <set_pagetable+0x68>
   42f76:	ba 70 4b 04 00       	mov    $0x44b70,%edx
   42f7b:	be 3f 00 00 00       	mov    $0x3f,%esi
   42f80:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   42f85:	e8 ca fd ff ff       	callq  42d54 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42f8a:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42f8e:	48 8b 0d 6b f0 00 00 	mov    0xf06b(%rip),%rcx        # 52000 <kernel_pagetable>
   42f95:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42f99:	48 89 ce             	mov    %rcx,%rsi
   42f9c:	48 89 c7             	mov    %rax,%rdi
   42f9f:	e8 64 04 00 00       	callq  43408 <virtual_memory_lookup>
   42fa4:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42fa8:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42fac:	48 39 c2             	cmp    %rax,%rdx
   42faf:	74 14                	je     42fc5 <set_pagetable+0xa3>
   42fb1:	ba d8 4b 04 00       	mov    $0x44bd8,%edx
   42fb6:	be 41 00 00 00       	mov    $0x41,%esi
   42fbb:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   42fc0:	e8 8f fd ff ff       	callq  42d54 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42fc5:	48 8b 05 34 f0 00 00 	mov    0xf034(%rip),%rax        # 52000 <kernel_pagetable>
   42fcc:	48 89 c2             	mov    %rax,%rdx
   42fcf:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42fd3:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42fd7:	48 89 ce             	mov    %rcx,%rsi
   42fda:	48 89 c7             	mov    %rax,%rdi
   42fdd:	e8 26 04 00 00       	callq  43408 <virtual_memory_lookup>
   42fe2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42fe6:	48 8b 15 13 f0 00 00 	mov    0xf013(%rip),%rdx        # 52000 <kernel_pagetable>
   42fed:	48 39 d0             	cmp    %rdx,%rax
   42ff0:	74 14                	je     43006 <set_pagetable+0xe4>
   42ff2:	ba 38 4c 04 00       	mov    $0x44c38,%edx
   42ff7:	be 43 00 00 00       	mov    $0x43,%esi
   42ffc:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   43001:	e8 4e fd ff ff       	callq  42d54 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   43006:	ba 53 30 04 00       	mov    $0x43053,%edx
   4300b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4300f:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43013:	48 89 ce             	mov    %rcx,%rsi
   43016:	48 89 c7             	mov    %rax,%rdi
   43019:	e8 ea 03 00 00       	callq  43408 <virtual_memory_lookup>
   4301e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43022:	ba 53 30 04 00       	mov    $0x43053,%edx
   43027:	48 39 d0             	cmp    %rdx,%rax
   4302a:	74 14                	je     43040 <set_pagetable+0x11e>
   4302c:	ba a0 4c 04 00       	mov    $0x44ca0,%edx
   43031:	be 45 00 00 00       	mov    $0x45,%esi
   43036:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   4303b:	e8 14 fd ff ff       	callq  42d54 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   43040:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43044:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   43048:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4304c:	0f 22 d8             	mov    %rax,%cr3
}
   4304f:	90                   	nop
}
   43050:	90                   	nop
   43051:	c9                   	leaveq 
   43052:	c3                   	retq   

0000000000043053 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   43053:	55                   	push   %rbp
   43054:	48 89 e5             	mov    %rsp,%rbp
   43057:	48 83 ec 50          	sub    $0x50,%rsp
   4305b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4305f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43063:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43067:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   4306b:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4306f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43073:	25 ff 0f 00 00       	and    $0xfff,%eax
   43078:	48 85 c0             	test   %rax,%rax
   4307b:	74 14                	je     43091 <virtual_memory_map+0x3e>
   4307d:	ba 06 4d 04 00       	mov    $0x44d06,%edx
   43082:	be 66 00 00 00       	mov    $0x66,%esi
   43087:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   4308c:	e8 c3 fc ff ff       	callq  42d54 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   43091:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43095:	25 ff 0f 00 00       	and    $0xfff,%eax
   4309a:	48 85 c0             	test   %rax,%rax
   4309d:	74 14                	je     430b3 <virtual_memory_map+0x60>
   4309f:	ba 19 4d 04 00       	mov    $0x44d19,%edx
   430a4:	be 67 00 00 00       	mov    $0x67,%esi
   430a9:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   430ae:	e8 a1 fc ff ff       	callq  42d54 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   430b3:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   430b7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   430bb:	48 01 d0             	add    %rdx,%rax
   430be:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   430c2:	76 24                	jbe    430e8 <virtual_memory_map+0x95>
   430c4:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   430c8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   430cc:	48 01 d0             	add    %rdx,%rax
   430cf:	48 85 c0             	test   %rax,%rax
   430d2:	74 14                	je     430e8 <virtual_memory_map+0x95>
   430d4:	ba 2c 4d 04 00       	mov    $0x44d2c,%edx
   430d9:	be 68 00 00 00       	mov    $0x68,%esi
   430de:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   430e3:	e8 6c fc ff ff       	callq  42d54 <assert_fail>
    if (perm & PTE_P) {
   430e8:	8b 45 bc             	mov    -0x44(%rbp),%eax
   430eb:	48 98                	cltq   
   430ed:	83 e0 01             	and    $0x1,%eax
   430f0:	48 85 c0             	test   %rax,%rax
   430f3:	74 6e                	je     43163 <virtual_memory_map+0x110>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   430f5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   430f9:	25 ff 0f 00 00       	and    $0xfff,%eax
   430fe:	48 85 c0             	test   %rax,%rax
   43101:	74 14                	je     43117 <virtual_memory_map+0xc4>
   43103:	ba 4a 4d 04 00       	mov    $0x44d4a,%edx
   43108:	be 6a 00 00 00       	mov    $0x6a,%esi
   4310d:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   43112:	e8 3d fc ff ff       	callq  42d54 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   43117:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4311b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4311f:	48 01 d0             	add    %rdx,%rax
   43122:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   43126:	76 14                	jbe    4313c <virtual_memory_map+0xe9>
   43128:	ba 5d 4d 04 00       	mov    $0x44d5d,%edx
   4312d:	be 6b 00 00 00       	mov    $0x6b,%esi
   43132:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   43137:	e8 18 fc ff ff       	callq  42d54 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   4313c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43140:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43144:	48 01 d0             	add    %rdx,%rax
   43147:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   4314d:	76 14                	jbe    43163 <virtual_memory_map+0x110>
   4314f:	ba 6b 4d 04 00       	mov    $0x44d6b,%edx
   43154:	be 6c 00 00 00       	mov    $0x6c,%esi
   43159:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   4315e:	e8 f1 fb ff ff       	callq  42d54 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   43163:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43167:	78 09                	js     43172 <virtual_memory_map+0x11f>
   43169:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   43170:	7e 14                	jle    43186 <virtual_memory_map+0x133>
   43172:	ba 87 4d 04 00       	mov    $0x44d87,%edx
   43177:	be 6e 00 00 00       	mov    $0x6e,%esi
   4317c:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   43181:	e8 ce fb ff ff       	callq  42d54 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   43186:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4318a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4318f:	48 85 c0             	test   %rax,%rax
   43192:	74 14                	je     431a8 <virtual_memory_map+0x155>
   43194:	ba a8 4d 04 00       	mov    $0x44da8,%edx
   43199:	be 6f 00 00 00       	mov    $0x6f,%esi
   4319e:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   431a3:	e8 ac fb ff ff       	callq  42d54 <assert_fail>

    int last_index123 = -1;
   431a8:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   431af:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   431b6:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   431b7:	e9 d4 00 00 00       	jmpq   43290 <virtual_memory_map+0x23d>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   431bc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431c0:	48 c1 e8 15          	shr    $0x15,%rax
   431c4:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   431c7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   431ca:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   431cd:	74 20                	je     431ef <virtual_memory_map+0x19c>
            // TODO
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   431cf:	8b 55 bc             	mov    -0x44(%rbp),%edx
   431d2:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   431d6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   431da:	48 89 ce             	mov    %rcx,%rsi
   431dd:	48 89 c7             	mov    %rax,%rdi
   431e0:	e8 bd 00 00 00       	callq  432a2 <lookup_l4pagetable>
   431e5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   431e9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   431ec:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }

        // index for L4 page
        int index = L4PAGEINDEX(va);
   431ef:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431f3:	be 03 00 00 00       	mov    $0x3,%esi
   431f8:	48 89 c7             	mov    %rax,%rdi
   431fb:	e8 b9 fb ff ff       	callq  42db9 <pageindex>
   43200:	89 45 e8             	mov    %eax,-0x18(%rbp)

        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   43203:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43206:	48 98                	cltq   
   43208:	83 e0 01             	and    $0x1,%eax
   4320b:	48 85 c0             	test   %rax,%rax
   4320e:	74 23                	je     43233 <virtual_memory_map+0x1e0>
   43210:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43215:	74 1c                	je     43233 <virtual_memory_map+0x1e0>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
            l4pagetable->entry[index] = pa | perm;
   43217:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4321a:	48 98                	cltq   
   4321c:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   43220:	48 89 c1             	mov    %rax,%rcx
   43223:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43227:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4322a:	48 63 d2             	movslq %edx,%rdx
   4322d:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   43231:	eb 45                	jmp    43278 <virtual_memory_map+0x225>
        } else if (l4pagetable) { // if page is NOT marked present
   43233:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43238:	74 16                	je     43250 <virtual_memory_map+0x1fd>
            // TODO
            // map to address 0 with `perm`
            l4pagetable->entry[index] = perm;
   4323a:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4323d:	48 63 c8             	movslq %eax,%rcx
   43240:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43244:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43247:	48 63 d2             	movslq %edx,%rdx
   4324a:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   4324e:	eb 28                	jmp    43278 <virtual_memory_map+0x225>
        } else if (perm & PTE_P) {
   43250:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43253:	48 98                	cltq   
   43255:	83 e0 01             	and    $0x1,%eax
   43258:	48 85 c0             	test   %rax,%rax
   4325b:	74 1b                	je     43278 <virtual_memory_map+0x225>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   4325d:	be 8c 00 00 00       	mov    $0x8c,%esi
   43262:	bf d0 4d 04 00       	mov    $0x44dd0,%edi
   43267:	b8 00 00 00 00       	mov    $0x0,%eax
   4326c:	e8 c5 f7 ff ff       	callq  42a36 <log_printf>
            return -1;
   43271:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43276:	eb 28                	jmp    432a0 <virtual_memory_map+0x24d>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43278:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   4327f:	00 
   43280:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   43287:	00 
   43288:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   4328f:	00 
   43290:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   43295:	0f 85 21 ff ff ff    	jne    431bc <virtual_memory_map+0x169>
        }
    }
    return 0;
   4329b:	b8 00 00 00 00       	mov    $0x0,%eax
}
   432a0:	c9                   	leaveq 
   432a1:	c3                   	retq   

00000000000432a2 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   432a2:	55                   	push   %rbp
   432a3:	48 89 e5             	mov    %rsp,%rbp
   432a6:	48 83 ec 40          	sub    $0x40,%rsp
   432aa:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   432ae:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   432b2:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   432b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   432bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   432c4:	e9 2f 01 00 00       	jmpq   433f8 <lookup_l4pagetable+0x156>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = 0;
   432c9:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
   432d0:	00 

        int index = PAGEINDEX(va, i);
   432d1:	8b 55 f4             	mov    -0xc(%rbp),%edx
   432d4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   432d8:	89 d6                	mov    %edx,%esi
   432da:	48 89 c7             	mov    %rax,%rdi
   432dd:	e8 d7 fa ff ff       	callq  42db9 <pageindex>
   432e2:	89 45 e4             	mov    %eax,-0x1c(%rbp)
        pe = pt->entry[index];
   432e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   432e9:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   432ec:	48 63 d2             	movslq %edx,%rdx
   432ef:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   432f3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   432f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432fb:	83 e0 01             	and    $0x1,%eax
   432fe:	48 85 c0             	test   %rax,%rax
   43301:	75 63                	jne    43366 <lookup_l4pagetable+0xc4>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   43303:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43306:	8d 48 02             	lea    0x2(%rax),%ecx
   43309:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4330d:	25 ff 0f 00 00       	and    $0xfff,%eax
   43312:	48 89 c2             	mov    %rax,%rdx
   43315:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43319:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4331f:	48 89 c6             	mov    %rax,%rsi
   43322:	bf 10 4e 04 00       	mov    $0x44e10,%edi
   43327:	b8 00 00 00 00       	mov    $0x0,%eax
   4332c:	e8 05 f7 ff ff       	callq  42a36 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   43331:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43334:	48 98                	cltq   
   43336:	83 e0 01             	and    $0x1,%eax
   43339:	48 85 c0             	test   %rax,%rax
   4333c:	75 0a                	jne    43348 <lookup_l4pagetable+0xa6>
                return NULL;
   4333e:	b8 00 00 00 00       	mov    $0x0,%eax
   43343:	e9 be 00 00 00       	jmpq   43406 <lookup_l4pagetable+0x164>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   43348:	be b3 00 00 00       	mov    $0xb3,%esi
   4334d:	bf 78 4e 04 00       	mov    $0x44e78,%edi
   43352:	b8 00 00 00 00       	mov    $0x0,%eax
   43357:	e8 da f6 ff ff       	callq  42a36 <log_printf>
            return NULL;
   4335c:	b8 00 00 00 00       	mov    $0x0,%eax
   43361:	e9 a0 00 00 00       	jmpq   43406 <lookup_l4pagetable+0x164>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   43366:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4336a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43370:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   43376:	76 14                	jbe    4338c <lookup_l4pagetable+0xea>
   43378:	ba b8 4e 04 00       	mov    $0x44eb8,%edx
   4337d:	be b8 00 00 00       	mov    $0xb8,%esi
   43382:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   43387:	e8 c8 f9 ff ff       	callq  42d54 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   4338c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4338f:	48 98                	cltq   
   43391:	83 e0 02             	and    $0x2,%eax
   43394:	48 85 c0             	test   %rax,%rax
   43397:	74 20                	je     433b9 <lookup_l4pagetable+0x117>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   43399:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4339d:	83 e0 02             	and    $0x2,%eax
   433a0:	48 85 c0             	test   %rax,%rax
   433a3:	75 14                	jne    433b9 <lookup_l4pagetable+0x117>
   433a5:	ba d8 4e 04 00       	mov    $0x44ed8,%edx
   433aa:	be ba 00 00 00       	mov    $0xba,%esi
   433af:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   433b4:	e8 9b f9 ff ff       	callq  42d54 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   433b9:	8b 45 cc             	mov    -0x34(%rbp),%eax
   433bc:	48 98                	cltq   
   433be:	83 e0 04             	and    $0x4,%eax
   433c1:	48 85 c0             	test   %rax,%rax
   433c4:	74 20                	je     433e6 <lookup_l4pagetable+0x144>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   433c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433ca:	83 e0 04             	and    $0x4,%eax
   433cd:	48 85 c0             	test   %rax,%rax
   433d0:	75 14                	jne    433e6 <lookup_l4pagetable+0x144>
   433d2:	ba e3 4e 04 00       	mov    $0x44ee3,%edx
   433d7:	be bd 00 00 00       	mov    $0xbd,%esi
   433dc:	bf 22 4b 04 00       	mov    $0x44b22,%edi
   433e1:	e8 6e f9 ff ff       	callq  42d54 <assert_fail>
        }

        // TODO
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   433e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433ea:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   433f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   433f4:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   433f8:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   433fc:	0f 8e c7 fe ff ff    	jle    432c9 <lookup_l4pagetable+0x27>
    }
    return pt;
   43402:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43406:	c9                   	leaveq 
   43407:	c3                   	retq   

0000000000043408 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   43408:	55                   	push   %rbp
   43409:	48 89 e5             	mov    %rsp,%rbp
   4340c:	48 83 ec 50          	sub    $0x50,%rsp
   43410:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43414:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   43418:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   4341c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43420:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   43424:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4342b:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4342c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   43433:	eb 41                	jmp    43476 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   43435:	8b 55 ec             	mov    -0x14(%rbp),%edx
   43438:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4343c:	89 d6                	mov    %edx,%esi
   4343e:	48 89 c7             	mov    %rax,%rdi
   43441:	e8 73 f9 ff ff       	callq  42db9 <pageindex>
   43446:	89 c2                	mov    %eax,%edx
   43448:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4344c:	48 63 d2             	movslq %edx,%rdx
   4344f:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43453:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43457:	83 e0 06             	and    $0x6,%eax
   4345a:	48 f7 d0             	not    %rax
   4345d:	48 21 d0             	and    %rdx,%rax
   43460:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43464:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43468:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4346e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43472:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43476:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4347a:	7f 0c                	jg     43488 <virtual_memory_lookup+0x80>
   4347c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43480:	83 e0 01             	and    $0x1,%eax
   43483:	48 85 c0             	test   %rax,%rax
   43486:	75 ad                	jne    43435 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   43488:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   4348f:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   43496:	ff 
   43497:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   4349e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434a2:	83 e0 01             	and    $0x1,%eax
   434a5:	48 85 c0             	test   %rax,%rax
   434a8:	74 34                	je     434de <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   434aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434ae:	48 c1 e8 0c          	shr    $0xc,%rax
   434b2:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   434b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434b9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   434bf:	48 89 c2             	mov    %rax,%rdx
   434c2:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   434c6:	25 ff 0f 00 00       	and    $0xfff,%eax
   434cb:	48 09 d0             	or     %rdx,%rax
   434ce:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   434d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434d6:	25 ff 0f 00 00       	and    $0xfff,%eax
   434db:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   434de:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   434e2:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   434e6:	48 89 10             	mov    %rdx,(%rax)
   434e9:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   434ed:	48 89 50 08          	mov    %rdx,0x8(%rax)
   434f1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   434f5:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   434f9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   434fd:	c9                   	leaveq 
   434fe:	c3                   	retq   

00000000000434ff <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   434ff:	55                   	push   %rbp
   43500:	48 89 e5             	mov    %rsp,%rbp
   43503:	48 83 ec 40          	sub    $0x40,%rsp
   43507:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4350b:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   4350e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   43512:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   43519:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4351d:	78 08                	js     43527 <program_load+0x28>
   4351f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43522:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   43525:	7c 14                	jl     4353b <program_load+0x3c>
   43527:	ba f0 4e 04 00       	mov    $0x44ef0,%edx
   4352c:	be 37 00 00 00       	mov    $0x37,%esi
   43531:	bf 20 4f 04 00       	mov    $0x44f20,%edi
   43536:	e8 19 f8 ff ff       	callq  42d54 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4353b:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   4353e:	48 98                	cltq   
   43540:	48 c1 e0 04          	shl    $0x4,%rax
   43544:	48 05 20 60 04 00    	add    $0x46020,%rax
   4354a:	48 8b 00             	mov    (%rax),%rax
   4354d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43551:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43555:	8b 00                	mov    (%rax),%eax
   43557:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   4355c:	74 14                	je     43572 <program_load+0x73>
   4355e:	ba 2b 4f 04 00       	mov    $0x44f2b,%edx
   43563:	be 39 00 00 00       	mov    $0x39,%esi
   43568:	bf 20 4f 04 00       	mov    $0x44f20,%edi
   4356d:	e8 e2 f7 ff ff       	callq  42d54 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43572:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43576:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4357a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4357e:	48 01 d0             	add    %rdx,%rax
   43581:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43585:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4358c:	e9 94 00 00 00       	jmpq   43625 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43591:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43594:	48 63 d0             	movslq %eax,%rdx
   43597:	48 89 d0             	mov    %rdx,%rax
   4359a:	48 c1 e0 03          	shl    $0x3,%rax
   4359e:	48 29 d0             	sub    %rdx,%rax
   435a1:	48 c1 e0 03          	shl    $0x3,%rax
   435a5:	48 89 c2             	mov    %rax,%rdx
   435a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435ac:	48 01 d0             	add    %rdx,%rax
   435af:	8b 00                	mov    (%rax),%eax
   435b1:	83 f8 01             	cmp    $0x1,%eax
   435b4:	75 6b                	jne    43621 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   435b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   435b9:	48 63 d0             	movslq %eax,%rdx
   435bc:	48 89 d0             	mov    %rdx,%rax
   435bf:	48 c1 e0 03          	shl    $0x3,%rax
   435c3:	48 29 d0             	sub    %rdx,%rax
   435c6:	48 c1 e0 03          	shl    $0x3,%rax
   435ca:	48 89 c2             	mov    %rax,%rdx
   435cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435d1:	48 01 d0             	add    %rdx,%rax
   435d4:	48 8b 50 08          	mov    0x8(%rax),%rdx
   435d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435dc:	48 01 d0             	add    %rdx,%rax
   435df:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   435e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   435e6:	48 63 d0             	movslq %eax,%rdx
   435e9:	48 89 d0             	mov    %rdx,%rax
   435ec:	48 c1 e0 03          	shl    $0x3,%rax
   435f0:	48 29 d0             	sub    %rdx,%rax
   435f3:	48 c1 e0 03          	shl    $0x3,%rax
   435f7:	48 89 c2             	mov    %rax,%rdx
   435fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435fe:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43602:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   43606:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4360a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4360e:	48 89 c7             	mov    %rax,%rdi
   43611:	e8 3d 00 00 00       	callq  43653 <program_load_segment>
   43616:	85 c0                	test   %eax,%eax
   43618:	79 07                	jns    43621 <program_load+0x122>
                return -1;
   4361a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4361f:	eb 30                	jmp    43651 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43621:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43625:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43629:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   4362d:	0f b7 c0             	movzwl %ax,%eax
   43630:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43633:	0f 8c 58 ff ff ff    	jl     43591 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   43639:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4363d:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43641:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43645:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   4364c:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43651:	c9                   	leaveq 
   43652:	c3                   	retq   

0000000000043653 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43653:	55                   	push   %rbp
   43654:	48 89 e5             	mov    %rsp,%rbp
   43657:	48 83 ec 70          	sub    $0x70,%rsp
   4365b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4365f:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43663:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   43667:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4366b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4366f:	48 8b 40 10          	mov    0x10(%rax),%rax
   43673:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   43677:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4367b:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4367f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43683:	48 01 d0             	add    %rdx,%rax
   43686:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4368a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4368e:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43692:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43696:	48 01 d0             	add    %rdx,%rax
   43699:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   4369d:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   436a4:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   436a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436a9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   436ad:	e9 8f 00 00 00       	jmpq   43741 <program_load_segment+0xee>
        intptr_t pPage = getAvailablePhysicalPage();
   436b2:	e8 b0 ca ff ff       	callq  40167 <getAvailablePhysicalPage>
   436b7:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        if (pPage < 0 || assign_physical_page(pPage, p->p_pid) < 0
   436bb:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   436c0:	78 45                	js     43707 <program_load_segment+0xb4>
   436c2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436c6:	8b 00                	mov    (%rax),%eax
   436c8:	0f be d0             	movsbl %al,%edx
   436cb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   436cf:	89 d6                	mov    %edx,%esi
   436d1:	48 89 c7             	mov    %rax,%rdi
   436d4:	e8 57 d0 ff ff       	callq  40730 <assign_physical_page>
   436d9:	85 c0                	test   %eax,%eax
   436db:	78 2a                	js     43707 <program_load_segment+0xb4>
            || virtual_memory_map(p->p_pagetable, addr, pPage, PAGESIZE,
   436dd:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   436e1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436e5:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   436ec:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   436f0:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   436f6:	b9 00 10 00 00       	mov    $0x1000,%ecx
   436fb:	48 89 c7             	mov    %rax,%rdi
   436fe:	e8 50 f9 ff ff       	callq  43053 <virtual_memory_map>
   43703:	85 c0                	test   %eax,%eax
   43705:	79 32                	jns    43739 <program_load_segment+0xe6>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43707:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4370b:	8b 00                	mov    (%rax),%eax
   4370d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43711:	49 89 d0             	mov    %rdx,%r8
   43714:	89 c1                	mov    %eax,%ecx
   43716:	ba 48 4f 04 00       	mov    $0x44f48,%edx
   4371b:	be 00 c0 00 00       	mov    $0xc000,%esi
   43720:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43725:	b8 00 00 00 00       	mov    $0x0,%eax
   4372a:	e8 66 0a 00 00       	callq  44195 <console_printf>
            return -1;
   4372f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43734:	e9 20 01 00 00       	jmpq   43859 <program_load_segment+0x206>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43739:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43740:	00 
   43741:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43745:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43749:	0f 82 63 ff ff ff    	jb     436b2 <program_load_segment+0x5f>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   4374f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43753:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4375a:	48 89 c7             	mov    %rax,%rdi
   4375d:	e8 c0 f7 ff ff       	callq  42f22 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43762:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43766:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4376a:	48 89 c2             	mov    %rax,%rdx
   4376d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43771:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   43775:	48 89 ce             	mov    %rcx,%rsi
   43778:	48 89 c7             	mov    %rax,%rdi
   4377b:	e8 77 01 00 00       	callq  438f7 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43780:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43784:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   43788:	48 89 c2             	mov    %rax,%rdx
   4378b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4378f:	be 00 00 00 00       	mov    $0x0,%esi
   43794:	48 89 c7             	mov    %rax,%rdi
   43797:	e8 c4 01 00 00       	callq  43960 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   4379c:	48 8b 05 5d e8 00 00 	mov    0xe85d(%rip),%rax        # 52000 <kernel_pagetable>
   437a3:	48 89 c7             	mov    %rax,%rdi
   437a6:	e8 77 f7 ff ff       	callq  42f22 <set_pagetable>

    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   437ab:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   437af:	8b 40 04             	mov    0x4(%rax),%eax
   437b2:	83 e0 02             	and    $0x2,%eax
   437b5:	85 c0                	test   %eax,%eax
   437b7:	0f 85 97 00 00 00    	jne    43854 <program_load_segment+0x201>
        // read-only section
        for(uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   437bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437c1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   437c5:	eb 7f                	jmp    43846 <program_load_segment+0x1f3>
            // map without write access
            vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   437c7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   437cb:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   437d2:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   437d6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   437da:	48 89 ce             	mov    %rcx,%rsi
   437dd:	48 89 c7             	mov    %rax,%rdi
   437e0:	e8 23 fc ff ff       	callq  43408 <virtual_memory_lookup>
            if(virtual_memory_map(p->p_pagetable, addr, map.pa, PAGESIZE, PTE_P | PTE_U) < 0){
   437e5:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   437e9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   437ed:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   437f4:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   437f8:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   437fe:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43803:	48 89 c7             	mov    %rax,%rdi
   43806:	e8 48 f8 ff ff       	callq  43053 <virtual_memory_map>
   4380b:	85 c0                	test   %eax,%eax
   4380d:	79 2f                	jns    4383e <program_load_segment+0x1eb>
                console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   4380f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43813:	8b 00                	mov    (%rax),%eax
   43815:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43819:	49 89 d0             	mov    %rdx,%r8
   4381c:	89 c1                	mov    %eax,%ecx
   4381e:	ba 48 4f 04 00       	mov    $0x44f48,%edx
   43823:	be 00 c0 00 00       	mov    $0xc000,%esi
   43828:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4382d:	b8 00 00 00 00       	mov    $0x0,%eax
   43832:	e8 5e 09 00 00       	callq  44195 <console_printf>
                return -1;
   43837:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4383c:	eb 1b                	jmp    43859 <program_load_segment+0x206>
        for(uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4383e:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43845:	00 
   43846:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4384a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4384e:	0f 82 73 ff ff ff    	jb     437c7 <program_load_segment+0x174>
            }
        }
    }

    return 0;
   43854:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43859:	c9                   	leaveq 
   4385a:	c3                   	retq   

000000000004385b <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4385b:	48 89 f9             	mov    %rdi,%rcx
   4385e:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43860:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
   43867:	00 
   43868:	72 08                	jb     43872 <console_putc+0x17>
        cp->cursor = console;
   4386a:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
   43871:	00 
    }
    if (c == '\n') {
   43872:	40 80 fe 0a          	cmp    $0xa,%sil
   43876:	74 16                	je     4388e <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
   43878:	48 8b 41 08          	mov    0x8(%rcx),%rax
   4387c:	48 8d 50 02          	lea    0x2(%rax),%rdx
   43880:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   43884:	40 0f b6 f6          	movzbl %sil,%esi
   43888:	09 fe                	or     %edi,%esi
   4388a:	66 89 30             	mov    %si,(%rax)
    }
}
   4388d:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
   4388e:	4c 8b 41 08          	mov    0x8(%rcx),%r8
   43892:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
   43899:	4c 89 c6             	mov    %r8,%rsi
   4389c:	48 d1 fe             	sar    %rsi
   4389f:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   438a6:	66 66 66 
   438a9:	48 89 f0             	mov    %rsi,%rax
   438ac:	48 f7 ea             	imul   %rdx
   438af:	48 c1 fa 05          	sar    $0x5,%rdx
   438b3:	49 c1 f8 3f          	sar    $0x3f,%r8
   438b7:	4c 29 c2             	sub    %r8,%rdx
   438ba:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   438be:	48 c1 e2 04          	shl    $0x4,%rdx
   438c2:	89 f0                	mov    %esi,%eax
   438c4:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
   438c6:	83 cf 20             	or     $0x20,%edi
   438c9:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   438cd:	48 8d 72 02          	lea    0x2(%rdx),%rsi
   438d1:	48 89 71 08          	mov    %rsi,0x8(%rcx)
   438d5:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
   438d8:	83 c0 01             	add    $0x1,%eax
   438db:	83 f8 50             	cmp    $0x50,%eax
   438de:	75 e9                	jne    438c9 <console_putc+0x6e>
   438e0:	c3                   	retq   

00000000000438e1 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
   438e1:	48 8b 47 08          	mov    0x8(%rdi),%rax
   438e5:	48 3b 47 10          	cmp    0x10(%rdi),%rax
   438e9:	73 0b                	jae    438f6 <string_putc+0x15>
        *sp->s++ = c;
   438eb:	48 8d 50 01          	lea    0x1(%rax),%rdx
   438ef:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   438f3:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
   438f6:	c3                   	retq   

00000000000438f7 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
   438f7:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   438fa:	48 85 d2             	test   %rdx,%rdx
   438fd:	74 17                	je     43916 <memcpy+0x1f>
   438ff:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
   43904:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
   43909:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4390d:	48 83 c1 01          	add    $0x1,%rcx
   43911:	48 39 d1             	cmp    %rdx,%rcx
   43914:	75 ee                	jne    43904 <memcpy+0xd>
}
   43916:	c3                   	retq   

0000000000043917 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
   43917:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
   4391a:	48 39 fe             	cmp    %rdi,%rsi
   4391d:	72 1d                	jb     4393c <memmove+0x25>
        while (n-- > 0) {
   4391f:	b9 00 00 00 00       	mov    $0x0,%ecx
   43924:	48 85 d2             	test   %rdx,%rdx
   43927:	74 12                	je     4393b <memmove+0x24>
            *d++ = *s++;
   43929:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
   4392d:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
   43931:	48 83 c1 01          	add    $0x1,%rcx
   43935:	48 39 ca             	cmp    %rcx,%rdx
   43938:	75 ef                	jne    43929 <memmove+0x12>
}
   4393a:	c3                   	retq   
   4393b:	c3                   	retq   
    if (s < d && s + n > d) {
   4393c:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
   43940:	48 39 cf             	cmp    %rcx,%rdi
   43943:	73 da                	jae    4391f <memmove+0x8>
        while (n-- > 0) {
   43945:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
   43949:	48 85 d2             	test   %rdx,%rdx
   4394c:	74 ec                	je     4393a <memmove+0x23>
            *--d = *--s;
   4394e:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
   43952:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
   43955:	48 83 e9 01          	sub    $0x1,%rcx
   43959:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
   4395d:	75 ef                	jne    4394e <memmove+0x37>
   4395f:	c3                   	retq   

0000000000043960 <memset>:
void* memset(void* v, int c, size_t n) {
   43960:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43963:	48 85 d2             	test   %rdx,%rdx
   43966:	74 12                	je     4397a <memset+0x1a>
   43968:	48 01 fa             	add    %rdi,%rdx
   4396b:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
   4396e:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43971:	48 83 c1 01          	add    $0x1,%rcx
   43975:	48 39 ca             	cmp    %rcx,%rdx
   43978:	75 f4                	jne    4396e <memset+0xe>
}
   4397a:	c3                   	retq   

000000000004397b <strlen>:
    for (n = 0; *s != '\0'; ++s) {
   4397b:	80 3f 00             	cmpb   $0x0,(%rdi)
   4397e:	74 10                	je     43990 <strlen+0x15>
   43980:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   43985:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
   43989:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   4398d:	75 f6                	jne    43985 <strlen+0xa>
   4398f:	c3                   	retq   
   43990:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43995:	c3                   	retq   

0000000000043996 <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
   43996:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43999:	ba 00 00 00 00       	mov    $0x0,%edx
   4399e:	48 85 f6             	test   %rsi,%rsi
   439a1:	74 11                	je     439b4 <strnlen+0x1e>
   439a3:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
   439a7:	74 0c                	je     439b5 <strnlen+0x1f>
        ++n;
   439a9:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   439ad:	48 39 d0             	cmp    %rdx,%rax
   439b0:	75 f1                	jne    439a3 <strnlen+0xd>
   439b2:	eb 04                	jmp    439b8 <strnlen+0x22>
   439b4:	c3                   	retq   
   439b5:	48 89 d0             	mov    %rdx,%rax
}
   439b8:	c3                   	retq   

00000000000439b9 <strcpy>:
char* strcpy(char* dst, const char* src) {
   439b9:	48 89 f8             	mov    %rdi,%rax
   439bc:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
   439c1:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
   439c5:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
   439c8:	48 83 c2 01          	add    $0x1,%rdx
   439cc:	84 c9                	test   %cl,%cl
   439ce:	75 f1                	jne    439c1 <strcpy+0x8>
}
   439d0:	c3                   	retq   

00000000000439d1 <strcmp>:
    while (*a && *b && *a == *b) {
   439d1:	0f b6 07             	movzbl (%rdi),%eax
   439d4:	84 c0                	test   %al,%al
   439d6:	74 1a                	je     439f2 <strcmp+0x21>
   439d8:	0f b6 16             	movzbl (%rsi),%edx
   439db:	38 c2                	cmp    %al,%dl
   439dd:	75 13                	jne    439f2 <strcmp+0x21>
   439df:	84 d2                	test   %dl,%dl
   439e1:	74 0f                	je     439f2 <strcmp+0x21>
        ++a, ++b;
   439e3:	48 83 c7 01          	add    $0x1,%rdi
   439e7:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
   439eb:	0f b6 07             	movzbl (%rdi),%eax
   439ee:	84 c0                	test   %al,%al
   439f0:	75 e6                	jne    439d8 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
   439f2:	3a 06                	cmp    (%rsi),%al
   439f4:	0f 97 c0             	seta   %al
   439f7:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
   439fa:	83 d8 00             	sbb    $0x0,%eax
}
   439fd:	c3                   	retq   

00000000000439fe <strchr>:
    while (*s && *s != (char) c) {
   439fe:	0f b6 07             	movzbl (%rdi),%eax
   43a01:	84 c0                	test   %al,%al
   43a03:	74 10                	je     43a15 <strchr+0x17>
   43a05:	40 38 f0             	cmp    %sil,%al
   43a08:	74 18                	je     43a22 <strchr+0x24>
        ++s;
   43a0a:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
   43a0e:	0f b6 07             	movzbl (%rdi),%eax
   43a11:	84 c0                	test   %al,%al
   43a13:	75 f0                	jne    43a05 <strchr+0x7>
        return NULL;
   43a15:	40 84 f6             	test   %sil,%sil
   43a18:	b8 00 00 00 00       	mov    $0x0,%eax
   43a1d:	48 0f 44 c7          	cmove  %rdi,%rax
}
   43a21:	c3                   	retq   
   43a22:	48 89 f8             	mov    %rdi,%rax
   43a25:	c3                   	retq   

0000000000043a26 <rand>:
    if (!rand_seed_set) {
   43a26:	83 3d d7 45 01 00 00 	cmpl   $0x0,0x145d7(%rip)        # 58004 <rand_seed_set>
   43a2d:	74 1b                	je     43a4a <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43a2f:	69 05 c7 45 01 00 0d 	imul   $0x19660d,0x145c7(%rip),%eax        # 58000 <rand_seed>
   43a36:	66 19 00 
   43a39:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43a3e:	89 05 bc 45 01 00    	mov    %eax,0x145bc(%rip)        # 58000 <rand_seed>
    return rand_seed & RAND_MAX;
   43a44:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43a49:	c3                   	retq   
    rand_seed = seed;
   43a4a:	c7 05 ac 45 01 00 9e 	movl   $0x30d4879e,0x145ac(%rip)        # 58000 <rand_seed>
   43a51:	87 d4 30 
    rand_seed_set = 1;
   43a54:	c7 05 a6 45 01 00 01 	movl   $0x1,0x145a6(%rip)        # 58004 <rand_seed_set>
   43a5b:	00 00 00 
}
   43a5e:	eb cf                	jmp    43a2f <rand+0x9>

0000000000043a60 <srand>:
    rand_seed = seed;
   43a60:	89 3d 9a 45 01 00    	mov    %edi,0x1459a(%rip)        # 58000 <rand_seed>
    rand_seed_set = 1;
   43a66:	c7 05 94 45 01 00 01 	movl   $0x1,0x14594(%rip)        # 58004 <rand_seed_set>
   43a6d:	00 00 00 
}
   43a70:	c3                   	retq   

0000000000043a71 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43a71:	55                   	push   %rbp
   43a72:	48 89 e5             	mov    %rsp,%rbp
   43a75:	41 57                	push   %r15
   43a77:	41 56                	push   %r14
   43a79:	41 55                	push   %r13
   43a7b:	41 54                	push   %r12
   43a7d:	53                   	push   %rbx
   43a7e:	48 83 ec 58          	sub    $0x58,%rsp
   43a82:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
   43a86:	0f b6 02             	movzbl (%rdx),%eax
   43a89:	84 c0                	test   %al,%al
   43a8b:	0f 84 b0 06 00 00    	je     44141 <printer_vprintf+0x6d0>
   43a91:	49 89 fe             	mov    %rdi,%r14
   43a94:	49 89 d4             	mov    %rdx,%r12
            length = 1;
   43a97:	41 89 f7             	mov    %esi,%r15d
   43a9a:	e9 a4 04 00 00       	jmpq   43f43 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
   43a9f:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
   43aa4:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
   43aaa:	45 84 e4             	test   %r12b,%r12b
   43aad:	0f 84 82 06 00 00    	je     44135 <printer_vprintf+0x6c4>
        int flags = 0;
   43ab3:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
   43ab9:	41 0f be f4          	movsbl %r12b,%esi
   43abd:	bf 81 51 04 00       	mov    $0x45181,%edi
   43ac2:	e8 37 ff ff ff       	callq  439fe <strchr>
   43ac7:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
   43aca:	48 85 c0             	test   %rax,%rax
   43acd:	74 55                	je     43b24 <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
   43acf:	48 81 e9 81 51 04 00 	sub    $0x45181,%rcx
   43ad6:	b8 01 00 00 00       	mov    $0x1,%eax
   43adb:	d3 e0                	shl    %cl,%eax
   43add:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
   43ae0:	48 83 c3 01          	add    $0x1,%rbx
   43ae4:	44 0f b6 23          	movzbl (%rbx),%r12d
   43ae8:	45 84 e4             	test   %r12b,%r12b
   43aeb:	75 cc                	jne    43ab9 <printer_vprintf+0x48>
   43aed:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
   43af1:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
   43af7:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
   43afe:	80 3b 2e             	cmpb   $0x2e,(%rbx)
   43b01:	0f 84 a9 00 00 00    	je     43bb0 <printer_vprintf+0x13f>
        int length = 0;
   43b07:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
   43b0c:	0f b6 13             	movzbl (%rbx),%edx
   43b0f:	8d 42 bd             	lea    -0x43(%rdx),%eax
   43b12:	3c 37                	cmp    $0x37,%al
   43b14:	0f 87 c4 04 00 00    	ja     43fde <printer_vprintf+0x56d>
   43b1a:	0f b6 c0             	movzbl %al,%eax
   43b1d:	ff 24 c5 90 4f 04 00 	jmpq   *0x44f90(,%rax,8)
        if (*format >= '1' && *format <= '9') {
   43b24:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
   43b28:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
   43b2d:	3c 08                	cmp    $0x8,%al
   43b2f:	77 2f                	ja     43b60 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43b31:	0f b6 03             	movzbl (%rbx),%eax
   43b34:	8d 50 d0             	lea    -0x30(%rax),%edx
   43b37:	80 fa 09             	cmp    $0x9,%dl
   43b3a:	77 5e                	ja     43b9a <printer_vprintf+0x129>
   43b3c:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
   43b42:	48 83 c3 01          	add    $0x1,%rbx
   43b46:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
   43b4b:	0f be c0             	movsbl %al,%eax
   43b4e:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43b53:	0f b6 03             	movzbl (%rbx),%eax
   43b56:	8d 50 d0             	lea    -0x30(%rax),%edx
   43b59:	80 fa 09             	cmp    $0x9,%dl
   43b5c:	76 e4                	jbe    43b42 <printer_vprintf+0xd1>
   43b5e:	eb 97                	jmp    43af7 <printer_vprintf+0x86>
        } else if (*format == '*') {
   43b60:	41 80 fc 2a          	cmp    $0x2a,%r12b
   43b64:	75 3f                	jne    43ba5 <printer_vprintf+0x134>
            width = va_arg(val, int);
   43b66:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43b6a:	8b 07                	mov    (%rdi),%eax
   43b6c:	83 f8 2f             	cmp    $0x2f,%eax
   43b6f:	77 17                	ja     43b88 <printer_vprintf+0x117>
   43b71:	89 c2                	mov    %eax,%edx
   43b73:	48 03 57 10          	add    0x10(%rdi),%rdx
   43b77:	83 c0 08             	add    $0x8,%eax
   43b7a:	89 07                	mov    %eax,(%rdi)
   43b7c:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
   43b7f:	48 83 c3 01          	add    $0x1,%rbx
   43b83:	e9 6f ff ff ff       	jmpq   43af7 <printer_vprintf+0x86>
            width = va_arg(val, int);
   43b88:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43b8c:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43b90:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43b94:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43b98:	eb e2                	jmp    43b7c <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43b9a:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   43ba0:	e9 52 ff ff ff       	jmpq   43af7 <printer_vprintf+0x86>
        int width = -1;
   43ba5:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
   43bab:	e9 47 ff ff ff       	jmpq   43af7 <printer_vprintf+0x86>
            ++format;
   43bb0:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
   43bb4:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43bb8:	8d 48 d0             	lea    -0x30(%rax),%ecx
   43bbb:	80 f9 09             	cmp    $0x9,%cl
   43bbe:	76 13                	jbe    43bd3 <printer_vprintf+0x162>
            } else if (*format == '*') {
   43bc0:	3c 2a                	cmp    $0x2a,%al
   43bc2:	74 33                	je     43bf7 <printer_vprintf+0x186>
            ++format;
   43bc4:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
   43bc7:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
   43bce:	e9 34 ff ff ff       	jmpq   43b07 <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43bd3:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
   43bd8:	48 83 c2 01          	add    $0x1,%rdx
   43bdc:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
   43bdf:	0f be c0             	movsbl %al,%eax
   43be2:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43be6:	0f b6 02             	movzbl (%rdx),%eax
   43be9:	8d 70 d0             	lea    -0x30(%rax),%esi
   43bec:	40 80 fe 09          	cmp    $0x9,%sil
   43bf0:	76 e6                	jbe    43bd8 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
   43bf2:	48 89 d3             	mov    %rdx,%rbx
   43bf5:	eb 1c                	jmp    43c13 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
   43bf7:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43bfb:	8b 07                	mov    (%rdi),%eax
   43bfd:	83 f8 2f             	cmp    $0x2f,%eax
   43c00:	77 23                	ja     43c25 <printer_vprintf+0x1b4>
   43c02:	89 c2                	mov    %eax,%edx
   43c04:	48 03 57 10          	add    0x10(%rdi),%rdx
   43c08:	83 c0 08             	add    $0x8,%eax
   43c0b:	89 07                	mov    %eax,(%rdi)
   43c0d:	8b 0a                	mov    (%rdx),%ecx
                ++format;
   43c0f:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
   43c13:	85 c9                	test   %ecx,%ecx
   43c15:	b8 00 00 00 00       	mov    $0x0,%eax
   43c1a:	0f 49 c1             	cmovns %ecx,%eax
   43c1d:	89 45 9c             	mov    %eax,-0x64(%rbp)
   43c20:	e9 e2 fe ff ff       	jmpq   43b07 <printer_vprintf+0x96>
                precision = va_arg(val, int);
   43c25:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43c29:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43c2d:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43c31:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43c35:	eb d6                	jmp    43c0d <printer_vprintf+0x19c>
        switch (*format) {
   43c37:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43c3c:	e9 f3 00 00 00       	jmpq   43d34 <printer_vprintf+0x2c3>
            ++format;
   43c41:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
   43c45:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
   43c4a:	e9 bd fe ff ff       	jmpq   43b0c <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43c4f:	85 c9                	test   %ecx,%ecx
   43c51:	74 55                	je     43ca8 <printer_vprintf+0x237>
   43c53:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43c57:	8b 07                	mov    (%rdi),%eax
   43c59:	83 f8 2f             	cmp    $0x2f,%eax
   43c5c:	77 38                	ja     43c96 <printer_vprintf+0x225>
   43c5e:	89 c2                	mov    %eax,%edx
   43c60:	48 03 57 10          	add    0x10(%rdi),%rdx
   43c64:	83 c0 08             	add    $0x8,%eax
   43c67:	89 07                	mov    %eax,(%rdi)
   43c69:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43c6c:	48 89 d0             	mov    %rdx,%rax
   43c6f:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
   43c73:	49 89 d0             	mov    %rdx,%r8
   43c76:	49 f7 d8             	neg    %r8
   43c79:	25 80 00 00 00       	and    $0x80,%eax
   43c7e:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43c82:	0b 45 a8             	or     -0x58(%rbp),%eax
   43c85:	83 c8 60             	or     $0x60,%eax
   43c88:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
   43c8b:	41 bc 87 4f 04 00    	mov    $0x44f87,%r12d
            break;
   43c91:	e9 35 01 00 00       	jmpq   43dcb <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43c96:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43c9a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43c9e:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43ca2:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43ca6:	eb c1                	jmp    43c69 <printer_vprintf+0x1f8>
   43ca8:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43cac:	8b 07                	mov    (%rdi),%eax
   43cae:	83 f8 2f             	cmp    $0x2f,%eax
   43cb1:	77 10                	ja     43cc3 <printer_vprintf+0x252>
   43cb3:	89 c2                	mov    %eax,%edx
   43cb5:	48 03 57 10          	add    0x10(%rdi),%rdx
   43cb9:	83 c0 08             	add    $0x8,%eax
   43cbc:	89 07                	mov    %eax,(%rdi)
   43cbe:	48 63 12             	movslq (%rdx),%rdx
   43cc1:	eb a9                	jmp    43c6c <printer_vprintf+0x1fb>
   43cc3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43cc7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43ccb:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43ccf:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43cd3:	eb e9                	jmp    43cbe <printer_vprintf+0x24d>
        int base = 10;
   43cd5:	be 0a 00 00 00       	mov    $0xa,%esi
   43cda:	eb 58                	jmp    43d34 <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43cdc:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43ce0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43ce4:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43ce8:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43cec:	eb 60                	jmp    43d4e <printer_vprintf+0x2dd>
   43cee:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43cf2:	8b 07                	mov    (%rdi),%eax
   43cf4:	83 f8 2f             	cmp    $0x2f,%eax
   43cf7:	77 10                	ja     43d09 <printer_vprintf+0x298>
   43cf9:	89 c2                	mov    %eax,%edx
   43cfb:	48 03 57 10          	add    0x10(%rdi),%rdx
   43cff:	83 c0 08             	add    $0x8,%eax
   43d02:	89 07                	mov    %eax,(%rdi)
   43d04:	44 8b 02             	mov    (%rdx),%r8d
   43d07:	eb 48                	jmp    43d51 <printer_vprintf+0x2e0>
   43d09:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43d0d:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43d11:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43d15:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43d19:	eb e9                	jmp    43d04 <printer_vprintf+0x293>
   43d1b:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
   43d1e:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
   43d25:	bf 70 51 04 00       	mov    $0x45170,%edi
   43d2a:	e9 e2 02 00 00       	jmpq   44011 <printer_vprintf+0x5a0>
            base = 16;
   43d2f:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43d34:	85 c9                	test   %ecx,%ecx
   43d36:	74 b6                	je     43cee <printer_vprintf+0x27d>
   43d38:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43d3c:	8b 01                	mov    (%rcx),%eax
   43d3e:	83 f8 2f             	cmp    $0x2f,%eax
   43d41:	77 99                	ja     43cdc <printer_vprintf+0x26b>
   43d43:	89 c2                	mov    %eax,%edx
   43d45:	48 03 51 10          	add    0x10(%rcx),%rdx
   43d49:	83 c0 08             	add    $0x8,%eax
   43d4c:	89 01                	mov    %eax,(%rcx)
   43d4e:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
   43d51:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
   43d55:	85 f6                	test   %esi,%esi
   43d57:	79 c2                	jns    43d1b <printer_vprintf+0x2aa>
        base = -base;
   43d59:	41 89 f1             	mov    %esi,%r9d
   43d5c:	f7 de                	neg    %esi
   43d5e:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
   43d65:	bf 50 51 04 00       	mov    $0x45150,%edi
   43d6a:	e9 a2 02 00 00       	jmpq   44011 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
   43d6f:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43d73:	8b 07                	mov    (%rdi),%eax
   43d75:	83 f8 2f             	cmp    $0x2f,%eax
   43d78:	77 1c                	ja     43d96 <printer_vprintf+0x325>
   43d7a:	89 c2                	mov    %eax,%edx
   43d7c:	48 03 57 10          	add    0x10(%rdi),%rdx
   43d80:	83 c0 08             	add    $0x8,%eax
   43d83:	89 07                	mov    %eax,(%rdi)
   43d85:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43d88:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
   43d8f:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43d94:	eb c3                	jmp    43d59 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
   43d96:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43d9a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43d9e:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43da2:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43da6:	eb dd                	jmp    43d85 <printer_vprintf+0x314>
            data = va_arg(val, char*);
   43da8:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43dac:	8b 01                	mov    (%rcx),%eax
   43dae:	83 f8 2f             	cmp    $0x2f,%eax
   43db1:	0f 87 a5 01 00 00    	ja     43f5c <printer_vprintf+0x4eb>
   43db7:	89 c2                	mov    %eax,%edx
   43db9:	48 03 51 10          	add    0x10(%rcx),%rdx
   43dbd:	83 c0 08             	add    $0x8,%eax
   43dc0:	89 01                	mov    %eax,(%rcx)
   43dc2:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
   43dc5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
   43dcb:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43dce:	83 e0 20             	and    $0x20,%eax
   43dd1:	89 45 8c             	mov    %eax,-0x74(%rbp)
   43dd4:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
   43dda:	0f 85 21 02 00 00    	jne    44001 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43de0:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43de3:	89 45 88             	mov    %eax,-0x78(%rbp)
   43de6:	83 e0 60             	and    $0x60,%eax
   43de9:	83 f8 60             	cmp    $0x60,%eax
   43dec:	0f 84 54 02 00 00    	je     44046 <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43df2:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43df5:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
   43df8:	48 c7 45 a0 87 4f 04 	movq   $0x44f87,-0x60(%rbp)
   43dff:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43e00:	83 f8 21             	cmp    $0x21,%eax
   43e03:	0f 84 79 02 00 00    	je     44082 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43e09:	8b 7d 9c             	mov    -0x64(%rbp),%edi
   43e0c:	89 f8                	mov    %edi,%eax
   43e0e:	f7 d0                	not    %eax
   43e10:	c1 e8 1f             	shr    $0x1f,%eax
   43e13:	89 45 84             	mov    %eax,-0x7c(%rbp)
   43e16:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   43e1a:	0f 85 9e 02 00 00    	jne    440be <printer_vprintf+0x64d>
   43e20:	84 c0                	test   %al,%al
   43e22:	0f 84 96 02 00 00    	je     440be <printer_vprintf+0x64d>
            len = strnlen(data, precision);
   43e28:	48 63 f7             	movslq %edi,%rsi
   43e2b:	4c 89 e7             	mov    %r12,%rdi
   43e2e:	e8 63 fb ff ff       	callq  43996 <strnlen>
   43e33:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
   43e36:	8b 45 88             	mov    -0x78(%rbp),%eax
   43e39:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
   43e3c:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43e43:	83 f8 22             	cmp    $0x22,%eax
   43e46:	0f 84 aa 02 00 00    	je     440f6 <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
   43e4c:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43e50:	e8 26 fb ff ff       	callq  4397b <strlen>
   43e55:	8b 55 9c             	mov    -0x64(%rbp),%edx
   43e58:	03 55 98             	add    -0x68(%rbp),%edx
   43e5b:	44 89 e9             	mov    %r13d,%ecx
   43e5e:	29 d1                	sub    %edx,%ecx
   43e60:	29 c1                	sub    %eax,%ecx
   43e62:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
   43e65:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43e68:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
   43e6c:	75 2d                	jne    43e9b <printer_vprintf+0x42a>
   43e6e:	85 c9                	test   %ecx,%ecx
   43e70:	7e 29                	jle    43e9b <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
   43e72:	44 89 fa             	mov    %r15d,%edx
   43e75:	be 20 00 00 00       	mov    $0x20,%esi
   43e7a:	4c 89 f7             	mov    %r14,%rdi
   43e7d:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43e80:	41 83 ed 01          	sub    $0x1,%r13d
   43e84:	45 85 ed             	test   %r13d,%r13d
   43e87:	7f e9                	jg     43e72 <printer_vprintf+0x401>
   43e89:	8b 7d 8c             	mov    -0x74(%rbp),%edi
   43e8c:	85 ff                	test   %edi,%edi
   43e8e:	b8 01 00 00 00       	mov    $0x1,%eax
   43e93:	0f 4f c7             	cmovg  %edi,%eax
   43e96:	29 c7                	sub    %eax,%edi
   43e98:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
   43e9b:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43e9f:	0f b6 07             	movzbl (%rdi),%eax
   43ea2:	84 c0                	test   %al,%al
   43ea4:	74 22                	je     43ec8 <printer_vprintf+0x457>
   43ea6:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43eaa:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
   43ead:	0f b6 f0             	movzbl %al,%esi
   43eb0:	44 89 fa             	mov    %r15d,%edx
   43eb3:	4c 89 f7             	mov    %r14,%rdi
   43eb6:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
   43eb9:	48 83 c3 01          	add    $0x1,%rbx
   43ebd:	0f b6 03             	movzbl (%rbx),%eax
   43ec0:	84 c0                	test   %al,%al
   43ec2:	75 e9                	jne    43ead <printer_vprintf+0x43c>
   43ec4:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
   43ec8:	8b 45 9c             	mov    -0x64(%rbp),%eax
   43ecb:	85 c0                	test   %eax,%eax
   43ecd:	7e 1d                	jle    43eec <printer_vprintf+0x47b>
   43ecf:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43ed3:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
   43ed5:	44 89 fa             	mov    %r15d,%edx
   43ed8:	be 30 00 00 00       	mov    $0x30,%esi
   43edd:	4c 89 f7             	mov    %r14,%rdi
   43ee0:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
   43ee3:	83 eb 01             	sub    $0x1,%ebx
   43ee6:	75 ed                	jne    43ed5 <printer_vprintf+0x464>
   43ee8:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
   43eec:	8b 45 98             	mov    -0x68(%rbp),%eax
   43eef:	85 c0                	test   %eax,%eax
   43ef1:	7e 27                	jle    43f1a <printer_vprintf+0x4a9>
   43ef3:	89 c0                	mov    %eax,%eax
   43ef5:	4c 01 e0             	add    %r12,%rax
   43ef8:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43efc:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
   43eff:	41 0f b6 34 24       	movzbl (%r12),%esi
   43f04:	44 89 fa             	mov    %r15d,%edx
   43f07:	4c 89 f7             	mov    %r14,%rdi
   43f0a:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
   43f0d:	49 83 c4 01          	add    $0x1,%r12
   43f11:	49 39 dc             	cmp    %rbx,%r12
   43f14:	75 e9                	jne    43eff <printer_vprintf+0x48e>
   43f16:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
   43f1a:	45 85 ed             	test   %r13d,%r13d
   43f1d:	7e 14                	jle    43f33 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
   43f1f:	44 89 fa             	mov    %r15d,%edx
   43f22:	be 20 00 00 00       	mov    $0x20,%esi
   43f27:	4c 89 f7             	mov    %r14,%rdi
   43f2a:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
   43f2d:	41 83 ed 01          	sub    $0x1,%r13d
   43f31:	75 ec                	jne    43f1f <printer_vprintf+0x4ae>
    for (; *format; ++format) {
   43f33:	4c 8d 63 01          	lea    0x1(%rbx),%r12
   43f37:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43f3b:	84 c0                	test   %al,%al
   43f3d:	0f 84 fe 01 00 00    	je     44141 <printer_vprintf+0x6d0>
        if (*format != '%') {
   43f43:	3c 25                	cmp    $0x25,%al
   43f45:	0f 84 54 fb ff ff    	je     43a9f <printer_vprintf+0x2e>
            p->putc(p, *format, color);
   43f4b:	0f b6 f0             	movzbl %al,%esi
   43f4e:	44 89 fa             	mov    %r15d,%edx
   43f51:	4c 89 f7             	mov    %r14,%rdi
   43f54:	41 ff 16             	callq  *(%r14)
            continue;
   43f57:	4c 89 e3             	mov    %r12,%rbx
   43f5a:	eb d7                	jmp    43f33 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
   43f5c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43f60:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43f64:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43f68:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43f6c:	e9 51 fe ff ff       	jmpq   43dc2 <printer_vprintf+0x351>
            color = va_arg(val, int);
   43f71:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43f75:	8b 07                	mov    (%rdi),%eax
   43f77:	83 f8 2f             	cmp    $0x2f,%eax
   43f7a:	77 10                	ja     43f8c <printer_vprintf+0x51b>
   43f7c:	89 c2                	mov    %eax,%edx
   43f7e:	48 03 57 10          	add    0x10(%rdi),%rdx
   43f82:	83 c0 08             	add    $0x8,%eax
   43f85:	89 07                	mov    %eax,(%rdi)
   43f87:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
   43f8a:	eb a7                	jmp    43f33 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
   43f8c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43f90:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43f94:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43f98:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43f9c:	eb e9                	jmp    43f87 <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
   43f9e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43fa2:	8b 01                	mov    (%rcx),%eax
   43fa4:	83 f8 2f             	cmp    $0x2f,%eax
   43fa7:	77 23                	ja     43fcc <printer_vprintf+0x55b>
   43fa9:	89 c2                	mov    %eax,%edx
   43fab:	48 03 51 10          	add    0x10(%rcx),%rdx
   43faf:	83 c0 08             	add    $0x8,%eax
   43fb2:	89 01                	mov    %eax,(%rcx)
   43fb4:	8b 02                	mov    (%rdx),%eax
   43fb6:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
   43fb9:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43fbd:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43fc1:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
   43fc7:	e9 ff fd ff ff       	jmpq   43dcb <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
   43fcc:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43fd0:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43fd4:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43fd8:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43fdc:	eb d6                	jmp    43fb4 <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
   43fde:	84 d2                	test   %dl,%dl
   43fe0:	0f 85 39 01 00 00    	jne    4411f <printer_vprintf+0x6ae>
   43fe6:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
   43fea:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
   43fee:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
   43ff2:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43ff6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43ffc:	e9 ca fd ff ff       	jmpq   43dcb <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
   44001:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
   44007:	bf 70 51 04 00       	mov    $0x45170,%edi
        if (flags & FLAG_NUMERIC) {
   4400c:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
   44011:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
   44015:	4c 89 c1             	mov    %r8,%rcx
   44018:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
   4401c:	48 63 f6             	movslq %esi,%rsi
   4401f:	49 83 ec 01          	sub    $0x1,%r12
   44023:	48 89 c8             	mov    %rcx,%rax
   44026:	ba 00 00 00 00       	mov    $0x0,%edx
   4402b:	48 f7 f6             	div    %rsi
   4402e:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
   44032:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
   44036:	48 89 ca             	mov    %rcx,%rdx
   44039:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
   4403c:	48 39 d6             	cmp    %rdx,%rsi
   4403f:	76 de                	jbe    4401f <printer_vprintf+0x5ae>
   44041:	e9 9a fd ff ff       	jmpq   43de0 <printer_vprintf+0x36f>
                prefix = "-";
   44046:	48 c7 45 a0 84 4f 04 	movq   $0x44f84,-0x60(%rbp)
   4404d:	00 
            if (flags & FLAG_NEGATIVE) {
   4404e:	8b 45 a8             	mov    -0x58(%rbp),%eax
   44051:	a8 80                	test   $0x80,%al
   44053:	0f 85 b0 fd ff ff    	jne    43e09 <printer_vprintf+0x398>
                prefix = "+";
   44059:	48 c7 45 a0 7f 4f 04 	movq   $0x44f7f,-0x60(%rbp)
   44060:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44061:	a8 10                	test   $0x10,%al
   44063:	0f 85 a0 fd ff ff    	jne    43e09 <printer_vprintf+0x398>
                prefix = " ";
   44069:	a8 08                	test   $0x8,%al
   4406b:	ba 87 4f 04 00       	mov    $0x44f87,%edx
   44070:	b8 86 4f 04 00       	mov    $0x44f86,%eax
   44075:	48 0f 44 c2          	cmove  %rdx,%rax
   44079:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   4407d:	e9 87 fd ff ff       	jmpq   43e09 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
   44082:	41 8d 41 10          	lea    0x10(%r9),%eax
   44086:	a9 df ff ff ff       	test   $0xffffffdf,%eax
   4408b:	0f 85 78 fd ff ff    	jne    43e09 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
   44091:	4d 85 c0             	test   %r8,%r8
   44094:	75 0d                	jne    440a3 <printer_vprintf+0x632>
   44096:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
   4409d:	0f 84 66 fd ff ff    	je     43e09 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
   440a3:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
   440a7:	ba 88 4f 04 00       	mov    $0x44f88,%edx
   440ac:	b8 81 4f 04 00       	mov    $0x44f81,%eax
   440b1:	48 0f 44 c2          	cmove  %rdx,%rax
   440b5:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   440b9:	e9 4b fd ff ff       	jmpq   43e09 <printer_vprintf+0x398>
            len = strlen(data);
   440be:	4c 89 e7             	mov    %r12,%rdi
   440c1:	e8 b5 f8 ff ff       	callq  4397b <strlen>
   440c6:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   440c9:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   440cd:	0f 84 63 fd ff ff    	je     43e36 <printer_vprintf+0x3c5>
   440d3:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
   440d7:	0f 84 59 fd ff ff    	je     43e36 <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
   440dd:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
   440e0:	89 ca                	mov    %ecx,%edx
   440e2:	29 c2                	sub    %eax,%edx
   440e4:	39 c1                	cmp    %eax,%ecx
   440e6:	b8 00 00 00 00       	mov    $0x0,%eax
   440eb:	0f 4e d0             	cmovle %eax,%edx
   440ee:	89 55 9c             	mov    %edx,-0x64(%rbp)
   440f1:	e9 56 fd ff ff       	jmpq   43e4c <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
   440f6:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   440fa:	e8 7c f8 ff ff       	callq  4397b <strlen>
   440ff:	8b 7d 98             	mov    -0x68(%rbp),%edi
   44102:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
   44105:	44 89 e9             	mov    %r13d,%ecx
   44108:	29 f9                	sub    %edi,%ecx
   4410a:	29 c1                	sub    %eax,%ecx
   4410c:	44 39 ea             	cmp    %r13d,%edx
   4410f:	b8 00 00 00 00       	mov    $0x0,%eax
   44114:	0f 4d c8             	cmovge %eax,%ecx
   44117:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
   4411a:	e9 2d fd ff ff       	jmpq   43e4c <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
   4411f:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
   44122:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   44126:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   4412a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   44130:	e9 96 fc ff ff       	jmpq   43dcb <printer_vprintf+0x35a>
        int flags = 0;
   44135:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
   4413c:	e9 b0 f9 ff ff       	jmpq   43af1 <printer_vprintf+0x80>
}
   44141:	48 83 c4 58          	add    $0x58,%rsp
   44145:	5b                   	pop    %rbx
   44146:	41 5c                	pop    %r12
   44148:	41 5d                	pop    %r13
   4414a:	41 5e                	pop    %r14
   4414c:	41 5f                	pop    %r15
   4414e:	5d                   	pop    %rbp
   4414f:	c3                   	retq   

0000000000044150 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44150:	55                   	push   %rbp
   44151:	48 89 e5             	mov    %rsp,%rbp
   44154:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
   44158:	48 c7 45 f0 5b 38 04 	movq   $0x4385b,-0x10(%rbp)
   4415f:	00 
        cpos = 0;
   44160:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
   44166:	b8 00 00 00 00       	mov    $0x0,%eax
   4416b:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
   4416e:	48 63 ff             	movslq %edi,%rdi
   44171:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
   44178:	00 
   44179:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   4417d:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
   44181:	e8 eb f8 ff ff       	callq  43a71 <printer_vprintf>
    return cp.cursor - console;
   44186:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4418a:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44190:	48 d1 f8             	sar    %rax
}
   44193:	c9                   	leaveq 
   44194:	c3                   	retq   

0000000000044195 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
   44195:	55                   	push   %rbp
   44196:	48 89 e5             	mov    %rsp,%rbp
   44199:	48 83 ec 50          	sub    $0x50,%rsp
   4419d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   441a1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   441a5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
   441a9:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   441b0:	48 8d 45 10          	lea    0x10(%rbp),%rax
   441b4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   441b8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   441bc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   441c0:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   441c4:	e8 87 ff ff ff       	callq  44150 <console_vprintf>
}
   441c9:	c9                   	leaveq 
   441ca:	c3                   	retq   

00000000000441cb <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   441cb:	55                   	push   %rbp
   441cc:	48 89 e5             	mov    %rsp,%rbp
   441cf:	53                   	push   %rbx
   441d0:	48 83 ec 28          	sub    $0x28,%rsp
   441d4:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
   441d7:	48 c7 45 d8 e1 38 04 	movq   $0x438e1,-0x28(%rbp)
   441de:	00 
    sp.s = s;
   441df:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
   441e3:	48 85 f6             	test   %rsi,%rsi
   441e6:	75 0b                	jne    441f3 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
   441e8:	8b 45 e0             	mov    -0x20(%rbp),%eax
   441eb:	29 d8                	sub    %ebx,%eax
}
   441ed:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   441f1:	c9                   	leaveq 
   441f2:	c3                   	retq   
        sp.end = s + size - 1;
   441f3:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
   441f8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   441fc:	be 00 00 00 00       	mov    $0x0,%esi
   44201:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
   44205:	e8 67 f8 ff ff       	callq  43a71 <printer_vprintf>
        *sp.s = 0;
   4420a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4420e:	c6 00 00             	movb   $0x0,(%rax)
   44211:	eb d5                	jmp    441e8 <vsnprintf+0x1d>

0000000000044213 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44213:	55                   	push   %rbp
   44214:	48 89 e5             	mov    %rsp,%rbp
   44217:	48 83 ec 50          	sub    $0x50,%rsp
   4421b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4421f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44223:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44227:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4422e:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44232:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44236:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4423a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
   4423e:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44242:	e8 84 ff ff ff       	callq  441cb <vsnprintf>
    va_end(val);
    return n;
}
   44247:	c9                   	leaveq 
   44248:	c3                   	retq   

0000000000044249 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44249:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4424e:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
   44253:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44258:	48 83 c0 02          	add    $0x2,%rax
   4425c:	48 39 d0             	cmp    %rdx,%rax
   4425f:	75 f2                	jne    44253 <console_clear+0xa>
    }
    cursorpos = 0;
   44261:	c7 05 91 4d 07 00 00 	movl   $0x0,0x74d91(%rip)        # b8ffc <cursorpos>
   44268:	00 00 00 
}
   4426b:	c3                   	retq   

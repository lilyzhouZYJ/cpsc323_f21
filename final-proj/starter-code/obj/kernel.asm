
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
   40028:	e9 3a 01 00 00       	jmpq   40167 <kernel>
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
   400be:	e8 3c 06 00 00       	callq  406ff <exception>

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

0000000000040167 <kernel>:

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 d7 14 00 00       	callq  4164f <hardware_init>
    pageinfo_init();
   40178:	e8 5b 0b 00 00       	callq  40cd8 <pageinfo_init>
    console_clear();
   4017d:	e8 11 39 00 00       	callq  43a93 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 b3 19 00 00       	callq  41b3f <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 20 05 00       	mov    $0x52000,%edi
   4019b:	e8 0a 30 00 00       	callq  431aa <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 00 20 05 00 	lea    0x52000(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be 26 46 04 00       	mov    $0x44626,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 10 30 00 00       	callq  4321b <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 4);
   4020f:	be 04 00 00 00       	mov    $0x4,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 b8 00 00 00       	callq  402d6 <process_setup>
   4021e:	e9 a9 00 00 00       	jmpq   402cc <kernel+0x165>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 26                	je     40250 <kernel+0xe9>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be 2d 46 04 00       	mov    $0x4462d,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 e0 2f 00 00       	callq  4321b <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 11                	jne    40250 <kernel+0xe9>
        process_setup(1, 5);
   4023f:	be 05 00 00 00       	mov    $0x5,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 88 00 00 00       	callq  402d6 <process_setup>
   4024e:	eb 7c                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test") == 0){
   40250:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40255:	74 26                	je     4027d <kernel+0x116>
   40257:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025b:	be 38 46 04 00       	mov    $0x44638,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 b3 2f 00 00       	callq  4321b <strcmp>
   40268:	85 c0                	test   %eax,%eax
   4026a:	75 11                	jne    4027d <kernel+0x116>
        process_setup(1, 6);
   4026c:	be 06 00 00 00       	mov    $0x6,%esi
   40271:	bf 01 00 00 00       	mov    $0x1,%edi
   40276:	e8 5b 00 00 00       	callq  402d6 <process_setup>
   4027b:	eb 4f                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test2") == 0) {
   4027d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40282:	74 39                	je     402bd <kernel+0x156>
   40284:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40288:	be 3d 46 04 00       	mov    $0x4463d,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 86 2f 00 00       	callq  4321b <strcmp>
   40295:	85 c0                	test   %eax,%eax
   40297:	75 24                	jne    402bd <kernel+0x156>
        for (pid_t i = 1; i <= 2; ++i) {
   40299:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a0:	eb 13                	jmp    402b5 <kernel+0x14e>
            process_setup(i, 6);
   402a2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a5:	be 06 00 00 00       	mov    $0x6,%esi
   402aa:	89 c7                	mov    %eax,%edi
   402ac:	e8 25 00 00 00       	callq  402d6 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b5:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402b9:	7e e7                	jle    402a2 <kernel+0x13b>
   402bb:	eb 0f                	jmp    402cc <kernel+0x165>
        }
    } else {
        process_setup(1, 0);
   402bd:	be 00 00 00 00       	mov    $0x0,%esi
   402c2:	bf 01 00 00 00       	mov    $0x1,%edi
   402c7:	e8 0a 00 00 00       	callq  402d6 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   402cc:	bf f0 20 05 00       	mov    $0x520f0,%edi
   402d1:	e8 71 09 00 00       	callq  40c47 <run>

00000000000402d6 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402d6:	55                   	push   %rbp
   402d7:	48 89 e5             	mov    %rsp,%rbp
   402da:	48 83 ec 10          	sub    $0x10,%rsp
   402de:	89 7d fc             	mov    %edi,-0x4(%rbp)
   402e1:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402e7:	48 63 d0             	movslq %eax,%rdx
   402ea:	48 89 d0             	mov    %rdx,%rax
   402ed:	48 c1 e0 04          	shl    $0x4,%rax
   402f1:	48 29 d0             	sub    %rdx,%rax
   402f4:	48 c1 e0 04          	shl    $0x4,%rax
   402f8:	48 05 00 20 05 00    	add    $0x52000,%rax
   402fe:	be 00 00 00 00       	mov    $0x0,%esi
   40303:	48 89 c7             	mov    %rax,%rdi
   40306:	e8 c6 1a 00 00       	callq  41dd1 <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 9c 3b 00 00       	callq  43eb1 <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba 48 46 04 00       	mov    $0x44648,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf 68 46 04 00       	mov    $0x44668,%edi
   40328:	e8 6c 22 00 00       	callq  42599 <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4032d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40330:	48 63 d0             	movslq %eax,%rdx
   40333:	48 89 d0             	mov    %rdx,%rax
   40336:	48 c1 e0 04          	shl    $0x4,%rax
   4033a:	48 29 d0             	sub    %rdx,%rax
   4033d:	48 c1 e0 04          	shl    $0x4,%rax
   40341:	48 8d 90 00 20 05 00 	lea    0x52000(%rax),%rdx
   40348:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4034b:	89 c6                	mov    %eax,%esi
   4034d:	48 89 d7             	mov    %rdx,%rdi
   40350:	e8 aa 3e 00 00       	callq  441ff <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba 78 46 04 00       	mov    $0x44678,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf 68 46 04 00       	mov    $0x44668,%edi
   40368:	e8 2c 22 00 00       	callq  42599 <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 20 05 00    	add    $0x52000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 a8 3e 00 00       	callq  44237 <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4038f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40392:	48 63 d0             	movslq %eax,%rdx
   40395:	48 89 d0             	mov    %rdx,%rax
   40398:	48 c1 e0 04          	shl    $0x4,%rax
   4039c:	48 29 d0             	sub    %rdx,%rax
   4039f:	48 c1 e0 04          	shl    $0x4,%rax
   403a3:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   403a9:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   403af:	90                   	nop
   403b0:	c9                   	leaveq 
   403b1:	c3                   	retq   

00000000000403b2 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   403b2:	55                   	push   %rbp
   403b3:	48 89 e5             	mov    %rsp,%rbp
   403b6:	48 83 ec 10          	sub    $0x10,%rsp
   403ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   403be:	89 f0                	mov    %esi,%eax
   403c0:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   403c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   403cc:	48 85 c0             	test   %rax,%rax
   403cf:	75 20                	jne    403f1 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   403d1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403d8:	00 
   403d9:	77 16                	ja     403f1 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   403db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403df:	48 c1 e8 0c          	shr    $0xc,%rax
   403e3:	48 98                	cltq   
   403e5:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   403ec:	00 
   403ed:	84 c0                	test   %al,%al
   403ef:	74 07                	je     403f8 <assign_physical_page+0x46>
        return -1;
   403f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403f6:	eb 2c                	jmp    40424 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403fc:	48 c1 e8 0c          	shr    $0xc,%rax
   40400:	48 98                	cltq   
   40402:	c6 84 00 21 2f 05 00 	movb   $0x1,0x52f21(%rax,%rax,1)
   40409:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4040a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4040e:	48 c1 e8 0c          	shr    $0xc,%rax
   40412:	48 98                	cltq   
   40414:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40418:	88 94 00 20 2f 05 00 	mov    %dl,0x52f20(%rax,%rax,1)
        return 0;
   4041f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40424:	c9                   	leaveq 
   40425:	c3                   	retq   

0000000000040426 <syscall_fork>:

pid_t syscall_fork() {
   40426:	55                   	push   %rbp
   40427:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   4042a:	48 8b 05 cf 2a 01 00 	mov    0x12acf(%rip),%rax        # 52f00 <current>
   40431:	48 89 c7             	mov    %rax,%rdi
   40434:	e8 b1 3e 00 00       	callq  442ea <process_fork>
}
   40439:	5d                   	pop    %rbp
   4043a:	c3                   	retq   

000000000004043b <syscall_exit>:


void syscall_exit() {
   4043b:	55                   	push   %rbp
   4043c:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   4043f:	48 8b 05 ba 2a 01 00 	mov    0x12aba(%rip),%rax        # 52f00 <current>
   40446:	8b 00                	mov    (%rax),%eax
   40448:	89 c7                	mov    %eax,%edi
   4044a:	e8 80 37 00 00       	callq  43bcf <process_free>
}
   4044f:	90                   	nop
   40450:	5d                   	pop    %rbp
   40451:	c3                   	retq   

0000000000040452 <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   40452:	55                   	push   %rbp
   40453:	48 89 e5             	mov    %rsp,%rbp
   40456:	48 83 ec 10          	sub    $0x10,%rsp
   4045a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4045e:	48 8b 05 9b 2a 01 00 	mov    0x12a9b(%rip),%rax        # 52f00 <current>
   40465:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40469:	48 89 d6             	mov    %rdx,%rsi
   4046c:	48 89 c7             	mov    %rax,%rdi
   4046f:	e8 08 41 00 00       	callq  4457c <process_page_alloc>
}
   40474:	c9                   	leaveq 
   40475:	c3                   	retq   

0000000000040476 <sbrk>:


int sbrk(proc * p, intptr_t difference) {
   40476:	55                   	push   %rbp
   40477:	48 89 e5             	mov    %rsp,%rbp
   4047a:	48 83 ec 40          	sub    $0x40,%rsp
   4047e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   40482:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    log_printf("called sbrk(%d)\n", difference);
   40486:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4048a:	48 89 c6             	mov    %rax,%rsi
   4048d:	bf ab 46 04 00       	mov    $0x446ab,%edi
   40492:	b8 00 00 00 00       	mov    $0x0,%eax
   40497:	e8 df 1d 00 00       	callq  4227b <log_printf>
    // TODO : Your code here

    // check if new break is below start of heap or above stack
    uintptr_t new_break = p->program_break + difference;
   4049c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404a0:	48 8b 50 08          	mov    0x8(%rax),%rdx
   404a4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   404a8:	48 01 d0             	add    %rdx,%rax
   404ab:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(new_break < p->original_break || new_break > MEMSIZE_VIRTUAL-PAGESIZE)
   404af:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404b3:	48 8b 40 10          	mov    0x10(%rax),%rax
   404b7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   404bb:	72 0a                	jb     404c7 <sbrk+0x51>
   404bd:	48 81 7d f0 00 f0 2f 	cmpq   $0x2ff000,-0x10(%rbp)
   404c4:	00 
   404c5:	76 0a                	jbe    404d1 <sbrk+0x5b>
        return -1;
   404c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   404cc:	e9 fa 00 00 00       	jmpq   405cb <sbrk+0x155>

    // unmap pages if the heap has been contracted
    if(difference < 0) {
   404d1:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   404d6:	0f 89 c8 00 00 00    	jns    405a4 <sbrk+0x12e>
        log_printf("heap contracting!\n");
   404dc:	bf bc 46 04 00       	mov    $0x446bc,%edi
   404e1:	b8 00 00 00 00       	mov    $0x0,%eax
   404e6:	e8 90 1d 00 00       	callq  4227b <log_printf>
        x86_64_pagetable * pt = p->p_pagetable;
   404eb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404ef:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   404f6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        uintptr_t addr = new_break;
   404fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   404fe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        // page align: only unmap pages that no longer overlap with heap
        if(addr % PAGESIZE != 0)
   40502:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40506:	25 ff 0f 00 00       	and    $0xfff,%eax
   4050b:	48 85 c0             	test   %rax,%rax
   4050e:	0f 84 82 00 00 00    	je     40596 <sbrk+0x120>
            addr = (addr & ~(PAGESIZE - 1)) + PAGESIZE;
   40514:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40518:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4051e:	48 05 00 10 00 00    	add    $0x1000,%rax
   40524:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        for( ; addr < p->program_break; addr += PAGESIZE) {
   40528:	eb 6c                	jmp    40596 <sbrk+0x120>
            vamapping map = virtual_memory_lookup(pt, addr);
   4052a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4052e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40532:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   40536:	48 89 ce             	mov    %rcx,%rsi
   40539:	48 89 c7             	mov    %rax,%rdi
   4053c:	e8 1a 27 00 00       	callq  42c5b <virtual_memory_lookup>
            if(map.pn != -1) {
   40541:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40544:	83 f8 ff             	cmp    $0xffffffff,%eax
   40547:	74 45                	je     4058e <sbrk+0x118>
                // unmap the page
                virtual_memory_map(pt, addr, map.pa, PAGESIZE, PTE_W | PTE_U);
   40549:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   4054d:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40551:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40555:	41 b8 06 00 00 00    	mov    $0x6,%r8d
   4055b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40560:	48 89 c7             	mov    %rax,%rdi
   40563:	e8 30 23 00 00       	callq  42898 <virtual_memory_map>
                // free page
                pageinfo[PAGENUMBER(map.pn)].refcount = 0;
   40568:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4056b:	48 98                	cltq   
   4056d:	48 c1 e8 0c          	shr    $0xc,%rax
   40571:	48 98                	cltq   
   40573:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   4057a:	00 
                pageinfo[PAGENUMBER(map.pn)].owner = PO_FREE;
   4057b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4057e:	48 98                	cltq   
   40580:	48 c1 e8 0c          	shr    $0xc,%rax
   40584:	48 98                	cltq   
   40586:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   4058d:	00 
        for( ; addr < p->program_break; addr += PAGESIZE) {
   4058e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40595:	00 
   40596:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4059a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4059e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   405a2:	72 86                	jb     4052a <sbrk+0xb4>
            }
        }
    }

    p->program_break = new_break;
   405a4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   405a8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   405ac:	48 89 50 08          	mov    %rdx,0x8(%rax)
    log_printf("new heap break is %x\n", new_break);
   405b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   405b4:	48 89 c6             	mov    %rax,%rsi
   405b7:	bf cf 46 04 00       	mov    $0x446cf,%edi
   405bc:	b8 00 00 00 00       	mov    $0x0,%eax
   405c1:	e8 b5 1c 00 00       	callq  4227b <log_printf>

    return 0;
   405c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
   405cb:	c9                   	leaveq 
   405cc:	c3                   	retq   

00000000000405cd <syscall_mapping>:


void syscall_mapping(proc* p){
   405cd:	55                   	push   %rbp
   405ce:	48 89 e5             	mov    %rsp,%rbp
   405d1:	48 83 ec 70          	sub    $0x70,%rsp
   405d5:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   405d9:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405dd:	48 8b 40 48          	mov    0x48(%rax),%rax
   405e1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   405e5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405e9:	48 8b 40 40          	mov    0x40(%rax),%rax
   405ed:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   405f1:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405f5:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   405fc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40600:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40604:	48 89 ce             	mov    %rcx,%rsi
   40607:	48 89 c7             	mov    %rax,%rdi
   4060a:	e8 4c 26 00 00       	callq  42c5b <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   4060f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40612:	48 98                	cltq   
   40614:	83 e0 06             	and    $0x6,%eax
   40617:	48 83 f8 06          	cmp    $0x6,%rax
   4061b:	75 73                	jne    40690 <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   4061d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40621:	48 83 c0 17          	add    $0x17,%rax
   40625:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40629:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4062d:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40634:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40638:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4063c:	48 89 ce             	mov    %rcx,%rsi
   4063f:	48 89 c7             	mov    %rax,%rdi
   40642:	e8 14 26 00 00       	callq  42c5b <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40647:	8b 45 c8             	mov    -0x38(%rbp),%eax
   4064a:	48 98                	cltq   
   4064c:	83 e0 03             	and    $0x3,%eax
   4064f:	48 83 f8 03          	cmp    $0x3,%rax
   40653:	75 3e                	jne    40693 <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40655:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40659:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40660:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40664:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40668:	48 89 ce             	mov    %rcx,%rsi
   4066b:	48 89 c7             	mov    %rax,%rdi
   4066e:	e8 e8 25 00 00       	callq  42c5b <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40673:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40677:	48 89 c1             	mov    %rax,%rcx
   4067a:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4067e:	ba 18 00 00 00       	mov    $0x18,%edx
   40683:	48 89 c6             	mov    %rax,%rsi
   40686:	48 89 cf             	mov    %rcx,%rdi
   40689:	e8 b3 2a 00 00       	callq  43141 <memcpy>
   4068e:	eb 04                	jmp    40694 <syscall_mapping+0xc7>
	return;
   40690:	90                   	nop
   40691:	eb 01                	jmp    40694 <syscall_mapping+0xc7>
	return;
   40693:	90                   	nop
}
   40694:	c9                   	leaveq 
   40695:	c3                   	retq   

0000000000040696 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40696:	55                   	push   %rbp
   40697:	48 89 e5             	mov    %rsp,%rbp
   4069a:	48 83 ec 18          	sub    $0x18,%rsp
   4069e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   406a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406a6:	48 8b 40 48          	mov    0x48(%rax),%rax
   406aa:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   406ad:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   406b1:	75 14                	jne    406c7 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   406b3:	0f b6 05 46 59 00 00 	movzbl 0x5946(%rip),%eax        # 46000 <disp_global>
   406ba:	84 c0                	test   %al,%al
   406bc:	0f 94 c0             	sete   %al
   406bf:	88 05 3b 59 00 00    	mov    %al,0x593b(%rip)        # 46000 <disp_global>
   406c5:	eb 36                	jmp    406fd <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   406c7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   406cb:	78 2f                	js     406fc <syscall_mem_tog+0x66>
   406cd:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   406d1:	7f 29                	jg     406fc <syscall_mem_tog+0x66>
   406d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406d7:	8b 00                	mov    (%rax),%eax
   406d9:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   406dc:	75 1e                	jne    406fc <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   406de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406e2:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   406e9:	84 c0                	test   %al,%al
   406eb:	0f 94 c0             	sete   %al
   406ee:	89 c2                	mov    %eax,%edx
   406f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406f4:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   406fa:	eb 01                	jmp    406fd <syscall_mem_tog+0x67>
            return;
   406fc:	90                   	nop
    }
}
   406fd:	c9                   	leaveq 
   406fe:	c3                   	retq   

00000000000406ff <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   406ff:	55                   	push   %rbp
   40700:	48 89 e5             	mov    %rsp,%rbp
   40703:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
   4070a:	48 89 bd d8 fe ff ff 	mov    %rdi,-0x128(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40711:	48 8b 05 e8 27 01 00 	mov    0x127e8(%rip),%rax        # 52f00 <current>
   40718:	48 8b 95 d8 fe ff ff 	mov    -0x128(%rbp),%rdx
   4071f:	48 83 c0 18          	add    $0x18,%rax
   40723:	48 89 d6             	mov    %rdx,%rsi
   40726:	ba 18 00 00 00       	mov    $0x18,%edx
   4072b:	48 89 c7             	mov    %rax,%rdi
   4072e:	48 89 d1             	mov    %rdx,%rcx
   40731:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40734:	48 8b 05 c5 48 01 00 	mov    0x148c5(%rip),%rax        # 55000 <kernel_pagetable>
   4073b:	48 89 c7             	mov    %rax,%rdi
   4073e:	e8 24 20 00 00       	callq  42767 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40743:	8b 05 b3 88 07 00    	mov    0x788b3(%rip),%eax        # b8ffc <cursorpos>
   40749:	89 c7                	mov    %eax,%edi
   4074b:	e8 4b 17 00 00       	callq  41e9b <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   40750:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40757:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4075e:	48 83 f8 0e          	cmp    $0xe,%rax
   40762:	74 14                	je     40778 <exception+0x79>
	    && reg->reg_intno != INT_GPF)
   40764:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   4076b:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40772:	48 83 f8 0d          	cmp    $0xd,%rax
   40776:	75 16                	jne    4078e <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   40778:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   4077f:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40786:	83 e0 04             	and    $0x4,%eax
   40789:	48 85 c0             	test   %rax,%rax
   4078c:	74 1a                	je     407a8 <exception+0xa9>
        check_virtual_memory();
   4078e:	e8 dc 08 00 00       	callq  4106f <check_virtual_memory>
        if(disp_global){
   40793:	0f b6 05 66 58 00 00 	movzbl 0x5866(%rip),%eax        # 46000 <disp_global>
   4079a:	84 c0                	test   %al,%al
   4079c:	74 0a                	je     407a8 <exception+0xa9>
            memshow_physical();
   4079e:	e8 44 0a 00 00       	callq  411e7 <memshow_physical>
            memshow_virtual_animate();
   407a3:	e8 6a 0d 00 00       	callq  41512 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   407a8:	e8 cb 1b 00 00       	callq  42378 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   407ad:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   407b4:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407bb:	48 83 e8 0e          	sub    $0xe,%rax
   407bf:	48 83 f8 2c          	cmp    $0x2c,%rax
   407c3:	0f 87 d3 03 00 00    	ja     40b9c <exception+0x49d>
   407c9:	48 8b 04 c5 98 47 04 	mov    0x44798(,%rax,8),%rax
   407d0:	00 
   407d1:	ff e0                	jmpq   *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   407d3:	48 8b 05 26 27 01 00 	mov    0x12726(%rip),%rax        # 52f00 <current>
   407da:	48 8b 40 48          	mov    0x48(%rax),%rax
   407de:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
                    if((void *)addr == NULL)
   407e2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   407e7:	75 0f                	jne    407f8 <exception+0xf9>
                        kernel_panic(NULL);
   407e9:	bf 00 00 00 00       	mov    $0x0,%edi
   407ee:	b8 00 00 00 00       	mov    $0x0,%eax
   407f3:	e8 c1 1c 00 00       	callq  424b9 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   407f8:	48 8b 05 01 27 01 00 	mov    0x12701(%rip),%rax        # 52f00 <current>
   407ff:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40806:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   4080a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   4080e:	48 89 ce             	mov    %rcx,%rsi
   40811:	48 89 c7             	mov    %rax,%rdi
   40814:	e8 42 24 00 00       	callq  42c5b <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   40819:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4081d:	48 89 c1             	mov    %rax,%rcx
   40820:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
   40827:	ba a0 00 00 00       	mov    $0xa0,%edx
   4082c:	48 89 ce             	mov    %rcx,%rsi
   4082f:	48 89 c7             	mov    %rax,%rdi
   40832:	e8 0a 29 00 00       	callq  43141 <memcpy>
                    kernel_panic(msg);
   40837:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
   4083e:	48 89 c7             	mov    %rax,%rdi
   40841:	b8 00 00 00 00       	mov    $0x0,%eax
   40846:	e8 6e 1c 00 00       	callq  424b9 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   4084b:	48 8b 05 ae 26 01 00 	mov    0x126ae(%rip),%rax        # 52f00 <current>
   40852:	8b 10                	mov    (%rax),%edx
   40854:	48 8b 05 a5 26 01 00 	mov    0x126a5(%rip),%rax        # 52f00 <current>
   4085b:	48 63 d2             	movslq %edx,%rdx
   4085e:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40862:	e9 45 03 00 00       	jmpq   40bac <exception+0x4ad>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   40867:	b8 00 00 00 00       	mov    $0x0,%eax
   4086c:	e8 b5 fb ff ff       	callq  40426 <syscall_fork>
   40871:	89 c2                	mov    %eax,%edx
   40873:	48 8b 05 86 26 01 00 	mov    0x12686(%rip),%rax        # 52f00 <current>
   4087a:	48 63 d2             	movslq %edx,%rdx
   4087d:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40881:	e9 26 03 00 00       	jmpq   40bac <exception+0x4ad>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   40886:	48 8b 05 73 26 01 00 	mov    0x12673(%rip),%rax        # 52f00 <current>
   4088d:	48 89 c7             	mov    %rax,%rdi
   40890:	e8 38 fd ff ff       	callq  405cd <syscall_mapping>
                break;
   40895:	e9 12 03 00 00       	jmpq   40bac <exception+0x4ad>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   4089a:	b8 00 00 00 00       	mov    $0x0,%eax
   4089f:	e8 97 fb ff ff       	callq  4043b <syscall_exit>
                schedule();
   408a4:	e8 2c 03 00 00       	callq  40bd5 <schedule>
                break;
   408a9:	e9 fe 02 00 00       	jmpq   40bac <exception+0x4ad>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   408ae:	e8 22 03 00 00       	callq  40bd5 <schedule>
                break;                  /* will not be reached */
   408b3:	e9 f4 02 00 00       	jmpq   40bac <exception+0x4ad>
            }

        case INT_SYS_BRK:
            {
                // TODO : Your code here
                uintptr_t diff = reg->reg_rdi - current->program_break;
   408b8:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   408bf:	48 8b 50 30          	mov    0x30(%rax),%rdx
   408c3:	48 8b 05 36 26 01 00 	mov    0x12636(%rip),%rax        # 52f00 <current>
   408ca:	48 8b 48 08          	mov    0x8(%rax),%rcx
   408ce:	48 89 d0             	mov    %rdx,%rax
   408d1:	48 29 c8             	sub    %rcx,%rax
   408d4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
                if(sbrk(current, diff) == -1)
   408d8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   408dc:	48 8b 05 1d 26 01 00 	mov    0x1261d(%rip),%rax        # 52f00 <current>
   408e3:	48 89 d6             	mov    %rdx,%rsi
   408e6:	48 89 c7             	mov    %rax,%rdi
   408e9:	e8 88 fb ff ff       	callq  40476 <sbrk>
   408ee:	83 f8 ff             	cmp    $0xffffffff,%eax
   408f1:	75 14                	jne    40907 <exception+0x208>
                    current->p_registers.reg_rax = -1;
   408f3:	48 8b 05 06 26 01 00 	mov    0x12606(%rip),%rax        # 52f00 <current>
   408fa:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   40901:	ff 
                else
                    current->p_registers.reg_rax = 0;

		        break;
   40902:	e9 a5 02 00 00       	jmpq   40bac <exception+0x4ad>
                    current->p_registers.reg_rax = 0;
   40907:	48 8b 05 f2 25 01 00 	mov    0x125f2(%rip),%rax        # 52f00 <current>
   4090e:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
   40915:	00 
		        break;
   40916:	e9 91 02 00 00       	jmpq   40bac <exception+0x4ad>
            }

        case INT_SYS_SBRK:
            {
                // TODO : Your code here
                uintptr_t orig_break = current->program_break;
   4091b:	48 8b 05 de 25 01 00 	mov    0x125de(%rip),%rax        # 52f00 <current>
   40922:	48 8b 40 08          	mov    0x8(%rax),%rax
   40926:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
                uintptr_t diff = reg->reg_rdi;
   4092a:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40931:	48 8b 40 30          	mov    0x30(%rax),%rax
   40935:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

                if(sbrk(current, diff) == -1)
   40939:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4093d:	48 8b 05 bc 25 01 00 	mov    0x125bc(%rip),%rax        # 52f00 <current>
   40944:	48 89 d6             	mov    %rdx,%rsi
   40947:	48 89 c7             	mov    %rax,%rdi
   4094a:	e8 27 fb ff ff       	callq  40476 <sbrk>
   4094f:	83 f8 ff             	cmp    $0xffffffff,%eax
   40952:	75 14                	jne    40968 <exception+0x269>
                    current->p_registers.reg_rax = -1;
   40954:	48 8b 05 a5 25 01 00 	mov    0x125a5(%rip),%rax        # 52f00 <current>
   4095b:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   40962:	ff 
                else
                    current->p_registers.reg_rax = orig_break;

                break;
   40963:	e9 44 02 00 00       	jmpq   40bac <exception+0x4ad>
                    current->p_registers.reg_rax = orig_break;
   40968:	48 8b 05 91 25 01 00 	mov    0x12591(%rip),%rax        # 52f00 <current>
   4096f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40973:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40977:	e9 30 02 00 00       	jmpq   40bac <exception+0x4ad>
            }
	    case INT_SYS_PAGE_ALLOC:
            {
                intptr_t addr = reg->reg_rdi;
   4097c:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40983:	48 8b 40 30          	mov    0x30(%rax),%rax
   40987:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
                syscall_page_alloc(addr);
   4098b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4098f:	48 89 c7             	mov    %rax,%rdi
   40992:	e8 bb fa ff ff       	callq  40452 <syscall_page_alloc>
                break;
   40997:	e9 10 02 00 00       	jmpq   40bac <exception+0x4ad>
            }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   4099c:	48 8b 05 5d 25 01 00 	mov    0x1255d(%rip),%rax        # 52f00 <current>
   409a3:	48 89 c7             	mov    %rax,%rdi
   409a6:	e8 eb fc ff ff       	callq  40696 <syscall_mem_tog>
                break;
   409ab:	e9 fc 01 00 00       	jmpq   40bac <exception+0x4ad>
            }

        case INT_TIMER:
            {
                ++ticks;
   409b0:	8b 05 6a 29 01 00    	mov    0x1296a(%rip),%eax        # 53320 <ticks>
   409b6:	83 c0 01             	add    $0x1,%eax
   409b9:	89 05 61 29 01 00    	mov    %eax,0x12961(%rip)        # 53320 <ticks>
                schedule();
   409bf:	e8 11 02 00 00       	callq  40bd5 <schedule>
                break;                  /* will not be reached */
   409c4:	e9 e3 01 00 00       	jmpq   40bac <exception+0x4ad>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   409c9:	0f 20 d0             	mov    %cr2,%rax
   409cc:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    return val;
   409d0:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                uintptr_t addr = rcr2();    // faulting address
   409d4:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

                // TODO: check if addr is in heap
                if(addr < current->program_break && addr >= current->original_break) {
   409d8:	48 8b 05 21 25 01 00 	mov    0x12521(%rip),%rax        # 52f00 <current>
   409df:	48 8b 40 08          	mov    0x8(%rax),%rax
   409e3:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   409e7:	0f 83 b9 00 00 00    	jae    40aa6 <exception+0x3a7>
   409ed:	48 8b 05 0c 25 01 00 	mov    0x1250c(%rip),%rax        # 52f00 <current>
   409f4:	48 8b 40 10          	mov    0x10(%rax),%rax
   409f8:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   409fc:	0f 82 a4 00 00 00    	jb     40aa6 <exception+0x3a7>
                    // page align
                    addr = addr & ~(PAGESIZE - 1);
   40a02:	48 81 65 d0 00 f0 ff 	andq   $0xfffffffffffff000,-0x30(%rbp)
   40a09:	ff 
                    // find physical page
                    uintptr_t page = (uintptr_t) palloc(current->p_pid);
   40a0a:	48 8b 05 ef 24 01 00 	mov    0x124ef(%rip),%rax        # 52f00 <current>
   40a11:	8b 00                	mov    (%rax),%eax
   40a13:	89 c7                	mov    %eax,%edi
   40a15:	e8 9c 30 00 00       	callq  43ab6 <palloc>
   40a1a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
                    if(page == 0)
   40a1e:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40a23:	75 0a                	jne    40a2f <exception+0x330>
                        syscall_exit();
   40a25:	b8 00 00 00 00       	mov    $0x0,%eax
   40a2a:	e8 0c fa ff ff       	callq  4043b <syscall_exit>
                    // map to the physical page
                    if(virtual_memory_map(current->p_pagetable, addr, page, PAGESIZE, 
   40a2f:	48 8b 05 ca 24 01 00 	mov    0x124ca(%rip),%rax        # 52f00 <current>
   40a36:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40a3d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40a41:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40a45:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40a4b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40a50:	48 89 c7             	mov    %rax,%rdi
   40a53:	e8 40 1e 00 00       	callq  42898 <virtual_memory_map>
   40a58:	85 c0                	test   %eax,%eax
   40a5a:	79 0a                	jns    40a66 <exception+0x367>
                                    PTE_P | PTE_W | PTE_U) < 0)
                        syscall_exit();
   40a5c:	b8 00 00 00 00       	mov    $0x0,%eax
   40a61:	e8 d5 f9 ff ff       	callq  4043b <syscall_exit>
                    log_printf("allocated physical page %x for %x\n", page, addr);
   40a66:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40a6a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40a6e:	48 89 c6             	mov    %rax,%rsi
   40a71:	bf e8 46 04 00       	mov    $0x446e8,%edi
   40a76:	b8 00 00 00 00       	mov    $0x0,%eax
   40a7b:	e8 fb 17 00 00       	callq  4227b <log_printf>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40a80:	48 8b 05 79 24 01 00 	mov    0x12479(%rip),%rax        # 52f00 <current>
   40a87:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40a8e:	48 8d 45 80          	lea    -0x80(%rbp),%rax
   40a92:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40a96:	48 89 ce             	mov    %rcx,%rsi
   40a99:	48 89 c7             	mov    %rax,%rdi
   40a9c:	e8 ba 21 00 00       	callq  42c5b <virtual_memory_lookup>
                    break;
   40aa1:	e9 06 01 00 00       	jmpq   40bac <exception+0x4ad>
                }

                // Analyze faulting address and access type.
                const char* operation = reg->reg_err & PFERR_WRITE
   40aa6:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40aad:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ab4:	83 e0 02             	and    $0x2,%eax
                    ? "write" : "read";
   40ab7:	48 85 c0             	test   %rax,%rax
   40aba:	74 07                	je     40ac3 <exception+0x3c4>
   40abc:	b8 0b 47 04 00       	mov    $0x4470b,%eax
   40ac1:	eb 05                	jmp    40ac8 <exception+0x3c9>
   40ac3:	b8 11 47 04 00       	mov    $0x44711,%eax
                const char* operation = reg->reg_err & PFERR_WRITE
   40ac8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
                const char* problem = reg->reg_err & PFERR_PRESENT
   40acc:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40ad3:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ada:	83 e0 01             	and    $0x1,%eax
                    ? "protection problem" : "missing page";
   40add:	48 85 c0             	test   %rax,%rax
   40ae0:	74 07                	je     40ae9 <exception+0x3ea>
   40ae2:	b8 16 47 04 00       	mov    $0x44716,%eax
   40ae7:	eb 05                	jmp    40aee <exception+0x3ef>
   40ae9:	b8 29 47 04 00       	mov    $0x44729,%eax
                const char* problem = reg->reg_err & PFERR_PRESENT
   40aee:	48 89 45 b8          	mov    %rax,-0x48(%rbp)

                if (!(reg->reg_err & PFERR_USER)) {
   40af2:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40af9:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b00:	83 e0 04             	and    $0x4,%eax
   40b03:	48 85 c0             	test   %rax,%rax
   40b06:	75 2f                	jne    40b37 <exception+0x438>
                    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40b08:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40b0f:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40b16:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40b1a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   40b1e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40b22:	49 89 f0             	mov    %rsi,%r8
   40b25:	48 89 c6             	mov    %rax,%rsi
   40b28:	bf 38 47 04 00       	mov    $0x44738,%edi
   40b2d:	b8 00 00 00 00       	mov    $0x0,%eax
   40b32:	e8 82 19 00 00       	callq  424b9 <kernel_panic>
                            addr, operation, problem, reg->reg_rip);
                }
                console_printf(CPOS(24, 0), 0x0C00,
   40b37:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40b3e:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                        "Process %d page fault for %p (%s %s, rip=%p)!\n",
                        current->p_pid, addr, operation, problem, reg->reg_rip);
   40b45:	48 8b 05 b4 23 01 00 	mov    0x123b4(%rip),%rax        # 52f00 <current>
                console_printf(CPOS(24, 0), 0x0C00,
   40b4c:	8b 00                	mov    (%rax),%eax
   40b4e:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
   40b52:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40b56:	52                   	push   %rdx
   40b57:	ff 75 b8             	pushq  -0x48(%rbp)
   40b5a:	49 89 f1             	mov    %rsi,%r9
   40b5d:	49 89 c8             	mov    %rcx,%r8
   40b60:	89 c1                	mov    %eax,%ecx
   40b62:	ba 68 47 04 00       	mov    $0x44768,%edx
   40b67:	be 00 0c 00 00       	mov    $0xc00,%esi
   40b6c:	bf 80 07 00 00       	mov    $0x780,%edi
   40b71:	b8 00 00 00 00       	mov    $0x0,%eax
   40b76:	e8 64 2e 00 00       	callq  439df <console_printf>
   40b7b:	48 83 c4 10          	add    $0x10,%rsp
                current->p_state = P_BROKEN;
   40b7f:	48 8b 05 7a 23 01 00 	mov    0x1237a(%rip),%rax        # 52f00 <current>
   40b86:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40b8d:	00 00 00 
                syscall_exit();
   40b90:	b8 00 00 00 00       	mov    $0x0,%eax
   40b95:	e8 a1 f8 ff ff       	callq  4043b <syscall_exit>
                break;
   40b9a:	eb 10                	jmp    40bac <exception+0x4ad>
            }

        default:
            default_exception(current);
   40b9c:	48 8b 05 5d 23 01 00 	mov    0x1235d(%rip),%rax        # 52f00 <current>
   40ba3:	48 89 c7             	mov    %rax,%rdi
   40ba6:	e8 1e 1a 00 00       	callq  425c9 <default_exception>
            break;                  /* will not be reached */
   40bab:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40bac:	48 8b 05 4d 23 01 00 	mov    0x1234d(%rip),%rax        # 52f00 <current>
   40bb3:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40bb9:	83 f8 01             	cmp    $0x1,%eax
   40bbc:	75 0f                	jne    40bcd <exception+0x4ce>
        run(current);
   40bbe:	48 8b 05 3b 23 01 00 	mov    0x1233b(%rip),%rax        # 52f00 <current>
   40bc5:	48 89 c7             	mov    %rax,%rdi
   40bc8:	e8 7a 00 00 00       	callq  40c47 <run>
    } else {
        schedule();
   40bcd:	e8 03 00 00 00       	callq  40bd5 <schedule>
    }
}
   40bd2:	90                   	nop
   40bd3:	c9                   	leaveq 
   40bd4:	c3                   	retq   

0000000000040bd5 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40bd5:	55                   	push   %rbp
   40bd6:	48 89 e5             	mov    %rsp,%rbp
   40bd9:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40bdd:	48 8b 05 1c 23 01 00 	mov    0x1231c(%rip),%rax        # 52f00 <current>
   40be4:	8b 00                	mov    (%rax),%eax
   40be6:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40be9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bec:	83 c0 01             	add    $0x1,%eax
   40bef:	99                   	cltd   
   40bf0:	c1 ea 1c             	shr    $0x1c,%edx
   40bf3:	01 d0                	add    %edx,%eax
   40bf5:	83 e0 0f             	and    $0xf,%eax
   40bf8:	29 d0                	sub    %edx,%eax
   40bfa:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40bfd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c00:	48 63 d0             	movslq %eax,%rdx
   40c03:	48 89 d0             	mov    %rdx,%rax
   40c06:	48 c1 e0 04          	shl    $0x4,%rax
   40c0a:	48 29 d0             	sub    %rdx,%rax
   40c0d:	48 c1 e0 04          	shl    $0x4,%rax
   40c11:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   40c17:	8b 00                	mov    (%rax),%eax
   40c19:	83 f8 01             	cmp    $0x1,%eax
   40c1c:	75 22                	jne    40c40 <schedule+0x6b>
            run(&processes[pid]);
   40c1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c21:	48 63 d0             	movslq %eax,%rdx
   40c24:	48 89 d0             	mov    %rdx,%rax
   40c27:	48 c1 e0 04          	shl    $0x4,%rax
   40c2b:	48 29 d0             	sub    %rdx,%rax
   40c2e:	48 c1 e0 04          	shl    $0x4,%rax
   40c32:	48 05 00 20 05 00    	add    $0x52000,%rax
   40c38:	48 89 c7             	mov    %rax,%rdi
   40c3b:	e8 07 00 00 00       	callq  40c47 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40c40:	e8 33 17 00 00       	callq  42378 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40c45:	eb a2                	jmp    40be9 <schedule+0x14>

0000000000040c47 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40c47:	55                   	push   %rbp
   40c48:	48 89 e5             	mov    %rsp,%rbp
   40c4b:	48 83 ec 10          	sub    $0x10,%rsp
   40c4f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40c53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c57:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c5d:	83 f8 01             	cmp    $0x1,%eax
   40c60:	74 14                	je     40c76 <run+0x2f>
   40c62:	ba 00 49 04 00       	mov    $0x44900,%edx
   40c67:	be b7 01 00 00       	mov    $0x1b7,%esi
   40c6c:	bf 68 46 04 00       	mov    $0x44668,%edi
   40c71:	e8 23 19 00 00       	callq  42599 <assert_fail>
    current = p;
   40c76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c7a:	48 89 05 7f 22 01 00 	mov    %rax,0x1227f(%rip)        # 52f00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40c81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c85:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40c87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c8b:	8b 00                	mov    (%rax),%eax
   40c8d:	83 c0 02             	add    $0x2,%eax
   40c90:	48 98                	cltq   
   40c92:	0f b7 84 00 00 46 04 	movzwl 0x44600(%rax,%rax,1),%eax
   40c99:	00 
    console_printf(CPOS(24, 79),
   40c9a:	0f b7 c0             	movzwl %ax,%eax
   40c9d:	89 d1                	mov    %edx,%ecx
   40c9f:	ba 19 49 04 00       	mov    $0x44919,%edx
   40ca4:	89 c6                	mov    %eax,%esi
   40ca6:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40cab:	b8 00 00 00 00       	mov    $0x0,%eax
   40cb0:	e8 2a 2d 00 00       	callq  439df <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40cb5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cb9:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40cc0:	48 89 c7             	mov    %rax,%rdi
   40cc3:	e8 9f 1a 00 00       	callq  42767 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40cc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ccc:	48 83 c0 18          	add    $0x18,%rax
   40cd0:	48 89 c7             	mov    %rax,%rdi
   40cd3:	e8 eb f3 ff ff       	callq  400c3 <exception_return>

0000000000040cd8 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40cd8:	55                   	push   %rbp
   40cd9:	48 89 e5             	mov    %rsp,%rbp
   40cdc:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40ce0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40ce7:	00 
   40ce8:	e9 81 00 00 00       	jmpq   40d6e <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40ced:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cf1:	48 89 c7             	mov    %rax,%rdi
   40cf4:	e8 13 0f 00 00       	callq  41c0c <physical_memory_isreserved>
   40cf9:	85 c0                	test   %eax,%eax
   40cfb:	74 09                	je     40d06 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40cfd:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40d04:	eb 2f                	jmp    40d35 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40d06:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40d0d:	00 
   40d0e:	76 0b                	jbe    40d1b <pageinfo_init+0x43>
   40d10:	b8 10 b0 05 00       	mov    $0x5b010,%eax
   40d15:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d19:	72 0a                	jb     40d25 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40d1b:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40d22:	00 
   40d23:	75 09                	jne    40d2e <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40d25:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40d2c:	eb 07                	jmp    40d35 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40d2e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40d35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d39:	48 c1 e8 0c          	shr    $0xc,%rax
   40d3d:	89 c1                	mov    %eax,%ecx
   40d3f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40d42:	89 c2                	mov    %eax,%edx
   40d44:	48 63 c1             	movslq %ecx,%rax
   40d47:	88 94 00 20 2f 05 00 	mov    %dl,0x52f20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40d4e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40d52:	0f 95 c2             	setne  %dl
   40d55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d59:	48 c1 e8 0c          	shr    $0xc,%rax
   40d5d:	48 98                	cltq   
   40d5f:	88 94 00 21 2f 05 00 	mov    %dl,0x52f21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d66:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d6d:	00 
   40d6e:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40d75:	00 
   40d76:	0f 86 71 ff ff ff    	jbe    40ced <pageinfo_init+0x15>
    }
}
   40d7c:	90                   	nop
   40d7d:	90                   	nop
   40d7e:	c9                   	leaveq 
   40d7f:	c3                   	retq   

0000000000040d80 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40d80:	55                   	push   %rbp
   40d81:	48 89 e5             	mov    %rsp,%rbp
   40d84:	48 83 ec 50          	sub    $0x50,%rsp
   40d88:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40d8c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d90:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40d96:	48 89 c2             	mov    %rax,%rdx
   40d99:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d9d:	48 39 c2             	cmp    %rax,%rdx
   40da0:	74 14                	je     40db6 <check_page_table_mappings+0x36>
   40da2:	ba 20 49 04 00       	mov    $0x44920,%edx
   40da7:	be e5 01 00 00       	mov    $0x1e5,%esi
   40dac:	bf 68 46 04 00       	mov    $0x44668,%edi
   40db1:	e8 e3 17 00 00       	callq  42599 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40db6:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40dbd:	00 
   40dbe:	e9 9a 00 00 00       	jmpq   40e5d <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40dc3:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40dc7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40dcb:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40dcf:	48 89 ce             	mov    %rcx,%rsi
   40dd2:	48 89 c7             	mov    %rax,%rdi
   40dd5:	e8 81 1e 00 00       	callq  42c5b <virtual_memory_lookup>
        if (vam.pa != va) {
   40dda:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40dde:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40de2:	74 27                	je     40e0b <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40de4:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40de8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dec:	49 89 d0             	mov    %rdx,%r8
   40def:	48 89 c1             	mov    %rax,%rcx
   40df2:	ba 3f 49 04 00       	mov    $0x4493f,%edx
   40df7:	be 00 c0 00 00       	mov    $0xc000,%esi
   40dfc:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40e01:	b8 00 00 00 00       	mov    $0x0,%eax
   40e06:	e8 d4 2b 00 00       	callq  439df <console_printf>
        }
        assert(vam.pa == va);
   40e0b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e0f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e13:	74 14                	je     40e29 <check_page_table_mappings+0xa9>
   40e15:	ba 49 49 04 00       	mov    $0x44949,%edx
   40e1a:	be ee 01 00 00       	mov    $0x1ee,%esi
   40e1f:	bf 68 46 04 00       	mov    $0x44668,%edi
   40e24:	e8 70 17 00 00       	callq  42599 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40e29:	b8 00 60 04 00       	mov    $0x46000,%eax
   40e2e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e32:	72 21                	jb     40e55 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40e34:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40e37:	48 98                	cltq   
   40e39:	83 e0 02             	and    $0x2,%eax
   40e3c:	48 85 c0             	test   %rax,%rax
   40e3f:	75 14                	jne    40e55 <check_page_table_mappings+0xd5>
   40e41:	ba 56 49 04 00       	mov    $0x44956,%edx
   40e46:	be f0 01 00 00       	mov    $0x1f0,%esi
   40e4b:	bf 68 46 04 00       	mov    $0x44668,%edi
   40e50:	e8 44 17 00 00       	callq  42599 <assert_fail>
         va += PAGESIZE) {
   40e55:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e5c:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e5d:	b8 10 b0 05 00       	mov    $0x5b010,%eax
   40e62:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e66:	0f 82 57 ff ff ff    	jb     40dc3 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40e6c:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40e73:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40e74:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40e78:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40e7c:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e80:	48 89 ce             	mov    %rcx,%rsi
   40e83:	48 89 c7             	mov    %rax,%rdi
   40e86:	e8 d0 1d 00 00       	callq  42c5b <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40e8b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e8f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40e93:	74 14                	je     40ea9 <check_page_table_mappings+0x129>
   40e95:	ba 67 49 04 00       	mov    $0x44967,%edx
   40e9a:	be f7 01 00 00       	mov    $0x1f7,%esi
   40e9f:	bf 68 46 04 00       	mov    $0x44668,%edi
   40ea4:	e8 f0 16 00 00       	callq  42599 <assert_fail>
    assert(vam.perm & PTE_W);
   40ea9:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40eac:	48 98                	cltq   
   40eae:	83 e0 02             	and    $0x2,%eax
   40eb1:	48 85 c0             	test   %rax,%rax
   40eb4:	75 14                	jne    40eca <check_page_table_mappings+0x14a>
   40eb6:	ba 56 49 04 00       	mov    $0x44956,%edx
   40ebb:	be f8 01 00 00       	mov    $0x1f8,%esi
   40ec0:	bf 68 46 04 00       	mov    $0x44668,%edi
   40ec5:	e8 cf 16 00 00       	callq  42599 <assert_fail>
}
   40eca:	90                   	nop
   40ecb:	c9                   	leaveq 
   40ecc:	c3                   	retq   

0000000000040ecd <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40ecd:	55                   	push   %rbp
   40ece:	48 89 e5             	mov    %rsp,%rbp
   40ed1:	48 83 ec 20          	sub    $0x20,%rsp
   40ed5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40ed9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40edc:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40edf:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40ee2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40ee9:	48 8b 05 10 41 01 00 	mov    0x14110(%rip),%rax        # 55000 <kernel_pagetable>
   40ef0:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40ef4:	75 67                	jne    40f5d <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40ef6:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40efd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40f04:	eb 51                	jmp    40f57 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40f06:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f09:	48 63 d0             	movslq %eax,%rdx
   40f0c:	48 89 d0             	mov    %rdx,%rax
   40f0f:	48 c1 e0 04          	shl    $0x4,%rax
   40f13:	48 29 d0             	sub    %rdx,%rax
   40f16:	48 c1 e0 04          	shl    $0x4,%rax
   40f1a:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   40f20:	8b 00                	mov    (%rax),%eax
   40f22:	85 c0                	test   %eax,%eax
   40f24:	74 2d                	je     40f53 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40f26:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f29:	48 63 d0             	movslq %eax,%rdx
   40f2c:	48 89 d0             	mov    %rdx,%rax
   40f2f:	48 c1 e0 04          	shl    $0x4,%rax
   40f33:	48 29 d0             	sub    %rdx,%rax
   40f36:	48 c1 e0 04          	shl    $0x4,%rax
   40f3a:	48 05 e0 20 05 00    	add    $0x520e0,%rax
   40f40:	48 8b 10             	mov    (%rax),%rdx
   40f43:	48 8b 05 b6 40 01 00 	mov    0x140b6(%rip),%rax        # 55000 <kernel_pagetable>
   40f4a:	48 39 c2             	cmp    %rax,%rdx
   40f4d:	75 04                	jne    40f53 <check_page_table_ownership+0x86>
                ++expected_refcount;
   40f4f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f53:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40f57:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40f5b:	7e a9                	jle    40f06 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40f5d:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40f60:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f63:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f67:	be 00 00 00 00       	mov    $0x0,%esi
   40f6c:	48 89 c7             	mov    %rax,%rdi
   40f6f:	e8 03 00 00 00       	callq  40f77 <check_page_table_ownership_level>
}
   40f74:	90                   	nop
   40f75:	c9                   	leaveq 
   40f76:	c3                   	retq   

0000000000040f77 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40f77:	55                   	push   %rbp
   40f78:	48 89 e5             	mov    %rsp,%rbp
   40f7b:	48 83 ec 30          	sub    $0x30,%rsp
   40f7f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40f83:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40f86:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40f89:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40f8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f90:	48 c1 e8 0c          	shr    $0xc,%rax
   40f94:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40f99:	7e 14                	jle    40faf <check_page_table_ownership_level+0x38>
   40f9b:	ba 78 49 04 00       	mov    $0x44978,%edx
   40fa0:	be 15 02 00 00       	mov    $0x215,%esi
   40fa5:	bf 68 46 04 00       	mov    $0x44668,%edi
   40faa:	e8 ea 15 00 00       	callq  42599 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40faf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fb3:	48 c1 e8 0c          	shr    $0xc,%rax
   40fb7:	48 98                	cltq   
   40fb9:	0f b6 84 00 20 2f 05 	movzbl 0x52f20(%rax,%rax,1),%eax
   40fc0:	00 
   40fc1:	0f be c0             	movsbl %al,%eax
   40fc4:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40fc7:	74 14                	je     40fdd <check_page_table_ownership_level+0x66>
   40fc9:	ba 90 49 04 00       	mov    $0x44990,%edx
   40fce:	be 16 02 00 00       	mov    $0x216,%esi
   40fd3:	bf 68 46 04 00       	mov    $0x44668,%edi
   40fd8:	e8 bc 15 00 00       	callq  42599 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40fdd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fe1:	48 c1 e8 0c          	shr    $0xc,%rax
   40fe5:	48 98                	cltq   
   40fe7:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   40fee:	00 
   40fef:	0f be c0             	movsbl %al,%eax
   40ff2:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40ff5:	74 14                	je     4100b <check_page_table_ownership_level+0x94>
   40ff7:	ba b8 49 04 00       	mov    $0x449b8,%edx
   40ffc:	be 17 02 00 00       	mov    $0x217,%esi
   41001:	bf 68 46 04 00       	mov    $0x44668,%edi
   41006:	e8 8e 15 00 00       	callq  42599 <assert_fail>
    if (level < 3) {
   4100b:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   4100f:	7f 5b                	jg     4106c <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41011:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41018:	eb 49                	jmp    41063 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   4101a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4101e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41021:	48 63 d2             	movslq %edx,%rdx
   41024:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41028:	48 85 c0             	test   %rax,%rax
   4102b:	74 32                	je     4105f <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   4102d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41031:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41034:	48 63 d2             	movslq %edx,%rdx
   41037:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4103b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41041:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   41045:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41048:	8d 70 01             	lea    0x1(%rax),%esi
   4104b:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4104e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41052:	b9 01 00 00 00       	mov    $0x1,%ecx
   41057:	48 89 c7             	mov    %rax,%rdi
   4105a:	e8 18 ff ff ff       	callq  40f77 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4105f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41063:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4106a:	7e ae                	jle    4101a <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   4106c:	90                   	nop
   4106d:	c9                   	leaveq 
   4106e:	c3                   	retq   

000000000004106f <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   4106f:	55                   	push   %rbp
   41070:	48 89 e5             	mov    %rsp,%rbp
   41073:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41077:	8b 05 5b 10 01 00    	mov    0x1105b(%rip),%eax        # 520d8 <processes+0xd8>
   4107d:	85 c0                	test   %eax,%eax
   4107f:	74 14                	je     41095 <check_virtual_memory+0x26>
   41081:	ba e8 49 04 00       	mov    $0x449e8,%edx
   41086:	be 2a 02 00 00       	mov    $0x22a,%esi
   4108b:	bf 68 46 04 00       	mov    $0x44668,%edi
   41090:	e8 04 15 00 00       	callq  42599 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41095:	48 8b 05 64 3f 01 00 	mov    0x13f64(%rip),%rax        # 55000 <kernel_pagetable>
   4109c:	48 89 c7             	mov    %rax,%rdi
   4109f:	e8 dc fc ff ff       	callq  40d80 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   410a4:	48 8b 05 55 3f 01 00 	mov    0x13f55(%rip),%rax        # 55000 <kernel_pagetable>
   410ab:	be ff ff ff ff       	mov    $0xffffffff,%esi
   410b0:	48 89 c7             	mov    %rax,%rdi
   410b3:	e8 15 fe ff ff       	callq  40ecd <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   410b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   410bf:	e9 9c 00 00 00       	jmpq   41160 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   410c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410c7:	48 63 d0             	movslq %eax,%rdx
   410ca:	48 89 d0             	mov    %rdx,%rax
   410cd:	48 c1 e0 04          	shl    $0x4,%rax
   410d1:	48 29 d0             	sub    %rdx,%rax
   410d4:	48 c1 e0 04          	shl    $0x4,%rax
   410d8:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   410de:	8b 00                	mov    (%rax),%eax
   410e0:	85 c0                	test   %eax,%eax
   410e2:	74 78                	je     4115c <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   410e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410e7:	48 63 d0             	movslq %eax,%rdx
   410ea:	48 89 d0             	mov    %rdx,%rax
   410ed:	48 c1 e0 04          	shl    $0x4,%rax
   410f1:	48 29 d0             	sub    %rdx,%rax
   410f4:	48 c1 e0 04          	shl    $0x4,%rax
   410f8:	48 05 e0 20 05 00    	add    $0x520e0,%rax
   410fe:	48 8b 10             	mov    (%rax),%rdx
   41101:	48 8b 05 f8 3e 01 00 	mov    0x13ef8(%rip),%rax        # 55000 <kernel_pagetable>
   41108:	48 39 c2             	cmp    %rax,%rdx
   4110b:	74 4f                	je     4115c <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   4110d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41110:	48 63 d0             	movslq %eax,%rdx
   41113:	48 89 d0             	mov    %rdx,%rax
   41116:	48 c1 e0 04          	shl    $0x4,%rax
   4111a:	48 29 d0             	sub    %rdx,%rax
   4111d:	48 c1 e0 04          	shl    $0x4,%rax
   41121:	48 05 e0 20 05 00    	add    $0x520e0,%rax
   41127:	48 8b 00             	mov    (%rax),%rax
   4112a:	48 89 c7             	mov    %rax,%rdi
   4112d:	e8 4e fc ff ff       	callq  40d80 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41132:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41135:	48 63 d0             	movslq %eax,%rdx
   41138:	48 89 d0             	mov    %rdx,%rax
   4113b:	48 c1 e0 04          	shl    $0x4,%rax
   4113f:	48 29 d0             	sub    %rdx,%rax
   41142:	48 c1 e0 04          	shl    $0x4,%rax
   41146:	48 05 e0 20 05 00    	add    $0x520e0,%rax
   4114c:	48 8b 00             	mov    (%rax),%rax
   4114f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41152:	89 d6                	mov    %edx,%esi
   41154:	48 89 c7             	mov    %rax,%rdi
   41157:	e8 71 fd ff ff       	callq  40ecd <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   4115c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41160:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41164:	0f 8e 5a ff ff ff    	jle    410c4 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4116a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41171:	eb 67                	jmp    411da <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41173:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41176:	48 98                	cltq   
   41178:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   4117f:	00 
   41180:	84 c0                	test   %al,%al
   41182:	7e 52                	jle    411d6 <check_virtual_memory+0x167>
   41184:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41187:	48 98                	cltq   
   41189:	0f b6 84 00 20 2f 05 	movzbl 0x52f20(%rax,%rax,1),%eax
   41190:	00 
   41191:	84 c0                	test   %al,%al
   41193:	78 41                	js     411d6 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41195:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41198:	48 98                	cltq   
   4119a:	0f b6 84 00 20 2f 05 	movzbl 0x52f20(%rax,%rax,1),%eax
   411a1:	00 
   411a2:	0f be c0             	movsbl %al,%eax
   411a5:	48 63 d0             	movslq %eax,%rdx
   411a8:	48 89 d0             	mov    %rdx,%rax
   411ab:	48 c1 e0 04          	shl    $0x4,%rax
   411af:	48 29 d0             	sub    %rdx,%rax
   411b2:	48 c1 e0 04          	shl    $0x4,%rax
   411b6:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   411bc:	8b 00                	mov    (%rax),%eax
   411be:	85 c0                	test   %eax,%eax
   411c0:	75 14                	jne    411d6 <check_virtual_memory+0x167>
   411c2:	ba 08 4a 04 00       	mov    $0x44a08,%edx
   411c7:	be 41 02 00 00       	mov    $0x241,%esi
   411cc:	bf 68 46 04 00       	mov    $0x44668,%edi
   411d1:	e8 c3 13 00 00       	callq  42599 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411d6:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   411da:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   411e1:	7e 90                	jle    41173 <check_virtual_memory+0x104>
        }
    }
}
   411e3:	90                   	nop
   411e4:	90                   	nop
   411e5:	c9                   	leaveq 
   411e6:	c3                   	retq   

00000000000411e7 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   411e7:	55                   	push   %rbp
   411e8:	48 89 e5             	mov    %rsp,%rbp
   411eb:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   411ef:	ba 38 4a 04 00       	mov    $0x44a38,%edx
   411f4:	be 00 0f 00 00       	mov    $0xf00,%esi
   411f9:	bf 20 00 00 00       	mov    $0x20,%edi
   411fe:	b8 00 00 00 00       	mov    $0x0,%eax
   41203:	e8 d7 27 00 00       	callq  439df <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41208:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4120f:	e9 f4 00 00 00       	jmpq   41308 <memshow_physical+0x121>
        if (pn % 64 == 0) {
   41214:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41217:	83 e0 3f             	and    $0x3f,%eax
   4121a:	85 c0                	test   %eax,%eax
   4121c:	75 3e                	jne    4125c <memshow_physical+0x75>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   4121e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41221:	c1 e0 0c             	shl    $0xc,%eax
   41224:	89 c2                	mov    %eax,%edx
   41226:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41229:	8d 48 3f             	lea    0x3f(%rax),%ecx
   4122c:	85 c0                	test   %eax,%eax
   4122e:	0f 48 c1             	cmovs  %ecx,%eax
   41231:	c1 f8 06             	sar    $0x6,%eax
   41234:	8d 48 01             	lea    0x1(%rax),%ecx
   41237:	89 c8                	mov    %ecx,%eax
   41239:	c1 e0 02             	shl    $0x2,%eax
   4123c:	01 c8                	add    %ecx,%eax
   4123e:	c1 e0 04             	shl    $0x4,%eax
   41241:	83 c0 03             	add    $0x3,%eax
   41244:	89 d1                	mov    %edx,%ecx
   41246:	ba 48 4a 04 00       	mov    $0x44a48,%edx
   4124b:	be 00 0f 00 00       	mov    $0xf00,%esi
   41250:	89 c7                	mov    %eax,%edi
   41252:	b8 00 00 00 00       	mov    $0x0,%eax
   41257:	e8 83 27 00 00       	callq  439df <console_printf>
        }

        int owner = pageinfo[pn].owner;
   4125c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4125f:	48 98                	cltq   
   41261:	0f b6 84 00 20 2f 05 	movzbl 0x52f20(%rax,%rax,1),%eax
   41268:	00 
   41269:	0f be c0             	movsbl %al,%eax
   4126c:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   4126f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41272:	48 98                	cltq   
   41274:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   4127b:	00 
   4127c:	84 c0                	test   %al,%al
   4127e:	75 07                	jne    41287 <memshow_physical+0xa0>
            owner = PO_FREE;
   41280:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41287:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4128a:	83 c0 02             	add    $0x2,%eax
   4128d:	48 98                	cltq   
   4128f:	0f b7 84 00 00 46 04 	movzwl 0x44600(%rax,%rax,1),%eax
   41296:	00 
   41297:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   4129b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4129e:	48 98                	cltq   
   412a0:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   412a7:	00 
   412a8:	3c 01                	cmp    $0x1,%al
   412aa:	7e 1a                	jle    412c6 <memshow_physical+0xdf>
   412ac:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   412b1:	48 c1 e8 0c          	shr    $0xc,%rax
   412b5:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   412b8:	74 0c                	je     412c6 <memshow_physical+0xdf>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   412ba:	b8 53 00 00 00       	mov    $0x53,%eax
   412bf:	80 cc 0f             	or     $0xf,%ah
   412c2:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   412c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412c9:	8d 50 3f             	lea    0x3f(%rax),%edx
   412cc:	85 c0                	test   %eax,%eax
   412ce:	0f 48 c2             	cmovs  %edx,%eax
   412d1:	c1 f8 06             	sar    $0x6,%eax
   412d4:	8d 50 01             	lea    0x1(%rax),%edx
   412d7:	89 d0                	mov    %edx,%eax
   412d9:	c1 e0 02             	shl    $0x2,%eax
   412dc:	01 d0                	add    %edx,%eax
   412de:	c1 e0 04             	shl    $0x4,%eax
   412e1:	89 c1                	mov    %eax,%ecx
   412e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412e6:	99                   	cltd   
   412e7:	c1 ea 1a             	shr    $0x1a,%edx
   412ea:	01 d0                	add    %edx,%eax
   412ec:	83 e0 3f             	and    $0x3f,%eax
   412ef:	29 d0                	sub    %edx,%eax
   412f1:	83 c0 0c             	add    $0xc,%eax
   412f4:	01 c8                	add    %ecx,%eax
   412f6:	48 98                	cltq   
   412f8:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   412fc:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   41303:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41304:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41308:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4130f:	0f 8e ff fe ff ff    	jle    41214 <memshow_physical+0x2d>
    }
}
   41315:	90                   	nop
   41316:	90                   	nop
   41317:	c9                   	leaveq 
   41318:	c3                   	retq   

0000000000041319 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41319:	55                   	push   %rbp
   4131a:	48 89 e5             	mov    %rsp,%rbp
   4131d:	48 83 ec 40          	sub    $0x40,%rsp
   41321:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41325:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41329:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4132d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41333:	48 89 c2             	mov    %rax,%rdx
   41336:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4133a:	48 39 c2             	cmp    %rax,%rdx
   4133d:	74 14                	je     41353 <memshow_virtual+0x3a>
   4133f:	ba 50 4a 04 00       	mov    $0x44a50,%edx
   41344:	be 72 02 00 00       	mov    $0x272,%esi
   41349:	bf 68 46 04 00       	mov    $0x44668,%edi
   4134e:	e8 46 12 00 00       	callq  42599 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41353:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41357:	48 89 c1             	mov    %rax,%rcx
   4135a:	ba 7d 4a 04 00       	mov    $0x44a7d,%edx
   4135f:	be 00 0f 00 00       	mov    $0xf00,%esi
   41364:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41369:	b8 00 00 00 00       	mov    $0x0,%eax
   4136e:	e8 6c 26 00 00       	callq  439df <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41373:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4137a:	00 
   4137b:	e9 80 01 00 00       	jmpq   41500 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41380:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41384:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41388:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4138c:	48 89 ce             	mov    %rcx,%rsi
   4138f:	48 89 c7             	mov    %rax,%rdi
   41392:	e8 c4 18 00 00       	callq  42c5b <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41397:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4139a:	85 c0                	test   %eax,%eax
   4139c:	79 0b                	jns    413a9 <memshow_virtual+0x90>
            color = ' ';
   4139e:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   413a4:	e9 d7 00 00 00       	jmpq   41480 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   413a9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   413ad:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   413b3:	76 14                	jbe    413c9 <memshow_virtual+0xb0>
   413b5:	ba 9a 4a 04 00       	mov    $0x44a9a,%edx
   413ba:	be 7b 02 00 00       	mov    $0x27b,%esi
   413bf:	bf 68 46 04 00       	mov    $0x44668,%edi
   413c4:	e8 d0 11 00 00       	callq  42599 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   413c9:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413cc:	48 98                	cltq   
   413ce:	0f b6 84 00 20 2f 05 	movzbl 0x52f20(%rax,%rax,1),%eax
   413d5:	00 
   413d6:	0f be c0             	movsbl %al,%eax
   413d9:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   413dc:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413df:	48 98                	cltq   
   413e1:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   413e8:	00 
   413e9:	84 c0                	test   %al,%al
   413eb:	75 07                	jne    413f4 <memshow_virtual+0xdb>
                owner = PO_FREE;
   413ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   413f4:	8b 45 f0             	mov    -0x10(%rbp),%eax
   413f7:	83 c0 02             	add    $0x2,%eax
   413fa:	48 98                	cltq   
   413fc:	0f b7 84 00 00 46 04 	movzwl 0x44600(%rax,%rax,1),%eax
   41403:	00 
   41404:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41408:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4140b:	48 98                	cltq   
   4140d:	83 e0 04             	and    $0x4,%eax
   41410:	48 85 c0             	test   %rax,%rax
   41413:	74 27                	je     4143c <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41415:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41419:	c1 e0 04             	shl    $0x4,%eax
   4141c:	66 25 00 f0          	and    $0xf000,%ax
   41420:	89 c2                	mov    %eax,%edx
   41422:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41426:	c1 f8 04             	sar    $0x4,%eax
   41429:	66 25 00 0f          	and    $0xf00,%ax
   4142d:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   4142f:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41433:	0f b6 c0             	movzbl %al,%eax
   41436:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41438:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   4143c:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4143f:	48 98                	cltq   
   41441:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   41448:	00 
   41449:	3c 01                	cmp    $0x1,%al
   4144b:	7e 33                	jle    41480 <memshow_virtual+0x167>
   4144d:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41452:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41456:	74 28                	je     41480 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41458:	b8 53 00 00 00       	mov    $0x53,%eax
   4145d:	89 c2                	mov    %eax,%edx
   4145f:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41463:	66 25 00 f0          	and    $0xf000,%ax
   41467:	09 d0                	or     %edx,%eax
   41469:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   4146d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41470:	48 98                	cltq   
   41472:	83 e0 04             	and    $0x4,%eax
   41475:	48 85 c0             	test   %rax,%rax
   41478:	75 06                	jne    41480 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   4147a:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41480:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41484:	48 c1 e8 0c          	shr    $0xc,%rax
   41488:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   4148b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4148e:	83 e0 3f             	and    $0x3f,%eax
   41491:	85 c0                	test   %eax,%eax
   41493:	75 34                	jne    414c9 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41495:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41498:	c1 e8 06             	shr    $0x6,%eax
   4149b:	89 c2                	mov    %eax,%edx
   4149d:	89 d0                	mov    %edx,%eax
   4149f:	c1 e0 02             	shl    $0x2,%eax
   414a2:	01 d0                	add    %edx,%eax
   414a4:	c1 e0 04             	shl    $0x4,%eax
   414a7:	05 73 03 00 00       	add    $0x373,%eax
   414ac:	89 c7                	mov    %eax,%edi
   414ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414b2:	48 89 c1             	mov    %rax,%rcx
   414b5:	ba 48 4a 04 00       	mov    $0x44a48,%edx
   414ba:	be 00 0f 00 00       	mov    $0xf00,%esi
   414bf:	b8 00 00 00 00       	mov    $0x0,%eax
   414c4:	e8 16 25 00 00       	callq  439df <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   414c9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414cc:	c1 e8 06             	shr    $0x6,%eax
   414cf:	89 c2                	mov    %eax,%edx
   414d1:	89 d0                	mov    %edx,%eax
   414d3:	c1 e0 02             	shl    $0x2,%eax
   414d6:	01 d0                	add    %edx,%eax
   414d8:	c1 e0 04             	shl    $0x4,%eax
   414db:	89 c2                	mov    %eax,%edx
   414dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414e0:	83 e0 3f             	and    $0x3f,%eax
   414e3:	01 d0                	add    %edx,%eax
   414e5:	05 7c 03 00 00       	add    $0x37c,%eax
   414ea:	89 c2                	mov    %eax,%edx
   414ec:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414f0:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   414f7:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   414f8:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   414ff:	00 
   41500:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41507:	00 
   41508:	0f 86 72 fe ff ff    	jbe    41380 <memshow_virtual+0x67>
    }
}
   4150e:	90                   	nop
   4150f:	90                   	nop
   41510:	c9                   	leaveq 
   41511:	c3                   	retq   

0000000000041512 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41512:	55                   	push   %rbp
   41513:	48 89 e5             	mov    %rsp,%rbp
   41516:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   4151a:	8b 05 04 1e 01 00    	mov    0x11e04(%rip),%eax        # 53324 <last_ticks.1>
   41520:	85 c0                	test   %eax,%eax
   41522:	74 13                	je     41537 <memshow_virtual_animate+0x25>
   41524:	8b 05 f6 1d 01 00    	mov    0x11df6(%rip),%eax        # 53320 <ticks>
   4152a:	8b 15 f4 1d 01 00    	mov    0x11df4(%rip),%edx        # 53324 <last_ticks.1>
   41530:	29 d0                	sub    %edx,%eax
   41532:	83 f8 31             	cmp    $0x31,%eax
   41535:	76 2c                	jbe    41563 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41537:	8b 05 e3 1d 01 00    	mov    0x11de3(%rip),%eax        # 53320 <ticks>
   4153d:	89 05 e1 1d 01 00    	mov    %eax,0x11de1(%rip)        # 53324 <last_ticks.1>
        ++showing;
   41543:	8b 05 bb 4a 00 00    	mov    0x4abb(%rip),%eax        # 46004 <showing.0>
   41549:	83 c0 01             	add    $0x1,%eax
   4154c:	89 05 b2 4a 00 00    	mov    %eax,0x4ab2(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41552:	eb 0f                	jmp    41563 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   41554:	8b 05 aa 4a 00 00    	mov    0x4aaa(%rip),%eax        # 46004 <showing.0>
   4155a:	83 c0 01             	add    $0x1,%eax
   4155d:	89 05 a1 4a 00 00    	mov    %eax,0x4aa1(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41563:	8b 05 9b 4a 00 00    	mov    0x4a9b(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41569:	83 f8 20             	cmp    $0x20,%eax
   4156c:	7f 2e                	jg     4159c <memshow_virtual_animate+0x8a>
   4156e:	8b 05 90 4a 00 00    	mov    0x4a90(%rip),%eax        # 46004 <showing.0>
   41574:	99                   	cltd   
   41575:	c1 ea 1c             	shr    $0x1c,%edx
   41578:	01 d0                	add    %edx,%eax
   4157a:	83 e0 0f             	and    $0xf,%eax
   4157d:	29 d0                	sub    %edx,%eax
   4157f:	48 63 d0             	movslq %eax,%rdx
   41582:	48 89 d0             	mov    %rdx,%rax
   41585:	48 c1 e0 04          	shl    $0x4,%rax
   41589:	48 29 d0             	sub    %rdx,%rax
   4158c:	48 c1 e0 04          	shl    $0x4,%rax
   41590:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   41596:	8b 00                	mov    (%rax),%eax
   41598:	85 c0                	test   %eax,%eax
   4159a:	74 b8                	je     41554 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   4159c:	8b 05 62 4a 00 00    	mov    0x4a62(%rip),%eax        # 46004 <showing.0>
   415a2:	99                   	cltd   
   415a3:	c1 ea 1c             	shr    $0x1c,%edx
   415a6:	01 d0                	add    %edx,%eax
   415a8:	83 e0 0f             	and    $0xf,%eax
   415ab:	29 d0                	sub    %edx,%eax
   415ad:	89 05 51 4a 00 00    	mov    %eax,0x4a51(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   415b3:	8b 05 4b 4a 00 00    	mov    0x4a4b(%rip),%eax        # 46004 <showing.0>
   415b9:	48 63 d0             	movslq %eax,%rdx
   415bc:	48 89 d0             	mov    %rdx,%rax
   415bf:	48 c1 e0 04          	shl    $0x4,%rax
   415c3:	48 29 d0             	sub    %rdx,%rax
   415c6:	48 c1 e0 04          	shl    $0x4,%rax
   415ca:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   415d0:	8b 00                	mov    (%rax),%eax
   415d2:	85 c0                	test   %eax,%eax
   415d4:	74 76                	je     4164c <memshow_virtual_animate+0x13a>
   415d6:	8b 05 28 4a 00 00    	mov    0x4a28(%rip),%eax        # 46004 <showing.0>
   415dc:	48 63 d0             	movslq %eax,%rdx
   415df:	48 89 d0             	mov    %rdx,%rax
   415e2:	48 c1 e0 04          	shl    $0x4,%rax
   415e6:	48 29 d0             	sub    %rdx,%rax
   415e9:	48 c1 e0 04          	shl    $0x4,%rax
   415ed:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   415f3:	0f b6 00             	movzbl (%rax),%eax
   415f6:	84 c0                	test   %al,%al
   415f8:	74 52                	je     4164c <memshow_virtual_animate+0x13a>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   415fa:	8b 15 04 4a 00 00    	mov    0x4a04(%rip),%edx        # 46004 <showing.0>
   41600:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41604:	89 d1                	mov    %edx,%ecx
   41606:	ba b4 4a 04 00       	mov    $0x44ab4,%edx
   4160b:	be 04 00 00 00       	mov    $0x4,%esi
   41610:	48 89 c7             	mov    %rax,%rdi
   41613:	b8 00 00 00 00       	mov    $0x0,%eax
   41618:	e8 40 24 00 00       	callq  43a5d <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   4161d:	8b 05 e1 49 00 00    	mov    0x49e1(%rip),%eax        # 46004 <showing.0>
   41623:	48 63 d0             	movslq %eax,%rdx
   41626:	48 89 d0             	mov    %rdx,%rax
   41629:	48 c1 e0 04          	shl    $0x4,%rax
   4162d:	48 29 d0             	sub    %rdx,%rax
   41630:	48 c1 e0 04          	shl    $0x4,%rax
   41634:	48 05 e0 20 05 00    	add    $0x520e0,%rax
   4163a:	48 8b 00             	mov    (%rax),%rax
   4163d:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41641:	48 89 d6             	mov    %rdx,%rsi
   41644:	48 89 c7             	mov    %rax,%rdi
   41647:	e8 cd fc ff ff       	callq  41319 <memshow_virtual>
    }
}
   4164c:	90                   	nop
   4164d:	c9                   	leaveq 
   4164e:	c3                   	retq   

000000000004164f <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   4164f:	55                   	push   %rbp
   41650:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41653:	e8 53 01 00 00       	callq  417ab <segments_init>
    interrupt_init();
   41658:	e8 d4 03 00 00       	callq  41a31 <interrupt_init>
    virtual_memory_init();
   4165d:	e8 f2 0f 00 00       	callq  42654 <virtual_memory_init>
}
   41662:	90                   	nop
   41663:	5d                   	pop    %rbp
   41664:	c3                   	retq   

0000000000041665 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41665:	55                   	push   %rbp
   41666:	48 89 e5             	mov    %rsp,%rbp
   41669:	48 83 ec 18          	sub    $0x18,%rsp
   4166d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41671:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41675:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41678:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4167b:	48 98                	cltq   
   4167d:	48 c1 e0 2d          	shl    $0x2d,%rax
   41681:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41685:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   4168c:	90 00 00 
   4168f:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41692:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41696:	48 89 10             	mov    %rdx,(%rax)
}
   41699:	90                   	nop
   4169a:	c9                   	leaveq 
   4169b:	c3                   	retq   

000000000004169c <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   4169c:	55                   	push   %rbp
   4169d:	48 89 e5             	mov    %rsp,%rbp
   416a0:	48 83 ec 28          	sub    $0x28,%rsp
   416a4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   416a8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   416ac:	89 55 ec             	mov    %edx,-0x14(%rbp)
   416af:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   416b3:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   416b7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416bb:	48 c1 e0 10          	shl    $0x10,%rax
   416bf:	48 89 c2             	mov    %rax,%rdx
   416c2:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   416c9:	00 00 00 
   416cc:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   416cf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416d3:	48 c1 e0 20          	shl    $0x20,%rax
   416d7:	48 89 c1             	mov    %rax,%rcx
   416da:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   416e1:	00 00 ff 
   416e4:	48 21 c8             	and    %rcx,%rax
   416e7:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   416ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   416ee:	48 83 e8 01          	sub    $0x1,%rax
   416f2:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   416f5:	48 09 d0             	or     %rdx,%rax
        | type
   416f8:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   416fc:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   416ff:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41702:	48 98                	cltq   
   41704:	48 c1 e0 2d          	shl    $0x2d,%rax
   41708:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   4170b:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41712:	80 00 00 
   41715:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41718:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4171c:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   4171f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41723:	48 83 c0 08          	add    $0x8,%rax
   41727:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4172b:	48 c1 ea 20          	shr    $0x20,%rdx
   4172f:	48 89 10             	mov    %rdx,(%rax)
}
   41732:	90                   	nop
   41733:	c9                   	leaveq 
   41734:	c3                   	retq   

0000000000041735 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41735:	55                   	push   %rbp
   41736:	48 89 e5             	mov    %rsp,%rbp
   41739:	48 83 ec 20          	sub    $0x20,%rsp
   4173d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41741:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41745:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41748:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   4174c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41750:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41753:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41757:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   4175a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4175d:	48 98                	cltq   
   4175f:	48 c1 e0 2d          	shl    $0x2d,%rax
   41763:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41766:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4176a:	48 c1 e0 20          	shl    $0x20,%rax
   4176e:	48 89 c1             	mov    %rax,%rcx
   41771:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41778:	00 ff ff 
   4177b:	48 21 c8             	and    %rcx,%rax
   4177e:	48 09 c2             	or     %rax,%rdx
   41781:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41788:	80 00 00 
   4178b:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   4178e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41792:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41795:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41799:	48 c1 e8 20          	shr    $0x20,%rax
   4179d:	48 89 c2             	mov    %rax,%rdx
   417a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   417a4:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   417a8:	90                   	nop
   417a9:	c9                   	leaveq 
   417aa:	c3                   	retq   

00000000000417ab <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   417ab:	55                   	push   %rbp
   417ac:	48 89 e5             	mov    %rsp,%rbp
   417af:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   417b3:	48 c7 05 82 1b 01 00 	movq   $0x0,0x11b82(%rip)        # 53340 <segments>
   417ba:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   417be:	ba 00 00 00 00       	mov    $0x0,%edx
   417c3:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417ca:	08 20 00 
   417cd:	48 89 c6             	mov    %rax,%rsi
   417d0:	bf 48 33 05 00       	mov    $0x53348,%edi
   417d5:	e8 8b fe ff ff       	callq  41665 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   417da:	ba 03 00 00 00       	mov    $0x3,%edx
   417df:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417e6:	08 20 00 
   417e9:	48 89 c6             	mov    %rax,%rsi
   417ec:	bf 50 33 05 00       	mov    $0x53350,%edi
   417f1:	e8 6f fe ff ff       	callq  41665 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   417f6:	ba 00 00 00 00       	mov    $0x0,%edx
   417fb:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41802:	02 00 00 
   41805:	48 89 c6             	mov    %rax,%rsi
   41808:	bf 58 33 05 00       	mov    $0x53358,%edi
   4180d:	e8 53 fe ff ff       	callq  41665 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41812:	ba 03 00 00 00       	mov    $0x3,%edx
   41817:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   4181e:	02 00 00 
   41821:	48 89 c6             	mov    %rax,%rsi
   41824:	bf 60 33 05 00       	mov    $0x53360,%edi
   41829:	e8 37 fe ff ff       	callq  41665 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   4182e:	b8 80 43 05 00       	mov    $0x54380,%eax
   41833:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41839:	48 89 c1             	mov    %rax,%rcx
   4183c:	ba 00 00 00 00       	mov    $0x0,%edx
   41841:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41848:	09 00 00 
   4184b:	48 89 c6             	mov    %rax,%rsi
   4184e:	bf 68 33 05 00       	mov    $0x53368,%edi
   41853:	e8 44 fe ff ff       	callq  4169c <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41858:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   4185e:	b8 40 33 05 00       	mov    $0x53340,%eax
   41863:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41867:	ba 60 00 00 00       	mov    $0x60,%edx
   4186c:	be 00 00 00 00       	mov    $0x0,%esi
   41871:	bf 80 43 05 00       	mov    $0x54380,%edi
   41876:	e8 2f 19 00 00       	callq  431aa <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   4187b:	48 c7 05 fe 2a 01 00 	movq   $0x80000,0x12afe(%rip)        # 54384 <kernel_task_descriptor+0x4>
   41882:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41886:	ba 00 10 00 00       	mov    $0x1000,%edx
   4188b:	be 00 00 00 00       	mov    $0x0,%esi
   41890:	bf 80 33 05 00       	mov    $0x53380,%edi
   41895:	e8 10 19 00 00       	callq  431aa <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4189a:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   418a1:	eb 30                	jmp    418d3 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   418a3:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   418a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418ab:	48 c1 e0 04          	shl    $0x4,%rax
   418af:	48 05 80 33 05 00    	add    $0x53380,%rax
   418b5:	48 89 d1             	mov    %rdx,%rcx
   418b8:	ba 00 00 00 00       	mov    $0x0,%edx
   418bd:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   418c4:	0e 00 00 
   418c7:	48 89 c7             	mov    %rax,%rdi
   418ca:	e8 66 fe ff ff       	callq  41735 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   418cf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   418d3:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   418da:	76 c7                	jbe    418a3 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   418dc:	b8 36 00 04 00       	mov    $0x40036,%eax
   418e1:	48 89 c1             	mov    %rax,%rcx
   418e4:	ba 00 00 00 00       	mov    $0x0,%edx
   418e9:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418f0:	0e 00 00 
   418f3:	48 89 c6             	mov    %rax,%rsi
   418f6:	bf 80 35 05 00       	mov    $0x53580,%edi
   418fb:	e8 35 fe ff ff       	callq  41735 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41900:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41905:	48 89 c1             	mov    %rax,%rcx
   41908:	ba 00 00 00 00       	mov    $0x0,%edx
   4190d:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41914:	0e 00 00 
   41917:	48 89 c6             	mov    %rax,%rsi
   4191a:	bf 50 34 05 00       	mov    $0x53450,%edi
   4191f:	e8 11 fe ff ff       	callq  41735 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41924:	b8 32 00 04 00       	mov    $0x40032,%eax
   41929:	48 89 c1             	mov    %rax,%rcx
   4192c:	ba 00 00 00 00       	mov    $0x0,%edx
   41931:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41938:	0e 00 00 
   4193b:	48 89 c6             	mov    %rax,%rsi
   4193e:	bf 60 34 05 00       	mov    $0x53460,%edi
   41943:	e8 ed fd ff ff       	callq  41735 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41948:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   4194f:	eb 3e                	jmp    4198f <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41951:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41954:	83 e8 30             	sub    $0x30,%eax
   41957:	89 c0                	mov    %eax,%eax
   41959:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41960:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41961:	48 89 c2             	mov    %rax,%rdx
   41964:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41967:	48 c1 e0 04          	shl    $0x4,%rax
   4196b:	48 05 80 33 05 00    	add    $0x53380,%rax
   41971:	48 89 d1             	mov    %rdx,%rcx
   41974:	ba 03 00 00 00       	mov    $0x3,%edx
   41979:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41980:	0e 00 00 
   41983:	48 89 c7             	mov    %rax,%rdi
   41986:	e8 aa fd ff ff       	callq  41735 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4198b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4198f:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41993:	76 bc                	jbe    41951 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41995:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   4199b:	b8 80 33 05 00       	mov    $0x53380,%eax
   419a0:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   419a4:	b8 28 00 00 00       	mov    $0x28,%eax
   419a9:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   419ad:	0f 00 d8             	ltr    %ax
   419b0:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   419b4:	0f 20 c0             	mov    %cr0,%rax
   419b7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   419bb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   419bf:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   419c2:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   419c9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   419cc:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   419cf:	8b 45 f0             	mov    -0x10(%rbp),%eax
   419d2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   419d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   419da:	0f 22 c0             	mov    %rax,%cr0
}
   419dd:	90                   	nop
    lcr0(cr0);
}
   419de:	90                   	nop
   419df:	c9                   	leaveq 
   419e0:	c3                   	retq   

00000000000419e1 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   419e1:	55                   	push   %rbp
   419e2:	48 89 e5             	mov    %rsp,%rbp
   419e5:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   419e9:	0f b7 05 f0 29 01 00 	movzwl 0x129f0(%rip),%eax        # 543e0 <interrupts_enabled>
   419f0:	f7 d0                	not    %eax
   419f2:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   419f6:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419fa:	0f b6 c0             	movzbl %al,%eax
   419fd:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41a04:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a07:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41a0b:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41a0e:	ee                   	out    %al,(%dx)
}
   41a0f:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41a10:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a14:	66 c1 e8 08          	shr    $0x8,%ax
   41a18:	0f b6 c0             	movzbl %al,%eax
   41a1b:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41a22:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a25:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41a29:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41a2c:	ee                   	out    %al,(%dx)
}
   41a2d:	90                   	nop
}
   41a2e:	90                   	nop
   41a2f:	c9                   	leaveq 
   41a30:	c3                   	retq   

0000000000041a31 <interrupt_init>:

void interrupt_init(void) {
   41a31:	55                   	push   %rbp
   41a32:	48 89 e5             	mov    %rsp,%rbp
   41a35:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41a39:	66 c7 05 9e 29 01 00 	movw   $0x0,0x1299e(%rip)        # 543e0 <interrupts_enabled>
   41a40:	00 00 
    interrupt_mask();
   41a42:	e8 9a ff ff ff       	callq  419e1 <interrupt_mask>
   41a47:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41a4e:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a52:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41a56:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41a59:	ee                   	out    %al,(%dx)
}
   41a5a:	90                   	nop
   41a5b:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41a62:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a66:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41a6a:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41a6d:	ee                   	out    %al,(%dx)
}
   41a6e:	90                   	nop
   41a6f:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41a76:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a7a:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41a7e:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41a81:	ee                   	out    %al,(%dx)
}
   41a82:	90                   	nop
   41a83:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41a8a:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a8e:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41a92:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41a95:	ee                   	out    %al,(%dx)
}
   41a96:	90                   	nop
   41a97:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41a9e:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aa2:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41aa6:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41aa9:	ee                   	out    %al,(%dx)
}
   41aaa:	90                   	nop
   41aab:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41ab2:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ab6:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41aba:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41abd:	ee                   	out    %al,(%dx)
}
   41abe:	90                   	nop
   41abf:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41ac6:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aca:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41ace:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41ad1:	ee                   	out    %al,(%dx)
}
   41ad2:	90                   	nop
   41ad3:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41ada:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ade:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41ae2:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41ae5:	ee                   	out    %al,(%dx)
}
   41ae6:	90                   	nop
   41ae7:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41aee:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41af2:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41af6:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41af9:	ee                   	out    %al,(%dx)
}
   41afa:	90                   	nop
   41afb:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41b02:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b06:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b0a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b0d:	ee                   	out    %al,(%dx)
}
   41b0e:	90                   	nop
   41b0f:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41b16:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b1a:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b1e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b21:	ee                   	out    %al,(%dx)
}
   41b22:	90                   	nop
   41b23:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41b2a:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b2e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b32:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b35:	ee                   	out    %al,(%dx)
}
   41b36:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41b37:	e8 a5 fe ff ff       	callq  419e1 <interrupt_mask>
}
   41b3c:	90                   	nop
   41b3d:	c9                   	leaveq 
   41b3e:	c3                   	retq   

0000000000041b3f <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41b3f:	55                   	push   %rbp
   41b40:	48 89 e5             	mov    %rsp,%rbp
   41b43:	48 83 ec 28          	sub    $0x28,%rsp
   41b47:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41b4a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41b4e:	0f 8e 9f 00 00 00    	jle    41bf3 <timer_init+0xb4>
   41b54:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41b5b:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b5f:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b63:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b66:	ee                   	out    %al,(%dx)
}
   41b67:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41b68:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b6b:	89 c2                	mov    %eax,%edx
   41b6d:	c1 ea 1f             	shr    $0x1f,%edx
   41b70:	01 d0                	add    %edx,%eax
   41b72:	d1 f8                	sar    %eax
   41b74:	05 de 34 12 00       	add    $0x1234de,%eax
   41b79:	99                   	cltd   
   41b7a:	f7 7d dc             	idivl  -0x24(%rbp)
   41b7d:	89 c2                	mov    %eax,%edx
   41b7f:	89 d0                	mov    %edx,%eax
   41b81:	c1 f8 1f             	sar    $0x1f,%eax
   41b84:	c1 e8 18             	shr    $0x18,%eax
   41b87:	89 c1                	mov    %eax,%ecx
   41b89:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41b8c:	0f b6 c0             	movzbl %al,%eax
   41b8f:	29 c8                	sub    %ecx,%eax
   41b91:	0f b6 c0             	movzbl %al,%eax
   41b94:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41b9b:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b9e:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ba2:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ba5:	ee                   	out    %al,(%dx)
}
   41ba6:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41ba7:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41baa:	89 c2                	mov    %eax,%edx
   41bac:	c1 ea 1f             	shr    $0x1f,%edx
   41baf:	01 d0                	add    %edx,%eax
   41bb1:	d1 f8                	sar    %eax
   41bb3:	05 de 34 12 00       	add    $0x1234de,%eax
   41bb8:	99                   	cltd   
   41bb9:	f7 7d dc             	idivl  -0x24(%rbp)
   41bbc:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41bc2:	85 c0                	test   %eax,%eax
   41bc4:	0f 48 c2             	cmovs  %edx,%eax
   41bc7:	c1 f8 08             	sar    $0x8,%eax
   41bca:	0f b6 c0             	movzbl %al,%eax
   41bcd:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41bd4:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bd7:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41bdb:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41bde:	ee                   	out    %al,(%dx)
}
   41bdf:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41be0:	0f b7 05 f9 27 01 00 	movzwl 0x127f9(%rip),%eax        # 543e0 <interrupts_enabled>
   41be7:	83 c8 01             	or     $0x1,%eax
   41bea:	66 89 05 ef 27 01 00 	mov    %ax,0x127ef(%rip)        # 543e0 <interrupts_enabled>
   41bf1:	eb 11                	jmp    41c04 <timer_init+0xc5>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41bf3:	0f b7 05 e6 27 01 00 	movzwl 0x127e6(%rip),%eax        # 543e0 <interrupts_enabled>
   41bfa:	83 e0 fe             	and    $0xfffffffe,%eax
   41bfd:	66 89 05 dc 27 01 00 	mov    %ax,0x127dc(%rip)        # 543e0 <interrupts_enabled>
    }
    interrupt_mask();
   41c04:	e8 d8 fd ff ff       	callq  419e1 <interrupt_mask>
}
   41c09:	90                   	nop
   41c0a:	c9                   	leaveq 
   41c0b:	c3                   	retq   

0000000000041c0c <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41c0c:	55                   	push   %rbp
   41c0d:	48 89 e5             	mov    %rsp,%rbp
   41c10:	48 83 ec 08          	sub    $0x8,%rsp
   41c14:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41c18:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41c1d:	74 14                	je     41c33 <physical_memory_isreserved+0x27>
   41c1f:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41c26:	00 
   41c27:	76 11                	jbe    41c3a <physical_memory_isreserved+0x2e>
   41c29:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41c30:	00 
   41c31:	77 07                	ja     41c3a <physical_memory_isreserved+0x2e>
   41c33:	b8 01 00 00 00       	mov    $0x1,%eax
   41c38:	eb 05                	jmp    41c3f <physical_memory_isreserved+0x33>
   41c3a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41c3f:	c9                   	leaveq 
   41c40:	c3                   	retq   

0000000000041c41 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41c41:	55                   	push   %rbp
   41c42:	48 89 e5             	mov    %rsp,%rbp
   41c45:	48 83 ec 10          	sub    $0x10,%rsp
   41c49:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41c4c:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41c4f:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41c52:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c55:	c1 e0 10             	shl    $0x10,%eax
   41c58:	89 c2                	mov    %eax,%edx
   41c5a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c5d:	c1 e0 0b             	shl    $0xb,%eax
   41c60:	09 c2                	or     %eax,%edx
   41c62:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c65:	c1 e0 08             	shl    $0x8,%eax
   41c68:	09 d0                	or     %edx,%eax
}
   41c6a:	c9                   	leaveq 
   41c6b:	c3                   	retq   

0000000000041c6c <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41c6c:	55                   	push   %rbp
   41c6d:	48 89 e5             	mov    %rsp,%rbp
   41c70:	48 83 ec 18          	sub    $0x18,%rsp
   41c74:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41c77:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41c7a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c7d:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41c80:	09 d0                	or     %edx,%eax
   41c82:	0d 00 00 00 80       	or     $0x80000000,%eax
   41c87:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41c8e:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41c91:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c94:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c97:	ef                   	out    %eax,(%dx)
}
   41c98:	90                   	nop
   41c99:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41ca0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ca3:	89 c2                	mov    %eax,%edx
   41ca5:	ed                   	in     (%dx),%eax
   41ca6:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41ca9:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41cac:	c9                   	leaveq 
   41cad:	c3                   	retq   

0000000000041cae <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41cae:	55                   	push   %rbp
   41caf:	48 89 e5             	mov    %rsp,%rbp
   41cb2:	48 83 ec 28          	sub    $0x28,%rsp
   41cb6:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41cb9:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41cbc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41cc3:	eb 73                	jmp    41d38 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41cc5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41ccc:	eb 60                	jmp    41d2e <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41cce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41cd5:	eb 4a                	jmp    41d21 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41cd7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cda:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41cdd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ce0:	89 ce                	mov    %ecx,%esi
   41ce2:	89 c7                	mov    %eax,%edi
   41ce4:	e8 58 ff ff ff       	callq  41c41 <pci_make_configaddr>
   41ce9:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41cec:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cef:	be 00 00 00 00       	mov    $0x0,%esi
   41cf4:	89 c7                	mov    %eax,%edi
   41cf6:	e8 71 ff ff ff       	callq  41c6c <pci_config_readl>
   41cfb:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41cfe:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41d01:	c1 e0 10             	shl    $0x10,%eax
   41d04:	0b 45 dc             	or     -0x24(%rbp),%eax
   41d07:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41d0a:	75 05                	jne    41d11 <pci_find_device+0x63>
                    return configaddr;
   41d0c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d0f:	eb 35                	jmp    41d46 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41d11:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41d15:	75 06                	jne    41d1d <pci_find_device+0x6f>
   41d17:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41d1b:	74 0c                	je     41d29 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41d1d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41d21:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41d25:	75 b0                	jne    41cd7 <pci_find_device+0x29>
   41d27:	eb 01                	jmp    41d2a <pci_find_device+0x7c>
                    break;
   41d29:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41d2a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41d2e:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41d32:	75 9a                	jne    41cce <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41d34:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41d38:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41d3f:	75 84                	jne    41cc5 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41d41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41d46:	c9                   	leaveq 
   41d47:	c3                   	retq   

0000000000041d48 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41d48:	55                   	push   %rbp
   41d49:	48 89 e5             	mov    %rsp,%rbp
   41d4c:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41d50:	be 13 71 00 00       	mov    $0x7113,%esi
   41d55:	bf 86 80 00 00       	mov    $0x8086,%edi
   41d5a:	e8 4f ff ff ff       	callq  41cae <pci_find_device>
   41d5f:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41d62:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41d66:	78 30                	js     41d98 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41d68:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d6b:	be 40 00 00 00       	mov    $0x40,%esi
   41d70:	89 c7                	mov    %eax,%edi
   41d72:	e8 f5 fe ff ff       	callq  41c6c <pci_config_readl>
   41d77:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41d7c:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41d7f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41d82:	83 c0 04             	add    $0x4,%eax
   41d85:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41d88:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41d8e:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41d92:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d95:	66 ef                	out    %ax,(%dx)
}
   41d97:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41d98:	ba c0 4a 04 00       	mov    $0x44ac0,%edx
   41d9d:	be 00 c0 00 00       	mov    $0xc000,%esi
   41da2:	bf 80 07 00 00       	mov    $0x780,%edi
   41da7:	b8 00 00 00 00       	mov    $0x0,%eax
   41dac:	e8 2e 1c 00 00       	callq  439df <console_printf>
 spinloop: goto spinloop;
   41db1:	eb fe                	jmp    41db1 <poweroff+0x69>

0000000000041db3 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41db3:	55                   	push   %rbp
   41db4:	48 89 e5             	mov    %rsp,%rbp
   41db7:	48 83 ec 10          	sub    $0x10,%rsp
   41dbb:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41dc2:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dc6:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41dca:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41dcd:	ee                   	out    %al,(%dx)
}
   41dce:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41dcf:	eb fe                	jmp    41dcf <reboot+0x1c>

0000000000041dd1 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41dd1:	55                   	push   %rbp
   41dd2:	48 89 e5             	mov    %rsp,%rbp
   41dd5:	48 83 ec 10          	sub    $0x10,%rsp
   41dd9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41ddd:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41de0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41de4:	48 83 c0 18          	add    $0x18,%rax
   41de8:	ba c0 00 00 00       	mov    $0xc0,%edx
   41ded:	be 00 00 00 00       	mov    $0x0,%esi
   41df2:	48 89 c7             	mov    %rax,%rdi
   41df5:	e8 b0 13 00 00       	callq  431aa <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41dfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dfe:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41e05:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41e07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e0b:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41e12:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41e16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e1a:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41e21:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41e25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e29:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41e30:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41e32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e36:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41e3d:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41e41:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e44:	83 e0 01             	and    $0x1,%eax
   41e47:	85 c0                	test   %eax,%eax
   41e49:	74 1c                	je     41e67 <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41e4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e4f:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e56:	80 cc 30             	or     $0x30,%ah
   41e59:	48 89 c2             	mov    %rax,%rdx
   41e5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e60:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41e67:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e6a:	83 e0 02             	and    $0x2,%eax
   41e6d:	85 c0                	test   %eax,%eax
   41e6f:	74 1c                	je     41e8d <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41e71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e75:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e7c:	80 e4 fd             	and    $0xfd,%ah
   41e7f:	48 89 c2             	mov    %rax,%rdx
   41e82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e86:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41e8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e91:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41e98:	90                   	nop
   41e99:	c9                   	leaveq 
   41e9a:	c3                   	retq   

0000000000041e9b <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41e9b:	55                   	push   %rbp
   41e9c:	48 89 e5             	mov    %rsp,%rbp
   41e9f:	48 83 ec 28          	sub    $0x28,%rsp
   41ea3:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41ea6:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41eaa:	78 09                	js     41eb5 <console_show_cursor+0x1a>
   41eac:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41eb3:	7e 07                	jle    41ebc <console_show_cursor+0x21>
        cpos = 0;
   41eb5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41ebc:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41ec3:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ec7:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41ecb:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41ece:	ee                   	out    %al,(%dx)
}
   41ecf:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41ed0:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41ed3:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41ed9:	85 c0                	test   %eax,%eax
   41edb:	0f 48 c2             	cmovs  %edx,%eax
   41ede:	c1 f8 08             	sar    $0x8,%eax
   41ee1:	0f b6 c0             	movzbl %al,%eax
   41ee4:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41eeb:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41eee:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41ef2:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ef5:	ee                   	out    %al,(%dx)
}
   41ef6:	90                   	nop
   41ef7:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41efe:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f02:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41f06:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f09:	ee                   	out    %al,(%dx)
}
   41f0a:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41f0b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f0e:	99                   	cltd   
   41f0f:	c1 ea 18             	shr    $0x18,%edx
   41f12:	01 d0                	add    %edx,%eax
   41f14:	0f b6 c0             	movzbl %al,%eax
   41f17:	29 d0                	sub    %edx,%eax
   41f19:	0f b6 c0             	movzbl %al,%eax
   41f1c:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41f23:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f26:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f2a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f2d:	ee                   	out    %al,(%dx)
}
   41f2e:	90                   	nop
}
   41f2f:	90                   	nop
   41f30:	c9                   	leaveq 
   41f31:	c3                   	retq   

0000000000041f32 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41f32:	55                   	push   %rbp
   41f33:	48 89 e5             	mov    %rsp,%rbp
   41f36:	48 83 ec 20          	sub    $0x20,%rsp
   41f3a:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f41:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f44:	89 c2                	mov    %eax,%edx
   41f46:	ec                   	in     (%dx),%al
   41f47:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41f4a:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41f4e:	0f b6 c0             	movzbl %al,%eax
   41f51:	83 e0 01             	and    $0x1,%eax
   41f54:	85 c0                	test   %eax,%eax
   41f56:	75 0a                	jne    41f62 <keyboard_readc+0x30>
        return -1;
   41f58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41f5d:	e9 e7 01 00 00       	jmpq   42149 <keyboard_readc+0x217>
   41f62:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f69:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f6c:	89 c2                	mov    %eax,%edx
   41f6e:	ec                   	in     (%dx),%al
   41f6f:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41f72:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41f76:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41f79:	0f b6 05 62 24 01 00 	movzbl 0x12462(%rip),%eax        # 543e2 <last_escape.2>
   41f80:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41f83:	c6 05 58 24 01 00 00 	movb   $0x0,0x12458(%rip)        # 543e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41f8a:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41f8e:	75 11                	jne    41fa1 <keyboard_readc+0x6f>
        last_escape = 0x80;
   41f90:	c6 05 4b 24 01 00 80 	movb   $0x80,0x1244b(%rip)        # 543e2 <last_escape.2>
        return 0;
   41f97:	b8 00 00 00 00       	mov    $0x0,%eax
   41f9c:	e9 a8 01 00 00       	jmpq   42149 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41fa1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fa5:	84 c0                	test   %al,%al
   41fa7:	79 60                	jns    42009 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41fa9:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fad:	83 e0 7f             	and    $0x7f,%eax
   41fb0:	89 c2                	mov    %eax,%edx
   41fb2:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41fb6:	09 d0                	or     %edx,%eax
   41fb8:	48 98                	cltq   
   41fba:	0f b6 80 e0 4a 04 00 	movzbl 0x44ae0(%rax),%eax
   41fc1:	0f b6 c0             	movzbl %al,%eax
   41fc4:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41fc7:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41fce:	7e 2f                	jle    41fff <keyboard_readc+0xcd>
   41fd0:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41fd7:	7f 26                	jg     41fff <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41fd9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41fdc:	2d fa 00 00 00       	sub    $0xfa,%eax
   41fe1:	ba 01 00 00 00       	mov    $0x1,%edx
   41fe6:	89 c1                	mov    %eax,%ecx
   41fe8:	d3 e2                	shl    %cl,%edx
   41fea:	89 d0                	mov    %edx,%eax
   41fec:	f7 d0                	not    %eax
   41fee:	89 c2                	mov    %eax,%edx
   41ff0:	0f b6 05 ec 23 01 00 	movzbl 0x123ec(%rip),%eax        # 543e3 <modifiers.1>
   41ff7:	21 d0                	and    %edx,%eax
   41ff9:	88 05 e4 23 01 00    	mov    %al,0x123e4(%rip)        # 543e3 <modifiers.1>
        }
        return 0;
   41fff:	b8 00 00 00 00       	mov    $0x0,%eax
   42004:	e9 40 01 00 00       	jmpq   42149 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   42009:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4200d:	0a 45 fa             	or     -0x6(%rbp),%al
   42010:	0f b6 c0             	movzbl %al,%eax
   42013:	48 98                	cltq   
   42015:	0f b6 80 e0 4a 04 00 	movzbl 0x44ae0(%rax),%eax
   4201c:	0f b6 c0             	movzbl %al,%eax
   4201f:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42022:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42026:	7e 57                	jle    4207f <keyboard_readc+0x14d>
   42028:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   4202c:	7f 51                	jg     4207f <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   4202e:	0f b6 05 ae 23 01 00 	movzbl 0x123ae(%rip),%eax        # 543e3 <modifiers.1>
   42035:	0f b6 c0             	movzbl %al,%eax
   42038:	83 e0 02             	and    $0x2,%eax
   4203b:	85 c0                	test   %eax,%eax
   4203d:	74 09                	je     42048 <keyboard_readc+0x116>
            ch -= 0x60;
   4203f:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42043:	e9 fd 00 00 00       	jmpq   42145 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42048:	0f b6 05 94 23 01 00 	movzbl 0x12394(%rip),%eax        # 543e3 <modifiers.1>
   4204f:	0f b6 c0             	movzbl %al,%eax
   42052:	83 e0 01             	and    $0x1,%eax
   42055:	85 c0                	test   %eax,%eax
   42057:	0f 94 c2             	sete   %dl
   4205a:	0f b6 05 82 23 01 00 	movzbl 0x12382(%rip),%eax        # 543e3 <modifiers.1>
   42061:	0f b6 c0             	movzbl %al,%eax
   42064:	83 e0 08             	and    $0x8,%eax
   42067:	85 c0                	test   %eax,%eax
   42069:	0f 94 c0             	sete   %al
   4206c:	31 d0                	xor    %edx,%eax
   4206e:	84 c0                	test   %al,%al
   42070:	0f 84 cf 00 00 00    	je     42145 <keyboard_readc+0x213>
            ch -= 0x20;
   42076:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4207a:	e9 c6 00 00 00       	jmpq   42145 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4207f:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42086:	7e 30                	jle    420b8 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42088:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4208b:	2d fa 00 00 00       	sub    $0xfa,%eax
   42090:	ba 01 00 00 00       	mov    $0x1,%edx
   42095:	89 c1                	mov    %eax,%ecx
   42097:	d3 e2                	shl    %cl,%edx
   42099:	89 d0                	mov    %edx,%eax
   4209b:	89 c2                	mov    %eax,%edx
   4209d:	0f b6 05 3f 23 01 00 	movzbl 0x1233f(%rip),%eax        # 543e3 <modifiers.1>
   420a4:	31 d0                	xor    %edx,%eax
   420a6:	88 05 37 23 01 00    	mov    %al,0x12337(%rip)        # 543e3 <modifiers.1>
        ch = 0;
   420ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   420b3:	e9 8e 00 00 00       	jmpq   42146 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   420b8:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   420bf:	7e 2d                	jle    420ee <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   420c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420c4:	2d fa 00 00 00       	sub    $0xfa,%eax
   420c9:	ba 01 00 00 00       	mov    $0x1,%edx
   420ce:	89 c1                	mov    %eax,%ecx
   420d0:	d3 e2                	shl    %cl,%edx
   420d2:	89 d0                	mov    %edx,%eax
   420d4:	89 c2                	mov    %eax,%edx
   420d6:	0f b6 05 06 23 01 00 	movzbl 0x12306(%rip),%eax        # 543e3 <modifiers.1>
   420dd:	09 d0                	or     %edx,%eax
   420df:	88 05 fe 22 01 00    	mov    %al,0x122fe(%rip)        # 543e3 <modifiers.1>
        ch = 0;
   420e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   420ec:	eb 58                	jmp    42146 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   420ee:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   420f2:	7e 31                	jle    42125 <keyboard_readc+0x1f3>
   420f4:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   420fb:	7f 28                	jg     42125 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   420fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42100:	8d 50 80             	lea    -0x80(%rax),%edx
   42103:	0f b6 05 d9 22 01 00 	movzbl 0x122d9(%rip),%eax        # 543e3 <modifiers.1>
   4210a:	0f b6 c0             	movzbl %al,%eax
   4210d:	83 e0 03             	and    $0x3,%eax
   42110:	48 98                	cltq   
   42112:	48 63 d2             	movslq %edx,%rdx
   42115:	0f b6 84 90 e0 4b 04 	movzbl 0x44be0(%rax,%rdx,4),%eax
   4211c:	00 
   4211d:	0f b6 c0             	movzbl %al,%eax
   42120:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42123:	eb 21                	jmp    42146 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42125:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42129:	7f 1b                	jg     42146 <keyboard_readc+0x214>
   4212b:	0f b6 05 b1 22 01 00 	movzbl 0x122b1(%rip),%eax        # 543e3 <modifiers.1>
   42132:	0f b6 c0             	movzbl %al,%eax
   42135:	83 e0 02             	and    $0x2,%eax
   42138:	85 c0                	test   %eax,%eax
   4213a:	74 0a                	je     42146 <keyboard_readc+0x214>
        ch = 0;
   4213c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42143:	eb 01                	jmp    42146 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42145:	90                   	nop
    }

    return ch;
   42146:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42149:	c9                   	leaveq 
   4214a:	c3                   	retq   

000000000004214b <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   4214b:	55                   	push   %rbp
   4214c:	48 89 e5             	mov    %rsp,%rbp
   4214f:	48 83 ec 20          	sub    $0x20,%rsp
   42153:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4215a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4215d:	89 c2                	mov    %eax,%edx
   4215f:	ec                   	in     (%dx),%al
   42160:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42163:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   4216a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4216d:	89 c2                	mov    %eax,%edx
   4216f:	ec                   	in     (%dx),%al
   42170:	88 45 eb             	mov    %al,-0x15(%rbp)
   42173:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   4217a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4217d:	89 c2                	mov    %eax,%edx
   4217f:	ec                   	in     (%dx),%al
   42180:	88 45 f3             	mov    %al,-0xd(%rbp)
   42183:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   4218a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4218d:	89 c2                	mov    %eax,%edx
   4218f:	ec                   	in     (%dx),%al
   42190:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42193:	90                   	nop
   42194:	c9                   	leaveq 
   42195:	c3                   	retq   

0000000000042196 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42196:	55                   	push   %rbp
   42197:	48 89 e5             	mov    %rsp,%rbp
   4219a:	48 83 ec 40          	sub    $0x40,%rsp
   4219e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   421a2:	89 f0                	mov    %esi,%eax
   421a4:	89 55 c0             	mov    %edx,-0x40(%rbp)
   421a7:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   421aa:	8b 05 34 22 01 00    	mov    0x12234(%rip),%eax        # 543e4 <initialized.0>
   421b0:	85 c0                	test   %eax,%eax
   421b2:	75 1e                	jne    421d2 <parallel_port_putc+0x3c>
   421b4:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   421bb:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421bf:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   421c3:	8b 55 f8             	mov    -0x8(%rbp),%edx
   421c6:	ee                   	out    %al,(%dx)
}
   421c7:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   421c8:	c7 05 12 22 01 00 01 	movl   $0x1,0x12212(%rip)        # 543e4 <initialized.0>
   421cf:	00 00 00 
    }

    for (int i = 0;
   421d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421d9:	eb 09                	jmp    421e4 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   421db:	e8 6b ff ff ff       	callq  4214b <delay>
         ++i) {
   421e0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   421e4:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   421eb:	7f 18                	jg     42205 <parallel_port_putc+0x6f>
   421ed:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421f4:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421f7:	89 c2                	mov    %eax,%edx
   421f9:	ec                   	in     (%dx),%al
   421fa:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   421fd:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42201:	84 c0                	test   %al,%al
   42203:	79 d6                	jns    421db <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   42205:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42209:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42210:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42213:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42217:	8b 55 d8             	mov    -0x28(%rbp),%edx
   4221a:	ee                   	out    %al,(%dx)
}
   4221b:	90                   	nop
   4221c:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42223:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42227:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   4222b:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4222e:	ee                   	out    %al,(%dx)
}
   4222f:	90                   	nop
   42230:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42237:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4223b:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4223f:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42242:	ee                   	out    %al,(%dx)
}
   42243:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42244:	90                   	nop
   42245:	c9                   	leaveq 
   42246:	c3                   	retq   

0000000000042247 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42247:	55                   	push   %rbp
   42248:	48 89 e5             	mov    %rsp,%rbp
   4224b:	48 83 ec 20          	sub    $0x20,%rsp
   4224f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42253:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42257:	48 c7 45 f8 96 21 04 	movq   $0x42196,-0x8(%rbp)
   4225e:	00 
    printer_vprintf(&p, 0, format, val);
   4225f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42263:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42267:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4226b:	be 00 00 00 00       	mov    $0x0,%esi
   42270:	48 89 c7             	mov    %rax,%rdi
   42273:	e8 43 10 00 00       	callq  432bb <printer_vprintf>
}
   42278:	90                   	nop
   42279:	c9                   	leaveq 
   4227a:	c3                   	retq   

000000000004227b <log_printf>:

void log_printf(const char* format, ...) {
   4227b:	55                   	push   %rbp
   4227c:	48 89 e5             	mov    %rsp,%rbp
   4227f:	48 83 ec 60          	sub    $0x60,%rsp
   42283:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42287:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4228b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4228f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42293:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42297:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4229b:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   422a2:	48 8d 45 10          	lea    0x10(%rbp),%rax
   422a6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   422aa:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   422ae:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   422b2:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   422b6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   422ba:	48 89 d6             	mov    %rdx,%rsi
   422bd:	48 89 c7             	mov    %rax,%rdi
   422c0:	e8 82 ff ff ff       	callq  42247 <log_vprintf>
    va_end(val);
}
   422c5:	90                   	nop
   422c6:	c9                   	leaveq 
   422c7:	c3                   	retq   

00000000000422c8 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   422c8:	55                   	push   %rbp
   422c9:	48 89 e5             	mov    %rsp,%rbp
   422cc:	48 83 ec 40          	sub    $0x40,%rsp
   422d0:	89 7d dc             	mov    %edi,-0x24(%rbp)
   422d3:	89 75 d8             	mov    %esi,-0x28(%rbp)
   422d6:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   422da:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   422de:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   422e2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   422e6:	48 8b 0a             	mov    (%rdx),%rcx
   422e9:	48 89 08             	mov    %rcx,(%rax)
   422ec:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   422f0:	48 89 48 08          	mov    %rcx,0x8(%rax)
   422f4:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   422f8:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   422fc:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42300:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42304:	48 89 d6             	mov    %rdx,%rsi
   42307:	48 89 c7             	mov    %rax,%rdi
   4230a:	e8 38 ff ff ff       	callq  42247 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4230f:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42313:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42317:	8b 75 d8             	mov    -0x28(%rbp),%esi
   4231a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4231d:	89 c7                	mov    %eax,%edi
   4231f:	e8 76 16 00 00       	callq  4399a <console_vprintf>
}
   42324:	c9                   	leaveq 
   42325:	c3                   	retq   

0000000000042326 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42326:	55                   	push   %rbp
   42327:	48 89 e5             	mov    %rsp,%rbp
   4232a:	48 83 ec 60          	sub    $0x60,%rsp
   4232e:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42331:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42334:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42338:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4233c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42340:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42344:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4234b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4234f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42353:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42357:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   4235b:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4235f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42363:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42366:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42369:	89 c7                	mov    %eax,%edi
   4236b:	e8 58 ff ff ff       	callq  422c8 <error_vprintf>
   42370:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42373:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42376:	c9                   	leaveq 
   42377:	c3                   	retq   

0000000000042378 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42378:	55                   	push   %rbp
   42379:	48 89 e5             	mov    %rsp,%rbp
   4237c:	53                   	push   %rbx
   4237d:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42381:	e8 ac fb ff ff       	callq  41f32 <keyboard_readc>
   42386:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42389:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4238d:	74 1c                	je     423ab <check_keyboard+0x33>
   4238f:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   42393:	74 16                	je     423ab <check_keyboard+0x33>
   42395:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42399:	74 10                	je     423ab <check_keyboard+0x33>
   4239b:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4239f:	74 0a                	je     423ab <check_keyboard+0x33>
   423a1:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   423a5:	0f 85 e9 00 00 00    	jne    42494 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   423ab:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   423b2:	00 
        memset(pt, 0, PAGESIZE * 3);
   423b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423b7:	ba 00 30 00 00       	mov    $0x3000,%edx
   423bc:	be 00 00 00 00       	mov    $0x0,%esi
   423c1:	48 89 c7             	mov    %rax,%rdi
   423c4:	e8 e1 0d 00 00       	callq  431aa <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   423c9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423cd:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   423d4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423d8:	48 05 00 10 00 00    	add    $0x1000,%rax
   423de:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   423e5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423e9:	48 05 00 20 00 00    	add    $0x2000,%rax
   423ef:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   423f6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423fa:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   423fe:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42402:	0f 22 d8             	mov    %rax,%cr3
}
   42405:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42406:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   4240d:	48 c7 45 e8 38 4c 04 	movq   $0x44c38,-0x18(%rbp)
   42414:	00 
        if (c == 'a') {
   42415:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42419:	75 0a                	jne    42425 <check_keyboard+0xad>
            argument = "allocator";
   4241b:	48 c7 45 e8 3f 4c 04 	movq   $0x44c3f,-0x18(%rbp)
   42422:	00 
   42423:	eb 2e                	jmp    42453 <check_keyboard+0xdb>
        } else if (c == 'c') {
   42425:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42429:	75 0a                	jne    42435 <check_keyboard+0xbd>
            argument = "alloctests";
   4242b:	48 c7 45 e8 49 4c 04 	movq   $0x44c49,-0x18(%rbp)
   42432:	00 
   42433:	eb 1e                	jmp    42453 <check_keyboard+0xdb>
        } else if(c == 't'){
   42435:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42439:	75 0a                	jne    42445 <check_keyboard+0xcd>
            argument = "test";
   4243b:	48 c7 45 e8 54 4c 04 	movq   $0x44c54,-0x18(%rbp)
   42442:	00 
   42443:	eb 0e                	jmp    42453 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42445:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42449:	75 08                	jne    42453 <check_keyboard+0xdb>
            argument = "test2";
   4244b:	48 c7 45 e8 59 4c 04 	movq   $0x44c59,-0x18(%rbp)
   42452:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42453:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42457:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   4245b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42460:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42464:	76 14                	jbe    4247a <check_keyboard+0x102>
   42466:	ba 5f 4c 04 00       	mov    $0x44c5f,%edx
   4246b:	be 5c 02 00 00       	mov    $0x25c,%esi
   42470:	bf 7b 4c 04 00       	mov    $0x44c7b,%edi
   42475:	e8 1f 01 00 00       	callq  42599 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   4247a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4247e:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42481:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42485:	48 89 c3             	mov    %rax,%rbx
   42488:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   4248d:	e9 6e db ff ff       	jmpq   40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42492:	eb 11                	jmp    424a5 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42494:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42498:	74 06                	je     424a0 <check_keyboard+0x128>
   4249a:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   4249e:	75 05                	jne    424a5 <check_keyboard+0x12d>
        poweroff();
   424a0:	e8 a3 f8 ff ff       	callq  41d48 <poweroff>
    }
    return c;
   424a5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   424a8:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   424ac:	c9                   	leaveq 
   424ad:	c3                   	retq   

00000000000424ae <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   424ae:	55                   	push   %rbp
   424af:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   424b2:	e8 c1 fe ff ff       	callq  42378 <check_keyboard>
   424b7:	eb f9                	jmp    424b2 <fail+0x4>

00000000000424b9 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   424b9:	55                   	push   %rbp
   424ba:	48 89 e5             	mov    %rsp,%rbp
   424bd:	48 83 ec 60          	sub    $0x60,%rsp
   424c1:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   424c5:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   424c9:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   424cd:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   424d1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   424d5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   424d9:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   424e0:	48 8d 45 10          	lea    0x10(%rbp),%rax
   424e4:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   424e8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   424ec:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   424f0:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   424f5:	0f 84 80 00 00 00    	je     4257b <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   424fb:	ba 88 4c 04 00       	mov    $0x44c88,%edx
   42500:	be 00 c0 00 00       	mov    $0xc000,%esi
   42505:	bf 30 07 00 00       	mov    $0x730,%edi
   4250a:	b8 00 00 00 00       	mov    $0x0,%eax
   4250f:	e8 12 fe ff ff       	callq  42326 <error_printf>
   42514:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42517:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4251b:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   4251f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42522:	be 00 c0 00 00       	mov    $0xc000,%esi
   42527:	89 c7                	mov    %eax,%edi
   42529:	e8 9a fd ff ff       	callq  422c8 <error_vprintf>
   4252e:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42531:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42534:	48 63 c1             	movslq %ecx,%rax
   42537:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4253e:	48 c1 e8 20          	shr    $0x20,%rax
   42542:	c1 f8 05             	sar    $0x5,%eax
   42545:	89 ce                	mov    %ecx,%esi
   42547:	c1 fe 1f             	sar    $0x1f,%esi
   4254a:	29 f0                	sub    %esi,%eax
   4254c:	89 c2                	mov    %eax,%edx
   4254e:	89 d0                	mov    %edx,%eax
   42550:	c1 e0 02             	shl    $0x2,%eax
   42553:	01 d0                	add    %edx,%eax
   42555:	c1 e0 04             	shl    $0x4,%eax
   42558:	29 c1                	sub    %eax,%ecx
   4255a:	89 ca                	mov    %ecx,%edx
   4255c:	85 d2                	test   %edx,%edx
   4255e:	74 34                	je     42594 <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42560:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42563:	ba 90 4c 04 00       	mov    $0x44c90,%edx
   42568:	be 00 c0 00 00       	mov    $0xc000,%esi
   4256d:	89 c7                	mov    %eax,%edi
   4256f:	b8 00 00 00 00       	mov    $0x0,%eax
   42574:	e8 ad fd ff ff       	callq  42326 <error_printf>
   42579:	eb 19                	jmp    42594 <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   4257b:	ba 92 4c 04 00       	mov    $0x44c92,%edx
   42580:	be 00 c0 00 00       	mov    $0xc000,%esi
   42585:	bf 30 07 00 00       	mov    $0x730,%edi
   4258a:	b8 00 00 00 00       	mov    $0x0,%eax
   4258f:	e8 92 fd ff ff       	callq  42326 <error_printf>
    }

    va_end(val);
    fail();
   42594:	e8 15 ff ff ff       	callq  424ae <fail>

0000000000042599 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42599:	55                   	push   %rbp
   4259a:	48 89 e5             	mov    %rsp,%rbp
   4259d:	48 83 ec 20          	sub    $0x20,%rsp
   425a1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425a5:	89 75 f4             	mov    %esi,-0xc(%rbp)
   425a8:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   425ac:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   425b0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   425b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425b7:	48 89 c6             	mov    %rax,%rsi
   425ba:	bf 98 4c 04 00       	mov    $0x44c98,%edi
   425bf:	b8 00 00 00 00       	mov    $0x0,%eax
   425c4:	e8 f0 fe ff ff       	callq  424b9 <kernel_panic>

00000000000425c9 <default_exception>:
}

void default_exception(proc* p){
   425c9:	55                   	push   %rbp
   425ca:	48 89 e5             	mov    %rsp,%rbp
   425cd:	48 83 ec 20          	sub    $0x20,%rsp
   425d1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   425d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   425d9:	48 83 c0 18          	add    $0x18,%rax
   425dd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   425e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425e5:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   425ec:	48 89 c6             	mov    %rax,%rsi
   425ef:	bf b6 4c 04 00       	mov    $0x44cb6,%edi
   425f4:	b8 00 00 00 00       	mov    $0x0,%eax
   425f9:	e8 bb fe ff ff       	callq  424b9 <kernel_panic>

00000000000425fe <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   425fe:	55                   	push   %rbp
   425ff:	48 89 e5             	mov    %rsp,%rbp
   42602:	48 83 ec 10          	sub    $0x10,%rsp
   42606:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4260a:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   4260d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42611:	78 06                	js     42619 <pageindex+0x1b>
   42613:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42617:	7e 14                	jle    4262d <pageindex+0x2f>
   42619:	ba d0 4c 04 00       	mov    $0x44cd0,%edx
   4261e:	be 1e 00 00 00       	mov    $0x1e,%esi
   42623:	bf e9 4c 04 00       	mov    $0x44ce9,%edi
   42628:	e8 6c ff ff ff       	callq  42599 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   4262d:	b8 03 00 00 00       	mov    $0x3,%eax
   42632:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42635:	89 c2                	mov    %eax,%edx
   42637:	89 d0                	mov    %edx,%eax
   42639:	c1 e0 03             	shl    $0x3,%eax
   4263c:	01 d0                	add    %edx,%eax
   4263e:	83 c0 0c             	add    $0xc,%eax
   42641:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42645:	89 c1                	mov    %eax,%ecx
   42647:	48 d3 ea             	shr    %cl,%rdx
   4264a:	48 89 d0             	mov    %rdx,%rax
   4264d:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42652:	c9                   	leaveq 
   42653:	c3                   	retq   

0000000000042654 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42654:	55                   	push   %rbp
   42655:	48 89 e5             	mov    %rsp,%rbp
   42658:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   4265c:	48 c7 05 99 29 01 00 	movq   $0x56000,0x12999(%rip)        # 55000 <kernel_pagetable>
   42663:	00 60 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42667:	ba 00 50 00 00       	mov    $0x5000,%edx
   4266c:	be 00 00 00 00       	mov    $0x0,%esi
   42671:	bf 00 60 05 00       	mov    $0x56000,%edi
   42676:	e8 2f 0b 00 00       	callq  431aa <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   4267b:	b8 00 70 05 00       	mov    $0x57000,%eax
   42680:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42684:	48 89 05 75 39 01 00 	mov    %rax,0x13975(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   4268b:	b8 00 80 05 00       	mov    $0x58000,%eax
   42690:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42694:	48 89 05 65 49 01 00 	mov    %rax,0x14965(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   4269b:	b8 00 90 05 00       	mov    $0x59000,%eax
   426a0:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   426a4:	48 89 05 55 59 01 00 	mov    %rax,0x15955(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   426ab:	b8 00 a0 05 00       	mov    $0x5a000,%eax
   426b0:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   426b4:	48 89 05 4d 59 01 00 	mov    %rax,0x1594d(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   426bb:	48 8b 05 3e 29 01 00 	mov    0x1293e(%rip),%rax        # 55000 <kernel_pagetable>
   426c2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   426c8:	b9 00 00 20 00       	mov    $0x200000,%ecx
   426cd:	ba 00 00 00 00       	mov    $0x0,%edx
   426d2:	be 00 00 00 00       	mov    $0x0,%esi
   426d7:	48 89 c7             	mov    %rax,%rdi
   426da:	e8 b9 01 00 00       	callq  42898 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   426df:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   426e6:	00 
   426e7:	eb 62                	jmp    4274b <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   426e9:	48 8b 0d 10 29 01 00 	mov    0x12910(%rip),%rcx        # 55000 <kernel_pagetable>
   426f0:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   426f4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   426f8:	48 89 ce             	mov    %rcx,%rsi
   426fb:	48 89 c7             	mov    %rax,%rdi
   426fe:	e8 58 05 00 00       	callq  42c5b <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   42703:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42707:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4270b:	74 14                	je     42721 <virtual_memory_init+0xcd>
   4270d:	ba f2 4c 04 00       	mov    $0x44cf2,%edx
   42712:	be 2d 00 00 00       	mov    $0x2d,%esi
   42717:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   4271c:	e8 78 fe ff ff       	callq  42599 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42721:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42724:	48 98                	cltq   
   42726:	83 e0 03             	and    $0x3,%eax
   42729:	48 83 f8 03          	cmp    $0x3,%rax
   4272d:	74 14                	je     42743 <virtual_memory_init+0xef>
   4272f:	ba 08 4d 04 00       	mov    $0x44d08,%edx
   42734:	be 2e 00 00 00       	mov    $0x2e,%esi
   42739:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   4273e:	e8 56 fe ff ff       	callq  42599 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42743:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4274a:	00 
   4274b:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42752:	00 
   42753:	76 94                	jbe    426e9 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42755:	48 8b 05 a4 28 01 00 	mov    0x128a4(%rip),%rax        # 55000 <kernel_pagetable>
   4275c:	48 89 c7             	mov    %rax,%rdi
   4275f:	e8 03 00 00 00       	callq  42767 <set_pagetable>
}
   42764:	90                   	nop
   42765:	c9                   	leaveq 
   42766:	c3                   	retq   

0000000000042767 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42767:	55                   	push   %rbp
   42768:	48 89 e5             	mov    %rsp,%rbp
   4276b:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4276f:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42773:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42777:	25 ff 0f 00 00       	and    $0xfff,%eax
   4277c:	48 85 c0             	test   %rax,%rax
   4277f:	74 14                	je     42795 <set_pagetable+0x2e>
   42781:	ba 35 4d 04 00       	mov    $0x44d35,%edx
   42786:	be 3d 00 00 00       	mov    $0x3d,%esi
   4278b:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   42790:	e8 04 fe ff ff       	callq  42599 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42795:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4279a:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   4279e:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   427a2:	48 89 ce             	mov    %rcx,%rsi
   427a5:	48 89 c7             	mov    %rax,%rdi
   427a8:	e8 ae 04 00 00       	callq  42c5b <virtual_memory_lookup>
   427ad:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   427b1:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   427b6:	48 39 d0             	cmp    %rdx,%rax
   427b9:	74 14                	je     427cf <set_pagetable+0x68>
   427bb:	ba 50 4d 04 00       	mov    $0x44d50,%edx
   427c0:	be 3f 00 00 00       	mov    $0x3f,%esi
   427c5:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   427ca:	e8 ca fd ff ff       	callq  42599 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   427cf:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   427d3:	48 8b 0d 26 28 01 00 	mov    0x12826(%rip),%rcx        # 55000 <kernel_pagetable>
   427da:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   427de:	48 89 ce             	mov    %rcx,%rsi
   427e1:	48 89 c7             	mov    %rax,%rdi
   427e4:	e8 72 04 00 00       	callq  42c5b <virtual_memory_lookup>
   427e9:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   427ed:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427f1:	48 39 c2             	cmp    %rax,%rdx
   427f4:	74 14                	je     4280a <set_pagetable+0xa3>
   427f6:	ba b8 4d 04 00       	mov    $0x44db8,%edx
   427fb:	be 41 00 00 00       	mov    $0x41,%esi
   42800:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   42805:	e8 8f fd ff ff       	callq  42599 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   4280a:	48 8b 05 ef 27 01 00 	mov    0x127ef(%rip),%rax        # 55000 <kernel_pagetable>
   42811:	48 89 c2             	mov    %rax,%rdx
   42814:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42818:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4281c:	48 89 ce             	mov    %rcx,%rsi
   4281f:	48 89 c7             	mov    %rax,%rdi
   42822:	e8 34 04 00 00       	callq  42c5b <virtual_memory_lookup>
   42827:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4282b:	48 8b 15 ce 27 01 00 	mov    0x127ce(%rip),%rdx        # 55000 <kernel_pagetable>
   42832:	48 39 d0             	cmp    %rdx,%rax
   42835:	74 14                	je     4284b <set_pagetable+0xe4>
   42837:	ba 18 4e 04 00       	mov    $0x44e18,%edx
   4283c:	be 43 00 00 00       	mov    $0x43,%esi
   42841:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   42846:	e8 4e fd ff ff       	callq  42599 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   4284b:	ba 98 28 04 00       	mov    $0x42898,%edx
   42850:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42854:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42858:	48 89 ce             	mov    %rcx,%rsi
   4285b:	48 89 c7             	mov    %rax,%rdi
   4285e:	e8 f8 03 00 00       	callq  42c5b <virtual_memory_lookup>
   42863:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42867:	ba 98 28 04 00       	mov    $0x42898,%edx
   4286c:	48 39 d0             	cmp    %rdx,%rax
   4286f:	74 14                	je     42885 <set_pagetable+0x11e>
   42871:	ba 80 4e 04 00       	mov    $0x44e80,%edx
   42876:	be 45 00 00 00       	mov    $0x45,%esi
   4287b:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   42880:	e8 14 fd ff ff       	callq  42599 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42885:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42889:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4288d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42891:	0f 22 d8             	mov    %rax,%cr3
}
   42894:	90                   	nop
}
   42895:	90                   	nop
   42896:	c9                   	leaveq 
   42897:	c3                   	retq   

0000000000042898 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42898:	55                   	push   %rbp
   42899:	48 89 e5             	mov    %rsp,%rbp
   4289c:	53                   	push   %rbx
   4289d:	48 83 ec 58          	sub    $0x58,%rsp
   428a1:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   428a5:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   428a9:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   428ad:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   428b1:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   428b5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   428b9:	25 ff 0f 00 00       	and    $0xfff,%eax
   428be:	48 85 c0             	test   %rax,%rax
   428c1:	74 14                	je     428d7 <virtual_memory_map+0x3f>
   428c3:	ba e6 4e 04 00       	mov    $0x44ee6,%edx
   428c8:	be 66 00 00 00       	mov    $0x66,%esi
   428cd:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   428d2:	e8 c2 fc ff ff       	callq  42599 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   428d7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428db:	25 ff 0f 00 00       	and    $0xfff,%eax
   428e0:	48 85 c0             	test   %rax,%rax
   428e3:	74 14                	je     428f9 <virtual_memory_map+0x61>
   428e5:	ba f9 4e 04 00       	mov    $0x44ef9,%edx
   428ea:	be 67 00 00 00       	mov    $0x67,%esi
   428ef:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   428f4:	e8 a0 fc ff ff       	callq  42599 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   428f9:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428fd:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42901:	48 01 d0             	add    %rdx,%rax
   42904:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   42908:	76 24                	jbe    4292e <virtual_memory_map+0x96>
   4290a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4290e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42912:	48 01 d0             	add    %rdx,%rax
   42915:	48 85 c0             	test   %rax,%rax
   42918:	74 14                	je     4292e <virtual_memory_map+0x96>
   4291a:	ba 0c 4f 04 00       	mov    $0x44f0c,%edx
   4291f:	be 68 00 00 00       	mov    $0x68,%esi
   42924:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   42929:	e8 6b fc ff ff       	callq  42599 <assert_fail>
    if (perm & PTE_P) {
   4292e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42931:	48 98                	cltq   
   42933:	83 e0 01             	and    $0x1,%eax
   42936:	48 85 c0             	test   %rax,%rax
   42939:	74 6e                	je     429a9 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   4293b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4293f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42944:	48 85 c0             	test   %rax,%rax
   42947:	74 14                	je     4295d <virtual_memory_map+0xc5>
   42949:	ba 2a 4f 04 00       	mov    $0x44f2a,%edx
   4294e:	be 6a 00 00 00       	mov    $0x6a,%esi
   42953:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   42958:	e8 3c fc ff ff       	callq  42599 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   4295d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42961:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42965:	48 01 d0             	add    %rdx,%rax
   42968:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   4296c:	76 14                	jbe    42982 <virtual_memory_map+0xea>
   4296e:	ba 3d 4f 04 00       	mov    $0x44f3d,%edx
   42973:	be 6b 00 00 00       	mov    $0x6b,%esi
   42978:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   4297d:	e8 17 fc ff ff       	callq  42599 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42982:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42986:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4298a:	48 01 d0             	add    %rdx,%rax
   4298d:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42993:	76 14                	jbe    429a9 <virtual_memory_map+0x111>
   42995:	ba 4b 4f 04 00       	mov    $0x44f4b,%edx
   4299a:	be 6c 00 00 00       	mov    $0x6c,%esi
   4299f:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   429a4:	e8 f0 fb ff ff       	callq  42599 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   429a9:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   429ad:	78 09                	js     429b8 <virtual_memory_map+0x120>
   429af:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   429b6:	7e 14                	jle    429cc <virtual_memory_map+0x134>
   429b8:	ba 67 4f 04 00       	mov    $0x44f67,%edx
   429bd:	be 6e 00 00 00       	mov    $0x6e,%esi
   429c2:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   429c7:	e8 cd fb ff ff       	callq  42599 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   429cc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429d0:	25 ff 0f 00 00       	and    $0xfff,%eax
   429d5:	48 85 c0             	test   %rax,%rax
   429d8:	74 14                	je     429ee <virtual_memory_map+0x156>
   429da:	ba 88 4f 04 00       	mov    $0x44f88,%edx
   429df:	be 6f 00 00 00       	mov    $0x6f,%esi
   429e4:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   429e9:	e8 ab fb ff ff       	callq  42599 <assert_fail>

    int last_index123 = -1;
   429ee:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   429f5:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   429fc:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   429fd:	e9 e1 00 00 00       	jmpq   42ae3 <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42a02:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a06:	48 c1 e8 15          	shr    $0x15,%rax
   42a0a:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42a0d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42a10:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42a13:	74 20                	je     42a35 <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42a15:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42a18:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42a1c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42a20:	48 89 ce             	mov    %rcx,%rsi
   42a23:	48 89 c7             	mov    %rax,%rdi
   42a26:	e8 ce 00 00 00       	callq  42af9 <lookup_l4pagetable>
   42a2b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42a2f:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42a32:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42a35:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a38:	48 98                	cltq   
   42a3a:	83 e0 01             	and    $0x1,%eax
   42a3d:	48 85 c0             	test   %rax,%rax
   42a40:	74 34                	je     42a76 <virtual_memory_map+0x1de>
   42a42:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a47:	74 2d                	je     42a76 <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42a49:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a4c:	48 63 d8             	movslq %eax,%rbx
   42a4f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a53:	be 03 00 00 00       	mov    $0x3,%esi
   42a58:	48 89 c7             	mov    %rax,%rdi
   42a5b:	e8 9e fb ff ff       	callq  425fe <pageindex>
   42a60:	89 c2                	mov    %eax,%edx
   42a62:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42a66:	48 89 d9             	mov    %rbx,%rcx
   42a69:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a6d:	48 63 d2             	movslq %edx,%rdx
   42a70:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a74:	eb 55                	jmp    42acb <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42a76:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a7b:	74 26                	je     42aa3 <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42a7d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a81:	be 03 00 00 00       	mov    $0x3,%esi
   42a86:	48 89 c7             	mov    %rax,%rdi
   42a89:	e8 70 fb ff ff       	callq  425fe <pageindex>
   42a8e:	89 c2                	mov    %eax,%edx
   42a90:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a93:	48 63 c8             	movslq %eax,%rcx
   42a96:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a9a:	48 63 d2             	movslq %edx,%rdx
   42a9d:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42aa1:	eb 28                	jmp    42acb <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42aa3:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42aa6:	48 98                	cltq   
   42aa8:	83 e0 01             	and    $0x1,%eax
   42aab:	48 85 c0             	test   %rax,%rax
   42aae:	74 1b                	je     42acb <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42ab0:	be 84 00 00 00       	mov    $0x84,%esi
   42ab5:	bf b0 4f 04 00       	mov    $0x44fb0,%edi
   42aba:	b8 00 00 00 00       	mov    $0x0,%eax
   42abf:	e8 b7 f7 ff ff       	callq  4227b <log_printf>
            return -1;
   42ac4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42ac9:	eb 28                	jmp    42af3 <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42acb:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42ad2:	00 
   42ad3:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42ada:	00 
   42adb:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42ae2:	00 
   42ae3:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42ae8:	0f 85 14 ff ff ff    	jne    42a02 <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42aee:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42af3:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42af7:	c9                   	leaveq 
   42af8:	c3                   	retq   

0000000000042af9 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42af9:	55                   	push   %rbp
   42afa:	48 89 e5             	mov    %rsp,%rbp
   42afd:	48 83 ec 40          	sub    $0x40,%rsp
   42b01:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42b05:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42b09:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42b0c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b10:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42b14:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42b1b:	e9 2b 01 00 00       	jmpq   42c4b <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42b20:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42b23:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b27:	89 d6                	mov    %edx,%esi
   42b29:	48 89 c7             	mov    %rax,%rdi
   42b2c:	e8 cd fa ff ff       	callq  425fe <pageindex>
   42b31:	89 c2                	mov    %eax,%edx
   42b33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b37:	48 63 d2             	movslq %edx,%rdx
   42b3a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42b3e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42b42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b46:	83 e0 01             	and    $0x1,%eax
   42b49:	48 85 c0             	test   %rax,%rax
   42b4c:	75 63                	jne    42bb1 <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42b4e:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42b51:	8d 48 02             	lea    0x2(%rax),%ecx
   42b54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b58:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b5d:	48 89 c2             	mov    %rax,%rdx
   42b60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b64:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b6a:	48 89 c6             	mov    %rax,%rsi
   42b6d:	bf f0 4f 04 00       	mov    $0x44ff0,%edi
   42b72:	b8 00 00 00 00       	mov    $0x0,%eax
   42b77:	e8 ff f6 ff ff       	callq  4227b <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42b7c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b7f:	48 98                	cltq   
   42b81:	83 e0 01             	and    $0x1,%eax
   42b84:	48 85 c0             	test   %rax,%rax
   42b87:	75 0a                	jne    42b93 <lookup_l4pagetable+0x9a>
                return NULL;
   42b89:	b8 00 00 00 00       	mov    $0x0,%eax
   42b8e:	e9 c6 00 00 00       	jmpq   42c59 <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42b93:	be a7 00 00 00       	mov    $0xa7,%esi
   42b98:	bf 58 50 04 00       	mov    $0x45058,%edi
   42b9d:	b8 00 00 00 00       	mov    $0x0,%eax
   42ba2:	e8 d4 f6 ff ff       	callq  4227b <log_printf>
            return NULL;
   42ba7:	b8 00 00 00 00       	mov    $0x0,%eax
   42bac:	e9 a8 00 00 00       	jmpq   42c59 <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42bb1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bb5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42bbb:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42bc1:	76 14                	jbe    42bd7 <lookup_l4pagetable+0xde>
   42bc3:	ba 98 50 04 00       	mov    $0x45098,%edx
   42bc8:	be ac 00 00 00       	mov    $0xac,%esi
   42bcd:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   42bd2:	e8 c2 f9 ff ff       	callq  42599 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42bd7:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bda:	48 98                	cltq   
   42bdc:	83 e0 02             	and    $0x2,%eax
   42bdf:	48 85 c0             	test   %rax,%rax
   42be2:	74 20                	je     42c04 <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42be4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42be8:	83 e0 02             	and    $0x2,%eax
   42beb:	48 85 c0             	test   %rax,%rax
   42bee:	75 14                	jne    42c04 <lookup_l4pagetable+0x10b>
   42bf0:	ba b8 50 04 00       	mov    $0x450b8,%edx
   42bf5:	be ae 00 00 00       	mov    $0xae,%esi
   42bfa:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   42bff:	e8 95 f9 ff ff       	callq  42599 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42c04:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c07:	48 98                	cltq   
   42c09:	83 e0 04             	and    $0x4,%eax
   42c0c:	48 85 c0             	test   %rax,%rax
   42c0f:	74 20                	je     42c31 <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42c11:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c15:	83 e0 04             	and    $0x4,%eax
   42c18:	48 85 c0             	test   %rax,%rax
   42c1b:	75 14                	jne    42c31 <lookup_l4pagetable+0x138>
   42c1d:	ba c3 50 04 00       	mov    $0x450c3,%edx
   42c22:	be b1 00 00 00       	mov    $0xb1,%esi
   42c27:	bf 02 4d 04 00       	mov    $0x44d02,%edi
   42c2c:	e8 68 f9 ff ff       	callq  42599 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42c31:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42c38:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c3d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c43:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42c47:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42c4b:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42c4f:	0f 8e cb fe ff ff    	jle    42b20 <lookup_l4pagetable+0x27>
    }
    return pt;
   42c55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42c59:	c9                   	leaveq 
   42c5a:	c3                   	retq   

0000000000042c5b <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42c5b:	55                   	push   %rbp
   42c5c:	48 89 e5             	mov    %rsp,%rbp
   42c5f:	48 83 ec 50          	sub    $0x50,%rsp
   42c63:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42c67:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42c6b:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c6f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c73:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42c77:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42c7e:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c7f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42c86:	eb 41                	jmp    42cc9 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42c88:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42c8b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c8f:	89 d6                	mov    %edx,%esi
   42c91:	48 89 c7             	mov    %rax,%rdi
   42c94:	e8 65 f9 ff ff       	callq  425fe <pageindex>
   42c99:	89 c2                	mov    %eax,%edx
   42c9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c9f:	48 63 d2             	movslq %edx,%rdx
   42ca2:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42ca6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42caa:	83 e0 06             	and    $0x6,%eax
   42cad:	48 f7 d0             	not    %rax
   42cb0:	48 21 d0             	and    %rdx,%rax
   42cb3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42cb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cbb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42cc1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42cc5:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42cc9:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42ccd:	7f 0c                	jg     42cdb <virtual_memory_lookup+0x80>
   42ccf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cd3:	83 e0 01             	and    $0x1,%eax
   42cd6:	48 85 c0             	test   %rax,%rax
   42cd9:	75 ad                	jne    42c88 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42cdb:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42ce2:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42ce9:	ff 
   42cea:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42cf1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cf5:	83 e0 01             	and    $0x1,%eax
   42cf8:	48 85 c0             	test   %rax,%rax
   42cfb:	74 34                	je     42d31 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42cfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d01:	48 c1 e8 0c          	shr    $0xc,%rax
   42d05:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42d08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d0c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d12:	48 89 c2             	mov    %rax,%rdx
   42d15:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42d19:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d1e:	48 09 d0             	or     %rdx,%rax
   42d21:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42d25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d29:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d2e:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42d31:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d35:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42d39:	48 89 10             	mov    %rdx,(%rax)
   42d3c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42d40:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42d44:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42d48:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42d4c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d50:	c9                   	leaveq 
   42d51:	c3                   	retq   

0000000000042d52 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42d52:	55                   	push   %rbp
   42d53:	48 89 e5             	mov    %rsp,%rbp
   42d56:	48 83 ec 40          	sub    $0x40,%rsp
   42d5a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42d5e:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42d61:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42d65:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42d6c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42d70:	78 08                	js     42d7a <program_load+0x28>
   42d72:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d75:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42d78:	7c 14                	jl     42d8e <program_load+0x3c>
   42d7a:	ba d0 50 04 00       	mov    $0x450d0,%edx
   42d7f:	be 37 00 00 00       	mov    $0x37,%esi
   42d84:	bf 00 51 04 00       	mov    $0x45100,%edi
   42d89:	e8 0b f8 ff ff       	callq  42599 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42d8e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d91:	48 98                	cltq   
   42d93:	48 c1 e0 04          	shl    $0x4,%rax
   42d97:	48 05 20 60 04 00    	add    $0x46020,%rax
   42d9d:	48 8b 00             	mov    (%rax),%rax
   42da0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42da4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42da8:	8b 00                	mov    (%rax),%eax
   42daa:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42daf:	74 14                	je     42dc5 <program_load+0x73>
   42db1:	ba 0b 51 04 00       	mov    $0x4510b,%edx
   42db6:	be 39 00 00 00       	mov    $0x39,%esi
   42dbb:	bf 00 51 04 00       	mov    $0x45100,%edi
   42dc0:	e8 d4 f7 ff ff       	callq  42599 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42dc5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dc9:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42dcd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dd1:	48 01 d0             	add    %rdx,%rax
   42dd4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42dd8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42ddf:	e9 94 00 00 00       	jmpq   42e78 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42de4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42de7:	48 63 d0             	movslq %eax,%rdx
   42dea:	48 89 d0             	mov    %rdx,%rax
   42ded:	48 c1 e0 03          	shl    $0x3,%rax
   42df1:	48 29 d0             	sub    %rdx,%rax
   42df4:	48 c1 e0 03          	shl    $0x3,%rax
   42df8:	48 89 c2             	mov    %rax,%rdx
   42dfb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dff:	48 01 d0             	add    %rdx,%rax
   42e02:	8b 00                	mov    (%rax),%eax
   42e04:	83 f8 01             	cmp    $0x1,%eax
   42e07:	75 6b                	jne    42e74 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42e09:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e0c:	48 63 d0             	movslq %eax,%rdx
   42e0f:	48 89 d0             	mov    %rdx,%rax
   42e12:	48 c1 e0 03          	shl    $0x3,%rax
   42e16:	48 29 d0             	sub    %rdx,%rax
   42e19:	48 c1 e0 03          	shl    $0x3,%rax
   42e1d:	48 89 c2             	mov    %rax,%rdx
   42e20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e24:	48 01 d0             	add    %rdx,%rax
   42e27:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42e2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e2f:	48 01 d0             	add    %rdx,%rax
   42e32:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42e36:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e39:	48 63 d0             	movslq %eax,%rdx
   42e3c:	48 89 d0             	mov    %rdx,%rax
   42e3f:	48 c1 e0 03          	shl    $0x3,%rax
   42e43:	48 29 d0             	sub    %rdx,%rax
   42e46:	48 c1 e0 03          	shl    $0x3,%rax
   42e4a:	48 89 c2             	mov    %rax,%rdx
   42e4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e51:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42e55:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42e59:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42e5d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e61:	48 89 c7             	mov    %rax,%rdi
   42e64:	e8 3d 00 00 00       	callq  42ea6 <program_load_segment>
   42e69:	85 c0                	test   %eax,%eax
   42e6b:	79 07                	jns    42e74 <program_load+0x122>
                return -1;
   42e6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42e72:	eb 30                	jmp    42ea4 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42e74:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42e78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e7c:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42e80:	0f b7 c0             	movzwl %ax,%eax
   42e83:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42e86:	0f 8c 58 ff ff ff    	jl     42de4 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42e8c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e90:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42e94:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e98:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42e9f:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42ea4:	c9                   	leaveq 
   42ea5:	c3                   	retq   

0000000000042ea6 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42ea6:	55                   	push   %rbp
   42ea7:	48 89 e5             	mov    %rsp,%rbp
   42eaa:	48 83 ec 70          	sub    $0x70,%rsp
   42eae:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42eb2:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   42eb6:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   42eba:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42ebe:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42ec2:	48 8b 40 10          	mov    0x10(%rax),%rax
   42ec6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42eca:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42ece:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42ed2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ed6:	48 01 d0             	add    %rdx,%rax
   42ed9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   42edd:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42ee1:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42ee5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ee9:	48 01 d0             	add    %rdx,%rax
   42eec:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42ef0:	48 81 65 e0 00 f0 ff 	andq   $0xfffffffffffff000,-0x20(%rbp)
   42ef7:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42ef8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42efc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42f00:	eb 7c                	jmp    42f7e <program_load_segment+0xd8>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42f02:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f06:	8b 00                	mov    (%rax),%eax
   42f08:	89 c7                	mov    %eax,%edi
   42f0a:	e8 a7 0b 00 00       	callq  43ab6 <palloc>
   42f0f:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42f13:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   42f18:	74 2a                	je     42f44 <program_load_segment+0x9e>
   42f1a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f1e:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f25:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42f29:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   42f2d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42f33:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42f38:	48 89 c7             	mov    %rax,%rdi
   42f3b:	e8 58 f9 ff ff       	callq  42898 <virtual_memory_map>
   42f40:	85 c0                	test   %eax,%eax
   42f42:	79 32                	jns    42f76 <program_load_segment+0xd0>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42f44:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f48:	8b 00                	mov    (%rax),%eax
   42f4a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   42f4e:	49 89 d0             	mov    %rdx,%r8
   42f51:	89 c1                	mov    %eax,%ecx
   42f53:	ba 28 51 04 00       	mov    $0x45128,%edx
   42f58:	be 00 c0 00 00       	mov    $0xc000,%esi
   42f5d:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42f62:	b8 00 00 00 00       	mov    $0x0,%eax
   42f67:	e8 73 0a 00 00       	callq  439df <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42f6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f71:	e9 2d 01 00 00       	jmpq   430a3 <program_load_segment+0x1fd>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42f76:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   42f7d:	00 
   42f7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f82:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
   42f86:	0f 82 76 ff ff ff    	jb     42f02 <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42f8c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f90:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f97:	48 89 c7             	mov    %rax,%rdi
   42f9a:	e8 c8 f7 ff ff       	callq  42767 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42f9f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fa3:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   42fa7:	48 89 c2             	mov    %rax,%rdx
   42faa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42fae:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   42fb2:	48 89 ce             	mov    %rcx,%rsi
   42fb5:	48 89 c7             	mov    %rax,%rdi
   42fb8:	e8 84 01 00 00       	callq  43141 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42fbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fc1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
   42fc5:	48 89 c2             	mov    %rax,%rdx
   42fc8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fcc:	be 00 00 00 00       	mov    $0x0,%esi
   42fd1:	48 89 c7             	mov    %rax,%rdi
   42fd4:	e8 d1 01 00 00       	callq  431aa <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42fd9:	48 8b 05 20 20 01 00 	mov    0x12020(%rip),%rax        # 55000 <kernel_pagetable>
   42fe0:	48 89 c7             	mov    %rax,%rdi
   42fe3:	e8 7f f7 ff ff       	callq  42767 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   42fe8:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42fec:	8b 40 04             	mov    0x4(%rax),%eax
   42fef:	83 e0 02             	and    $0x2,%eax
   42ff2:	85 c0                	test   %eax,%eax
   42ff4:	75 60                	jne    43056 <program_load_segment+0x1b0>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42ff6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ffa:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42ffe:	eb 4c                	jmp    4304c <program_load_segment+0x1a6>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   43000:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43004:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4300b:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4300f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   43013:	48 89 ce             	mov    %rcx,%rsi
   43016:	48 89 c7             	mov    %rax,%rdi
   43019:	e8 3d fc ff ff       	callq  42c5b <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   4301e:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   43022:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43026:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4302d:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   43031:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43037:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4303c:	48 89 c7             	mov    %rax,%rdi
   4303f:	e8 54 f8 ff ff       	callq  42898 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43044:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   4304b:	00 
   4304c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43050:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
   43054:	72 aa                	jb     43000 <program_load_segment+0x15a>
                    PTE_P | PTE_U);
        }
    }
    // TODO : Add code here
    // set heap start and heap break
    if(end_mem > p->program_break) {
   43056:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4305a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4305e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   43062:	76 3a                	jbe    4309e <program_load_segment+0x1f8>
        // ensure end_mem is page-aligned
        if(end_mem % PAGESIZE != 0) 
   43064:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43068:	25 ff 0f 00 00       	and    $0xfff,%eax
   4306d:	48 85 c0             	test   %rax,%rax
   43070:	74 14                	je     43086 <program_load_segment+0x1e0>
            end_mem = (end_mem & ~(PAGESIZE - 1)) + PAGESIZE;
   43072:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43076:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4307c:	48 05 00 10 00 00    	add    $0x1000,%rax
   43082:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        
        p->program_break = end_mem;
   43086:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4308a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4308e:	48 89 50 08          	mov    %rdx,0x8(%rax)
        p->original_break = end_mem;
   43092:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43096:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4309a:	48 89 50 10          	mov    %rdx,0x10(%rax)
    }

    return 0;
   4309e:	b8 00 00 00 00       	mov    $0x0,%eax
}
   430a3:	c9                   	leaveq 
   430a4:	c3                   	retq   

00000000000430a5 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   430a5:	48 89 f9             	mov    %rdi,%rcx
   430a8:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   430aa:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
   430b1:	00 
   430b2:	72 08                	jb     430bc <console_putc+0x17>
        cp->cursor = console;
   430b4:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
   430bb:	00 
    }
    if (c == '\n') {
   430bc:	40 80 fe 0a          	cmp    $0xa,%sil
   430c0:	74 16                	je     430d8 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
   430c2:	48 8b 41 08          	mov    0x8(%rcx),%rax
   430c6:	48 8d 50 02          	lea    0x2(%rax),%rdx
   430ca:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   430ce:	40 0f b6 f6          	movzbl %sil,%esi
   430d2:	09 fe                	or     %edi,%esi
   430d4:	66 89 30             	mov    %si,(%rax)
    }
}
   430d7:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
   430d8:	4c 8b 41 08          	mov    0x8(%rcx),%r8
   430dc:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
   430e3:	4c 89 c6             	mov    %r8,%rsi
   430e6:	48 d1 fe             	sar    %rsi
   430e9:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   430f0:	66 66 66 
   430f3:	48 89 f0             	mov    %rsi,%rax
   430f6:	48 f7 ea             	imul   %rdx
   430f9:	48 c1 fa 05          	sar    $0x5,%rdx
   430fd:	49 c1 f8 3f          	sar    $0x3f,%r8
   43101:	4c 29 c2             	sub    %r8,%rdx
   43104:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   43108:	48 c1 e2 04          	shl    $0x4,%rdx
   4310c:	89 f0                	mov    %esi,%eax
   4310e:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
   43110:	83 cf 20             	or     $0x20,%edi
   43113:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43117:	48 8d 72 02          	lea    0x2(%rdx),%rsi
   4311b:	48 89 71 08          	mov    %rsi,0x8(%rcx)
   4311f:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
   43122:	83 c0 01             	add    $0x1,%eax
   43125:	83 f8 50             	cmp    $0x50,%eax
   43128:	75 e9                	jne    43113 <console_putc+0x6e>
   4312a:	c3                   	retq   

000000000004312b <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
   4312b:	48 8b 47 08          	mov    0x8(%rdi),%rax
   4312f:	48 3b 47 10          	cmp    0x10(%rdi),%rax
   43133:	73 0b                	jae    43140 <string_putc+0x15>
        *sp->s++ = c;
   43135:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43139:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   4313d:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
   43140:	c3                   	retq   

0000000000043141 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
   43141:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43144:	48 85 d2             	test   %rdx,%rdx
   43147:	74 17                	je     43160 <memcpy+0x1f>
   43149:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
   4314e:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
   43153:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43157:	48 83 c1 01          	add    $0x1,%rcx
   4315b:	48 39 d1             	cmp    %rdx,%rcx
   4315e:	75 ee                	jne    4314e <memcpy+0xd>
}
   43160:	c3                   	retq   

0000000000043161 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
   43161:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
   43164:	48 39 fe             	cmp    %rdi,%rsi
   43167:	72 1d                	jb     43186 <memmove+0x25>
        while (n-- > 0) {
   43169:	b9 00 00 00 00       	mov    $0x0,%ecx
   4316e:	48 85 d2             	test   %rdx,%rdx
   43171:	74 12                	je     43185 <memmove+0x24>
            *d++ = *s++;
   43173:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
   43177:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
   4317b:	48 83 c1 01          	add    $0x1,%rcx
   4317f:	48 39 ca             	cmp    %rcx,%rdx
   43182:	75 ef                	jne    43173 <memmove+0x12>
}
   43184:	c3                   	retq   
   43185:	c3                   	retq   
    if (s < d && s + n > d) {
   43186:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
   4318a:	48 39 cf             	cmp    %rcx,%rdi
   4318d:	73 da                	jae    43169 <memmove+0x8>
        while (n-- > 0) {
   4318f:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
   43193:	48 85 d2             	test   %rdx,%rdx
   43196:	74 ec                	je     43184 <memmove+0x23>
            *--d = *--s;
   43198:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
   4319c:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
   4319f:	48 83 e9 01          	sub    $0x1,%rcx
   431a3:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
   431a7:	75 ef                	jne    43198 <memmove+0x37>
   431a9:	c3                   	retq   

00000000000431aa <memset>:
void* memset(void* v, int c, size_t n) {
   431aa:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
   431ad:	48 85 d2             	test   %rdx,%rdx
   431b0:	74 12                	je     431c4 <memset+0x1a>
   431b2:	48 01 fa             	add    %rdi,%rdx
   431b5:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
   431b8:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   431bb:	48 83 c1 01          	add    $0x1,%rcx
   431bf:	48 39 ca             	cmp    %rcx,%rdx
   431c2:	75 f4                	jne    431b8 <memset+0xe>
}
   431c4:	c3                   	retq   

00000000000431c5 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
   431c5:	80 3f 00             	cmpb   $0x0,(%rdi)
   431c8:	74 10                	je     431da <strlen+0x15>
   431ca:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   431cf:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
   431d3:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   431d7:	75 f6                	jne    431cf <strlen+0xa>
   431d9:	c3                   	retq   
   431da:	b8 00 00 00 00       	mov    $0x0,%eax
}
   431df:	c3                   	retq   

00000000000431e0 <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
   431e0:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   431e3:	ba 00 00 00 00       	mov    $0x0,%edx
   431e8:	48 85 f6             	test   %rsi,%rsi
   431eb:	74 11                	je     431fe <strnlen+0x1e>
   431ed:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
   431f1:	74 0c                	je     431ff <strnlen+0x1f>
        ++n;
   431f3:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   431f7:	48 39 d0             	cmp    %rdx,%rax
   431fa:	75 f1                	jne    431ed <strnlen+0xd>
   431fc:	eb 04                	jmp    43202 <strnlen+0x22>
   431fe:	c3                   	retq   
   431ff:	48 89 d0             	mov    %rdx,%rax
}
   43202:	c3                   	retq   

0000000000043203 <strcpy>:
char* strcpy(char* dst, const char* src) {
   43203:	48 89 f8             	mov    %rdi,%rax
   43206:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
   4320b:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
   4320f:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
   43212:	48 83 c2 01          	add    $0x1,%rdx
   43216:	84 c9                	test   %cl,%cl
   43218:	75 f1                	jne    4320b <strcpy+0x8>
}
   4321a:	c3                   	retq   

000000000004321b <strcmp>:
    while (*a && *b && *a == *b) {
   4321b:	0f b6 07             	movzbl (%rdi),%eax
   4321e:	84 c0                	test   %al,%al
   43220:	74 1a                	je     4323c <strcmp+0x21>
   43222:	0f b6 16             	movzbl (%rsi),%edx
   43225:	38 c2                	cmp    %al,%dl
   43227:	75 13                	jne    4323c <strcmp+0x21>
   43229:	84 d2                	test   %dl,%dl
   4322b:	74 0f                	je     4323c <strcmp+0x21>
        ++a, ++b;
   4322d:	48 83 c7 01          	add    $0x1,%rdi
   43231:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
   43235:	0f b6 07             	movzbl (%rdi),%eax
   43238:	84 c0                	test   %al,%al
   4323a:	75 e6                	jne    43222 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
   4323c:	3a 06                	cmp    (%rsi),%al
   4323e:	0f 97 c0             	seta   %al
   43241:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
   43244:	83 d8 00             	sbb    $0x0,%eax
}
   43247:	c3                   	retq   

0000000000043248 <strchr>:
    while (*s && *s != (char) c) {
   43248:	0f b6 07             	movzbl (%rdi),%eax
   4324b:	84 c0                	test   %al,%al
   4324d:	74 10                	je     4325f <strchr+0x17>
   4324f:	40 38 f0             	cmp    %sil,%al
   43252:	74 18                	je     4326c <strchr+0x24>
        ++s;
   43254:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
   43258:	0f b6 07             	movzbl (%rdi),%eax
   4325b:	84 c0                	test   %al,%al
   4325d:	75 f0                	jne    4324f <strchr+0x7>
        return NULL;
   4325f:	40 84 f6             	test   %sil,%sil
   43262:	b8 00 00 00 00       	mov    $0x0,%eax
   43267:	48 0f 44 c7          	cmove  %rdi,%rax
}
   4326b:	c3                   	retq   
   4326c:	48 89 f8             	mov    %rdi,%rax
   4326f:	c3                   	retq   

0000000000043270 <rand>:
    if (!rand_seed_set) {
   43270:	83 3d 8d 7d 01 00 00 	cmpl   $0x0,0x17d8d(%rip)        # 5b004 <rand_seed_set>
   43277:	74 1b                	je     43294 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43279:	69 05 7d 7d 01 00 0d 	imul   $0x19660d,0x17d7d(%rip),%eax        # 5b000 <rand_seed>
   43280:	66 19 00 
   43283:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43288:	89 05 72 7d 01 00    	mov    %eax,0x17d72(%rip)        # 5b000 <rand_seed>
    return rand_seed & RAND_MAX;
   4328e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43293:	c3                   	retq   
    rand_seed = seed;
   43294:	c7 05 62 7d 01 00 9e 	movl   $0x30d4879e,0x17d62(%rip)        # 5b000 <rand_seed>
   4329b:	87 d4 30 
    rand_seed_set = 1;
   4329e:	c7 05 5c 7d 01 00 01 	movl   $0x1,0x17d5c(%rip)        # 5b004 <rand_seed_set>
   432a5:	00 00 00 
}
   432a8:	eb cf                	jmp    43279 <rand+0x9>

00000000000432aa <srand>:
    rand_seed = seed;
   432aa:	89 3d 50 7d 01 00    	mov    %edi,0x17d50(%rip)        # 5b000 <rand_seed>
    rand_seed_set = 1;
   432b0:	c7 05 4a 7d 01 00 01 	movl   $0x1,0x17d4a(%rip)        # 5b004 <rand_seed_set>
   432b7:	00 00 00 
}
   432ba:	c3                   	retq   

00000000000432bb <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   432bb:	55                   	push   %rbp
   432bc:	48 89 e5             	mov    %rsp,%rbp
   432bf:	41 57                	push   %r15
   432c1:	41 56                	push   %r14
   432c3:	41 55                	push   %r13
   432c5:	41 54                	push   %r12
   432c7:	53                   	push   %rbx
   432c8:	48 83 ec 58          	sub    $0x58,%rsp
   432cc:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
   432d0:	0f b6 02             	movzbl (%rdx),%eax
   432d3:	84 c0                	test   %al,%al
   432d5:	0f 84 b0 06 00 00    	je     4398b <printer_vprintf+0x6d0>
   432db:	49 89 fe             	mov    %rdi,%r14
   432de:	49 89 d4             	mov    %rdx,%r12
            length = 1;
   432e1:	41 89 f7             	mov    %esi,%r15d
   432e4:	e9 a4 04 00 00       	jmpq   4378d <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
   432e9:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
   432ee:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
   432f4:	45 84 e4             	test   %r12b,%r12b
   432f7:	0f 84 82 06 00 00    	je     4397f <printer_vprintf+0x6c4>
        int flags = 0;
   432fd:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
   43303:	41 0f be f4          	movsbl %r12b,%esi
   43307:	bf 61 53 04 00       	mov    $0x45361,%edi
   4330c:	e8 37 ff ff ff       	callq  43248 <strchr>
   43311:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
   43314:	48 85 c0             	test   %rax,%rax
   43317:	74 55                	je     4336e <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
   43319:	48 81 e9 61 53 04 00 	sub    $0x45361,%rcx
   43320:	b8 01 00 00 00       	mov    $0x1,%eax
   43325:	d3 e0                	shl    %cl,%eax
   43327:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
   4332a:	48 83 c3 01          	add    $0x1,%rbx
   4332e:	44 0f b6 23          	movzbl (%rbx),%r12d
   43332:	45 84 e4             	test   %r12b,%r12b
   43335:	75 cc                	jne    43303 <printer_vprintf+0x48>
   43337:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
   4333b:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
   43341:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
   43348:	80 3b 2e             	cmpb   $0x2e,(%rbx)
   4334b:	0f 84 a9 00 00 00    	je     433fa <printer_vprintf+0x13f>
        int length = 0;
   43351:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
   43356:	0f b6 13             	movzbl (%rbx),%edx
   43359:	8d 42 bd             	lea    -0x43(%rdx),%eax
   4335c:	3c 37                	cmp    $0x37,%al
   4335e:	0f 87 c4 04 00 00    	ja     43828 <printer_vprintf+0x56d>
   43364:	0f b6 c0             	movzbl %al,%eax
   43367:	ff 24 c5 70 51 04 00 	jmpq   *0x45170(,%rax,8)
        if (*format >= '1' && *format <= '9') {
   4336e:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
   43372:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
   43377:	3c 08                	cmp    $0x8,%al
   43379:	77 2f                	ja     433aa <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4337b:	0f b6 03             	movzbl (%rbx),%eax
   4337e:	8d 50 d0             	lea    -0x30(%rax),%edx
   43381:	80 fa 09             	cmp    $0x9,%dl
   43384:	77 5e                	ja     433e4 <printer_vprintf+0x129>
   43386:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
   4338c:	48 83 c3 01          	add    $0x1,%rbx
   43390:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
   43395:	0f be c0             	movsbl %al,%eax
   43398:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4339d:	0f b6 03             	movzbl (%rbx),%eax
   433a0:	8d 50 d0             	lea    -0x30(%rax),%edx
   433a3:	80 fa 09             	cmp    $0x9,%dl
   433a6:	76 e4                	jbe    4338c <printer_vprintf+0xd1>
   433a8:	eb 97                	jmp    43341 <printer_vprintf+0x86>
        } else if (*format == '*') {
   433aa:	41 80 fc 2a          	cmp    $0x2a,%r12b
   433ae:	75 3f                	jne    433ef <printer_vprintf+0x134>
            width = va_arg(val, int);
   433b0:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   433b4:	8b 07                	mov    (%rdi),%eax
   433b6:	83 f8 2f             	cmp    $0x2f,%eax
   433b9:	77 17                	ja     433d2 <printer_vprintf+0x117>
   433bb:	89 c2                	mov    %eax,%edx
   433bd:	48 03 57 10          	add    0x10(%rdi),%rdx
   433c1:	83 c0 08             	add    $0x8,%eax
   433c4:	89 07                	mov    %eax,(%rdi)
   433c6:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
   433c9:	48 83 c3 01          	add    $0x1,%rbx
   433cd:	e9 6f ff ff ff       	jmpq   43341 <printer_vprintf+0x86>
            width = va_arg(val, int);
   433d2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   433d6:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   433da:	48 8d 42 08          	lea    0x8(%rdx),%rax
   433de:	48 89 41 08          	mov    %rax,0x8(%rcx)
   433e2:	eb e2                	jmp    433c6 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   433e4:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   433ea:	e9 52 ff ff ff       	jmpq   43341 <printer_vprintf+0x86>
        int width = -1;
   433ef:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
   433f5:	e9 47 ff ff ff       	jmpq   43341 <printer_vprintf+0x86>
            ++format;
   433fa:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
   433fe:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43402:	8d 48 d0             	lea    -0x30(%rax),%ecx
   43405:	80 f9 09             	cmp    $0x9,%cl
   43408:	76 13                	jbe    4341d <printer_vprintf+0x162>
            } else if (*format == '*') {
   4340a:	3c 2a                	cmp    $0x2a,%al
   4340c:	74 33                	je     43441 <printer_vprintf+0x186>
            ++format;
   4340e:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
   43411:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
   43418:	e9 34 ff ff ff       	jmpq   43351 <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4341d:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
   43422:	48 83 c2 01          	add    $0x1,%rdx
   43426:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
   43429:	0f be c0             	movsbl %al,%eax
   4342c:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43430:	0f b6 02             	movzbl (%rdx),%eax
   43433:	8d 70 d0             	lea    -0x30(%rax),%esi
   43436:	40 80 fe 09          	cmp    $0x9,%sil
   4343a:	76 e6                	jbe    43422 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
   4343c:	48 89 d3             	mov    %rdx,%rbx
   4343f:	eb 1c                	jmp    4345d <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
   43441:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43445:	8b 07                	mov    (%rdi),%eax
   43447:	83 f8 2f             	cmp    $0x2f,%eax
   4344a:	77 23                	ja     4346f <printer_vprintf+0x1b4>
   4344c:	89 c2                	mov    %eax,%edx
   4344e:	48 03 57 10          	add    0x10(%rdi),%rdx
   43452:	83 c0 08             	add    $0x8,%eax
   43455:	89 07                	mov    %eax,(%rdi)
   43457:	8b 0a                	mov    (%rdx),%ecx
                ++format;
   43459:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
   4345d:	85 c9                	test   %ecx,%ecx
   4345f:	b8 00 00 00 00       	mov    $0x0,%eax
   43464:	0f 49 c1             	cmovns %ecx,%eax
   43467:	89 45 9c             	mov    %eax,-0x64(%rbp)
   4346a:	e9 e2 fe ff ff       	jmpq   43351 <printer_vprintf+0x96>
                precision = va_arg(val, int);
   4346f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43473:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43477:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4347b:	48 89 41 08          	mov    %rax,0x8(%rcx)
   4347f:	eb d6                	jmp    43457 <printer_vprintf+0x19c>
        switch (*format) {
   43481:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43486:	e9 f3 00 00 00       	jmpq   4357e <printer_vprintf+0x2c3>
            ++format;
   4348b:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
   4348f:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
   43494:	e9 bd fe ff ff       	jmpq   43356 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43499:	85 c9                	test   %ecx,%ecx
   4349b:	74 55                	je     434f2 <printer_vprintf+0x237>
   4349d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   434a1:	8b 07                	mov    (%rdi),%eax
   434a3:	83 f8 2f             	cmp    $0x2f,%eax
   434a6:	77 38                	ja     434e0 <printer_vprintf+0x225>
   434a8:	89 c2                	mov    %eax,%edx
   434aa:	48 03 57 10          	add    0x10(%rdi),%rdx
   434ae:	83 c0 08             	add    $0x8,%eax
   434b1:	89 07                	mov    %eax,(%rdi)
   434b3:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   434b6:	48 89 d0             	mov    %rdx,%rax
   434b9:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
   434bd:	49 89 d0             	mov    %rdx,%r8
   434c0:	49 f7 d8             	neg    %r8
   434c3:	25 80 00 00 00       	and    $0x80,%eax
   434c8:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   434cc:	0b 45 a8             	or     -0x58(%rbp),%eax
   434cf:	83 c8 60             	or     $0x60,%eax
   434d2:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
   434d5:	41 bc 67 51 04 00    	mov    $0x45167,%r12d
            break;
   434db:	e9 35 01 00 00       	jmpq   43615 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   434e0:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   434e4:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   434e8:	48 8d 42 08          	lea    0x8(%rdx),%rax
   434ec:	48 89 41 08          	mov    %rax,0x8(%rcx)
   434f0:	eb c1                	jmp    434b3 <printer_vprintf+0x1f8>
   434f2:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   434f6:	8b 07                	mov    (%rdi),%eax
   434f8:	83 f8 2f             	cmp    $0x2f,%eax
   434fb:	77 10                	ja     4350d <printer_vprintf+0x252>
   434fd:	89 c2                	mov    %eax,%edx
   434ff:	48 03 57 10          	add    0x10(%rdi),%rdx
   43503:	83 c0 08             	add    $0x8,%eax
   43506:	89 07                	mov    %eax,(%rdi)
   43508:	48 63 12             	movslq (%rdx),%rdx
   4350b:	eb a9                	jmp    434b6 <printer_vprintf+0x1fb>
   4350d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43511:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43515:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43519:	48 89 47 08          	mov    %rax,0x8(%rdi)
   4351d:	eb e9                	jmp    43508 <printer_vprintf+0x24d>
        int base = 10;
   4351f:	be 0a 00 00 00       	mov    $0xa,%esi
   43524:	eb 58                	jmp    4357e <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43526:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4352a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   4352e:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43532:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43536:	eb 60                	jmp    43598 <printer_vprintf+0x2dd>
   43538:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4353c:	8b 07                	mov    (%rdi),%eax
   4353e:	83 f8 2f             	cmp    $0x2f,%eax
   43541:	77 10                	ja     43553 <printer_vprintf+0x298>
   43543:	89 c2                	mov    %eax,%edx
   43545:	48 03 57 10          	add    0x10(%rdi),%rdx
   43549:	83 c0 08             	add    $0x8,%eax
   4354c:	89 07                	mov    %eax,(%rdi)
   4354e:	44 8b 02             	mov    (%rdx),%r8d
   43551:	eb 48                	jmp    4359b <printer_vprintf+0x2e0>
   43553:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43557:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   4355b:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4355f:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43563:	eb e9                	jmp    4354e <printer_vprintf+0x293>
   43565:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
   43568:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
   4356f:	bf 50 53 04 00       	mov    $0x45350,%edi
   43574:	e9 e2 02 00 00       	jmpq   4385b <printer_vprintf+0x5a0>
            base = 16;
   43579:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   4357e:	85 c9                	test   %ecx,%ecx
   43580:	74 b6                	je     43538 <printer_vprintf+0x27d>
   43582:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43586:	8b 01                	mov    (%rcx),%eax
   43588:	83 f8 2f             	cmp    $0x2f,%eax
   4358b:	77 99                	ja     43526 <printer_vprintf+0x26b>
   4358d:	89 c2                	mov    %eax,%edx
   4358f:	48 03 51 10          	add    0x10(%rcx),%rdx
   43593:	83 c0 08             	add    $0x8,%eax
   43596:	89 01                	mov    %eax,(%rcx)
   43598:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
   4359b:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
   4359f:	85 f6                	test   %esi,%esi
   435a1:	79 c2                	jns    43565 <printer_vprintf+0x2aa>
        base = -base;
   435a3:	41 89 f1             	mov    %esi,%r9d
   435a6:	f7 de                	neg    %esi
   435a8:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
   435af:	bf 30 53 04 00       	mov    $0x45330,%edi
   435b4:	e9 a2 02 00 00       	jmpq   4385b <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
   435b9:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   435bd:	8b 07                	mov    (%rdi),%eax
   435bf:	83 f8 2f             	cmp    $0x2f,%eax
   435c2:	77 1c                	ja     435e0 <printer_vprintf+0x325>
   435c4:	89 c2                	mov    %eax,%edx
   435c6:	48 03 57 10          	add    0x10(%rdi),%rdx
   435ca:	83 c0 08             	add    $0x8,%eax
   435cd:	89 07                	mov    %eax,(%rdi)
   435cf:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   435d2:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
   435d9:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   435de:	eb c3                	jmp    435a3 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
   435e0:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   435e4:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   435e8:	48 8d 42 08          	lea    0x8(%rdx),%rax
   435ec:	48 89 41 08          	mov    %rax,0x8(%rcx)
   435f0:	eb dd                	jmp    435cf <printer_vprintf+0x314>
            data = va_arg(val, char*);
   435f2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   435f6:	8b 01                	mov    (%rcx),%eax
   435f8:	83 f8 2f             	cmp    $0x2f,%eax
   435fb:	0f 87 a5 01 00 00    	ja     437a6 <printer_vprintf+0x4eb>
   43601:	89 c2                	mov    %eax,%edx
   43603:	48 03 51 10          	add    0x10(%rcx),%rdx
   43607:	83 c0 08             	add    $0x8,%eax
   4360a:	89 01                	mov    %eax,(%rcx)
   4360c:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
   4360f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
   43615:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43618:	83 e0 20             	and    $0x20,%eax
   4361b:	89 45 8c             	mov    %eax,-0x74(%rbp)
   4361e:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
   43624:	0f 85 21 02 00 00    	jne    4384b <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   4362a:	8b 45 a8             	mov    -0x58(%rbp),%eax
   4362d:	89 45 88             	mov    %eax,-0x78(%rbp)
   43630:	83 e0 60             	and    $0x60,%eax
   43633:	83 f8 60             	cmp    $0x60,%eax
   43636:	0f 84 54 02 00 00    	je     43890 <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   4363c:	8b 45 a8             	mov    -0x58(%rbp),%eax
   4363f:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
   43642:	48 c7 45 a0 67 51 04 	movq   $0x45167,-0x60(%rbp)
   43649:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   4364a:	83 f8 21             	cmp    $0x21,%eax
   4364d:	0f 84 79 02 00 00    	je     438cc <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43653:	8b 7d 9c             	mov    -0x64(%rbp),%edi
   43656:	89 f8                	mov    %edi,%eax
   43658:	f7 d0                	not    %eax
   4365a:	c1 e8 1f             	shr    $0x1f,%eax
   4365d:	89 45 84             	mov    %eax,-0x7c(%rbp)
   43660:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   43664:	0f 85 9e 02 00 00    	jne    43908 <printer_vprintf+0x64d>
   4366a:	84 c0                	test   %al,%al
   4366c:	0f 84 96 02 00 00    	je     43908 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
   43672:	48 63 f7             	movslq %edi,%rsi
   43675:	4c 89 e7             	mov    %r12,%rdi
   43678:	e8 63 fb ff ff       	callq  431e0 <strnlen>
   4367d:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
   43680:	8b 45 88             	mov    -0x78(%rbp),%eax
   43683:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
   43686:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   4368d:	83 f8 22             	cmp    $0x22,%eax
   43690:	0f 84 aa 02 00 00    	je     43940 <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
   43696:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   4369a:	e8 26 fb ff ff       	callq  431c5 <strlen>
   4369f:	8b 55 9c             	mov    -0x64(%rbp),%edx
   436a2:	03 55 98             	add    -0x68(%rbp),%edx
   436a5:	44 89 e9             	mov    %r13d,%ecx
   436a8:	29 d1                	sub    %edx,%ecx
   436aa:	29 c1                	sub    %eax,%ecx
   436ac:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
   436af:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   436b2:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
   436b6:	75 2d                	jne    436e5 <printer_vprintf+0x42a>
   436b8:	85 c9                	test   %ecx,%ecx
   436ba:	7e 29                	jle    436e5 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
   436bc:	44 89 fa             	mov    %r15d,%edx
   436bf:	be 20 00 00 00       	mov    $0x20,%esi
   436c4:	4c 89 f7             	mov    %r14,%rdi
   436c7:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   436ca:	41 83 ed 01          	sub    $0x1,%r13d
   436ce:	45 85 ed             	test   %r13d,%r13d
   436d1:	7f e9                	jg     436bc <printer_vprintf+0x401>
   436d3:	8b 7d 8c             	mov    -0x74(%rbp),%edi
   436d6:	85 ff                	test   %edi,%edi
   436d8:	b8 01 00 00 00       	mov    $0x1,%eax
   436dd:	0f 4f c7             	cmovg  %edi,%eax
   436e0:	29 c7                	sub    %eax,%edi
   436e2:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
   436e5:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   436e9:	0f b6 07             	movzbl (%rdi),%eax
   436ec:	84 c0                	test   %al,%al
   436ee:	74 22                	je     43712 <printer_vprintf+0x457>
   436f0:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   436f4:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
   436f7:	0f b6 f0             	movzbl %al,%esi
   436fa:	44 89 fa             	mov    %r15d,%edx
   436fd:	4c 89 f7             	mov    %r14,%rdi
   43700:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
   43703:	48 83 c3 01          	add    $0x1,%rbx
   43707:	0f b6 03             	movzbl (%rbx),%eax
   4370a:	84 c0                	test   %al,%al
   4370c:	75 e9                	jne    436f7 <printer_vprintf+0x43c>
   4370e:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
   43712:	8b 45 9c             	mov    -0x64(%rbp),%eax
   43715:	85 c0                	test   %eax,%eax
   43717:	7e 1d                	jle    43736 <printer_vprintf+0x47b>
   43719:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   4371d:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
   4371f:	44 89 fa             	mov    %r15d,%edx
   43722:	be 30 00 00 00       	mov    $0x30,%esi
   43727:	4c 89 f7             	mov    %r14,%rdi
   4372a:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
   4372d:	83 eb 01             	sub    $0x1,%ebx
   43730:	75 ed                	jne    4371f <printer_vprintf+0x464>
   43732:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
   43736:	8b 45 98             	mov    -0x68(%rbp),%eax
   43739:	85 c0                	test   %eax,%eax
   4373b:	7e 27                	jle    43764 <printer_vprintf+0x4a9>
   4373d:	89 c0                	mov    %eax,%eax
   4373f:	4c 01 e0             	add    %r12,%rax
   43742:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43746:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
   43749:	41 0f b6 34 24       	movzbl (%r12),%esi
   4374e:	44 89 fa             	mov    %r15d,%edx
   43751:	4c 89 f7             	mov    %r14,%rdi
   43754:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
   43757:	49 83 c4 01          	add    $0x1,%r12
   4375b:	49 39 dc             	cmp    %rbx,%r12
   4375e:	75 e9                	jne    43749 <printer_vprintf+0x48e>
   43760:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
   43764:	45 85 ed             	test   %r13d,%r13d
   43767:	7e 14                	jle    4377d <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
   43769:	44 89 fa             	mov    %r15d,%edx
   4376c:	be 20 00 00 00       	mov    $0x20,%esi
   43771:	4c 89 f7             	mov    %r14,%rdi
   43774:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
   43777:	41 83 ed 01          	sub    $0x1,%r13d
   4377b:	75 ec                	jne    43769 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
   4377d:	4c 8d 63 01          	lea    0x1(%rbx),%r12
   43781:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43785:	84 c0                	test   %al,%al
   43787:	0f 84 fe 01 00 00    	je     4398b <printer_vprintf+0x6d0>
        if (*format != '%') {
   4378d:	3c 25                	cmp    $0x25,%al
   4378f:	0f 84 54 fb ff ff    	je     432e9 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
   43795:	0f b6 f0             	movzbl %al,%esi
   43798:	44 89 fa             	mov    %r15d,%edx
   4379b:	4c 89 f7             	mov    %r14,%rdi
   4379e:	41 ff 16             	callq  *(%r14)
            continue;
   437a1:	4c 89 e3             	mov    %r12,%rbx
   437a4:	eb d7                	jmp    4377d <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
   437a6:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   437aa:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   437ae:	48 8d 42 08          	lea    0x8(%rdx),%rax
   437b2:	48 89 47 08          	mov    %rax,0x8(%rdi)
   437b6:	e9 51 fe ff ff       	jmpq   4360c <printer_vprintf+0x351>
            color = va_arg(val, int);
   437bb:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   437bf:	8b 07                	mov    (%rdi),%eax
   437c1:	83 f8 2f             	cmp    $0x2f,%eax
   437c4:	77 10                	ja     437d6 <printer_vprintf+0x51b>
   437c6:	89 c2                	mov    %eax,%edx
   437c8:	48 03 57 10          	add    0x10(%rdi),%rdx
   437cc:	83 c0 08             	add    $0x8,%eax
   437cf:	89 07                	mov    %eax,(%rdi)
   437d1:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
   437d4:	eb a7                	jmp    4377d <printer_vprintf+0x4c2>
            color = va_arg(val, int);
   437d6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   437da:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   437de:	48 8d 42 08          	lea    0x8(%rdx),%rax
   437e2:	48 89 41 08          	mov    %rax,0x8(%rcx)
   437e6:	eb e9                	jmp    437d1 <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
   437e8:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   437ec:	8b 01                	mov    (%rcx),%eax
   437ee:	83 f8 2f             	cmp    $0x2f,%eax
   437f1:	77 23                	ja     43816 <printer_vprintf+0x55b>
   437f3:	89 c2                	mov    %eax,%edx
   437f5:	48 03 51 10          	add    0x10(%rcx),%rdx
   437f9:	83 c0 08             	add    $0x8,%eax
   437fc:	89 01                	mov    %eax,(%rcx)
   437fe:	8b 02                	mov    (%rdx),%eax
   43800:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
   43803:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43807:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   4380b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
   43811:	e9 ff fd ff ff       	jmpq   43615 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
   43816:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4381a:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   4381e:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43822:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43826:	eb d6                	jmp    437fe <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
   43828:	84 d2                	test   %dl,%dl
   4382a:	0f 85 39 01 00 00    	jne    43969 <printer_vprintf+0x6ae>
   43830:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
   43834:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
   43838:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
   4383c:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43840:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43846:	e9 ca fd ff ff       	jmpq   43615 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
   4384b:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
   43851:	bf 50 53 04 00       	mov    $0x45350,%edi
        if (flags & FLAG_NUMERIC) {
   43856:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
   4385b:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
   4385f:	4c 89 c1             	mov    %r8,%rcx
   43862:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
   43866:	48 63 f6             	movslq %esi,%rsi
   43869:	49 83 ec 01          	sub    $0x1,%r12
   4386d:	48 89 c8             	mov    %rcx,%rax
   43870:	ba 00 00 00 00       	mov    $0x0,%edx
   43875:	48 f7 f6             	div    %rsi
   43878:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
   4387c:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
   43880:	48 89 ca             	mov    %rcx,%rdx
   43883:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
   43886:	48 39 d6             	cmp    %rdx,%rsi
   43889:	76 de                	jbe    43869 <printer_vprintf+0x5ae>
   4388b:	e9 9a fd ff ff       	jmpq   4362a <printer_vprintf+0x36f>
                prefix = "-";
   43890:	48 c7 45 a0 64 51 04 	movq   $0x45164,-0x60(%rbp)
   43897:	00 
            if (flags & FLAG_NEGATIVE) {
   43898:	8b 45 a8             	mov    -0x58(%rbp),%eax
   4389b:	a8 80                	test   $0x80,%al
   4389d:	0f 85 b0 fd ff ff    	jne    43653 <printer_vprintf+0x398>
                prefix = "+";
   438a3:	48 c7 45 a0 5f 51 04 	movq   $0x4515f,-0x60(%rbp)
   438aa:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
   438ab:	a8 10                	test   $0x10,%al
   438ad:	0f 85 a0 fd ff ff    	jne    43653 <printer_vprintf+0x398>
                prefix = " ";
   438b3:	a8 08                	test   $0x8,%al
   438b5:	ba 67 51 04 00       	mov    $0x45167,%edx
   438ba:	b8 66 51 04 00       	mov    $0x45166,%eax
   438bf:	48 0f 44 c2          	cmove  %rdx,%rax
   438c3:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   438c7:	e9 87 fd ff ff       	jmpq   43653 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
   438cc:	41 8d 41 10          	lea    0x10(%r9),%eax
   438d0:	a9 df ff ff ff       	test   $0xffffffdf,%eax
   438d5:	0f 85 78 fd ff ff    	jne    43653 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
   438db:	4d 85 c0             	test   %r8,%r8
   438de:	75 0d                	jne    438ed <printer_vprintf+0x632>
   438e0:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
   438e7:	0f 84 66 fd ff ff    	je     43653 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
   438ed:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
   438f1:	ba 68 51 04 00       	mov    $0x45168,%edx
   438f6:	b8 61 51 04 00       	mov    $0x45161,%eax
   438fb:	48 0f 44 c2          	cmove  %rdx,%rax
   438ff:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43903:	e9 4b fd ff ff       	jmpq   43653 <printer_vprintf+0x398>
            len = strlen(data);
   43908:	4c 89 e7             	mov    %r12,%rdi
   4390b:	e8 b5 f8 ff ff       	callq  431c5 <strlen>
   43910:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43913:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   43917:	0f 84 63 fd ff ff    	je     43680 <printer_vprintf+0x3c5>
   4391d:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
   43921:	0f 84 59 fd ff ff    	je     43680 <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
   43927:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
   4392a:	89 ca                	mov    %ecx,%edx
   4392c:	29 c2                	sub    %eax,%edx
   4392e:	39 c1                	cmp    %eax,%ecx
   43930:	b8 00 00 00 00       	mov    $0x0,%eax
   43935:	0f 4e d0             	cmovle %eax,%edx
   43938:	89 55 9c             	mov    %edx,-0x64(%rbp)
   4393b:	e9 56 fd ff ff       	jmpq   43696 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
   43940:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43944:	e8 7c f8 ff ff       	callq  431c5 <strlen>
   43949:	8b 7d 98             	mov    -0x68(%rbp),%edi
   4394c:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
   4394f:	44 89 e9             	mov    %r13d,%ecx
   43952:	29 f9                	sub    %edi,%ecx
   43954:	29 c1                	sub    %eax,%ecx
   43956:	44 39 ea             	cmp    %r13d,%edx
   43959:	b8 00 00 00 00       	mov    $0x0,%eax
   4395e:	0f 4d c8             	cmovge %eax,%ecx
   43961:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
   43964:	e9 2d fd ff ff       	jmpq   43696 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
   43969:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
   4396c:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43970:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43974:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   4397a:	e9 96 fc ff ff       	jmpq   43615 <printer_vprintf+0x35a>
        int flags = 0;
   4397f:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
   43986:	e9 b0 f9 ff ff       	jmpq   4333b <printer_vprintf+0x80>
}
   4398b:	48 83 c4 58          	add    $0x58,%rsp
   4398f:	5b                   	pop    %rbx
   43990:	41 5c                	pop    %r12
   43992:	41 5d                	pop    %r13
   43994:	41 5e                	pop    %r14
   43996:	41 5f                	pop    %r15
   43998:	5d                   	pop    %rbp
   43999:	c3                   	retq   

000000000004399a <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
   4399a:	55                   	push   %rbp
   4399b:	48 89 e5             	mov    %rsp,%rbp
   4399e:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
   439a2:	48 c7 45 f0 a5 30 04 	movq   $0x430a5,-0x10(%rbp)
   439a9:	00 
        cpos = 0;
   439aa:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
   439b0:	b8 00 00 00 00       	mov    $0x0,%eax
   439b5:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
   439b8:	48 63 ff             	movslq %edi,%rdi
   439bb:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
   439c2:	00 
   439c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   439c7:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
   439cb:	e8 eb f8 ff ff       	callq  432bb <printer_vprintf>
    return cp.cursor - console;
   439d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   439d4:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   439da:	48 d1 f8             	sar    %rax
}
   439dd:	c9                   	leaveq 
   439de:	c3                   	retq   

00000000000439df <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
   439df:	55                   	push   %rbp
   439e0:	48 89 e5             	mov    %rsp,%rbp
   439e3:	48 83 ec 50          	sub    $0x50,%rsp
   439e7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   439eb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   439ef:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
   439f3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   439fa:	48 8d 45 10          	lea    0x10(%rbp),%rax
   439fe:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43a02:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43a06:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   43a0a:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43a0e:	e8 87 ff ff ff       	callq  4399a <console_vprintf>
}
   43a13:	c9                   	leaveq 
   43a14:	c3                   	retq   

0000000000043a15 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   43a15:	55                   	push   %rbp
   43a16:	48 89 e5             	mov    %rsp,%rbp
   43a19:	53                   	push   %rbx
   43a1a:	48 83 ec 28          	sub    $0x28,%rsp
   43a1e:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
   43a21:	48 c7 45 d8 2b 31 04 	movq   $0x4312b,-0x28(%rbp)
   43a28:	00 
    sp.s = s;
   43a29:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
   43a2d:	48 85 f6             	test   %rsi,%rsi
   43a30:	75 0b                	jne    43a3d <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
   43a32:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43a35:	29 d8                	sub    %ebx,%eax
}
   43a37:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43a3b:	c9                   	leaveq 
   43a3c:	c3                   	retq   
        sp.end = s + size - 1;
   43a3d:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
   43a42:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43a46:	be 00 00 00 00       	mov    $0x0,%esi
   43a4b:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
   43a4f:	e8 67 f8 ff ff       	callq  432bb <printer_vprintf>
        *sp.s = 0;
   43a54:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a58:	c6 00 00             	movb   $0x0,(%rax)
   43a5b:	eb d5                	jmp    43a32 <vsnprintf+0x1d>

0000000000043a5d <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43a5d:	55                   	push   %rbp
   43a5e:	48 89 e5             	mov    %rsp,%rbp
   43a61:	48 83 ec 50          	sub    $0x50,%rsp
   43a65:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43a69:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43a6d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43a71:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43a78:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43a7c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43a80:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43a84:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
   43a88:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43a8c:	e8 84 ff ff ff       	callq  43a15 <vsnprintf>
    va_end(val);
    return n;
}
   43a91:	c9                   	leaveq 
   43a92:	c3                   	retq   

0000000000043a93 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43a93:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   43a98:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
   43a9d:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43aa2:	48 83 c0 02          	add    $0x2,%rax
   43aa6:	48 39 d0             	cmp    %rdx,%rax
   43aa9:	75 f2                	jne    43a9d <console_clear+0xa>
    }
    cursorpos = 0;
   43aab:	c7 05 47 55 07 00 00 	movl   $0x0,0x75547(%rip)        # b8ffc <cursorpos>
   43ab2:	00 00 00 
}
   43ab5:	c3                   	retq   

0000000000043ab6 <palloc>:
   43ab6:	55                   	push   %rbp
   43ab7:	48 89 e5             	mov    %rsp,%rbp
   43aba:	48 83 ec 20          	sub    $0x20,%rsp
   43abe:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43ac1:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43ac8:	00 
   43ac9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43acd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43ad1:	e9 95 00 00 00       	jmpq   43b6b <palloc+0xb5>
   43ad6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ada:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43ade:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43ae5:	00 
   43ae6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43aea:	48 c1 e8 0c          	shr    $0xc,%rax
   43aee:	48 98                	cltq   
   43af0:	0f b6 84 00 20 2f 05 	movzbl 0x52f20(%rax,%rax,1),%eax
   43af7:	00 
   43af8:	84 c0                	test   %al,%al
   43afa:	75 6f                	jne    43b6b <palloc+0xb5>
   43afc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b00:	48 c1 e8 0c          	shr    $0xc,%rax
   43b04:	48 98                	cltq   
   43b06:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   43b0d:	00 
   43b0e:	84 c0                	test   %al,%al
   43b10:	75 59                	jne    43b6b <palloc+0xb5>
   43b12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b16:	48 c1 e8 0c          	shr    $0xc,%rax
   43b1a:	89 c2                	mov    %eax,%edx
   43b1c:	48 63 c2             	movslq %edx,%rax
   43b1f:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   43b26:	00 
   43b27:	83 c0 01             	add    $0x1,%eax
   43b2a:	89 c1                	mov    %eax,%ecx
   43b2c:	48 63 c2             	movslq %edx,%rax
   43b2f:	88 8c 00 21 2f 05 00 	mov    %cl,0x52f21(%rax,%rax,1)
   43b36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b3a:	48 c1 e8 0c          	shr    $0xc,%rax
   43b3e:	89 c1                	mov    %eax,%ecx
   43b40:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43b43:	89 c2                	mov    %eax,%edx
   43b45:	48 63 c1             	movslq %ecx,%rax
   43b48:	88 94 00 20 2f 05 00 	mov    %dl,0x52f20(%rax,%rax,1)
   43b4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b53:	ba 00 10 00 00       	mov    $0x1000,%edx
   43b58:	be cc 00 00 00       	mov    $0xcc,%esi
   43b5d:	48 89 c7             	mov    %rax,%rdi
   43b60:	e8 45 f6 ff ff       	callq  431aa <memset>
   43b65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b69:	eb 2c                	jmp    43b97 <palloc+0xe1>
   43b6b:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   43b72:	00 
   43b73:	0f 86 5d ff ff ff    	jbe    43ad6 <palloc+0x20>
   43b79:	ba 68 53 04 00       	mov    $0x45368,%edx
   43b7e:	be 00 0c 00 00       	mov    $0xc00,%esi
   43b83:	bf 80 07 00 00       	mov    $0x780,%edi
   43b88:	b8 00 00 00 00       	mov    $0x0,%eax
   43b8d:	e8 4d fe ff ff       	callq  439df <console_printf>
   43b92:	b8 00 00 00 00       	mov    $0x0,%eax
   43b97:	c9                   	leaveq 
   43b98:	c3                   	retq   

0000000000043b99 <palloc_target>:
   43b99:	55                   	push   %rbp
   43b9a:	48 89 e5             	mov    %rsp,%rbp
   43b9d:	48 8b 05 64 74 01 00 	mov    0x17464(%rip),%rax        # 5b008 <palloc_target_proc>
   43ba4:	48 85 c0             	test   %rax,%rax
   43ba7:	75 14                	jne    43bbd <palloc_target+0x24>
   43ba9:	ba 81 53 04 00       	mov    $0x45381,%edx
   43bae:	be 27 00 00 00       	mov    $0x27,%esi
   43bb3:	bf 9c 53 04 00       	mov    $0x4539c,%edi
   43bb8:	e8 dc e9 ff ff       	callq  42599 <assert_fail>
   43bbd:	48 8b 05 44 74 01 00 	mov    0x17444(%rip),%rax        # 5b008 <palloc_target_proc>
   43bc4:	8b 00                	mov    (%rax),%eax
   43bc6:	89 c7                	mov    %eax,%edi
   43bc8:	e8 e9 fe ff ff       	callq  43ab6 <palloc>
   43bcd:	5d                   	pop    %rbp
   43bce:	c3                   	retq   

0000000000043bcf <process_free>:
   43bcf:	55                   	push   %rbp
   43bd0:	48 89 e5             	mov    %rsp,%rbp
   43bd3:	48 83 ec 60          	sub    $0x60,%rsp
   43bd7:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43bda:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43bdd:	48 63 d0             	movslq %eax,%rdx
   43be0:	48 89 d0             	mov    %rdx,%rax
   43be3:	48 c1 e0 04          	shl    $0x4,%rax
   43be7:	48 29 d0             	sub    %rdx,%rax
   43bea:	48 c1 e0 04          	shl    $0x4,%rax
   43bee:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   43bf4:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43bfa:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43c01:	00 
   43c02:	e9 ad 00 00 00       	jmpq   43cb4 <process_free+0xe5>
   43c07:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43c0a:	48 63 d0             	movslq %eax,%rdx
   43c0d:	48 89 d0             	mov    %rdx,%rax
   43c10:	48 c1 e0 04          	shl    $0x4,%rax
   43c14:	48 29 d0             	sub    %rdx,%rax
   43c17:	48 c1 e0 04          	shl    $0x4,%rax
   43c1b:	48 05 e0 20 05 00    	add    $0x520e0,%rax
   43c21:	48 8b 08             	mov    (%rax),%rcx
   43c24:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   43c28:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c2c:	48 89 ce             	mov    %rcx,%rsi
   43c2f:	48 89 c7             	mov    %rax,%rdi
   43c32:	e8 24 f0 ff ff       	callq  42c5b <virtual_memory_lookup>
   43c37:	8b 45 c8             	mov    -0x38(%rbp),%eax
   43c3a:	48 98                	cltq   
   43c3c:	83 e0 01             	and    $0x1,%eax
   43c3f:	48 85 c0             	test   %rax,%rax
   43c42:	74 68                	je     43cac <process_free+0xdd>
   43c44:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43c47:	48 63 d0             	movslq %eax,%rdx
   43c4a:	0f b6 94 12 21 2f 05 	movzbl 0x52f21(%rdx,%rdx,1),%edx
   43c51:	00 
   43c52:	83 ea 01             	sub    $0x1,%edx
   43c55:	48 98                	cltq   
   43c57:	88 94 00 21 2f 05 00 	mov    %dl,0x52f21(%rax,%rax,1)
   43c5e:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43c61:	48 98                	cltq   
   43c63:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   43c6a:	00 
   43c6b:	84 c0                	test   %al,%al
   43c6d:	75 0f                	jne    43c7e <process_free+0xaf>
   43c6f:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43c72:	48 98                	cltq   
   43c74:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   43c7b:	00 
   43c7c:	eb 2e                	jmp    43cac <process_free+0xdd>
   43c7e:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43c81:	48 98                	cltq   
   43c83:	0f b6 84 00 20 2f 05 	movzbl 0x52f20(%rax,%rax,1),%eax
   43c8a:	00 
   43c8b:	0f be c0             	movsbl %al,%eax
   43c8e:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43c91:	75 19                	jne    43cac <process_free+0xdd>
   43c93:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43c97:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43c9a:	48 89 c6             	mov    %rax,%rsi
   43c9d:	bf a8 53 04 00       	mov    $0x453a8,%edi
   43ca2:	b8 00 00 00 00       	mov    $0x0,%eax
   43ca7:	e8 cf e5 ff ff       	callq  4227b <log_printf>
   43cac:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43cb3:	00 
   43cb4:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43cbb:	00 
   43cbc:	0f 86 45 ff ff ff    	jbe    43c07 <process_free+0x38>
   43cc2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43cc5:	48 63 d0             	movslq %eax,%rdx
   43cc8:	48 89 d0             	mov    %rdx,%rax
   43ccb:	48 c1 e0 04          	shl    $0x4,%rax
   43ccf:	48 29 d0             	sub    %rdx,%rax
   43cd2:	48 c1 e0 04          	shl    $0x4,%rax
   43cd6:	48 05 e0 20 05 00    	add    $0x520e0,%rax
   43cdc:	48 8b 00             	mov    (%rax),%rax
   43cdf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43ce3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ce7:	48 8b 00             	mov    (%rax),%rax
   43cea:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43cf0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43cf4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cf8:	48 8b 00             	mov    (%rax),%rax
   43cfb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43d01:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43d05:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43d09:	48 8b 00             	mov    (%rax),%rax
   43d0c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43d12:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43d16:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43d1a:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d1e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43d24:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   43d28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d2c:	48 c1 e8 0c          	shr    $0xc,%rax
   43d30:	48 98                	cltq   
   43d32:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   43d39:	00 
   43d3a:	3c 01                	cmp    $0x1,%al
   43d3c:	74 14                	je     43d52 <process_free+0x183>
   43d3e:	ba e0 53 04 00       	mov    $0x453e0,%edx
   43d43:	be 4f 00 00 00       	mov    $0x4f,%esi
   43d48:	bf 9c 53 04 00       	mov    $0x4539c,%edi
   43d4d:	e8 47 e8 ff ff       	callq  42599 <assert_fail>
   43d52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d56:	48 c1 e8 0c          	shr    $0xc,%rax
   43d5a:	48 98                	cltq   
   43d5c:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   43d63:	00 
   43d64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d68:	48 c1 e8 0c          	shr    $0xc,%rax
   43d6c:	48 98                	cltq   
   43d6e:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   43d75:	00 
   43d76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d7a:	48 c1 e8 0c          	shr    $0xc,%rax
   43d7e:	48 98                	cltq   
   43d80:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   43d87:	00 
   43d88:	3c 01                	cmp    $0x1,%al
   43d8a:	74 14                	je     43da0 <process_free+0x1d1>
   43d8c:	ba 08 54 04 00       	mov    $0x45408,%edx
   43d91:	be 52 00 00 00       	mov    $0x52,%esi
   43d96:	bf 9c 53 04 00       	mov    $0x4539c,%edi
   43d9b:	e8 f9 e7 ff ff       	callq  42599 <assert_fail>
   43da0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43da4:	48 c1 e8 0c          	shr    $0xc,%rax
   43da8:	48 98                	cltq   
   43daa:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   43db1:	00 
   43db2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43db6:	48 c1 e8 0c          	shr    $0xc,%rax
   43dba:	48 98                	cltq   
   43dbc:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   43dc3:	00 
   43dc4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43dc8:	48 c1 e8 0c          	shr    $0xc,%rax
   43dcc:	48 98                	cltq   
   43dce:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   43dd5:	00 
   43dd6:	3c 01                	cmp    $0x1,%al
   43dd8:	74 14                	je     43dee <process_free+0x21f>
   43dda:	ba 30 54 04 00       	mov    $0x45430,%edx
   43ddf:	be 55 00 00 00       	mov    $0x55,%esi
   43de4:	bf 9c 53 04 00       	mov    $0x4539c,%edi
   43de9:	e8 ab e7 ff ff       	callq  42599 <assert_fail>
   43dee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43df2:	48 c1 e8 0c          	shr    $0xc,%rax
   43df6:	48 98                	cltq   
   43df8:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   43dff:	00 
   43e00:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43e04:	48 c1 e8 0c          	shr    $0xc,%rax
   43e08:	48 98                	cltq   
   43e0a:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   43e11:	00 
   43e12:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e16:	48 c1 e8 0c          	shr    $0xc,%rax
   43e1a:	48 98                	cltq   
   43e1c:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   43e23:	00 
   43e24:	3c 01                	cmp    $0x1,%al
   43e26:	74 14                	je     43e3c <process_free+0x26d>
   43e28:	ba 58 54 04 00       	mov    $0x45458,%edx
   43e2d:	be 58 00 00 00       	mov    $0x58,%esi
   43e32:	bf 9c 53 04 00       	mov    $0x4539c,%edi
   43e37:	e8 5d e7 ff ff       	callq  42599 <assert_fail>
   43e3c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e40:	48 c1 e8 0c          	shr    $0xc,%rax
   43e44:	48 98                	cltq   
   43e46:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   43e4d:	00 
   43e4e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e52:	48 c1 e8 0c          	shr    $0xc,%rax
   43e56:	48 98                	cltq   
   43e58:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   43e5f:	00 
   43e60:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43e64:	48 c1 e8 0c          	shr    $0xc,%rax
   43e68:	48 98                	cltq   
   43e6a:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   43e71:	00 
   43e72:	3c 01                	cmp    $0x1,%al
   43e74:	74 14                	je     43e8a <process_free+0x2bb>
   43e76:	ba 80 54 04 00       	mov    $0x45480,%edx
   43e7b:	be 5b 00 00 00       	mov    $0x5b,%esi
   43e80:	bf 9c 53 04 00       	mov    $0x4539c,%edi
   43e85:	e8 0f e7 ff ff       	callq  42599 <assert_fail>
   43e8a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43e8e:	48 c1 e8 0c          	shr    $0xc,%rax
   43e92:	48 98                	cltq   
   43e94:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   43e9b:	00 
   43e9c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43ea0:	48 c1 e8 0c          	shr    $0xc,%rax
   43ea4:	48 98                	cltq   
   43ea6:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   43ead:	00 
   43eae:	90                   	nop
   43eaf:	c9                   	leaveq 
   43eb0:	c3                   	retq   

0000000000043eb1 <process_config_tables>:
   43eb1:	55                   	push   %rbp
   43eb2:	48 89 e5             	mov    %rsp,%rbp
   43eb5:	48 83 ec 40          	sub    $0x40,%rsp
   43eb9:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43ebc:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43ebf:	89 c7                	mov    %eax,%edi
   43ec1:	e8 f0 fb ff ff       	callq  43ab6 <palloc>
   43ec6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43eca:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43ecd:	89 c7                	mov    %eax,%edi
   43ecf:	e8 e2 fb ff ff       	callq  43ab6 <palloc>
   43ed4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43ed8:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43edb:	89 c7                	mov    %eax,%edi
   43edd:	e8 d4 fb ff ff       	callq  43ab6 <palloc>
   43ee2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43ee6:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43ee9:	89 c7                	mov    %eax,%edi
   43eeb:	e8 c6 fb ff ff       	callq  43ab6 <palloc>
   43ef0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43ef4:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43ef7:	89 c7                	mov    %eax,%edi
   43ef9:	e8 b8 fb ff ff       	callq  43ab6 <palloc>
   43efe:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43f02:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43f07:	74 20                	je     43f29 <process_config_tables+0x78>
   43f09:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43f0e:	74 19                	je     43f29 <process_config_tables+0x78>
   43f10:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43f15:	74 12                	je     43f29 <process_config_tables+0x78>
   43f17:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43f1c:	74 0b                	je     43f29 <process_config_tables+0x78>
   43f1e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43f23:	0f 85 e1 00 00 00    	jne    4400a <process_config_tables+0x159>
   43f29:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43f2e:	74 24                	je     43f54 <process_config_tables+0xa3>
   43f30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f34:	48 c1 e8 0c          	shr    $0xc,%rax
   43f38:	48 98                	cltq   
   43f3a:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   43f41:	00 
   43f42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f46:	48 c1 e8 0c          	shr    $0xc,%rax
   43f4a:	48 98                	cltq   
   43f4c:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   43f53:	00 
   43f54:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43f59:	74 24                	je     43f7f <process_config_tables+0xce>
   43f5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43f5f:	48 c1 e8 0c          	shr    $0xc,%rax
   43f63:	48 98                	cltq   
   43f65:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   43f6c:	00 
   43f6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43f71:	48 c1 e8 0c          	shr    $0xc,%rax
   43f75:	48 98                	cltq   
   43f77:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   43f7e:	00 
   43f7f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43f84:	74 24                	je     43faa <process_config_tables+0xf9>
   43f86:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f8a:	48 c1 e8 0c          	shr    $0xc,%rax
   43f8e:	48 98                	cltq   
   43f90:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   43f97:	00 
   43f98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f9c:	48 c1 e8 0c          	shr    $0xc,%rax
   43fa0:	48 98                	cltq   
   43fa2:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   43fa9:	00 
   43faa:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43faf:	74 24                	je     43fd5 <process_config_tables+0x124>
   43fb1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43fb5:	48 c1 e8 0c          	shr    $0xc,%rax
   43fb9:	48 98                	cltq   
   43fbb:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   43fc2:	00 
   43fc3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43fc7:	48 c1 e8 0c          	shr    $0xc,%rax
   43fcb:	48 98                	cltq   
   43fcd:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   43fd4:	00 
   43fd5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43fda:	74 24                	je     44000 <process_config_tables+0x14f>
   43fdc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43fe0:	48 c1 e8 0c          	shr    $0xc,%rax
   43fe4:	48 98                	cltq   
   43fe6:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   43fed:	00 
   43fee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43ff2:	48 c1 e8 0c          	shr    $0xc,%rax
   43ff6:	48 98                	cltq   
   43ff8:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   43fff:	00 
   44000:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44005:	e9 f3 01 00 00       	jmpq   441fd <process_config_tables+0x34c>
   4400a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4400e:	ba 00 10 00 00       	mov    $0x1000,%edx
   44013:	be 00 00 00 00       	mov    $0x0,%esi
   44018:	48 89 c7             	mov    %rax,%rdi
   4401b:	e8 8a f1 ff ff       	callq  431aa <memset>
   44020:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44024:	ba 00 10 00 00       	mov    $0x1000,%edx
   44029:	be 00 00 00 00       	mov    $0x0,%esi
   4402e:	48 89 c7             	mov    %rax,%rdi
   44031:	e8 74 f1 ff ff       	callq  431aa <memset>
   44036:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4403a:	ba 00 10 00 00       	mov    $0x1000,%edx
   4403f:	be 00 00 00 00       	mov    $0x0,%esi
   44044:	48 89 c7             	mov    %rax,%rdi
   44047:	e8 5e f1 ff ff       	callq  431aa <memset>
   4404c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44050:	ba 00 10 00 00       	mov    $0x1000,%edx
   44055:	be 00 00 00 00       	mov    $0x0,%esi
   4405a:	48 89 c7             	mov    %rax,%rdi
   4405d:	e8 48 f1 ff ff       	callq  431aa <memset>
   44062:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44066:	ba 00 10 00 00       	mov    $0x1000,%edx
   4406b:	be 00 00 00 00       	mov    $0x0,%esi
   44070:	48 89 c7             	mov    %rax,%rdi
   44073:	e8 32 f1 ff ff       	callq  431aa <memset>
   44078:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4407c:	48 83 c8 07          	or     $0x7,%rax
   44080:	48 89 c2             	mov    %rax,%rdx
   44083:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44087:	48 89 10             	mov    %rdx,(%rax)
   4408a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4408e:	48 83 c8 07          	or     $0x7,%rax
   44092:	48 89 c2             	mov    %rax,%rdx
   44095:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44099:	48 89 10             	mov    %rdx,(%rax)
   4409c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   440a0:	48 83 c8 07          	or     $0x7,%rax
   440a4:	48 89 c2             	mov    %rax,%rdx
   440a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   440ab:	48 89 10             	mov    %rdx,(%rax)
   440ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   440b2:	48 83 c8 07          	or     $0x7,%rax
   440b6:	48 89 c2             	mov    %rax,%rdx
   440b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   440bd:	48 89 50 08          	mov    %rdx,0x8(%rax)
   440c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440c5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   440cb:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   440d1:	b9 00 00 10 00       	mov    $0x100000,%ecx
   440d6:	ba 00 00 00 00       	mov    $0x0,%edx
   440db:	be 00 00 00 00       	mov    $0x0,%esi
   440e0:	48 89 c7             	mov    %rax,%rdi
   440e3:	e8 b0 e7 ff ff       	callq  42898 <virtual_memory_map>
   440e8:	85 c0                	test   %eax,%eax
   440ea:	75 2f                	jne    4411b <process_config_tables+0x26a>
   440ec:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   440f1:	be 00 80 0b 00       	mov    $0xb8000,%esi
   440f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440fa:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44100:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   44106:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4410b:	48 89 c7             	mov    %rax,%rdi
   4410e:	e8 85 e7 ff ff       	callq  42898 <virtual_memory_map>
   44113:	85 c0                	test   %eax,%eax
   44115:	0f 84 bb 00 00 00    	je     441d6 <process_config_tables+0x325>
   4411b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4411f:	48 c1 e8 0c          	shr    $0xc,%rax
   44123:	48 98                	cltq   
   44125:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   4412c:	00 
   4412d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44131:	48 c1 e8 0c          	shr    $0xc,%rax
   44135:	48 98                	cltq   
   44137:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   4413e:	00 
   4413f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44143:	48 c1 e8 0c          	shr    $0xc,%rax
   44147:	48 98                	cltq   
   44149:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   44150:	00 
   44151:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44155:	48 c1 e8 0c          	shr    $0xc,%rax
   44159:	48 98                	cltq   
   4415b:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   44162:	00 
   44163:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44167:	48 c1 e8 0c          	shr    $0xc,%rax
   4416b:	48 98                	cltq   
   4416d:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   44174:	00 
   44175:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44179:	48 c1 e8 0c          	shr    $0xc,%rax
   4417d:	48 98                	cltq   
   4417f:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   44186:	00 
   44187:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4418b:	48 c1 e8 0c          	shr    $0xc,%rax
   4418f:	48 98                	cltq   
   44191:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   44198:	00 
   44199:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4419d:	48 c1 e8 0c          	shr    $0xc,%rax
   441a1:	48 98                	cltq   
   441a3:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   441aa:	00 
   441ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   441af:	48 c1 e8 0c          	shr    $0xc,%rax
   441b3:	48 98                	cltq   
   441b5:	c6 84 00 20 2f 05 00 	movb   $0x0,0x52f20(%rax,%rax,1)
   441bc:	00 
   441bd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   441c1:	48 c1 e8 0c          	shr    $0xc,%rax
   441c5:	48 98                	cltq   
   441c7:	c6 84 00 21 2f 05 00 	movb   $0x0,0x52f21(%rax,%rax,1)
   441ce:	00 
   441cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   441d4:	eb 27                	jmp    441fd <process_config_tables+0x34c>
   441d6:	8b 45 cc             	mov    -0x34(%rbp),%eax
   441d9:	48 63 d0             	movslq %eax,%rdx
   441dc:	48 89 d0             	mov    %rdx,%rax
   441df:	48 c1 e0 04          	shl    $0x4,%rax
   441e3:	48 29 d0             	sub    %rdx,%rax
   441e6:	48 c1 e0 04          	shl    $0x4,%rax
   441ea:	48 8d 90 e0 20 05 00 	lea    0x520e0(%rax),%rdx
   441f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441f5:	48 89 02             	mov    %rax,(%rdx)
   441f8:	b8 00 00 00 00       	mov    $0x0,%eax
   441fd:	c9                   	leaveq 
   441fe:	c3                   	retq   

00000000000441ff <process_load>:
   441ff:	55                   	push   %rbp
   44200:	48 89 e5             	mov    %rsp,%rbp
   44203:	48 83 ec 20          	sub    $0x20,%rsp
   44207:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4420b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4420e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44212:	48 89 05 ef 6d 01 00 	mov    %rax,0x16def(%rip)        # 5b008 <palloc_target_proc>
   44219:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   4421c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44220:	ba 99 3b 04 00       	mov    $0x43b99,%edx
   44225:	89 ce                	mov    %ecx,%esi
   44227:	48 89 c7             	mov    %rax,%rdi
   4422a:	e8 23 eb ff ff       	callq  42d52 <program_load>
   4422f:	89 45 fc             	mov    %eax,-0x4(%rbp)
   44232:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44235:	c9                   	leaveq 
   44236:	c3                   	retq   

0000000000044237 <process_setup_stack>:
   44237:	55                   	push   %rbp
   44238:	48 89 e5             	mov    %rsp,%rbp
   4423b:	48 83 ec 20          	sub    $0x20,%rsp
   4423f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44243:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44247:	8b 00                	mov    (%rax),%eax
   44249:	89 c7                	mov    %eax,%edi
   4424b:	e8 66 f8 ff ff       	callq  43ab6 <palloc>
   44250:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44254:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44258:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   4425f:	00 00 30 00 
   44263:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44267:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4426e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44272:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44278:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4427e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44283:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   44288:	48 89 c7             	mov    %rax,%rdi
   4428b:	e8 08 e6 ff ff       	callq  42898 <virtual_memory_map>
   44290:	90                   	nop
   44291:	c9                   	leaveq 
   44292:	c3                   	retq   

0000000000044293 <find_free_pid>:
   44293:	55                   	push   %rbp
   44294:	48 89 e5             	mov    %rsp,%rbp
   44297:	48 83 ec 10          	sub    $0x10,%rsp
   4429b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   442a2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   442a9:	eb 24                	jmp    442cf <find_free_pid+0x3c>
   442ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
   442ae:	48 63 d0             	movslq %eax,%rdx
   442b1:	48 89 d0             	mov    %rdx,%rax
   442b4:	48 c1 e0 04          	shl    $0x4,%rax
   442b8:	48 29 d0             	sub    %rdx,%rax
   442bb:	48 c1 e0 04          	shl    $0x4,%rax
   442bf:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   442c5:	8b 00                	mov    (%rax),%eax
   442c7:	85 c0                	test   %eax,%eax
   442c9:	74 0c                	je     442d7 <find_free_pid+0x44>
   442cb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   442cf:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   442d3:	7e d6                	jle    442ab <find_free_pid+0x18>
   442d5:	eb 01                	jmp    442d8 <find_free_pid+0x45>
   442d7:	90                   	nop
   442d8:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   442dc:	74 05                	je     442e3 <find_free_pid+0x50>
   442de:	8b 45 fc             	mov    -0x4(%rbp),%eax
   442e1:	eb 05                	jmp    442e8 <find_free_pid+0x55>
   442e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   442e8:	c9                   	leaveq 
   442e9:	c3                   	retq   

00000000000442ea <process_fork>:
   442ea:	55                   	push   %rbp
   442eb:	48 89 e5             	mov    %rsp,%rbp
   442ee:	48 83 ec 40          	sub    $0x40,%rsp
   442f2:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   442f6:	b8 00 00 00 00       	mov    $0x0,%eax
   442fb:	e8 93 ff ff ff       	callq  44293 <find_free_pid>
   44300:	89 45 f4             	mov    %eax,-0xc(%rbp)
   44303:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   44307:	75 0a                	jne    44313 <process_fork+0x29>
   44309:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4430e:	e9 67 02 00 00       	jmpq   4457a <process_fork+0x290>
   44313:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44316:	48 63 d0             	movslq %eax,%rdx
   44319:	48 89 d0             	mov    %rdx,%rax
   4431c:	48 c1 e0 04          	shl    $0x4,%rax
   44320:	48 29 d0             	sub    %rdx,%rax
   44323:	48 c1 e0 04          	shl    $0x4,%rax
   44327:	48 05 00 20 05 00    	add    $0x52000,%rax
   4432d:	be 00 00 00 00       	mov    $0x0,%esi
   44332:	48 89 c7             	mov    %rax,%rdi
   44335:	e8 97 da ff ff       	callq  41dd1 <process_init>
   4433a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4433d:	89 c7                	mov    %eax,%edi
   4433f:	e8 6d fb ff ff       	callq  43eb1 <process_config_tables>
   44344:	83 f8 ff             	cmp    $0xffffffff,%eax
   44347:	75 0a                	jne    44353 <process_fork+0x69>
   44349:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4434e:	e9 27 02 00 00       	jmpq   4457a <process_fork+0x290>
   44353:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   4435a:	00 
   4435b:	e9 79 01 00 00       	jmpq   444d9 <process_fork+0x1ef>
   44360:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44364:	8b 00                	mov    (%rax),%eax
   44366:	48 63 d0             	movslq %eax,%rdx
   44369:	48 89 d0             	mov    %rdx,%rax
   4436c:	48 c1 e0 04          	shl    $0x4,%rax
   44370:	48 29 d0             	sub    %rdx,%rax
   44373:	48 c1 e0 04          	shl    $0x4,%rax
   44377:	48 05 e0 20 05 00    	add    $0x520e0,%rax
   4437d:	48 8b 08             	mov    (%rax),%rcx
   44380:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44384:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44388:	48 89 ce             	mov    %rcx,%rsi
   4438b:	48 89 c7             	mov    %rax,%rdi
   4438e:	e8 c8 e8 ff ff       	callq  42c5b <virtual_memory_lookup>
   44393:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44396:	48 98                	cltq   
   44398:	83 e0 07             	and    $0x7,%eax
   4439b:	48 83 f8 07          	cmp    $0x7,%rax
   4439f:	0f 85 a1 00 00 00    	jne    44446 <process_fork+0x15c>
   443a5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   443a8:	89 c7                	mov    %eax,%edi
   443aa:	e8 07 f7 ff ff       	callq  43ab6 <palloc>
   443af:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   443b3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   443b8:	75 14                	jne    443ce <process_fork+0xe4>
   443ba:	8b 45 f4             	mov    -0xc(%rbp),%eax
   443bd:	89 c7                	mov    %eax,%edi
   443bf:	e8 0b f8 ff ff       	callq  43bcf <process_free>
   443c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   443c9:	e9 ac 01 00 00       	jmpq   4457a <process_fork+0x290>
   443ce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   443d2:	48 89 c1             	mov    %rax,%rcx
   443d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443d9:	ba 00 10 00 00       	mov    $0x1000,%edx
   443de:	48 89 ce             	mov    %rcx,%rsi
   443e1:	48 89 c7             	mov    %rax,%rdi
   443e4:	e8 58 ed ff ff       	callq  43141 <memcpy>
   443e9:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   443ed:	8b 45 f4             	mov    -0xc(%rbp),%eax
   443f0:	48 63 d0             	movslq %eax,%rdx
   443f3:	48 89 d0             	mov    %rdx,%rax
   443f6:	48 c1 e0 04          	shl    $0x4,%rax
   443fa:	48 29 d0             	sub    %rdx,%rax
   443fd:	48 c1 e0 04          	shl    $0x4,%rax
   44401:	48 05 e0 20 05 00    	add    $0x520e0,%rax
   44407:	48 8b 00             	mov    (%rax),%rax
   4440a:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4440e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44414:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4441a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4441f:	48 89 fa             	mov    %rdi,%rdx
   44422:	48 89 c7             	mov    %rax,%rdi
   44425:	e8 6e e4 ff ff       	callq  42898 <virtual_memory_map>
   4442a:	85 c0                	test   %eax,%eax
   4442c:	0f 84 9f 00 00 00    	je     444d1 <process_fork+0x1e7>
   44432:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44435:	89 c7                	mov    %eax,%edi
   44437:	e8 93 f7 ff ff       	callq  43bcf <process_free>
   4443c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44441:	e9 34 01 00 00       	jmpq   4457a <process_fork+0x290>
   44446:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44449:	48 98                	cltq   
   4444b:	83 e0 05             	and    $0x5,%eax
   4444e:	48 83 f8 05          	cmp    $0x5,%rax
   44452:	75 7d                	jne    444d1 <process_fork+0x1e7>
   44454:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   44458:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4445b:	48 63 d0             	movslq %eax,%rdx
   4445e:	48 89 d0             	mov    %rdx,%rax
   44461:	48 c1 e0 04          	shl    $0x4,%rax
   44465:	48 29 d0             	sub    %rdx,%rax
   44468:	48 c1 e0 04          	shl    $0x4,%rax
   4446c:	48 05 e0 20 05 00    	add    $0x520e0,%rax
   44472:	48 8b 00             	mov    (%rax),%rax
   44475:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   44479:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4447f:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   44485:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4448a:	48 89 fa             	mov    %rdi,%rdx
   4448d:	48 89 c7             	mov    %rax,%rdi
   44490:	e8 03 e4 ff ff       	callq  42898 <virtual_memory_map>
   44495:	85 c0                	test   %eax,%eax
   44497:	74 14                	je     444ad <process_fork+0x1c3>
   44499:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4449c:	89 c7                	mov    %eax,%edi
   4449e:	e8 2c f7 ff ff       	callq  43bcf <process_free>
   444a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   444a8:	e9 cd 00 00 00       	jmpq   4457a <process_fork+0x290>
   444ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   444b1:	48 c1 e8 0c          	shr    $0xc,%rax
   444b5:	89 c2                	mov    %eax,%edx
   444b7:	48 63 c2             	movslq %edx,%rax
   444ba:	0f b6 84 00 21 2f 05 	movzbl 0x52f21(%rax,%rax,1),%eax
   444c1:	00 
   444c2:	83 c0 01             	add    $0x1,%eax
   444c5:	89 c1                	mov    %eax,%ecx
   444c7:	48 63 c2             	movslq %edx,%rax
   444ca:	88 8c 00 21 2f 05 00 	mov    %cl,0x52f21(%rax,%rax,1)
   444d1:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   444d8:	00 
   444d9:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   444e0:	00 
   444e1:	0f 86 79 fe ff ff    	jbe    44360 <process_fork+0x76>
   444e7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   444eb:	8b 08                	mov    (%rax),%ecx
   444ed:	8b 45 f4             	mov    -0xc(%rbp),%eax
   444f0:	48 63 d0             	movslq %eax,%rdx
   444f3:	48 89 d0             	mov    %rdx,%rax
   444f6:	48 c1 e0 04          	shl    $0x4,%rax
   444fa:	48 29 d0             	sub    %rdx,%rax
   444fd:	48 c1 e0 04          	shl    $0x4,%rax
   44501:	48 8d b0 10 20 05 00 	lea    0x52010(%rax),%rsi
   44508:	48 63 d1             	movslq %ecx,%rdx
   4450b:	48 89 d0             	mov    %rdx,%rax
   4450e:	48 c1 e0 04          	shl    $0x4,%rax
   44512:	48 29 d0             	sub    %rdx,%rax
   44515:	48 c1 e0 04          	shl    $0x4,%rax
   44519:	48 8d 90 10 20 05 00 	lea    0x52010(%rax),%rdx
   44520:	48 8d 46 08          	lea    0x8(%rsi),%rax
   44524:	48 83 c2 08          	add    $0x8,%rdx
   44528:	b9 18 00 00 00       	mov    $0x18,%ecx
   4452d:	48 89 c7             	mov    %rax,%rdi
   44530:	48 89 d6             	mov    %rdx,%rsi
   44533:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   44536:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44539:	48 63 d0             	movslq %eax,%rdx
   4453c:	48 89 d0             	mov    %rdx,%rax
   4453f:	48 c1 e0 04          	shl    $0x4,%rax
   44543:	48 29 d0             	sub    %rdx,%rax
   44546:	48 c1 e0 04          	shl    $0x4,%rax
   4454a:	48 05 18 20 05 00    	add    $0x52018,%rax
   44550:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   44557:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4455a:	48 63 d0             	movslq %eax,%rdx
   4455d:	48 89 d0             	mov    %rdx,%rax
   44560:	48 c1 e0 04          	shl    $0x4,%rax
   44564:	48 29 d0             	sub    %rdx,%rax
   44567:	48 c1 e0 04          	shl    $0x4,%rax
   4456b:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   44571:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   44577:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4457a:	c9                   	leaveq 
   4457b:	c3                   	retq   

000000000004457c <process_page_alloc>:
   4457c:	55                   	push   %rbp
   4457d:	48 89 e5             	mov    %rsp,%rbp
   44580:	48 83 ec 20          	sub    $0x20,%rsp
   44584:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44588:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4458c:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   44593:	00 
   44594:	77 07                	ja     4459d <process_page_alloc+0x21>
   44596:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4459b:	eb 4b                	jmp    445e8 <process_page_alloc+0x6c>
   4459d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   445a1:	8b 00                	mov    (%rax),%eax
   445a3:	89 c7                	mov    %eax,%edi
   445a5:	e8 0c f5 ff ff       	callq  43ab6 <palloc>
   445aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   445ae:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   445b3:	74 2e                	je     445e3 <process_page_alloc+0x67>
   445b5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   445b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   445bd:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   445c4:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   445c8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   445ce:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   445d4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   445d9:	48 89 c7             	mov    %rax,%rdi
   445dc:	e8 b7 e2 ff ff       	callq  42898 <virtual_memory_map>
   445e1:	eb 05                	jmp    445e8 <process_page_alloc+0x6c>
   445e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   445e8:	c9                   	leaveq 
   445e9:	c3                   	retq   

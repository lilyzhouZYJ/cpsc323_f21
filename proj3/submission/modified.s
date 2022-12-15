.LC0:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, %eax                # eax = a = 0
	movl	$1, %ebx                # ebx = c = 1
	jmp	.L2
.L3:
	addl	$1, %eax                # eax = a + 1 = b
	addl	%eax, %ebx              # ebx = ebx (c) + eax (b) = b + c = c
	addl	%eax, %eax              # eax = eax (b) + eax (b) = b * 2 = a
.L2:
	cmpl	$8, %eax                # compare %eax = a with 8
	jle	.L3
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc

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
	movl	$0, -12(%rbp)			# Mem[rbp-12] = 0 (a)
	movl	$1, -8(%rbp)			# Mem[rbp-8] = 1 (c)
	jmp	.L2
.L3:
	movl	-12(%rbp), %eax			# eax (b) = Mem[rbp-12] (a)
	addl	$1, %eax				# eax += 1		=> b = a + 1
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	%eax, -8(%rbp)
	movl	-4(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, -12(%rbp)
.L2:
	cmpl	$8, -12(%rbp)			# compare Mem[rbp-12] (a) with 8
	jle	.L3
	movl	-12(%rbp), %eax			# eax = a
	movl	%eax, %esi				# esi = eax = a
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc

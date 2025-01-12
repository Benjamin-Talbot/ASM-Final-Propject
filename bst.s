	.file	"bst.c"
	.text
	.section	.rodata
.LC0:
	.string	"bst:"
.LC1:
	.string	"Time: %lf\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -88(%rbp)
	movl	$5, -32(%rbp)
	movl	$7, -28(%rbp)
	movl	$12, -24(%rbp)
	movl	$13, -20(%rbp)
	movl	$11, -16(%rbp)
	movl	$5, -92(%rbp)
	leaq	-64(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime@PLT
	movl	$0, -100(%rbp)
	jmp	.L2
.L5:
	movl	$10, %edi
	call	init_tree
	movq	%rax, -72(%rbp)
	movl	$0, -96(%rbp)
	jmp	.L3
.L4:
	movl	-96(%rbp), %eax
	cltq
	movl	-32(%rbp,%rax,4), %eax
	movl	%eax, %edi
	call	init_node
	movq	%rax, -88(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	-88(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	add_node
	addl	$1, -96(%rbp)
.L3:
	movl	-96(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jl	.L4
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movl	$11, %esi
	movq	%rax, %rdi
	call	search_tree
	movq	%rax, -88(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free_tree
	addl	$1, -100(%rbp)
.L2:
	cmpl	$49999999, -100(%rbp)
	jle	.L5
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime@PLT
	movq	-48(%rbp), %rdx
	movq	-64(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	imulq	$1000000000, %rax, %rax
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rdx
	subq	%rdx, %rcx
	movq	%rcx, %rdx
	addq	%rdx, %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -80(%rbp)
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movq	-80(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC1(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.globl	init_node
	.type	init_node, @function
init_node:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	$24, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	-20(%rbp), %edx
	movl	%edx, (%rax)
	movq	-8(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 16(%rax)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	init_node, .-init_node
	.globl	init_tree
	.type	init_tree, @function
init_tree:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	$8, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, %edi
	call	init_node
	movq	-8(%rbp), %rdx
	movq	%rax, (%rdx)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	init_tree, .-init_tree
	.globl	add_node
	.type	add_node, @function
add_node:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	movl	(%rax), %edx
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	jge	.L13
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L14
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	add_node
	jmp	.L17
.L14:
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L17
.L13:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L16
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	add_node
	jmp	.L17
.L16:
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 16(%rax)
.L17:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	add_node, .-add_node
	.section	.rodata
.LC2:
	.string	"%d\n"
	.text
	.globl	print_tree
	.type	print_tree, @function
print_tree:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L19
	movl	-28(%rbp), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	print_tree
.L19:
	movl	$0, -4(%rbp)
	jmp	.L20
.L21:
	movl	$9, %edi
	call	putchar@PLT
	addl	$1, -4(%rbp)
.L20:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L21
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L23
	movl	-28(%rbp), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	print_tree
.L23:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	print_tree, .-print_tree
	.globl	search_tree
	.type	search_tree, @function
search_tree:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movq	$0, -8(%rbp)
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -28(%rbp)
	jne	.L25
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L26
.L25:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -28(%rbp)
	jge	.L27
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L26
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movl	-28(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	search_tree
	movq	%rax, -8(%rbp)
	jmp	.L26
.L27:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L26
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movl	-28(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	search_tree
	movq	%rax, -8(%rbp)
.L26:
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	search_tree, .-search_tree
	.globl	free_tree
	.type	free_tree, @function
free_tree:
.LFB12:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L30
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rdi
	call	free_tree
.L30:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L31
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, %rdi
	call	free_tree
.L31:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	free_tree, .-free_tree
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:

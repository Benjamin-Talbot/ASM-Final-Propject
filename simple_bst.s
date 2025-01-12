	.file	"simple_bst.c"
	.text
	.section	.rodata
.LC0:
	.string	"simple:"
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
.L6:
	movl	$10, %edi
	call	simple_init_tree
	movq	%rax, -72(%rbp)
	movl	$0, -96(%rbp)
.L3:
	movl	-96(%rbp), %eax
	cltq
	movl	-32(%rbp,%rax,4), %eax
	movl	%eax, %edi
	call	simple_init_node
	movq	%rax, -88(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	-88(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	simple_add_node
	addl	$1, -96(%rbp)
	movl	-96(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jge	.L4
	jmp	.L3
.L4:
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movl	$11, %esi
	movq	%rax, %rdi
	call	simple_search_tree
	movq	%rax, -88(%rbp)
.L5:
	endbr64
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	simple_free_tree
	addl	$1, -100(%rbp)
.L2:
	cmpl	$49999999, -100(%rbp)
	jle	.L6
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
	je	.L8
	call	__stack_chk_fail@PLT
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.globl	simple_init_node
	.type	simple_init_node, @function
simple_init_node:
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
	.size	simple_init_node, .-simple_init_node
	.globl	simple_init_tree
	.type	simple_init_tree, @function
simple_init_tree:
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
	call	simple_init_node
	movq	-8(%rbp), %rdx
	movq	%rax, (%rdx)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	simple_init_tree, .-simple_init_tree
	.globl	simple_add_node
	.type	simple_add_node, @function
simple_add_node:
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
	jge	.L25
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L26
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	simple_add_node
	jmp	.L18
.L26:
	nop
.L17:
	endbr64
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L18
.L25:
	nop
.L15:
	endbr64
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L27
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	simple_add_node
	jmp	.L18
.L27:
	nop
.L20:
	endbr64
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 16(%rax)
.L18:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	simple_add_node, .-simple_add_node
	.section	.rodata
.LC2:
	.string	"%d\n"
	.text
	.globl	simple_print_tree
	.type	simple_print_tree, @function
simple_print_tree:
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
	je	.L29
	movl	-28(%rbp), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	simple_print_tree
.L29:
	movl	$0, -4(%rbp)
	jmp	.L30
.L31:
	movl	$9, %edi
	call	putchar@PLT
	addl	$1, -4(%rbp)
.L30:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L31
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L33
	movl	-28(%rbp), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	simple_print_tree
.L33:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	simple_print_tree, .-simple_print_tree
	.globl	simple_search_tree
	.type	simple_search_tree, @function
simple_search_tree:
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
	jne	.L45
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L37
.L45:
	nop
.L36:
	endbr64
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -28(%rbp)
	jge	.L46
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L47
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movl	-28(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	simple_search_tree
	movq	%rax, -8(%rbp)
	jmp	.L37
.L46:
	nop
.L39:
	endbr64
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L48
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movl	-28(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	simple_search_tree
	movq	%rax, -8(%rbp)
	jmp	.L37
.L47:
	nop
	jmp	.L37
.L48:
	nop
.L37:
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	simple_search_tree, .-simple_search_tree
	.globl	simple_free_tree
	.type	simple_free_tree, @function
simple_free_tree:
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
	je	.L54
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rdi
	call	simple_free_tree
	jmp	.L51
.L54:
	nop
.L51:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L55
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, %rdi
	call	simple_free_tree
	jmp	.L53
.L55:
	nop
.L53:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	simple_free_tree, .-simple_free_tree
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

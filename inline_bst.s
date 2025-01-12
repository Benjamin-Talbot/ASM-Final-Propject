	.file	"inline_bst.c"
	.text
	.section	.rodata
.LC0:
	.string	"inline:"
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
	call	inline_init_tree
	movq	%rax, -72(%rbp)
	movl	$0, -96(%rbp)
.L3:
	movl	-96(%rbp), %eax
	cltq
	movl	-32(%rbp,%rax,4), %eax
	movl	%eax, %edi
	call	inline_init_node
	movq	%rax, -88(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	-88(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	inline_add_node
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
	call	inline_search_tree
	movq	%rax, -88(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	inline_free_tree
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
	.globl	inline_init_node
	.type	inline_init_node, @function
inline_init_node:
.LFB7:
	.cfi_startproc
	endbr64
#APP
# 73 "inline_bst.c" 1
	                               
         push    %rdi                    
         movl    $24, %edi               
         call    malloc                  
         pop     %rdi                    
         movl    %edi, (%rax)            
         movq    $0, 8(%rax)             
         movq    $0, 16(%rax)            
         ret                             
     
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE7:
	.size	inline_init_node, .-inline_init_node
	.globl	inline_init_tree
	.type	inline_init_tree, @function
inline_init_tree:
.LFB8:
	.cfi_startproc
	endbr64
#APP
# 86 "inline_bst.c" 1
	                               
         push    %rbx                    
         call    inline_init_node        
         movq    %rax, %rbx              
         movl    $8, %edi                
         call    malloc                  
         movq    %rbx, (%rax)            
         pop     %rbx                    
         ret                             
     
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE8:
	.size	inline_init_tree, .-inline_init_tree
	.globl	inline_add_node
	.type	inline_add_node, @function
inline_add_node:
.LFB9:
	.cfi_startproc
	endbr64
#APP
# 99 "inline_bst.c" 1
	                               
         movl    (%rsi), %eax            
         subl    (%rdi), %eax            
         jge     greatereq               
         movq    8(%rdi), %rax           
         cmpq    $0, %rax                
         je      addleft                 
         push    %rdi                    
         movq    %rax, %rdi              
         call    inline_add_node         
         pop     %rdi                    
         ret                             
     addleft:                            
         movq    %rsi, 8(%rdi)           
         ret                             
     greatereq:                          
         movq    16(%rdi), %rax          
         cmpq    $0, %rax                
         je      addright                
         push    %rdi                    
         movq    %rax, %rdi              
         call    inline_add_node         
         pop     %rdi                    
         ret                             
     addright:                           
         movq    %rsi, 16(%rdi)          
         ret                             
     
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE9:
	.size	inline_add_node, .-inline_add_node
	.section	.rodata
.LC2:
	.string	"%d\n"
	.text
	.globl	inline_print_tree
	.type	inline_print_tree, @function
inline_print_tree:
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
	je	.L12
	movl	-28(%rbp), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	inline_print_tree
.L12:
	movl	$0, -4(%rbp)
	jmp	.L13
.L14:
	movl	$9, %edi
	call	putchar@PLT
	addl	$1, -4(%rbp)
.L13:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L14
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L16
	movl	-28(%rbp), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	inline_print_tree
.L16:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	inline_print_tree, .-inline_print_tree
	.globl	inline_search_tree
	.type	inline_search_tree, @function
inline_search_tree:
.LFB11:
	.cfi_startproc
	endbr64
#APP
# 156 "inline_bst.c" 1
	                               
         movq    $0, %rax                
         cmpq    (%rdi), %rsi            
         jne     noteq                   
         movq    %rdi, %rax              
         ret                             
     noteq:                              
         push    %rbx                    
         cmpq    (%rdi), %rsi            
         jge     notgreater              
         movq    8(%rdi), %rbx           
         cmpq    $0, %rbx                
         # re (return if equal)          
         je      endsearch               
         push    %rdi                    
         movq    8(%rdi), %rdi           
         call    inline_search_tree      
         pop     %rdi                    
         # ret                           
         jmp     endsearch               
     notgreater:                         
         movq    16(%rdi), %rbx          
         cmpq    $0, %rbx                
         # re                            
         je      endsearch               
         movq    %rbx, %rdi              
         call    inline_search_tree      
     endsearch:                          
         pop     %rbx                    
         ret                             
     
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE11:
	.size	inline_search_tree, .-inline_search_tree
	.globl	inline_free_tree
	.type	inline_free_tree, @function
inline_free_tree:
.LFB12:
	.cfi_startproc
	endbr64
#APP
# 190 "inline_bst.c" 1
	                               
             cmpq    $0, 8(%rdi)         
             je      freeright           
             push    %rdi                
             movq    8(%rdi), %rdi       
             call    inline_free_tree    
             pop     %rdi                
         freeright:                      
             cmpq    $0, 16(%rdi)        
             je      freenode            
             push    %rdi                
             movq    16(%rdi), %rdi      
             call    inline_free_tree    
             pop     %rdi                
         freenode:                       
             call    free                
             ret                         
     
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE12:
	.size	inline_free_tree, .-inline_free_tree
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

	.text
	.globl	add_node

add_node:
    movl    (%rsi), %eax
    subl    (%rdi), %eax
    jge     greatereq
    movq    8(%rdi), %rax   # check if tree->left is NULL
    cmpq    $0, %rax
    je      addleft
    push    %rdi
    movq    %rax, %rdi      # rax has tree->left
    call    add_node
    pop     %rdi
    ret
addleft:
    movq    %rsi, 8(%rdi)
    ret
greatereq:
    movq    16(%rdi), %rax  # check if tree->right is NULL
    cmpq    $0, %rax
    je      addright
    push    %rdi
    movq    %rax, %rdi       # rax has tree->right
    call    add_node
    pop     %rdi
    ret
addright:
    movq    %rsi, 16(%rdi)
    ret

	.globl	free_tree

free_tree:
    cmpq    $0, 8(%rdi)
    je      freeright
    push    %rdi
    movq    8(%rdi), %rdi
    call    free_tree
    pop     %rdi
freeright:
    cmpq    $0, 16(%rdi)
    je      freenode
    push    %rdi
    movq    16(%rdi), %rdi
    call    free_tree
    pop     %rdi
freenode:
    call    free
    ret

	.globl	init_node

init_node:
    push    %rdi
    movl    $24, %edi
    call    malloc
    pop     %rdi
    movl    %edi, (%rax)
    movq    $0, 8(%rax)
    movq    $0, 16(%rax)
    ret
    
	.globl	init_tree
	
init_tree:
    push    %rbx
    call    init_node
    movq    %rax, %rbx
    movl    $8, %edi
    call    malloc
    movq    %rbx, (%rax)
    pop     %rbx
    ret
    
	.globl	search_tree

search_tree:
    movq    $0, %rax
    cmpl    (%edi), %esi
    jne     noteq
    movq    %rdi, %rax
    ret
noteq:
    push    %rbx
    cmpl    (%edi), %esi
    jge     notgreater
    movq    8(%rdi), %rbx
    cmpq    $0, %rbx
    je      endsearch
    push    %rdi
    movq    8(%rdi), %rdi
    call    search_tree
    pop     %rdi
    jmp     endsearch
notgreater:
    movq    16(%rdi), %rbx
    cmpq    $0, %rbx
    je      endsearch
    movq    %rbx, %rdi
    call    search_tree
endsearch:
    pop     %rbx
    ret

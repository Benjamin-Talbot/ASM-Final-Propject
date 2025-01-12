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

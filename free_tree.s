	.text
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

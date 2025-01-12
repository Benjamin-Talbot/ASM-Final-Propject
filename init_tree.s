	.text
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

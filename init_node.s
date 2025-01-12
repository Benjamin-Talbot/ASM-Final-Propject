	.text
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

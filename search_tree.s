	.text
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
    # ret
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

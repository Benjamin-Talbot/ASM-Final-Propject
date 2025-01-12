# data structure stuff

section .data
    msg db "Hello world!", 0ah

section .text
    global _start

# push and pop temp registers and parameters, if needed

_start:
    push    %rbp
    movq    %rsp, %rbp
    subq    $40, %rsp
    # stack setup:
    #   rbp     =   bst
    #   rbp-8   =   node
    #   rbp-16  =   values 0-4
    #   rbp-36  =   len

    movl    $10, %edi
    call    init_tree
    movq    %rax, (%rbp)    # bst = init_tree(10)
    movq    $0, -8(%rbp)    # node = NULL
    movl    $5, -16(%rbp)   # values array
    movl    $7, -20(%rbp)
    movl    $12, -24(%rbp)
    movl    $13, -28(%rbp)
    movl    $11, -32(%rbp)
    movl    $5, -36(%rbp)   # len = 5
    
    movl    $0, %ecx # i = 0
forloop:
    movl    -16(%rbp, %rcx), %rdi
    call    init_node
    movq    %rax, %rsi
    movq    (%rbp), %rdi
    call    add_node
    inc     %ecx
    cmpq    -36(%rbp), %ecx
    jl      forloop

    movq    (%rbp), %rdi
    movl    $0, %esi
    call    print_tree
    movq    (%rbp), %rdi    # can remove? i.e. does it get changed during subroutine call
    movl    $11, %esi
    call    search_tree
    cmpq    $0, %rax
    je      nullptr
    # printf "%d\n", node->value
    jmp     endprint
nullptr:
    # printf "NULL\n"
endprint:
    movq    (%rbp), %rdi
    call    free_tree

    addq    $40, %rsp
    movq    %rbp, %rsp
    pop     %rbp

    movq     $60, %rax
    movq     $0, %rdi
    syscall


init_node:
    push    %rdi
    movl    $24, %edi
    call    malloc
    pop     %rdi
    movl    %edi, (%rax)
    movq    $0, 8(%rax)
    movq    $0, 16(%rax)
    ret


init_tree:
    push    %rbx
    call    init_node
    movq    %rax, %rbx
    movl    $8, %edi
    call    malloc
    movq    %rbx, (%rax)
    pop     %rbx
    ret


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
end:
    ret


# not done yet, fix printf and 12(%rdi) -> 16(%rdi)
print_tree:
    movq    12(%rdi), %rax
    cmpq    $0, %rax
    je      loop
    push    %rdi
    push    %rsi
    movq    %rax, %rdi
    inc     %rsi
    call    print_tree      # print_tree(tree->right, layer+1)
    pop     %rsi
    pop     %rdi
loop:
    movl    %esi, %ecx
    cmpl    $0, %ecx
    je      endloop
loopbody:
    # printf "\t"
    loop    loopbody
endloop:
    # printf "%d\n", tree->value
    movq    4(%rdi), %rax
    cmpq    $0, %rax
    je      end
    movq    %rax, %rdi
    inc     %rsi
    call    print_tree      # print_tree(tree->left, layer+1)
end:
    ret


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
    # re (return if equal)
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
    # re
    je      endsearch
    movq    %rbx, %rdi
    call    search_tree
endsearch:
    pop     %rbx
    ret


free_tree:
    cmpq    $0, 8(%rdi)
    je      freeright
    push    %rdi
    movq    8(%rdi), %rdi
    call inline_init_node
    pop     %rdi
freeright:
    cmpq    $0, 16(%rdi)
    je      freenode
    push    %rdi
    movq    16(%rdi), %rdi
    call inline_init_node
    pop     %rdi
freenode:
    call    free
    ret
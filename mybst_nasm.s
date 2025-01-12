; data structure stuff

section .data
    msg db "Hello world!", 0ah

section .text
    global _start

; push and pop temp registers and parameters, if needed

_start:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 40
    ; stack setup:
    ;   rbp     =   bst
    ;   rbp-8   =   node
    ;   rbp-16  =   values 0-4
    ;   rbp-36  =   len

    mov     edi, 10
    call    init_tree
    mov     [rbp], rax    ; bst = init_tree(10)
    mov qword    [rbp-8], 0    ; node = NULL
    mov dword    [rbp-16], 5   ; values array
    mov dword    [rbp-20], 7
    mov dword    [rbp-24], 12
    mov dword    [rbp-28], 13
    mov dword    [rbp-32], 11
    mov dword    [rbp-36], 5   ; len = 5
    
    mov     ecx, 0 ; i = 0
forloop:
    mov     rdi, [rbp+rcx-16]
    call    init_node
    mov     rsi, rax
    mov     rdi, [rbp]
    call    add_node
    inc     ecx
    cmp     ecx, [rbp-36]
    jl      forloop

    mov     rdi, [rbp]
    mov     esi, 0
    call    print_tree
    mov     rdi, [rbp]    ; can remove? i.e. does it get changed during subroutine call
    mov     esi, 11
    call    search_tree
    cmp     rax, 0
    je      nullptr
    ; printf "%d\n", node->value
    jmp     endprint
nullptr:
    ; printf "NULL\n"
endprint:
    mov     rdi, [rbp]
    call    free_tree

    add     rsp, 40
    mov     rsp, rbp
    pop     rbp

    mov     rax, 60
    mov     rdi, 0
    syscall


init_node:
    push    rdi
    mov     edi, 24
    extern malloc
    call    malloc
    pop     rdi
    mov     [rax], edi
    mov qword    [rax+8], 0
    mov qword    [rax+16], 0
    ret


init_tree:
    push    rbx
    call    init_node
    mov     rbx, rax
    mov     edi, 8
    extern malloc
    call    malloc
    mov     [rax], rbx
    pop     rbx
    ret


add_node:
    mov     eax, [rsi]
    sub     eax, [rdi]
    jge     greatereq
    mov     rax, [rdi+8]   ; check if tree->left is NULL
    cmp     rax, 0
    je      addleft
    push    rdi
    mov     rdi, rax      ; rax has tree->left
    call    add_node
    pop     rdi
    ret
addleft:
    mov     [rdi+8], rsi
    ret
greatereq:
    mov     rax, [rdi+16]  ; check if tree->right is NULL
    cmp     rax, 0
    je      addright
    push    rdi
    mov     rdi, rax       ; rax has tree->right
    call    add_node
    pop     rdi
    ret
addright:
    mov     [rdi+16], rsi
    ret


; not done yet, fix printf and 12(rdi) -> 16(rdi)
print_tree:
    mov     rax, [rdi+12]
    cmp     rax, 0
    je      loop
    push    rdi
    push    rsi
    mov     rdi, rax
    inc     rsi
    call    print_tree      ; print_tree(tree->right, layer+1)
    pop     rsi
    pop     rdi
loop:
    mov     ecx, esi
    cmp     ecx, 0
    je      endloop
loopbody:
    ; printf "\t"
    loop    loopbody
endloop:
    ; printf "%d\n", tree->value
    mov     rax, [rdi+4]
    cmp     rax, 0
    je      endprintnode
    mov     rdi, rax
    inc     rsi
    call    print_tree      ; print_tree(tree->left, layer+1)
endprintnode:
    ret


search_tree:
    mov     rax, 0
    cmp     esi, [edi]
    jne     noteq
    mov     rax, rdi
    ret
noteq:
    push    rbx
    cmp     esi, [edi]
    jge     notgreater
    mov     rbx, [rdi+8]
    cmp     rbx, 0
    ; re (return if equal)
    je      endsearch
    push    rdi
    mov     rdi, [rdi+8]
    call    search_tree
    pop     rdi
    ; ret
    jmp     endsearch
notgreater:
    mov     rbx, [rdi+16]
    cmp     rbx, 0
    ; re
    je      endsearch
    mov     rdi, rbx
    call    search_tree
endsearch:
    pop     rbx
    ret


free_tree:
    cmp qword     [rdi+8], 0
    je      freeright
    push    rdi
    mov     rdi, [rdi+8]
    call init_node
    pop     rdi
freeright:
    cmp qword     [rdi+16], 0
    je      freenode
    push    rdi
    mov     rdi, [rdi+16]
    call init_node
    pop     rdi
freenode:
    extern free
    call    free
    ret
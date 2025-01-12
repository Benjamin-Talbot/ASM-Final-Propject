#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Data structures

typedef struct Node {
    int value;
    struct Node* left;
    struct Node* right;
} Node;
typedef Node* NODE;

typedef struct Tree {
    NODE head;
} Tree;
typedef Tree* TREE;


// Functions

__attribute__((naked)) NODE inline_init_node(int value);
__attribute__((naked)) TREE inline_init_tree(int value);
__attribute__((naked)) void inline_add_node(NODE tree, NODE node);
void inline_print_tree(NODE tree, int layer);
__attribute__((naked)) NODE inline_search_tree(NODE tree, int value);
__attribute__((naked)) void inline_free_tree(NODE tree);

int main() {
    TREE bst;
    NODE node = NULL;
    int values[] = {5, 7, 12, 13, 11};
    int len = 5;

    struct timespec start, stop;
    double time;
    clock_gettime(CLOCK_REALTIME, &start);
    
    for(int t = 0; t < 50000000; t++) {

        bst = inline_init_tree(10);
	    int i = 0;
	forloop:
	    node = inline_init_node(values[i]);
	    inline_add_node(bst->head, node);
	    i++;
	    if(i < len) goto forloop;

	    // inline_print_tree(bst->head, 0);
	    node = inline_search_tree(bst->head, 11);
	    // if(!node) goto nullptr;
	    // printf("%d\n", node->value);
	    // goto endprint;
	// nullptr:
	    // printf("NULL\n");
	// endprint:
	    inline_free_tree(bst->head);
    
    }

    clock_gettime(CLOCK_REALTIME, &stop);
    time = (stop.tv_sec - start.tv_sec) * 1000000000L + (stop.tv_nsec - start.tv_nsec);

    printf("inline:\n");
    printf("Time: %lf\n", time);
    
    return 0;
}

__attribute__((naked)) NODE inline_init_node(int value) {
    asm("                               \n \
        push    %rdi                    \n \
        movl    $24, %edi               \n \
        call    malloc                  \n \
        pop     %rdi                    \n \
        movl    %edi, (%rax)            \n \
        movq    $0, 8(%rax)             \n \
        movq    $0, 16(%rax)            \n \
        ret                             \n \
    ");
}

__attribute__((naked)) TREE inline_init_tree(int value) {
    asm("                               \n \
        push    %rbx                    \n \
        call    inline_init_node        \n \
        movq    %rax, %rbx              \n \
        movl    $8, %edi                \n \
        call    malloc                  \n \
        movq    %rbx, (%rax)            \n \
        pop     %rbx                    \n \
        ret                             \n \
    ");
}

__attribute__((naked)) void inline_add_node(NODE tree, NODE node) {
    asm("                               \n \
        movl    (%rsi), %eax            \n \
        subl    (%rdi), %eax            \n \
        jge     greatereq               \n \
        movq    8(%rdi), %rax           \n \
        cmpq    $0, %rax                \n \
        je      addleft                 \n \
        push    %rdi                    \n \
        movq    %rax, %rdi              \n \
        call    inline_add_node         \n \
        pop     %rdi                    \n \
        ret                             \n \
    addleft:                            \n \
        movq    %rsi, 8(%rdi)           \n \
        ret                             \n \
    greatereq:                          \n \
        movq    16(%rdi), %rax          \n \
        cmpq    $0, %rax                \n \
        je      addright                \n \
        push    %rdi                    \n \
        movq    %rax, %rdi              \n \
        call    inline_add_node         \n \
        pop     %rdi                    \n \
        ret                             \n \
    addright:                           \n \
        movq    %rsi, 16(%rdi)          \n \
        ret                             \n \
    ");
}

// __attribute__((naked))
void inline_print_tree(NODE tree, int layer) {
    if(tree->right)
        inline_print_tree(tree->right, layer+1);
    for(int i = 0; i < layer; i++)
        printf("\t");
    printf("%d\n", tree->value);
    if(tree->left)
        inline_print_tree(tree->left, layer+1);
//     if(!tree->right) goto loop;
//     inline_print_tree(tree->right, layer+1);
// loop: ;
//     int i = 0;
//     if(!(i < layer)) goto endloop;
// loopbody:
//     printf("\t");
//     i++;
//     if(i < layer) goto loopbody;
// endloop:
//     printf("%d\n", tree->value);
//     if(!tree->left) goto end;
//     inline_print_tree(tree->left, layer+1);
// end:
//     return;
}

__attribute__((naked)) NODE inline_search_tree(NODE tree, int value) {
    asm("                               \n \
        movq    $0, %rax                \n \
        cmpl    (%edi), %esi            \n \
        jne     noteq                   \n \
        movq    %rdi, %rax              \n \
        ret                             \n \
    noteq:                              \n \
        push    %rbx                    \n \
        cmpl    (%edi), %esi            \n \
        jge     notgreater              \n \
        movq    8(%rdi), %rbx           \n \
        cmpq    $0, %rbx                \n \
        je      endsearch               \n \
        push    %rdi                    \n \
        movq    8(%rdi), %rdi           \n \
        call    inline_search_tree      \n \
        pop     %rdi                    \n \
        jmp     endsearch               \n \
    notgreater:                         \n \
        movq    16(%rdi), %rbx          \n \
        cmpq    $0, %rbx                \n \
        je      endsearch               \n \
        movq    %rbx, %rdi              \n \
        call    inline_search_tree      \n \
    endsearch:                          \n \
        pop     %rbx                    \n \
        ret                             \n \
    ");
}

__attribute__((naked)) void inline_free_tree(NODE tree) {
    asm("                               \n \
            cmpq    $0, 8(%rdi)         \n \
            je      freeright           \n \
            push    %rdi                \n \
            movq    8(%rdi), %rdi       \n \
            call    inline_free_tree    \n \
            pop     %rdi                \n \
        freeright:                      \n \
            cmpq    $0, 16(%rdi)        \n \
            je      freenode            \n \
            push    %rdi                \n \
            movq    16(%rdi), %rdi      \n \
            call    inline_free_tree    \n \
            pop     %rdi                \n \
        freenode:                       \n \
            call    free                \n \
            ret                         \n \
    ");
}

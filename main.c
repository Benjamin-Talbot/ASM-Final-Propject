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

__attribute__((naked)) extern NODE init_node(int value);
__attribute__((naked)) extern TREE init_tree(int value);
__attribute__((naked)) extern void add_node(NODE tree, NODE node);
void print_tree(NODE tree, int layer);
__attribute__((naked)) extern NODE search_tree(NODE tree, int value);
__attribute__((naked)) extern void free_tree(NODE tree);


int main() {
    TREE bst;
    NODE node = NULL;
    int values[] = {5, 7, 12, 13, 11};
    int len = 5;

    struct timespec start, stop;
    double time;
    clock_gettime(CLOCK_REALTIME, &start);

    for(int t = 0; t < 50000000; t++) {

        bst = init_tree(10);
        for(int i = 0; i < len; i++) {
            node = init_node(values[i]);
            add_node(bst->head, node);
        }

        // print_tree(bst->head, 0);
        node = search_tree(bst->head, 11);
        // if(node)
        //     printf("%d\n", node->value);
        // else
        //     printf("NULL\n");

        free_tree(bst->head);
    
    }

    clock_gettime(CLOCK_REALTIME, &stop);
    time = (stop.tv_sec - start.tv_sec) * 1000000000L + (stop.tv_nsec - start.tv_nsec);

    printf("main:\n");
    printf("Time: %lf\n", time);
    
    return 0;
}

void print_tree(NODE tree, int layer) {
    if(tree->right)
        print_tree(tree->right, layer+1);
    for(int i = 0; i < layer; i++)
        printf("\t");
    printf("%d\n", tree->value);
    if(tree->left)
        print_tree(tree->left, layer+1);
}

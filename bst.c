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

NODE init_node(int value);
TREE init_tree(int value);
void add_node(NODE tree, NODE node);
void print_tree(NODE tree, int layer);
NODE search_tree(NODE tree, int value);
void free_tree(NODE tree);


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

    printf("bst:\n");
    printf("Time: %lf\n", time);
    // free(bst); // forgot to add this in the code, but not too bad since exiting the program probably does the job
    
    return 0;
}

NODE init_node(int value) {
    NODE node = (NODE) malloc(sizeof(Node));
    node->value = value;
    node->left = NULL;
    node->right = NULL;

    return node;
}

TREE init_tree(int value) {
    TREE tree = (TREE) malloc(sizeof(Tree));
    tree->head = init_node(value);

    return tree;
}

void add_node(NODE tree, NODE node) {
    if(node->value < tree->value) {
        if(tree->left)
            add_node(tree->left, node);
        else
            tree->left = node;
    }
    else {
        if(tree->right)
            add_node(tree->right, node);
        else
            tree->right = node;
    }
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

NODE search_tree(NODE tree, int value) {
    NODE node = NULL;
    if(value == tree->value)
        node = tree;
    else if(value < tree->value) {
        if(tree->left)
            node = search_tree(tree->left, value);
    }
    else {
        if(tree->right)
            node = search_tree(tree->right, value);
    }
    
    return node;
}

void free_tree(NODE tree) {
    if(tree->left)
        free_tree(tree->left);
    if(tree->right)
        free_tree(tree->right);
    free(tree);
}

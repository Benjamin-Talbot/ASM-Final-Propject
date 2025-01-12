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

NODE simple_init_node(int value);
TREE simple_init_tree(int value);
void simple_add_node(NODE tree, NODE node);
void simple_print_tree(NODE tree, int layer);
NODE simple_search_tree(NODE tree, int value);
void simple_free_tree(NODE tree);

int main() {
    TREE bst;
    NODE node = NULL;
    int values[] = {5, 7, 12, 13, 11};
    int len = 5;
    
    struct timespec start, stop;
    double time;
    clock_gettime(CLOCK_REALTIME, &start);
    
    for(int t = 0; t < 50000000; t++) {

	    bst = simple_init_tree(10);
	    int i = 0;
	forloop:
	    node = simple_init_node(values[i]);
	    simple_add_node(bst->head, node);
	    i++;
	    if(i < len) goto forloop;

//	    simple_print_tree(bst->head, 0);
	    node = simple_search_tree(bst->head, 11);
//	    if(!node) goto nullptr;
//	    printf("%d\n", node->value);
//	    goto endprint;
//	nullptr:
//	    printf("NULL\n");
	// endprint:
	    simple_free_tree(bst->head);
    
    }

    clock_gettime(CLOCK_REALTIME, &stop);
    time = (stop.tv_sec - start.tv_sec) * 1000000000L + (stop.tv_nsec - start.tv_nsec);

    printf("simple:\n");
    printf("Time: %lf\n", time);
    
    return 0;
}


NODE simple_init_node(int value) {
    NODE node = (NODE) malloc(sizeof(Node));
    node->value = value;
    node->left = NULL;
    node->right = NULL;

    return node;
}

TREE simple_init_tree(int value) {
    TREE tree = (TREE) malloc(sizeof(Tree));
    tree->head = simple_init_node(value);

    return tree;
}

void simple_add_node(NODE tree, NODE node) {
    if(!(node->value < tree->value)) goto greatereq;
    if(!tree->left) goto addleft;
    simple_add_node(tree->left, node);
    goto endadd;
addleft:
    tree->left = node;
    goto endadd;
greatereq:
    if(!tree->right) goto addright;
    simple_add_node(tree->right, node);
    goto endadd;
addright:
    tree->right = node;
endadd:
    return;
}

void simple_print_tree(NODE tree, int layer) {
    if(tree->right)
        simple_print_tree(tree->right, layer+1);
    for(int i = 0; i < layer; i++)
        printf("\t");
    printf("%d\n", tree->value);
    if(tree->left)
        simple_print_tree(tree->left, layer+1);
//     if(!tree->right) goto loop;
//     simple_print_tree(tree->right, layer+1);
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
//     simple_print_tree(tree->left, layer+1);
// end:
//     return;
}

NODE simple_search_tree(NODE tree, int value) {
    NODE node = NULL;
    if(!(value == tree->value)) goto noteq;
    node = tree;
    goto end;
noteq:
    if(!(value < tree->value)) goto notgreater;
    if(!(tree->left)) goto end;
    node = simple_search_tree(tree->left, value);
    goto end;
notgreater:
    if(!(tree->right)) goto end;
    node = simple_search_tree(tree->right, value);
end:
    return node;
}

void simple_free_tree(NODE tree) {
    if(!tree->left) goto freeright;
        simple_free_tree(tree->left);
freeright:
    if(!tree->right) goto freenode;
        simple_free_tree(tree->right);
freenode:
    free(tree);
}

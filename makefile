all: main
simple: simple_bst
inline: inline_bst

asm: main.c inline_bst.c simple_bst.c bst.c
	gcc -S main.c inline_bst.c simple_bst.c bst.c 

bst: bst.o
	gcc -o bst bst.o

bst.o: bst.c
	gcc -c bst.c

simple_bst: simple_bst.o
	gcc -o simple_bst simple_bst.o

simple_bst.o: simple_bst.c
	gcc -c simple_bst.c

inline_bst: inline_bst.o
	gcc -o inline_bst inline_bst.o

inline_bst.o: inline_bst.c
	gcc -c inline_bst.c

main: main.o assembly.s
	gcc -o main main.o assembly.s

#main: main.o init_node.s init_tree.s add_node.s search_tree.s free_tree.s
#	gcc -o main main.o init_node.s init_tree.s add_node.s search_tree.s free_tree.s

main.o: main.c
	gcc -c main.c

test.s:

test: test.c
	gcc -o test test.c

clean:
	rm -f *.o bst simple_bst inline_bst test main

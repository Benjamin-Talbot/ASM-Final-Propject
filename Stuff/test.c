#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

extern __attribute__((naked)) int func();

int main() {
    struct timespec start, stop;
    double time;
    clock_gettime(CLOCK_REALTIME, &start);

    for(unsigned int i = 0; i < 100000000; i++)
    	func();

    clock_gettime(CLOCK_REALTIME, &stop);
    time = (stop.tv_sec - start.tv_sec) * 1000000000L + (stop.tv_nsec - start.tv_nsec);

    printf("Time: %lf\n", time);
    return 0;
}

__attribute__((naked)) int func() {
    asm("           \n \
    movl $10, %eax  \n \
    ret             \n \
    ");
    // return 10;
}

// gcc -o test test.c

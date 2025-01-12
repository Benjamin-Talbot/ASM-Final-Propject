#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/**
int main() {
    struct timespec start, stop;
    double time;
    clock_gettime(CLOCK_REALTIME, &start);

    for(unsigned int i = 0; i < 4294967295; i++);

    clock_gettime(CLOCK_REALTIME, &stop);
    time = (stop.tv_sec - start.tv_sec) * 1000000000L + (stop.tv_nsec - start.tv_nsec);

    printf("Time: %lf\n", time);
    return 0;
}
//*/

/**/
int main() {
    clock_t start, end;
    double execution_time;
    start= clock();

    for(unsigned int i = 0; i < 4294967295; i++);

    end = clock();
    execution_time = ((double) (end - start)) / CLOCKS_PER_SEC;
    
    printf("Time: %lf\n", execution_time);
    printf("Cycles: %lu\n", (end - start));
    return 0;
}
//*/

/**
__attribute__((naked)) int somefunc(int value) {
    asm(".intel_syntax noprefix \n \
    mov rax, rdi \n \
    ret \n \
    .att_syntax \n \
    ");
}

int main() {
    int x = somefunc(5);
    printf("%d\n", x);

    return 0;
}

//*/
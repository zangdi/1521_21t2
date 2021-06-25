// print a triangle
#include <stdio.h>

int main (void) {
    int i = 1;
    loop0:
    if (i > 10) goto end0;
    int j = 0;

    loop1:
    if (j >= i) goto end1;
    printf("*");
    j = j + 1;
    goto loop1;

    end1:
    printf("\n");
    i = i + 1;
    goto loop0;

    end0:
    return 0;
}

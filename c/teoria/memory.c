#include <stdio.h>
#include <stdlib.h>

int main() {

        int *p;
        p = malloc(30 * sizeof(int));        
        *(p + 0) = 8;
        *(p + 2) = 100;
        *(p + 5) = 90;

        printf("%i, %i, %i", p[0], *(p + 2), *(p + 5));

        return 0;
};
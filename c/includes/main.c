#include <stdio.h>
#include <stdlib.h>
#include "another.c"

// Lanciare 'gcc *.c' genera errore (another.c incluso due volte perchè una viene compilato)
// Lanciare 'gcc main.c' NON genera quindi errore

int main() {

        printf("Main: %i, %i", ONE_H, TWO_H);
        
        return 0;
};
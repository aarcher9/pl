// Solo i file headers devono essere importati per fare in modo che il file .c che li implementa rispetti l'interfaccia
#include <stdio.h>
#include <stdlib.h>
#include "names.h"
#include "things.h"

// Indica al compilatore che la variabile 'a' di seguito usata è istanziata, solo che non lo è qui, si trova in names.c; non deve trovarsi in un file header poichè si tratta di una dichiarazione + definizione
// Incompatibile con "static".
extern char* a;
extern char* b;

int main() {
    
    printf("names(): ");
    names();
    printf("\n");
    printf("things(): ");
    things();
    printf("\n");

    printf("PI: %f\n", PI);
    printf("M: %d\n", M);

    printf("a: %s\n", a);
    printf("b: %s\n", b);
    b = "new b";
    printf("names() now: ");
    names();
    printf("\n");

    return 0;
}
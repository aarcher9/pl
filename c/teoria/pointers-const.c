#include <stdio.h>
#include <stdlib.h>

int main() {

        int a = 19;
        int b = 20;
        const int c = 20;
        const int d = 21;


        // puntatore classico
        int *p = &a;
        // No:
        // p = &c;


        // il valore puntato è costante
        const int *p1 = &c;
        p1 = &d;
        // No:
        // *p1 = 0;

        int const *p2 = &c;
        p1 = &d;
        // No:
        // *p2 = 0;


        // il puntatore è costante
        int *const p3 = &a;
        *p3 = 7;
        // No:
        // p3 = &c;


        // tutto costante, sia puntato che puntatore
        const int *const p4 = &a;
        // No:
        // p4 = &c;
        // *p4 = 8;


        // Altri esempi...

        // p5 punta ad un valore costante, questo valore costante è un puntatore a carattere.
        char char0 = 'c';
        char *c0 = &char0;
        char *const *p5 = &c0;

        // p6 punta ad un valore costante, questo valore costante è un puntatore a carattere costante.
        char const char1 = 'c';
        char const *c1 = &char1;
        char const *const *p6 = &c1;
        // notare che la dichiarazione "va" da dentro a fuori; *p6 indica c1, quindi **p6 indica c.

        printf("%p", *p6);

        // int 


        return 0;
};
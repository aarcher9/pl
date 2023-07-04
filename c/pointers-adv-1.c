#include <stdio.h>
#include <stdlib.h>

int test (int a) {
        return a * 2;
};

int test_2(int (*funzione)(int)) {
    return funzione(60);
}

int main() {

        // Non uso int* d(int); altrimenti dichiaro una funzione che ritorna un puntatore a intero
        int (*d)(int);

        // Non uso & perchè i nomi delle funzioni rappresentano già dei puntatori per il programma.
        d = test; 

        printf("%i\n", d(5));


        // Invece se voglio passare come argomento 
        printf("%i", test_2(&test));

        return 0;
};
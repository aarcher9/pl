#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define RIGHE 4
#define COLONNE 5

typedef int** Matrice;

Matrice* creaMatrice() {
    Matrice* m = malloc(sizeof(Matrice));
    (*m) = malloc(sizeof(int*) * RIGHE);

    (*m)[0] = malloc(sizeof(int) * COLONNE);
    (*m)[0][0] = 1;
    (*m)[0][1] = 5;
    (*m)[0][2] = 3;
    (*m)[0][3] = 6;
    (*m)[0][4] = 10;

    (*m)[1] = malloc(sizeof(int) * COLONNE);
    (*m)[1][0] = 2;
    (*m)[1][1] = 3;
    (*m)[1][2] = 1;
    (*m)[1][3] = 10;
    (*m)[1][4] = 8;

    (*m)[2] = malloc(sizeof(int) * COLONNE);
    (*m)[2][0] = 4;
    (*m)[2][1] = 11;
    (*m)[2][2] = 8;
    (*m)[2][3] = 5;
    (*m)[2][4] = 10;

    (*m)[3] = malloc(sizeof(int) * COLONNE);
    (*m)[3][0] = 8;
    (*m)[3][1] = 3;
    (*m)[3][2] = 2;
    (*m)[3][3] = 0;
    (*m)[3][4] = 6;

    return m;
}

void stampaMatrice(Matrice* m) {

    for (int k = 0; k < RIGHE; k++) {

        for (int i = 0; i < COLONNE; i++) {

            if (i == COLONNE - 1) {
                printf("%i\n", (*m)[k][i]);
            } else {
                printf("%i, ", (*m)[k][i]);
            }
        }
    }
}

int main() {
    Matrice* m = creaMatrice();
    stampaMatrice(m);

    return 0;
}
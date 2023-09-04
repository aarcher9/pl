#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define RIGHE 4
#define COLONNE 5

typedef int** Matrice;

Matrice* nuovaMatrice() {
    Matrice* m = malloc(sizeof(Matrice));
    (*m) = malloc(sizeof(int) * RIGHE);

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
    (*m)[1][3] = 7;
    (*m)[1][4] = 8;

    (*m)[2] = malloc(sizeof(int) * COLONNE);
    (*m)[2][0] = 4;
    (*m)[2][1] = 11;
    (*m)[2][2] = 1;
    (*m)[2][3] = 5;
    (*m)[2][4] = 10;

    (*m)[3] = malloc(sizeof(int) * COLONNE);
    (*m)[3][0] = 8;
    (*m)[3][1] = 2;
    (*m)[3][2] = 3;
    (*m)[3][3] = 1;
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

int tuttiDistinti(Matrice* m, int riga) {

    for (int k = 0; k < COLONNE; k++) {

        for (int i = 0; i < COLONNE; i++) {

            if ((*m)[riga][k] == (*m)[riga][i] && k != 1) {

                return 0;
            }
        }
    }

    return 1;
}

int elementiInComune(Matrice* m, int r, int s) {
    int inComune = 0;

    for (int k = 0; k < COLONNE; k++) {

        for (int i = 0; i < COLONNE; i++) {

            if ((*m)[r][k] == (*m)[s][i]) {

                ++inComune;
            }
        }
    }

    return inComune;
}

int verificaProprieta(Matrice* m) {
    int max = 0;
    int curr = 0;

    for (int k = 0; k < RIGHE; k++) {

        for (int i = 0; i < RIGHE; i++) {

            if (k != i) {
                curr = elementiInComune(m, k, i);

                if (curr > max) {
                    max = curr;
                }
            }
        }
    }

    return max;
}

int main() {
    Matrice* m = nuovaMatrice();
    int res = verificaProprieta(m);

    printf("Ecco la matrice:\n");
    stampaMatrice(m);
    printf("Elementi in comune max: %i\n", res);

    return 0;
}
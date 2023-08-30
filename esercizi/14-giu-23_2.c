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
    int r1[COLONNE] = { 1, 5, 3, 6, 10 };
    int r2[COLONNE] = { 2, 3, 1, 7, 8 };
    int r3[COLONNE] = { 4, 11, 1, 5, 10 };
    int r4[COLONNE] = { 8, 2, 3, 1, 6 };

    (*m)[0] = r1;
    (*m)[1] = r2;
    (*m)[2] = r3;
    (*m)[3] = r4;

    return m;
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
    int curr;

    for (int k = 0; k < RIGHE; k++) {

        for (int i = 0; i < RIGHE; i++) {

            // printf("%i", k);

            if (k != i) {
                curr = elementiInComune(m, k, i);
                max = curr;
                printf("ciao");
            }
        }
        // printf("\n");
    }

    return max;
}

int main() {
    Matrice* m = nuovaMatrice();

    int res = verificaProprieta(m);

    // int res = elementiInComune(m, 1, 3);
    // printf("%i\n", res);

    return 0;
}
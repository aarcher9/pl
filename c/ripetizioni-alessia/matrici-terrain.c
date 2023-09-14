#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

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
    (*m)[3][1] = 1;
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

void trovaPunti(Matrice* m) {
    printf("\nPunti trovati:\n");

    for (int k = 0; k < RIGHE; k++) {

        // La matrice contiene solo positivi, quindi sono sicuro che qualsiasi elemento sia maggiore di -1
        int maxRiga = -1;
        int rigaMaxCorrente = -1;
        int colonnaMaxCorrente = -1;

        for (int i = 0; i < COLONNE; i++) {

            if ((*m)[k][i] > maxRiga) {

                maxRiga = (*m)[k][i];
                rigaMaxCorrente = k;
                colonnaMaxCorrente = i;

            } else if ((*m)[k][i] == maxRiga) {

                // Mi segnalo che questa riga ha un massimo ripetuto almeno una volta quindi non va bene
                maxRiga = -1;
                rigaMaxCorrente = -1;
                colonnaMaxCorrente = -1;

            }
        }

        if (maxRiga != -1) {

            bool eValido = true;

            for (int r = 0; r < RIGHE; r++) {

                // Esploro la colonna relativa al massimo trovato, se trovo un numero almeno uguale o maggiore del corrente significa che non va bene e me lo segno
                bool maggioreUguale = (*m)[r][colonnaMaxCorrente] >= maxRiga;

                // Chiaramente devo skippare se stesso
                bool eSeStesso = r == rigaMaxCorrente;

                if (maggioreUguale && !eSeStesso) {
                    eValido = false;
                }
            }
            if (eValido) {
                printf("\t(%d, %d) = %d\n", rigaMaxCorrente, colonnaMaxCorrente, maxRiga);
            }
        }
    }
}

int main() {
    Matrice* m = creaMatrice();
    stampaMatrice(m);
    trovaPunti(m);

    return 0;
};

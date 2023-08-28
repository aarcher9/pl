#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

// Si presume sempre che il numero di colonne sia almeno pari ad 1.
#define RIGHE 10
#define COLONNE 10


// Supporto
int** nuovaMatrice() {
    int riga;
    int colonna;

    // Uso la malloc per allocare l'oggetto nell'heap
    int** matrice;
    matrice = malloc(RIGHE * sizeof(int*));

    for (riga = 0; riga < RIGHE; riga++) {
        matrice[riga] = malloc(COLONNE * sizeof(int));

        for (colonna = 0; colonna < COLONNE; colonna++) {
            matrice[riga][colonna] = 0;
        }
    }

    return matrice;
}

// Funzione 1
bool haUnElementoDiverso(int** matrice, int riga, int colonna) {
    return (matrice[riga][colonna] != matrice[0][0]);
}

bool verificaUguaglianzaDiOgniElemento(int** matrice) {
    int riga;
    int colonna;

    for (riga = 0; riga < RIGHE; riga++) {
        for (colonna = 0; colonna < COLONNE; colonna++) {
            if (haUnElementoDiverso(matrice, riga, colonna)) {
                return false;
            }
        }
    }

    return true;
}


// Funzione 2
int sommaColonna(int** matrice, int colonna) {
    int riga;
    int somma = 0;

    for (riga = 0; riga < RIGHE; riga++) {
        somma += matrice[riga][colonna];
    }

    return somma;
}

int* elencaSomme(int** matrice) {
    int riga;
    int colonna;
    int* elenco = malloc(sizeof(int) * COLONNE);

    for (colonna = 0; colonna < COLONNE; colonna++) {
        elenco[colonna] = sommaColonna(matrice, colonna);
    }

    return elenco;
}

bool controllaProprieta(int** matrice) {
    int start;
    int end = COLONNE - 1;
    int* elenco = elencaSomme(matrice);
    bool risultato = false;

    for (start = 0; start < end; start++, end--) {
        if (elenco[start] != elenco[end]) {
            return false;
        }
    }

    // La proprietà vale anche e a maggior ragione se la matrice ha una sola colonna
    return true;
}

int main() {

    int** a = nuovaMatrice();
    printf("Tutti gli elementi sono uguali? : %i\n", verificaUguaglianzaDiOgniElemento(a));

    int** b = nuovaMatrice();
    b[0][0] = -1;
    printf("Tutti gli elementi sono uguali? : %i\n", verificaUguaglianzaDiOgniElemento(b));

    int** c = nuovaMatrice();
    printf("Proprietà valida? : %i\n", controllaProprieta(c));

    int** d = nuovaMatrice();
    d[0][0] = -1;
    printf("Proprietà valida? : %i\n", controllaProprieta(d));

    // int** matrice;
    // *matrice = malloc(RIGHE * sizeof(int));
    // **matrice = malloc(COLONNE * sizeof(int));

    // int* c = matrice[0];

    return 0;
};

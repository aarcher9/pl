#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_NUMERI_MEMORIZZABILI 10
#define MAX_CONTATTI 10

// Gli enum vengono tradotti dal compilatore in interi corrispondenti alla loro posizione nell'enum.
enum TipoNumeroDiTelefono { UFFICIO, CASA, CELLULARE, ALTRO };

struct NumeroDiTelefono {
    enum TipoNumeroDiTelefono tipo;
    int numero;
};

struct Persona {
    char nome[30];
    char cognome[20];
    int numeriMemorizzati;
    struct NumeroDiTelefono numeri[];
};

struct Rubrica {
    char titolo[40];
    struct Persona contatti[MAX_CONTATTI];
};

void acquisisciNumeroDiTelefono(struct NumeroDiTelefono* numero) {
    printf("Inserisci numero: ");
    scanf("%i", &(numero->numero));
    printf("Inserisci tipo: ");
    printf("\n\t0: UFFICIO\n\t1: CASA\n\t2: CELLULARE\n\t3: ALTRO\n\t: ");
    int input;

    while (true) {
        scanf("%i", &input);

        if (0 <= input && input <= 3) {
            if (input == 0) {
                numero->tipo = UFFICIO;
            } if (input == 1) {
                numero->tipo = CASA;
            } if (input == 2) {
                numero->tipo = CELLULARE;
            }if (input == 3) {
                numero->tipo = ALTRO;
            }
            break;
        } else {
            printf("Numero non valido, riprova... : ");
        }
    }

}

int main() {
    struct NumeroDiTelefono* numero = malloc(sizeof(struct NumeroDiTelefono));
    acquisisciNumeroDiTelefono(numero);

    printf("Il tipo inserito è: %u\n", numero->tipo);

    return 0;
};

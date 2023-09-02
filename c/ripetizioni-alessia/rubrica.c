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

void mostraNumero(struct NumeroDiTelefono n) {
    char* tipo;

    if (n.tipo == 0) {
        tipo = "UFFICIO";
    } if (n.tipo == 1) {
        tipo = "CASA";
    } if (n.tipo == 2) {
        tipo = "CELLULARE";
    } if (n.tipo == 3) {
        tipo = "ALTRO";
    }

    printf("%i %s", n.numero, tipo);
}

void mostraPersona(struct Persona persona) {
    printf("Nome: %s\n", persona.nome);
    printf("Cognome: %s\n", persona.cognome);
    int n = 0;

    while (n < persona.numeriMemorizzati) {
        printf("Numero (%i / 10): ", n + 1);
        mostraNumero(persona.numeri[n]);
        printf("\n");
        ++n;
    }
}

void acquisisciNumeroDiTelefono(struct NumeroDiTelefono* numero) {
    printf("\tInserisci numero: ");
    scanf("%i", &(numero->numero));
    printf("\tInserisci tipo: ");
    printf("\t\n\t\t0: UFFICIO\n\t\t1: CASA\n\t\t2: CELLULARE\n\t\t3: ALTRO\n\t\t: ");
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
            } if (input == 3) {
                numero->tipo = ALTRO;
            }
            break;
        } else {
            printf("\t\tNumero non valido, riprova... : ");
        }
    }
}

struct Persona acquisisciPersona() {
    struct Persona* persona = malloc(sizeof(struct Persona));
    printf("Inserisci nome: ");
    scanf("%s", persona->nome);
    printf("Inserisci cognome: ");
    scanf("%s", persona->cognome);
    int n = 0;
    char* stop;

    while (n < 1) {
        printf("Numero (%i / 10) \n", n + 1);
        struct NumeroDiTelefono* numeroCorrente = malloc(sizeof(struct NumeroDiTelefono));
        acquisisciNumeroDiTelefono(numeroCorrente);
        (persona->numeri)[n] = *numeroCorrente;
        ++(persona->numeriMemorizzati);
        ++n;

        // printf("Proseguire? [Y/n]: \n");
        // scanf("%s", stop);

        // if (strcmp(stop, "Y") == 0) {
        //     n = 10;
        // }
    }

    return *persona;
}

int main() {
    struct Persona persona = acquisisciPersona();
    mostraPersona(persona);

    return 0;
};

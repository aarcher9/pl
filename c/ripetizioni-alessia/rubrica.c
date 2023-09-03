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
    struct NumeroDiTelefono numeri[MAX_NUMERI_MEMORIZZABILI];
};

struct Rubrica {
    char titolo[40];
    struct Persona contatti[MAX_CONTATTI];
};

void mostraNumero(struct NumeroDiTelefono* n) {
    char* tipo;

    if (n->tipo == 0) {
        tipo = "UFFICIO";
    } if (n->tipo == 1) {
        tipo = "CASA";
    } if (n->tipo == 2) {
        tipo = "CELLULARE";
    } if (n->tipo == 3) {
        tipo = "ALTRO";
    }

    printf("%s %i", tipo, n->numero);
}

// Informazioni persona
void mostraNominativoPersona(struct Persona* persona) {
    printf("Nome: %s\n", persona->nome);
    printf("Cognome: %s\n", persona->cognome);
}

void mostraNumeriDiTelefonoPersona(struct Persona* persona) {
    int n = 0;

    while (n < persona->numeriMemorizzati) {
        printf("[%i / 10]: ", n + 1);
        mostraNumero(&(persona->numeri[n]));
        printf("\n");
        ++n;
    }
}

void mostraPersona(struct Persona* persona) {
    printf("=== Informazioni persona ===\n");
    mostraNominativoPersona(persona);
    mostraNumeriDiTelefonoPersona(persona);
}

// Acquisizione numero di telefono
void setNumeroTelefonico(struct NumeroDiTelefono* numero) {
    printf("Inserisci numero: ");
    scanf("%i", &(numero->numero));
}

void setTipoNumeroTelefonico(struct NumeroDiTelefono* numero) {
    int input;
    printf("Inserisci tipo: ");
    printf("0: UFFICIO | 1: CASA | 2: CELLULARE | 3: ALTRO: ");
    scanf("%u", &input);

    if (input == 0) {
        numero->tipo = UFFICIO;
    } if (input == 1) {
        numero->tipo = CASA;
    } if (input == 2) {
        numero->tipo = CELLULARE;
    } if (input == 3) {
        numero->tipo = ALTRO;
    }
}

void acquisisciNumeroDiTelefono(struct NumeroDiTelefono* numero) {
    setNumeroTelefonico(numero);
    setTipoNumeroTelefonico(numero);
}

// Acquisizione persona
void setNominativoPersona(struct Persona* persona) {
    printf("Inserisci nome: ");
    scanf("%s", persona->nome);

    printf("Inserisci cognome: ");
    scanf("%s", persona->cognome);
}

struct Persona acquisisciPersona() {
    struct Persona* persona = malloc(sizeof(struct Persona));
    setNominativoPersona(persona);

    int n = persona->numeriMemorizzati;
    acquisisciNumeroDiTelefono(&((persona->numeri)[n]));
    ++(persona->numeriMemorizzati);

    return *persona;
}

int main() {
    struct Persona persona = acquisisciPersona();
    struct Persona* p_persona = &persona;

    mostraPersona(p_persona);

    return 0;
};

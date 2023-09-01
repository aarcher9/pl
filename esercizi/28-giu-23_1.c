#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUMERO_GIORNI 160

struct Cliente {
    char nome[20];
    char cognome[30];
    int numeroDiTelefono;
};

struct Spiaggia {
    char nome[30];
    int numeroClienti;
    struct Cliente clienti[100];
    const int numeroOmbrelloni;
    int assegnamenti[80][NUMERO_GIORNI];
};

// Supporto
void stampaCliente(struct Cliente* c) {
    printf("NOME: ");
    printf("%s\n", c->nome);

    printf("COGNOME: ");
    printf("%s\n", c->cognome);

    printf("NUMERO DI TELEFONO: ");
    printf("%d\n", c->numeroDiTelefono);
}

void inizializzaAssegnamenti(struct Spiaggia* s) {
    for (int omb = 0; omb < s->numeroOmbrelloni; omb++) {
        for (int gg = 0; gg < NUMERO_GIORNI; gg++) {
            s->assegnamenti[omb][gg] = -1;
        }
    }
}

int disponibilita(struct Spiaggia* s, int inizio, int fine) {
    int serieGiorniLiberi = 0;

    for (int omb = 0; omb < s->numeroOmbrelloni; omb++) {
        for (int gg = inizio; gg < fine; gg++) {
            if (s->assegnamenti[omb][gg] == -1) {
                serieGiorniLiberi++;
            } else {
                serieGiorniLiberi = 0;
            }
        }

        if (serieGiorniLiberi == (fine - inizio)) {
            return omb;
        }
    }

    return -1;
}

void assegnaOmbrellone(struct Spiaggia* s, int ombrellone, int clienteNumero, int inizio, int fine) {
    for (int gg = inizio; gg < fine; gg++) {
        s->assegnamenti[ombrellone][gg] = clienteNumero;
    }
}

// Richieste
struct Cliente inputCliente() {
    // struct Cliente* _cliente = malloc(sizeof(struct Cliente));
    struct Cliente* _cliente;

    printf("Inserisci nome cliente: ");
    scanf("%s", _cliente->nome);

    printf("Inserisci cognome cliente: ");
    scanf("%s", _cliente->cognome);

    printf("Inserisci numero di telefono cliente: ");
    scanf("%i", &_cliente->numeroDiTelefono);

    return *_cliente;
};

void aggiungiCliente(struct Spiaggia* s, struct Cliente c) {
    s->clienti[s->numeroClienti] = c;
    s->numeroClienti++;
};

int presenteCliente(struct Spiaggia* s, struct Cliente c) {
    for (int k = 0; k < s->numeroClienti; k++) {
        struct Cliente inEsame = s->clienti[k];

        if (strcmp(inEsame.nome, c.nome) == 0) {
            if (strcmp(inEsame.cognome, c.cognome) == 0) {
                if (inEsame.numeroDiTelefono == c.numeroDiTelefono) {
                    return k;
                }
            }
        }
    }

    return -1;
};

int prenota(struct Spiaggia* s, struct Cliente c, int g1, int g2) {
    int presenza = presenteCliente(s, c);
    int ombrelloneLibero = disponibilita(s, g1, g2);

    if (presenza == -1) {
        if (ombrelloneLibero != -1) {
            aggiungiCliente(s, c);
            assegnaOmbrellone(s, ombrelloneLibero, s->numeroClienti, g1, g2);
            return ombrelloneLibero;
        } else {
            return -1;
        }
    } else {
        if (ombrelloneLibero != -1) {
            assegnaOmbrellone(s, ombrelloneLibero, presenza, g1, g2);
            return ombrelloneLibero;
        } else {
            return -1;
        }
    }
};

int main() {

    struct Cliente c = inputCliente();
    struct Spiaggia* s;
    int p = presenteCliente(s, c);
    aggiungiCliente(s, c);
    int omb = prenota(s, c, 10, 70);


    return 0;
};
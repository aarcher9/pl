#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N_MAX_TAVOLI 30
#define N_MAX_PIATTI 50
#define LUNGHEZZA_MAX_NOME 50

enum Portata { PRIMO, SECONDO, CONTORNO, ALTRO };

struct Piatto {
    char nome[LUNGHEZZA_MAX_NOME];
    enum Portata categoria;
    int prezzo;
};

struct Tavolo {
    int codice;
    int posti;
    int occupato;
};

struct Ordinazione {
    int numeroPiattiOrdinati;
    struct Tavolo tavolo;
    struct Piatto piattiOrdinati[N_MAX_PIATTI];
    int totaleParziale;
};

struct Ristorante {
    char nome[LUNGHEZZA_MAX_NOME];
    int numeroOrdinazioniAperte;
    struct Tavolo tavoli[N_MAX_TAVOLI];
    struct Piatto piattiDisponibili[N_MAX_PIATTI];
    struct Ordinazione ordinazioniAperte[N_MAX_TAVOLI];
};

int calcolaConto(struct Ristorante* r, int codiceTavolo) {

    // Cerco l'ordinazione del tavolo con codice specificato
    for (int i = 0; i < r->numeroOrdinazioniAperte; i++) {

        // Variabili di appoggio per ordinare bene il codice
        struct Ordinazione ordinazione = r->ordinazioniAperte[i];
        struct Tavolo tavolo = ordinazione.tavolo;

        // Ecco il tavolo che cerco!
        if (tavolo.codice == codiceTavolo) {

            // Scorro i piatti che ha ordinato
            for (int k = 0; k < ordinazione.numeroPiattiOrdinati; k++) {

                // Fa comodo per ordinare bene il codice anche qui
                struct Piatto piatto = ordinazione.piattiOrdinati[k];
                ordinazione.totaleParziale += piatto.prezzo;
            }

            // Posso ritornarlo e basta cosi l'iterazione si ferma!
            printf("Ecco il conto: %d$", ordinazione.totaleParziale);
            return ordinazione.totaleParziale;
        }
    }

    // Se sono arrivato qui il codice del tavolo specificato non è stato trovato:
    printf("Impossibile calcolare il conto: codice tavolo non trovato!\n");
    return -1;
}

int main() {
    struct Ristorante* r;


    return 0;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct Iscritto {
    char nome[20];
    char cognome[30];
    int giorno;
    int mese;
    int anno;
};

struct ClubTennis {
    char nome[20];
    struct Iscritto iscritti[1000];
};

void creaIscritto(struct Iscritto iscritto) {

}

void stampaIscritto(struct Iscritto iscritto) {
    printf("%s\n", iscritto.nome);
    printf("%s\n", iscritto.cognome);
    printf("%i/%i/%i\n", iscritto.giorno, iscritto.mese, iscritto.anno);
}

void aggiungi(struct ClubTennis* club, struct Iscritto* nuovoIscritto) {
    int i = 0;
    // Ho un array di 1000 iscritti ma non so quanti ce ne siano al momento quindi devo controllare (non conosco la posizione dell'ultimo iscritto nell'array, se ce ne è uno)...
    while (i < 1000) {
        int primoCarattereDelNomeDellIscrittoAttuale = club->iscritti[i].nome[0];
        // Se il nome dell'iscritto appare vuoto (\0 è il carattere terminatore) significa che l'iscritto i-esimo non esiste quindi sono arrivato alla posizione appena dopo l'ultimo iscritto
        if (primoCarattereDelNomeDellIscrittoAttuale == '\0') {
            club->iscritti[i] = *nuovoIscritto;
            break;
        }

        i++;
    }
}

int main() {

    struct ClubTennis* club = malloc(sizeof(struct ClubTennis));

    struct Iscritto* iscritto_1 = malloc(sizeof(struct Iscritto));
    memcpy(iscritto_1->nome, "Marco", sizeof("Marco"));
    memcpy(iscritto_1->cognome, "Belotti", sizeof("Belotti"));
    iscritto_1->giorno = 12;
    iscritto_1->mese = 4;
    iscritto_1->anno = 99;

    struct Iscritto* iscritto_2 = malloc(sizeof(struct Iscritto));
    memcpy(iscritto_2->nome, "Alice", sizeof("Alice"));
    memcpy(iscritto_2->cognome, "Belotti", sizeof("Belotti"));
    iscritto_2->giorno = 14;
    iscritto_2->mese = 7;
    iscritto_2->anno = 94;

    aggiungi(club, iscritto_1);
    aggiungi(club, iscritto_2);

    // Il primo iscritto dovrebbe essere Marco
    stampaIscritto(club->iscritti[0]);

    // La seconda iscritto dovrebbe essere Alice
    stampaIscritto(club->iscritti[1]);

    return 0;
};

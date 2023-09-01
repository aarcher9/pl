#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct Stampante {
    char marca[50];
    char tipo[50];
    int id;
    int livelloToner;
};

struct Stanza {
    char nome[20];
    struct Stampante stampanti[5];
};

struct Piano {
    int livello;
    struct Stanza stanze[30];
};

struct Edificio {
    char nome[20];
    struct Piano piani[10];
};


void stampaInfoStanza(struct Stanza* stanza) {
    printf("Nome: %s\n", stanza->nome);
}

/**
 *@brief RICHIESTA
 *
 * @param stanza
 */
void realizzaStanzaManualmente(struct Stanza* stanza) {
    printf("Come chiami la stanza?\n");
    scanf("%s", stanza->nome);
    printf("Stanza pronta!\n");
}

/**
 *@brief RICHIESTA
 *
 * @param edificio
 */
void realizzaEdificioManualmente(struct Edificio* edificio) {

}

/**
 *@brief RICHIESTA
 *
 * @param stanza
 * @param stampante
 */
void aggiungiStampanteAllaStanza(struct Stanza* stanza, struct Stampante stampante) {

}

/**
 *@brief RICHIESTA
 *
 * @param edificio
 * @param sogliaLimiteToner
 * @return int
 */
int numeroStampantiEdificioConTonerMinoreDi(struct Edificio* edificio, int sogliaLimiteToner) {
    return 0;
}

int main() {

    // La malloc è necessaria!
    struct Stanza* stanza_1 = malloc(sizeof(struct Stanza*));

    realizzaStanzaManualmente(stanza_1);
    stampaInfoStanza(stanza_1);

    return 0;
};

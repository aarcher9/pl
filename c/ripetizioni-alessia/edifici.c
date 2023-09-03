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

// Aggiungi stampante alla stanza
void aggiungiStampanteAllaStanza(struct Stanza* stanza, struct Stampante stampante) {

}

// Numero stampanti con toner minore di una certa soglia
int numeroStampantiEdificioConTonerMinoreDi(struct Edificio* edificio, int sogliaLimiteToner) {
    return 0;
}

// stampante
void setMarcaStampante(struct Stampante* stampante) {
    printf("Marca stampante: ");
    scanf("%s", stampante->marca);
}
void setTipoStampante(struct Stampante* stampante) {
    printf("Tipo stampante: ");
    scanf("%s", stampante->tipo);
}
void setIDStampante(struct Stampante* stampante) {
    printf("ID stampante: ");
    scanf("%i", &(stampante->id));
}
void setLivelloTonerStampante(struct Stampante* stampante) {
    printf("Livello toner stampante: ");
    scanf("%i", &(stampante->livelloToner));
}

void mostraInformazioniStampante(struct Stampante* stampante) {
    printf("Marca stampante: %s\n", stampante->marca);
    printf("Tipo stampante: %s\n", stampante->tipo);
    printf("ID stampante: %i\n", stampante->id);
    printf("Livello toner stampante: %i\n", stampante->livelloToner);
}

void realizzaStampanteManualmente(struct Stampante* stampante) {
    setMarcaStampante(stampante);
    setTipoStampante(stampante);
    setIDStampante(stampante);
    setLivelloTonerStampante(stampante);
}

// stanza
void setNomeStanza(struct Stanza* stanza) {
    printf("Nome stanza: ");
    scanf("%s", stanza->nome);
}

void mostraInformazioniStanza(struct Stanza* stanza) {
    printf("Nome stanza: %s\n", stanza->nome);

    int n = 0;
    mostraInformazioniStampante(&(stanza->stampanti[n]));
}

void realizzaStanzaManualmente(struct Stanza* stanza) {
    setNomeStanza(stanza);

    int n = 0;
    realizzaStampanteManualmente(&(stanza->stampanti[n]));
}

// piano
void setLivelloPiano(struct Piano* piano) {
    printf("Livello piano: ");
    scanf("%i", &(piano->livello));
}

void mostraInformazioniPiano(struct Piano* piano) {
    printf("Livello piano: %i\n", piano->livello);

    int n = 0;
    mostraInformazioniStanza(&(piano->stanze[n]));
}

void realizzaPianoManualmente(struct Piano* piano) {
    setLivelloPiano(piano);

    int n = 0;
    realizzaStanzaManualmente(&(piano->stanze[n]));
}

// edificio
void setNomeEdificio(struct Edificio* edificio) {
    printf("Nome edificio: ");
    scanf("%s", edificio->nome);
}

void mostraInformazioniEdificio(struct Edificio* edificio) {
    printf("Nome edificio: %s\n", edificio->nome);

    int n = 0;
    mostraInformazioniPiano(&(edificio->piani[n]));
}

void realizzaEdificioManualmente(struct Edificio* edificio) {
    setNomeEdificio(edificio);

    int n = 0;
    realizzaPianoManualmente(&(edificio->piani[n]));
}

int main() {

    // La malloc è necessaria!
    struct Edificio* edificio_1 = malloc(sizeof(struct Edificio*));

    realizzaEdificioManualmente(edificio_1);
    mostraInformazioniEdificio(edificio_1);

    return 0;
};

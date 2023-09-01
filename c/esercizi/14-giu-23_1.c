#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Complesso {
    float reale;
    float immaginaria;
};

struct Segmento {
    struct Complesso a;
    struct Complesso b;
};

struct InsiemeSegmenti {
    struct Segmento set[50];
};

void stampaComplesso(struct Complesso* a) {
    printf("Reale: %f\n", a->reale);
    printf("Immaginaria: %f\n", a->immaginaria);
}

struct Complesso inputComplesso() {
    struct Complesso* c = malloc(sizeof(struct Complesso));

    // ... acquisisce da stdin
    c->reale = 20.1;
    c->immaginaria = 0.15;

    return *c;
}

struct Segmento inputSegmento(struct Segmento* s) {
    struct Complesso a = inputComplesso();
    struct Complesso b = inputComplesso();
    s->a = a;
    s->b = b;
    return *s;
}

struct Complesso somma(struct Complesso* a, struct Complesso* b) {
    struct Complesso* sum = malloc(sizeof(struct Complesso));
    sum->reale = a->reale + b->reale;
    sum->immaginaria = a->immaginaria + b->immaginaria;
    return *sum;
}

float distanza(struct Complesso* a, struct Complesso* b) {
    // La devo definire perchè sono in un compilatore!
    return 0.0;
}

// Terribile pratica usare parametri come output ma penso che lo sappia anche lui
struct Segmento maggioreDelSet(struct Segmento* segmento, struct InsiemeSegmenti insieme) {
    struct Segmento* max = malloc(sizeof(struct Segmento));
    int i = 0;
    float lunghezzaMax = 0;
    float lunghezzaCorrente = 0;

    // Cerca il maggiore
    for (i = 0; i < 50; i++) {
        lunghezzaCorrente = distanza(&(insieme.set[i].a), &(insieme.set[i].b));
        if (lunghezzaCorrente > lunghezzaMax) {
            lunghezzaMax = lunghezzaCorrente;
            max = &insieme.set[i];
        }
    }

    return *max;
}


int main() {
    struct InsiemeSegmenti insieme;
    struct Segmento s;
    maggioreDelSet(&s, insieme);
}
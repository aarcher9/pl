#include <stdio.h>
#include <stdlib.h>
#define REGIONIMAX 30
#define CITTAMAX 100

struct citta {
    char nome[30];
    int numabitanti;
};

struct regione {
    char nome[25];
    int numcitta;
    struct citta inscitta[CITTAMAX];
};

struct stati {
    char nome[20];
    int numregioni;
    struct regione insregioni[REGIONIMAX];
};



void incitta(struct citta* c) {
    printf("INSERIRE NOME CITTA: ");
    scanf("%s", c->nome);
    printf("INSERIRE NUMERO ABITANTI: ");
    scanf("%d", &c->numabitanti);
}

void instato(struct stati* s) {
    struct citta* _c;
    printf("INSERIRE STATO: ");
    scanf("%s", s->nome);
    printf("INSERIRE NUMERO REGIONI: ");
    scanf("%d", &s->numregioni);
    for (int j = 0;j < s->numregioni;j++) {
        printf("INSERIRE REGIONE: ");
        scanf("%s", s->insregioni[j].nome);
        printf("INSERIRE NUMERO CITTA: ");
        scanf("%d", &s->insregioni[j].numcitta);
        for (int i = 0;i < s->insregioni[j].numcitta;i++) {
            _c = malloc(sizeof(struct citta));
            incitta(_c);
            s->insregioni[j].inscitta[i] = *_c;
        }
    }
}

int abstato(struct stati s) {
    int totale = 0;
    for (int i = 0;i < s.numregioni;i++) {
        for (int j = 0;j < s.insregioni[i].numcitta;j++) {
            totale = totale + (s.insregioni[i].inscitta[j].numabitanti);
        }
    }
    return totale;
}
int main() {
    struct stati* st = malloc(sizeof(struct stati));
    instato(st);
    int n = abstato(*st);
    printf("Abitanti totali stato %d\n", n);
    return 0;
}
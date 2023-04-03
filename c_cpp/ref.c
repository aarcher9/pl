#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DIM 10

int main() {

    /*
    * &: richiede l'indirizzo della variabile
    * *: se la variabile a cui applicato è un puntatore, richiede il bersaglio (eccetto nella definizione, ovvero quando dichiaro una varibile 'int *k' dove ha significato sintattico), se non è un puntatore, il compilatore lancia un errore.
    */

    // ===== Casi base =====
	int intero = 200;
	int* puntatore = &intero;
    char parola[] = "ciao";

    // per definizione
    printf("A: %i\n", puntatore == &intero);
    // incremento il bersaglio del puntatore
    printf("B: %i\n", ++(*puntatore) == 201);

    // per un array il puntatore è l'indirizzo del primo elemento
    printf("C: %i\n", parola == &parola[0]);
    // se incremento il puntatore quindi, ottengo l'indirizzo del successivo elemento
    printf("D: %i\n", (parola + 1) == &parola[1]);
    // come sopra ma confronto i valori e non gli indirizzi
    printf("E: %i\n", *(parola + 1) == parola[1]);


    // ===== Sitauzioni più complesse =====
    intero = 200;
    puntatore = &intero;
    int** pp = &puntatore;
    
    // per definzione
    printf("F: %i\n", pp == &puntatore);
    // equivale a quanto sopra &* si "annullano"
    printf("G: %i\n", &*pp == &puntatore);
    // infatti...
    printf("H: %i\n", &*pp == pp);
    // esagerando in modo insensato
    printf("I: %i\n", &*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*pp == pp);
    // bersaglio del bersaglio del puntatore
    printf("J: %i\n", **pp == 200);


    // Aritmetica dei puntatori =====
    printf("K: %p, %p, %li\n", puntatore, (puntatore + 1), sizeof(int));

	
	return 0; 
}
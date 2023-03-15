#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DIM 10

int main() {

	int intero = 109;
	int *puntatore = &intero;

	printf("Sono un intero: %i \n", intero);
	printf("Sono sempre lo stesso intero: %i \n", *&intero);
	printf("Sono l'indirizzo dell' intero: %p \n", &intero);

	printf("Sono l'indirizzo che il puntatore indica: %p \n", puntatore);
	printf("Sono il contenuto dell'indirizzo che il puntatore indica: %i \n", *puntatore);
	printf("Sono il contenuto dell'indirizzo che il puntatore indica anche io: %i \n", **&puntatore);
	printf("Sono l'indirizzo del puntatore: %p \n", &puntatore);
	
	return 0; 
}
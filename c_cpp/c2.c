#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define DIM 10

void FUNZIONE(int vettore[], int dim, int *PROVA) {

	int resto = 0;

	for (int i = 0; i < dim; i++) {

		resto = (vettore[i] % 2);
		
		if (resto == 0) {
			*PROVA += 1;
		}
	}

	printf("Adesso PROVA, nella funzione 'FUNZIONE' vale: %i \n", *PROVA);
}



int main() {

	srand(time(NULL));
	int vettore[DIM];


	// riempimento array con numeri da 0 a 99

	for (int i = 0; i < DIM; i++) {
		vettore[i] = rand() %100;
	}


	// visualizzo il contenuto appena generato

		for (int i = 0; i < DIM; i++) {
		printf("Elemento in posizione %i del vettore: %i \n", i, vettore[i]);
	}


	// conto quanti elementi divisibili per due ci sono
	int PROVA = 0;
	int *p_PROVA = &PROVA;

	FUNZIONE(vettore, DIM, p_PROVA);

	printf("Ci sono %i elementi divisibili per 2\n", PROVA);
	printf("Il passaggio per referenza fa si che anche nell' 'int main() { ... }' PROVA valga %i \n", PROVA);
	
	return 0; 
}
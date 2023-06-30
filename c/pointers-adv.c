#include <stdio.h>
#include <stdlib.h>

int* scoped_var() {
        // Dichiarazione STATICA (nello stack) dell'array
        int c[1] = {167};

        return (int *) malloc(0);
        
        // Se infatti chiamo la procedura mi avvisa con uno warning, perchè tecnicamente essendo statica una vlta usciti dallo scope di definizione non dovrebbe piú esistere
        // return &c[0];
};

int* global_var() {
        // Dichiarazione DINAMICA (nell'heap) dell'array (nel'equivalente forma di puntatore)
        int* c = malloc(1 * sizeof(int));
        c[0] = 188;

        // Qui infatti non ho errori chiamando la procedura
        return &c[0];
};

int main() {

        int* arr = malloc(2 * sizeof(int));
        int arr_eq[2];

        // Non va bene, questa forma solo per inizializzare
        // arr = {1, 2};

        arr_eq[0] = 13;
        *(arr) = 13; 
        arr_eq[1] = 244;
        *(arr + 1) = 244;
        printf("%i %i\n", arr[0], arr[1]);
        printf("%i %i\n", arr_eq[0], arr_eq[1]);

        printf("%i\n", *scoped_var());
        printf("%i\n", *global_var());

        return 0;
}
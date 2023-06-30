#include <stdio.h>
#include <stdlib.h>

typedef int rows;
typedef int columns;
typedef double* items;

// Cosí facendo non devo tipizzare con 'struct Matrix' ma solo 'Matrix'
typedef struct {
        rows n_of_rows;
        columns n_of_columns;
        items elements;
} Matrix;

Matrix* new_matrix(int n_of_rows, int n_of_columns) {

        // Prolisso ma sensato
        Matrix* m = malloc(sizeof(Matrix));

        (*m).n_of_rows = n_of_rows;
        (*m).n_of_columns = n_of_columns;
        (*m).elements = malloc((n_of_rows * n_of_columns) * sizeof(int));

        return m;
};

int main() {

        Matrix* m = new_matrix(4, 5);

        printf("%i, %i", (*m).n_of_rows, (*m).n_of_columns);

        return 0;
}
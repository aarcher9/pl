#include <stdio.h>
#include <stdlib.h>

struct _matrix {
        double** entries;
        int rows, columns;
};

typedef struct _matrix* Matrix;

// Ovunque richiesto, dove il passaggio per valore non è permesso, devo usare la malloc per scrivere sull'heap. In caso contrario mi ritrovo con un buon segmentation fault (scrittura su area di memoria non accessibile) a runtime.
Matrix new_matrix(int r, int c, double initial_value) {

        Matrix m = malloc(sizeof(Matrix));
        m->rows = r;
        m->columns = c;
        m->entries = malloc(r * sizeof(double**));

        for(int row = 0; row < r; row++) {

                m->entries[row] = malloc(c * sizeof(double*)); 

                for(int column = 0; column < c; column++) {
                        m->entries[row][column] = initial_value;
                }
        }

        return m;
};


int main() {

        Matrix m = new_matrix(3, 3, 2.33);

        for(int row = 0; row < m->rows; row++) {
                for(int column = 0; column < m->columns; column++) {
                        printf("%f", m->entries[row][column]);
                }
        }

        return 0;
};
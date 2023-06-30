#include <stdio.h>

typedef int rows;
typedef int columns;
typedef double elements[];

struct Matrix {
        rows n_of_rows;
        columns n_of_columns;
        elements elements;
};

int main() {
        return 0;
}
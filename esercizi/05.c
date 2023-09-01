#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define R 3
#define C 2

int main() {

    int mat[R][C];

    // int max[C];
    int max = 0;
    int temp = 0;

    for (int i = 0; i < C; i++) {
        temp = 0;

        for (int k = 0; k < R; k++) {
            temp += mat[k][i];
        }
        // max[i] = temp;

        if (temp > max) {
            max = temp;
        }
    }

    // int m = 0;
    // for (int o = 0; o < R; o++) {
    //     if (max[o] > m) {
    //         m = max[o];
    //     }
    // }





    return 0;
}
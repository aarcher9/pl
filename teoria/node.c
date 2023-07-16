#include <stdio.h>
#include <stdlib.h>

// Albero binario per esempio
#define N 2

typedef char* Key;
typedef char* Value;

struct Node {
        // Lunghezza non definita
        Key key;
        Value value;
        struct Node* children[N];
};

int main() {

        return 0;
};
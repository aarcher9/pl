#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define MAX_HEAP_SIZE 5


struct item {
    int priority;
    char content[50];
};


int parentnk(int key) {
    return floor((key + 1) / 2) - 1;
};
int leftnk(int key) {
    return ((key + 1) * 2) - 1;
};
int rightnk(int key) {
    return ((key + 1) * 2 + 1) - 1;
};

int lastnk(struct item *heap) {

    int i = 0;

    while (i < MAX_HEAP_SIZE) {
        
        if (heap[i].priority == -1) {
            return i - 1;
        }

        i++;
    }

    return i - 1;
}

void printHeap(struct item *heap) {

    int i = 0;
    printf("[");

    for (i = 0; i < lastnk(heap); i++) {
        printf("%i, ", heap[i].priority);
    }

    printf("%i]\n", heap[i].priority);
};


void swap(struct item *heap, int j, int k) {

    struct item temp = heap[j];
    heap[j] = heap[k];
    heap[k] = temp;
};

void heapify(struct item *heap, int key) {

    int maxKey = key;

    if (leftnk(key) <= lastnk(heap) && heap[leftnk(key)].priority > heap[key].priority) {

        maxKey = leftnk(key);

    } if (rightnk(key) <= lastnk(heap) && heap[rightnk(key)].priority > heap[maxKey].priority) {

        maxKey = rightnk(key);

    } if (maxKey != key) {
        swap(heap, key, maxKey);
        heapify(heap, maxKey);
    }
};

void buildHeap(struct item *heap) {

    for (int i = lastnk(heap); i >= 0; i--) {
        heapify(heap, i);
    }
};

void delete(struct item *heap, int key) {

};

void add(struct item *heap, struct item node) {

};



int main() {

    struct item heap[MAX_HEAP_SIZE];


    struct item a = {4, "a"};
    struct item b = {10, "b"};
    struct item c = {3, "c"};
    struct item d = {5, "d"};
    struct item e = {1, "e"};
    // struct item f = {11, "s"};
    // struct item g = {6, "r"};

    heap[0] = a;
    heap[1] = b;
    heap[2] = c;
    heap[3] = d;
    heap[4] = e;
    // heap[5] = f;
    // heap[6] = g;

    printHeap(heap);

    buildHeap(heap);
    printHeap(heap);

	
	return 0; 
}
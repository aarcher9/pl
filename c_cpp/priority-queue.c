#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define MAX_HEAP_SIZE 5


struct item {
    int priority;
    char content[50];
};


int parentnk(int nodekey) {
    return floor(nodekey / 2);
};
int leftnk(int nodekey) {
    return (nodekey * 2);
};
int rightnk(int nodekey) {
    return (nodekey * 2 + 1);
};

int heapsize(struct item *heap) {

    int i = 0;

    while (i < MAX_HEAP_SIZE) {
        
        if (heap[i].content == "\n") {
            break;
        }

        i++;
    }

    return i;
}


void swap(struct item *heap, int j, int k) {

    struct item temp = heap[j];
    heap[j] = heap[k];
    heap[k] = temp;
};

void heapify(struct item *heap, int nodekey) {

    if (nodekey < heapsize(heap) - 1) {

        int candidateNodeKey = nodekey;

        if (heap[leftnk(nodekey)].priority >= heap[rightnk(nodekey)].priority && leftnk(nodekey) < heapsize(heap) - 1) {
            candidateNodeKey = leftnk(nodekey);

        } else if (rightnk(nodekey) < heapsize(heap) - 1) {
            candidateNodeKey = rightnk(nodekey);
        }

        if (heap[candidateNodeKey].priority > heap[nodekey].priority) {
            swap(heap, nodekey, candidateNodeKey);
            heapify(heap, candidateNodeKey);
        }
    }
};

void buildHeap(struct item *heap) {

    for (int i = heapsize(heap) - 1; i >= 0; i--) {
        heapify(heap, i);
    }
};

void delete(struct item *heap, int nodekey) {
    swap(heap, nodekey, heapsize(heap) - 1);
    heapify(heap, nodekey);
};

void add(struct item *heap, struct item node) {

    // Assuming heap contains HEAP_SIZE - 1 items
    // Probabily not the smartest way...
    heap[heapsize(heap - 1)] = node;
    swap(heap, 0, heapsize(heap - 1));
    heapify(heap, 0);
};


void printHeap(struct item *heap) {

    int i = 0;
    printf("[");

    for (i = 0; i < heapsize(heap) - 1; i++) {
        printf("%i, ", heap[i].priority);
    }

    printf("%i]\n", heap[i].priority);
};


int main() {

    struct item heap[5];


    struct item a = {4, "a"};
    struct item b = {10, "b"};
    struct item c = {3, "c"};
    struct item d = {5, "d"};
    struct item e = {1, "e"};

    // heap[0] = a;
    // heap[1] = b;
    // heap[2] = c;
    // heap[3] = d;
    // heap[4] = e;

    printf("%i", heapsize(heap));

    // printHeap(heap);

    // buildHeap(heap);
    // printHeap(heap);



	
	return 0; 
}
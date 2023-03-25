#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define MAX_HEAP_SIZE 7


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


void swap(struct item *heap, int j, int k) {

    struct item temp = heap[j];
    heap[j] = heap[k];
    heap[k] = temp;
};

void heapify(struct item *heap, int nodekey) {

    if (nodekey <= lastnk(heap)) {

        int candidate_nk = nodekey;

        if (leftnk(nodekey) <= lastnk(heap) && heap[leftnk(nodekey)].priority >= heap[rightnk(nodekey)].priority) {
            candidate_nk = leftnk(nodekey);

        } if (rightnk(nodekey) <= lastnk(heap) && heap[rightnk(nodekey)].priority > heap[candidate_nk].priority) {
            candidate_nk = rightnk(nodekey);
        }

        if (heap[candidate_nk].priority > heap[nodekey].priority) {

            swap(heap, nodekey, candidate_nk);
            heapify(heap, candidate_nk);
        }
    }
};

void buildHeap(struct item *heap) {

    for (int i = lastnk(heap); i >= 0; i--) {
        heapify(heap, i);
    }
};

void delete(struct item *heap, int nodekey) {

};

void add(struct item *heap, struct item node) {

};


void printHeap(struct item *heap) {

    int i = 0;
    printf("[");

    for (i = 0; i < lastnk(heap); i++) {
        printf("%i, ", heap[i].priority);
    }

    printf("%i]\n", heap[i].priority);
};



int main() {

    struct item heap[MAX_HEAP_SIZE];


    struct item a = {4, "a"};
    struct item b = {10, "b"};
    struct item c = {3, "c"};
    struct item d = {5, "d"};
    struct item e = {1, "e"};
    struct item f = {11, "s"};
    struct item g = {6, "r"};

    heap[0] = a;
    heap[1] = b;
    heap[2] = c;
    heap[3] = d;
    heap[4] = e;
    heap[5] = f;
    heap[6] = g;

    printHeap(heap);

    buildHeap(heap);
    printHeap(heap);

	
	return 0; 
}
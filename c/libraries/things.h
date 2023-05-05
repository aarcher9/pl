// Fintanto che esiste un altra macro N con lo stesso valore non c'è problema
#define PI 3.14

// Altrimenti sono costretto ad usare una condizionale quando c'è un conflitto, motivo per cui devo essere molto attento con il naming non esistendo un namespace
#ifndef M
#define M 10
#endif

extern void things();
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
using namespace std;

// funzione esterna
void stampaQualcosa() {
    cout << "Ho stampato a video!" << endl;
}
   
class Rettangolo {
    
    // qui scrivo di solito gli attributi o metodi che non voglio vengano visti dal main
    private:
        float altezza;
        float base;

    // qui metto i metodi o attributi che voglio siano utilizzabili dal main
    public:

        // il quadrato è un tipo di rettangolo particolare
        Rettangolo(float lato) {
            base = lato;
            altezza = lato;
        }

        // quando scrivo un metodo con il nome della classe allora ho un costruttore
        Rettangolo(float b, float a) {
            base = b;
            altezza = a;
        }

        // questo è un altro metodo qualunque
        float area() {
            return base*altezza;
        }

        // questo anche
        float perimetro() {
            return base*2 + altezza*2;
        }

        // i metodi possono avere la stessa classe come argomento
        bool uguale(Rettangolo r) {
            return (r.altezza == altezza && r.base == base);
        }


        // ===== Metodi get e set ===== //

        // lo uso per poter controllare, o utilizzare un valore che altrimenti sarebbe inaccessibile nel main (perchè altezza è private, quindi non posso vederlo se non metto a disposizione un get)
        float getAltezza() {
            return altezza;
        }
        // questo lo uso per cambiare l'attributo altezza che altrimenti non potrei modificare, perchè inaccessibile, appunto
        void setAltezza(float a) {
            altezza = a;
        }

        float getBase() {
            return base;
        }
        void setBase(float b) {
            base = b;
        }

};


// provo a vedere se il codice si comporta come previsto
int main() {

    Rettangolo ret(10, 20);
    Rettangolo ret2(10, 20);
    Rettangolo ret3(1, 4);
    cout << "Area = " << ret.area() << endl;
    cout << "Sono uguali? " << ret.uguale(ret2) << endl;
    cout << "Sono uguali? " << ret.uguale(ret3) << endl;
    
	
	return 0; 
}
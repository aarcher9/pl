#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
using namespace std;

class Oggettobiblioteca {

    string titolo;
    string autore;
    string regista;

    public:
        Oggettobiblioteca(string tito){
            titolo=tito;
        }

        string gettitolo(){
            return titolo;
        }
        void  settitolo (string tit){
            titolo=tit;
        }

        string getautore(){
            return autore;
        }
        void setautore(string aut){
            autore=aut;
        }

        string getregista(){
            return regista;
        }
        void setregista(string reg){
            regista=reg;
        }
};

class Libro : public Oggettobiblioteca {
    int npagine;

    public:
        Libro(string t, int npa) : Oggettobiblioteca(t){
            npagine=npa;
        }
        int getnpagine(){
                return npagine;
            }
        void setnpagine (int npag){
            npagine=npag;
        }
};

class Dvd : public Oggettobiblioteca {
    int durata;

    public:
        Dvd(string t, int dura) : Oggettobiblioteca(t) {
            durata=dura;
        }
        int getdurata(){
            return durata;
        }
        void setdurata(int dur){
            durata=dur;
        }
};


// provo a vedere se il codice si comporta come previsto
int main() {

   Libro primo ("fogna",400);
	cout<<primo.gettitolo()<<endl;
	return 0; 
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <iostream>
using namespace std;


class Macchina{

int cilindrata;
int potenza;
int vmassimo;
int t100kmh;
int impiantofrenante;
public:
Macchina(int cil,int vmax,int t){
    cilindrata=cil;
    vmassimo=vmax;
    t100kmh=t;


}
int accellera(){
    return vmassimo / (100/t100kmh);

}
   void  setimpiantofrena(int f){
    if(f<=10 && f>=0){
        impiantofrenante=f;

    }
  }
  
  int accellerazione(){
    return 100/t100kmh;
  }
};


void Gara(Macchina m1, Macchina m2){
    int t1,t2;
    t1=sqrt(2*400/m1.accellerazione());
    t2=sqrt(2*400/m2.accellerazione());

    if(t1>t2){
        cout<<"ha vinto t1"<<endl;

    }if(t1<t2){
        cout<<"ha vinto t2"<<endl;
    }else{

cout<<"hanno pareggiato"<<endl;

    }


}
int main() {

	return 0; 
}
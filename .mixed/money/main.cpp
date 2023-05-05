#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include "Money.hpp"
#include "SubMoney.hpp"
using namespace std;

int main() {

    Money* m1 = new Money(12.5f, '$');
    Money* m2 = new Money(12.5f, '$');
    Money* s = *m1 + *m2;
    cout << s->show() + "\n";

    // Oppure
    Money m3 = Money(12.5f, '$');
    cout << m3.show() + "\n";

    SubMoney* sm = new SubMoney(1, '$');
    cout << sm->show() + "\n";
	
	return 0; 
}
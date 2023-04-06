#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include "Money.hpp"
using namespace std;

int main() {

    Money* m1 = new Money(12.5f, '$');
    Money* m2 = new Money(12.5f, '$');
    Money* s = *m1 + *m2;
    cout << s->show() + "\n";

	
	return 0; 
}
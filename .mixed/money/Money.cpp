#include "Money.hpp"
#include <string>
#include <math.h>
using namespace std;

Money::Money(float val, char curr) {
    this->value = val;
    this->currency = curr;
};

string Money::show() {
    string repr = to_string(this->value) + this->currency;

    return repr;
}

int Money::ceil() {
    return ceilf(this->value);
}

int Money::floor() {
    return floorf(this->value);
}

Money* Money::operator+(Money m) {
    return new Money(this->value + m.value, this->currency);
}
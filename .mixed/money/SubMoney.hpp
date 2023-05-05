#pragma once
#include <string>
#include "Money.hpp"
using namespace std;

class SubMoney : public Money {

    public: 
        SubMoney(float val, char curr);
};
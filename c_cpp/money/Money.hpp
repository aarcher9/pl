#include <string>
using namespace std;

class Money {

    private:
        float value;
        char currency;

    public:
        Money(float val, char curr);
        string show();
        int floor();
        int ceil();

        Money* operator+(Money m);
        Money* operator-(Money m);
};
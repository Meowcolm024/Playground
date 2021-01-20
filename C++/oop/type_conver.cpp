#include <iostream>
using namespace std;

class box
{
private:
    double d;
    int i;

public:
    box(double v)
    {
        d = v;
        i = (int)v;
    };
    operator double() { return d; };
    operator int() { return i; };
};

int main() {
    box a = 10;
    int c = (int)a + 10;
    return 0;
}

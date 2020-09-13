#include <iostream>
#include <cmath>
using namespace std;

struct Func
{
    string name;
};

function<double(Func)> complex(double x, double y)
{
    return [x, y](Func op) {
        string tmp = op.name;
        if (tmp == "real_part")
            return x;
        if (tmp == "imag_part")
            return y;
        if (tmp == "magnitude")
            return sqrt(pow(x, 2) + pow(y, 2));
        if (tmp == "angle")
            return atan2(y, x);
    };
}

Func real_part = {"real_part"};
Func imag_part = {"imag_part"};
Func magnitude = {"magnitude"};
Func angle = {"angle"};

int main()
{
    auto c1 = complex(1, 2);
    cout << "complex number: " << c1(real_part) << "+" << c1(imag_part) << "i\n";
    cout << "magnitude: " << c1(magnitude) << endl;
    cout << "angle: " << c1(angle) << endl;
    return 0;
}
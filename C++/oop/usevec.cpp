#include <iostream>
#include "vect.h"

using namespace std;
using vec::Vector;

int main()
{
    Vector v1 = Vector(1, 2);
    Vector v2 = Vector(5, 1.5, Vector::Mode::POL);

    cout << v1 + v2 << " | " << v1 - v2 << endl;
    ;
    cout << v1 * 3 << " | " << 5 * v1 << endl;
    cout << v1 * v2 << " | " << -v2 << endl;
    cout << "v1 => " << v1 << endl;;
    v1.polMode();
    cout << "now v1 => " << v1 << endl;

    return 0;
}
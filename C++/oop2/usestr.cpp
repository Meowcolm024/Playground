#include <iostream>
#include "str.h"

using std::cout;
using std::endl;

int main()
{
    String x = "hello";
    String y = "world";

    cout << "\"" << x << "\" with length " << x.length() << endl;

    if (x > y)
        cout << "x is larger!";
    else
        cout << "x is not larger!";
    cout << endl;

    const String z = x;

    cout << "With z: \"" << z << "\" we have " << String::howMany();
    cout << " strings!\n";

    cout << "at #2, we have '" << z[2] <<"'\n";

    x[1] = 'a';
    cout << "x changed to \"" << x << "\"\n";

    return 0;
}
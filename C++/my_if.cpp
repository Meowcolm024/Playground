#include <iostream>
using namespace std;

function<int(int)> my_true(int x)
{
    return [x](int y) { return x; };
}

function<int(int)> my_false(int x)
{
    return [x](int y) { return y; };
}

function<function<int(int)>(int)> my_if(function<function<int(int)>(int)> p)
{
    return [p](int a) {
        return [p, a](int b) {
            return p(a)(b);
        };
    };
}

int main()
{
    int x = my_if(my_true)(1)(2);
    int y = my_if(my_false)(1)(2);
    cout << x << " " << y << endl;
    return 0;
}

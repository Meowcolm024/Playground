#include <iostream>
using namespace std;

int my_true(int x, int y)
{
    return x;
}

int my_false(int x, int y)
{
    return y;
}

int my_if(function<int(int, int)> p, int a, int b)
{
    return p(a,b);
}

int main()
{
    int x = my_if(my_true, 1, 2);
    int y = my_if(my_false, 1, 2);
    cout << x << " " << y << endl;
    return 0;
}

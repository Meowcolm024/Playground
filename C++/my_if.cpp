#include <iostream>
using namespace std;

template<class T, class F>
T my_true(T x, F y)
{
    return x;
}

template<class T, class F>
F my_false(T x, F y)
{
    return y;
}

template<class T>
T my_if(T p)
{
    return p;
}

int main()
{
    int x = my_if(my_true<int, int>)(1, 2);
    string y = my_if(my_false<int, string>)(1, "hello");
    cout << x << " " << y << endl;
    return 0;
}

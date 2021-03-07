#include <iostream>

using namespace std;

// neither
int p = 0;
int q = 3;

void func(int x, int y)
{
    // where ?
    int a = 10;
    int b = 3;
    // in heap
    int *c = new int(100);
    int *d = new int(-1);
    cout << "x " << &x << endl;
    cout << "y " << &y << endl;
    cout << "a " << &a << endl;
    cout << "b " << &b << endl;
    cout << "c " << c << endl;
    cout << "d " << d << endl;
    delete c;
    delete d;
}

int main()
{
    func(9, 7);
    cout << "func " << (void *)&func << endl;
    cout << "main " << (void *)&main << endl;
    cout << "p " << &p << endl;
    cout << "q " << &q << endl;
    return 0;
}
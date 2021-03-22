#include <iostream>
using namespace std;

struct A
{
    int a;
};
struct B : A
{
    int b;
};

int main()
{
    A *a = new A();
    a->a = 10;
    B *pb = (B *)a;
    cout << pb->a << endl;
    cout << pb->b << endl;
    return 0;
}
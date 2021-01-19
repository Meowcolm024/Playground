#include <iostream>
using namespace std;

int square(int x); // this line is necessary

int main()
{
    cout << square(2) << endl;
    return 0;
}

int square(int x) { return x * x; }

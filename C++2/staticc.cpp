#include <iostream>
using namespace std;

int x;                  // static, external, zero-init
int y = 1;              // static, external, const-exp-init
static int z = 2;       // static, internal

int fun(int v) {
    static int a = 10;  // static, in block
    int b = -4;         // automatic, in block
    return v + a - b;
}

int main() {
    cout << "Holy shit!" << endl;
    return 0;
}
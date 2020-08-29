#include <iostream>
using namespace std;

int main() {
    int x;
    auto r = scanf("%d", &x);
    cout << r << " <- scanf | input -> " << x << endl;
    return 0;
}
#include <iostream>
using namespace std;

int main() {
    int xs[] = {1,2,3,4,5};
    xs[0] = xs[0] << 2;
    for (auto i : xs)
        cout << i << " ";
    cout << endl;
    return 0;
}
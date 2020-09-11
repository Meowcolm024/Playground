#include <iostream>
using namespace std;

void swap(int &x, int &y) {
    int tmp = x;
    x = y;
    y = tmp;
}

int main() {
    int xs[] = {1,2,3,4,5};
    swap(xs[1], xs[3]);
    for (auto i : xs)
        cout << i << " ";
    cout << endl;
    return 0;
}
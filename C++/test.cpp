#include "fp.hpp"
#include <iostream>
#include <vector>

using namespace std;

int main() {
    vector<int> a(5);
    int xs[] = {1,2,3,4,5};
    for (auto i : xs)
        a.push_back(i);
    cout << a.size() << endl;
    return 0;
}
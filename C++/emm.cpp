#include <iostream>
using namespace std;

int main()
{
    int x = 100;
    auto add = [x]() { return x + 1; };

    cout << add() << endl;
    return 0;
}

#include <iostream>
#include "Stack.h"

using namespace std;
using stack::Stack;

int main()
{
    Stack *st = new Stack();
    int xs[] = {1, 2, 3, 4, 5};

    for (int x : xs)
        (*st) << x;

    for (int i = 0; i < 3; i++)
        cout << st->pop() << " ";
    cout << endl;

    delete st;
    return 0;
}
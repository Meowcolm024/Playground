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

    cout << "Stack stze: " << st->getSize() << endl;
    cout << "Item at #2: " << (*st)[2] << endl;
    cout << "Full stack: " << (*st) << endl;

    for (int i = 0; i < 3; i++)
        cout << st->pop() << " ";
    cout << endl;

    auto copied = st->copy();

    delete st;

    cout << "Still here! Size: " << copied.getSize() << endl;

    return 0;
}

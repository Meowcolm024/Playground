#include <iostream>
#include "Stack.hpp"

using namespace std;
using stack::Stack;

int main()
{
    Stack<int> *st = new Stack<int>();
    int xs[] = {1, 2, 3, 4, 5};
    double ys[] = {2.3,4.5,8.9,6.8,9.0};
    Stack<double> gg(ys, 5);

    for (int x : xs)
        (*st) << x;

    cout << "Stack stze: " << st->getSize() << endl;
    cout << "Item at #2: " << (*st)[2] << endl;
    // cout << "Full stack: " << (*st) << endl;

    for (int i = 0; i < 3; i++)
        cout << st->pop() << " ";
    cout << endl;

    auto copied = st->copy();

    Stack<double> haha;
    haha = gg;

    // Stack<double> emm(gg);
 
    delete st;

    cout << "Still here! Size: " << copied.getSize() << endl;

    return 0;
}

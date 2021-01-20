#include <iostream>
#include "queue.h"

int main()
{
    using namespace std;
    Queue q(10);
    q.enqueue(10);
    q.enqueue(20);
    int x;
    q.dequeue(x);
    cout << x << endl;
    return 0;
}
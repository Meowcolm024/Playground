#include "queue.h"

Queue::Queue(int qs) : qsize(qs)
{
    front = rear = 0;
    items = 0;
}

Queue::~Queue()
{
    Node *temp;
    while (front)
    {
        temp = front;
        front = front->next;
        delete front;
    }
}

bool Queue::enqueue(const Item &val)
{
    if (isFull())
        return false;
    Node *add = new Node;
    add->item = val;
    add->next = 0;
    items++;
    if (!front)
        front = add;
    else
        rear->next = add;
    rear = add;
    return true;
}

bool Queue::dequeue(Item &val)
{
    if (!front)
        return false;
    val = front->item;
    items--;
    Node *temp = front;
    front = front->next;
    delete temp;
    if (items == 0)
        rear = 0;
    return true;
}

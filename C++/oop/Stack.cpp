#include <iostream>
#include "Stack.h"

using namespace stack;

Stack::Stack(void)
{
    vals = 0;
}

Stack::Stack(int *items, int n)
{
    for (int i = 0; i < n; i++)
    {
        Node *v = new Node;
        v->setNode(items[i], vals);
        vals = v;
    }
}

Stack::~Stack()
{
    if (!vals)
        return;
    Node *i = vals;
    while (i)
    {
        Node *j = i;
        std::cout << "Cleaning: " << j->val << std::endl;
        delete j;
        i = i->next;
    }
}

void Stack::push(int item)
{
    Node *t = new Node;
    t->setNode(item, vals);
    vals = t;
}

void Stack::operator<<(int i)
{
    push(i);
}

int Stack::pop()
{
    if (!vals)
        return 0;
    auto x = vals->val;
    vals = vals->next;
    return x;
}

int Stack::top() const
{
    if (!vals)
        return 0;
    return vals->val;
}

bool Stack::isEmpty() const
{
    return (!vals);
}

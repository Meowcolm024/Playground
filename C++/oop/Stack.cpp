#include <iostream>
#include "Stack.h"

namespace stack
{
    void Node::setNode(int v, Node *n)
    {
        this->val = v;
        this->next = n;
    }

    std::ostream &operator<<(std::ostream &os, const Node &n)
    {
        if (!(n.next))
            os << n.val;
        else
            os << n.val << " " << (*n.next);
        return os;
    }

    Stack::Stack(void)
    {
        vals = 0;
        size = 0;
    }

    Stack::Stack(int *items, int n)
    {
        size = n;
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
        size++;
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
        size--;
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

    int Stack::getSize() const
    {
        return size;
    }

    Stack Stack::copy() const
    {
        Stack st = Stack();
        if (isEmpty())
            return st;
        else
        {
            Node *t = vals;
            int *tmp = new int[size];
            for (int i = 0; i < size; i++)
            {
                tmp[i] = t->val;
                t = t->next;
            }
            for (int i = size - 1; i >= 0; i--)
                st.push(tmp[i]);
            delete[] tmp;
            return st;
        }
    }

    int Stack::operator[](int i) const
    {
        if (i >= size)
            return 0;
        Node *n = vals;
        for (int j = 0; j < i; j++)
            n = n->next;
        return n->val;
    }

    std::ostream &operator<<(std::ostream &os, const Stack &st)
    {
        if (!st.isEmpty())
            os << (*st.vals);
        else
            os << "(empty stack)";
        return os;
    }
} // namespace stack

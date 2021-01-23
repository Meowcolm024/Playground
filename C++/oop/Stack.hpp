#ifndef STACK_HPP_
#define STACK_HPP_

#include <iostream>

namespace stack
{
    template <class a>
    class Node
    {
    public:
        a val;
        Node *next;

        Node(a v, Node<a> *n);
        ~Node();
        friend std::ostream &operator<<(std::ostream &os, const Node<a> &n);
    };

    template <class a>
    class Stack
    {
    private:
        Node<a> *vals;
        int size;

    public:
        Stack();
        Stack(a *, int);
        Stack(const Stack<a> &);
        ~Stack();

        void push(const a &);
        void operator<<(const a &);
        a pop();

        const a top() const;
        bool isEmpty() const;
        int getSize() const;
        Stack<a> copy() const;
        a operator[](int) const;
        Stack<a> &operator=(const Stack<a> &);

        friend std::ostream &operator<<(std::ostream &os, const Stack<a> &st);
    };

    template <class a>
    Node<a>::Node(a v, Node<a> *n)
    {
        this->val = v;
        this->next = n;
    }

    template <class a>
    Node<a>::~Node()
    {
        // std::cout << "delete: " << val << std::endl;
        if (next)
            delete next;
    }

    template <class a>
    std::ostream &operator<<(std::ostream &os, const Node<a> &n)
    {
        if (!(n.next))
            os << n.val;
        else
            os << n.val << " " << (*n.next);
        return os;
    }

    template <class a>
    Stack<a>::Stack()
    {
        vals = 0;
        size = 0;
    }

    template <class a>
    Stack<a>::Stack(a *items, int n)
    {
        size = n;
        for (int i = 0; i < n; i++)
        {
            Node<a> *v = new Node<a>(items[i], vals);
            vals = v;
        }
    }

    template <class a>
    Stack<a>::Stack(const Stack<a> &st)
    {
        vals = 0;
        size = 0;

        if (st.isEmpty())
            return;

        Node<a> *tmp = st.vals;
        while (tmp)
        {
            Node<a> *v = new Node<a>(tmp->val, vals);
            vals = v;
            tmp = tmp->next;
        }
    }

    template <class a>
    Stack<a>::~Stack()
    {
        if (vals)
            delete vals;
    }

    template <class a>
    void Stack<a>::push(const a &item)
    {
        Node<a> *t = new Node<a>(item, vals);
        vals = t;
        size++;
    }

    template <class a>
    void Stack<a>::operator<<(const a &i)
    {
        push(i);
    }

    template <class a>
    a Stack<a>::pop()
    {
        if (!vals)
            return 0;
        auto x = vals->val;
        vals = vals->next;
        size--;
        return x;
    }

    template <class a>
    const a Stack<a>::top() const
    {
        if (!vals)
            return 0;
        return vals->val;
    }

    template <class a>
    bool Stack<a>::isEmpty() const
    {
        return (!vals);
    }

    template <class a>
    int Stack<a>::getSize() const
    {
        return size;
    }

    template <class a>
    Stack<a> Stack<a>::copy() const
    {
        Stack st = Stack();
        if (isEmpty())
            return st;
        else
        {
            Node<a> *t = vals;
            a *tmp = new a[size];
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

    template <class a>
    a Stack<a>::operator[](int i) const
    {
        if (i >= size)
            return 0;
        Node<a> *n = vals;
        for (int j = 0; j < i; j++)
            n = n->next;
        return n->val;
    }

    template <class a>
    Stack<a> &Stack<a>::operator=(const Stack<a> &st)
    {
        if (this == &st)
            return *this;

        if (vals)
            delete vals;

        size = 0;
        vals = 0;

        Node<a> *t = st.vals;
        a *tmp = new a[st.size];
        for (int i = 0; i < st.size; i++)
        {
            tmp[i] = t->val;
            t = t->next;
        }
        for (int i = st.size - 1; i >= 0; i--)
            push(tmp[i]);
        delete[] tmp;

        return *this;
    }

    template <class a>
    std::ostream &operator<<(std::ostream &os, const Stack<a> &st)
    {
        if (!st.isEmpty())
            os << (*st.vals);
        else
            os << "(empty stack)";
        return os;
    }

    template class Node<int>;
    template class Stack<int>;

} // namespace stack

#endif
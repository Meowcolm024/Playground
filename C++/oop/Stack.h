#ifndef STACK_H_
#define STACK_H_

#include <iostream>

namespace stack
{
    struct Node
    {
        int val;
        Node *next;

        void setNode(int v, Node *n);
    };

    class Stack
    {
    private:
        Node *vals;
        int size;

    public:
        Stack();
        Stack(int *, int);
        ~Stack();

        void push(int);
        void operator<<(int);
        int pop();

        int top() const;
        bool isEmpty() const;
        int getSize() const;
        Stack copy() const;
        int operator[](int) const;
        
        friend std::ostream & operator<<(std::ostream & os, const Stack & st);
    };

} // namespace stack

#endif
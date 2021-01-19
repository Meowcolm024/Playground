#ifndef STACK_H_
#define STACK_H_

namespace stack
{
    struct Node
    {
        int val;
        Node *next;

        void setNode(int v, Node *n)
        {
            this->val = v;
            this->next = n;
        }
    };

    class Stack
    {
    private:
        Node *vals;

    public:
        Stack();
        Stack(int *, int);
        ~Stack();
        void push(int);
        void operator<<(int);
        int pop();
        int top() const;
        bool isEmpty() const;
    };
} // namespace stack

#endif
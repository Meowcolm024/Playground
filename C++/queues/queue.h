#ifndef QUEUE_H_
#define QUEUE_H_

typedef int Item;

class Queue
{
private:
    struct Node
    {
        Item item;
        Node *next;
    };
    enum
    {
        Q_SIZE = 10
    };
    Node *front;
    Node *rear;
    int items;
    const int qsize;

    Queue(const Queue &q) : qsize(0){};
    Queue &operator=(const Queue &q) { return *this; };

public:
    Queue(int qs = Q_SIZE);
    ~Queue();

    bool isEmpty() const { return items == 0; };
    bool isFull() const { return items == qsize; };
    int count() const;
    bool enqueue(const Item &);
    bool dequeue(Item &);
};

#endif
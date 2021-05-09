#include <iostream>
#include <memory>
#include <optional>

class Node
{
private:
    int value;
    std::optional<std::unique_ptr<Node> > next;

public:
    Node(int v)
    {
        value = v;
        next = std::nullopt;
    }
    Node(int v, std::unique_ptr<Node> n)
    {
        value = v;
        next = std::optional<std::unique_ptr<Node> >(std::move(n));
    }
    std::optional<std::unique_ptr<Node> > get_next()
    {
        if (!next)
        {
            return std::nullopt;
        }
        else
        {
            auto tmp = std::move(next.value());
            next = std::nullopt;
            return std::optional<std::unique_ptr<Node> >(std::move(tmp));
        }
    }
    int val()
    {
        return value;
    }
};

class Stack
{
private:
    std::optional<std::unique_ptr<Node> > nodes;
    int length;

public:
    Stack()
    {
        nodes = std::nullopt;
        length = 0;
    }

    void push(int v)
    {
        if (!nodes)
        {
            nodes = std::optional<std::unique_ptr<Node> >(std::unique_ptr<Node>(new Node(v)));
        }
        else
        {
            auto tmp = std::move(nodes.value());
            nodes = std::optional<std::unique_ptr<Node> >(std::unique_ptr<Node>(new Node(v, std::move(tmp))));
        }
        length++;
    }

    std::optional<int> pop()
    {
        if (!nodes)
        {
            length--;
            return std::nullopt;
        }
        else
        {
            length--;
            auto tmp = nodes.value()->val();
            nodes = nodes.value()->get_next();
            return std::optional<int>(tmp);
        }
    }

    int size() const
    {
        return length;
    }
};

int main()
{
    Stack test = Stack();
    test.push(10);
    test.push(20);
    test.push(30);
    std::cout << test.size() << std::endl;
    std::cout << test.pop().value() << std::endl;
    std::cout << test.pop().value() << std::endl;
    std::cout << test.size() << std::endl;
    return 0;
}
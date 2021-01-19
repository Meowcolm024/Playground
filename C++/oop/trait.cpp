#include <iostream>

class Show
{
public:
    virtual ~Show();
    virtual void show();
};

template <class T>
class Box : Show
{
private:
    T val;

public:
    Box(T v)
    {
        val = v;
    };
    ~Box(){};
    T getVal()
    {
        return val;
    }
    virtual void show()
    {
        std::cout << val;
    }
};

typedef Box<int> boxInt;

int main()
{
    using namespace std;

    auto a = Box<int>(10);
    auto b = Box<string>("hello");

    a.show();
    b.show();

    cout << endl;
    return 0;
}
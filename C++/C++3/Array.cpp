#include <iostream>
#include <cstdlib>

using namespace std;

template <class T>
class IShow
{
public:
    virtual void show() const
    {
        cout << "A humble IShow object :D" << endl;
    }
};

template <class T>
class Array : public IShow<T>
{
private:
    T *arr;
    int len;

public:
    Array()
    {
        arr = nullptr;
        len = 0;
    }
    explicit Array(int le)
    {
        arr = new T[le];
        for (int i = 0; i < le; i++)
            arr[i] = nullptr;
        len = le;
    }
    Array(const T ar[], int le)
    {
        arr = new T[le];
        for (int i = 0; i < le; i++)
            arr[i] = ar[i];
        len = le;
    }
    Array(const Array<T> &ar)
    {
        arr = new T[ar.length()];
        for (int i = 0; i < ar.length(); i++)
            arr[i] = ar[i];
        len = ar.length();
    }
    ~Array()
    {
        delete arr;
    }
    int length() const
    {
        return len;
    }
    const T &operator[](int i) const
    {
        if (i < 0 || i >= len)
        {
            std::cerr << "Index out of range.\n";
            std::exit(EXIT_FAILURE);
        }
        return arr[i];
    }
    T &operator[](int i)
    {
        if (i < 0 || i >= len)
        {
            std::cerr << "Index out of range.\n";
            std::exit(EXIT_FAILURE);
        }
        return arr[i];
    }
    Array<T> &operator=(const Array<T> &ar)
    {
        if (this == &ar)
            return *this;
        delete arr;
        arr = new T[ar.length()];
        len = ar.length();
        for (int i = 0; i < ar.length(); i++)
            arr[i] = ar[i];
        return *this;
    }
    virtual void show() const
    {
        for (int i = 0; i < len; i++)
            cout << arr[i] << " ";
        cout << endl;
    }
};

template <class T>
void print_arr(const IShow<T> &arr)
{
    cout << "Printing an IShow object:" << endl;
    arr.show();
}

int main()
{
    int tmp[] = {1, 2, 3, 4, 5};
    Array<int> arr = Array<int>(tmp, 5);
    print_arr<int>(arr);
    int haha[] = {2, 2, 3, 3, 4, 4};
    arr = Array<int>(haha, 6);
    print_arr<int>(arr);
    return 0;
}

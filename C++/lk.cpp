#include <iostream>
using namespace std;

template <class T>
struct lk
{
    T val;
    lk *next;
};

template <class T>
int len(lk<T> *ls)
{
    if (!ls)
        return 0;
    return (1 + len(ls->next));
}

template <class T, class S>
lk<S> *map(function<S(T)> f, lk<T> *ls)
{
    if (!ls)
        return 0;
    lk<T> *b = new lk<T>;
    b->val = f(ls->val);
    b->next = map(f, ls->next);
    return b;
}

template <class T>
lk<T> *filter(function<bool(T)> f, lk<T> *ls)
{
    if (!ls)
        return 0;
    if (f(ls->val))
    {
        lk<T> *b = new lk<T>;
        b->val = ls->val;
        b->next = filter(f, ls->next);
        return b;
    }
    else
    {
        return filter(f, ls->next);
    }
}

template <class T, class S>
S fold(function<S(T, S)> f, S i, lk<T> *ls)
{
    if (!ls)
        return i;
    return (f(ls->val, fold(f, i, ls->next)));
}

template <class T>
void printlk(lk<T> *ls)
{
    if (!ls)
    {
        cout << endl;
        return;
    }
    cout << ls->val << " ";
    printlk(ls->next);
}

template <class T>
lk<T> *assign(T *a, T *b)
{
    if (a >= b)
        return 0;
    lk<T> *tmp = new lk<T>;
    tmp->val = *a;
    tmp->next = assign(a + 1, b);
    return tmp;
}

template <class T>
T select(int i, lk<T> *ls)
{
    if (!ls)
        return 0;
    if (i == 0)
        return (ls->val);
    return select(i - 1, ls->next);
}

template <class T>
lk<T> *drop(int i, lk<T> *ls)
{
    if (!ls)
        return 0;
    if (i == 0)
        return ls;
    return drop(i - 1, ls->next);
}

template <class T>
lk<T> *take(int i, lk<T> *ls)
{
    if (i == 0 || !ls)
        return 0;
    lk<T> *b = new lk<T>;
    b->val = ls->val;
    b->next = take(i - 1, ls->next);
    return b;
}

int main()
{
    int hello[] = {1, 2, 3, 4, 5};
    lk<int> *x = assign(hello, hello + 5);
    printlk(map<int, int>([](int a) -> int { return a + 1; }, x));
    printlk(filter<int>([](int a) -> bool { return a > 3; }, x));
    cout << fold<int, int>([](int a, int b) -> int { return a + b; }, 0, x) << endl;
    cout << select(3, x) << endl;
    printlk(take(3, x));
    printlk(drop(1, x));
    return 0;
}
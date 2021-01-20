#include <iostream>
using namespace std;

// (.) :: (b -> c) -> (a -> b) -> (a -> c)
template <class a, class b, class c>
function<c(a)> operator*(function<c(b)> g, function<b(a)> f)
{
    return [&f, &g](a x) { return g(f(x)); };
}

// (&) :: a -> (a -> b) -> b
template <class a, class b>
b operator>>(a v, function<b(a)> f)
{
    return f(v);
}

function<int(int)> add1 = [](int x) { return x + 1; };
function<int(int)> mul2 = [](int x) { return x * 2; };
function<int(int)> neg = [](int x) { return -x; };

template <class a>
function<void(a)> show = [](a x) { cout << x << endl; };

int main()
{
    10 >> neg * add1 * mul2 >> show<int>;

    return 0;
}

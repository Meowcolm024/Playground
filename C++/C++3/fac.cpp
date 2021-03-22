#include <iostream>
using namespace std;

template<int N> struct Fib {
    enum {val = Fib<N-1>::val + Fib<N-2>::val};
};

template<> struct Fib<0> {
    enum {val = 0};
};

template<> struct Fib<1> {
    enum {val = 1};
};

template<int X, int Y> struct Add {
    enum {val = Add<X-1,Y+1>::val};
};

template<int Y> struct Add<0, Y> {
    enum {val = Y};
};

template<int X, int Y> struct Sub {
    enum {val = Sub<X-1, Y-1>::val};
};

template<int X> struct Sub<X, 0> {
    enum {val = X};
};

template<int Y> struct Sub<0, Y> {
    enum {val = 0};
};

template<int X, int Y> struct Mult {
    enum {val = X + Mult<X, Y-1>::val};
};

template<int X> struct Mult<X, 1> {
    enum {val = X};
};

template<int X> struct Mult<X, 0> {
    enum {val = 0};
};

int main() {
    cout << Fib<10>::val << endl;
    cout << Add<10, 5>::val << endl;
    cout << Sub<16, 4>::val << endl;
    cout << Mult<10, 8>::val << endl;
    return 0;
}
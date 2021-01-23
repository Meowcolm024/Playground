#ifndef TUPLE_H_
#define TUPLE_H_

template <class a, class b>
class Tuple
{
private:
    a x;
    b y;

public:
    Tuple() : x(0), y(0) {}
    Tuple(a v1, b v2) : x(v1), y(v2) {}

    a first() const { return x; }
    a &first() { return x; }
    b second() const { return y; }
    b &second() { return y; }
};

enum class tag
{
    Left,
    Right
};

template <class T>
class Tuple<tag, T>;

template <>
class Tuple<int, double>;

#endif
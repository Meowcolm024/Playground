#include <iostream>
#include <cstring>
#include "stringbad.h"

using std::cout;

// static member, declare separately outside!
int StringBad::nums = 0;

StringBad::StringBad(const char *s)
{
    len = std::strlen(s);
    str = new char[len + 1];
    std::strcpy(str, s);
    nums++;
    cout << nums << ": \"" << str << "\" created.\n";
}

StringBad::StringBad()
{
    len = 4;
    str = new char[4];
    std::strcpy(str, "C++");
    nums++;
    cout << nums << ": \"" << str << "\" created.\n";
}

StringBad::~StringBad()
{
    cout << "\"" << str << "\" deleted.\n";
    --nums;
    cout << nums << " left.\n";
    delete[] str;
}

StringBad::StringBad(const StringBad &st)
{
    nums++;
    len = st.len;
    str = new char[len + 1];
    std::strcpy(str, st.str);
    cout << nums << ": \"" << str << "\" created.\n";
}

StringBad &StringBad::operator=(const StringBad &st)
{
    if (this == &st)    // check self
        return *this;
    delete[] str;       // delete original str
    len = st.len;
    str = new char[len + 1];
    std::strcpy(str, st.str);
    return *this;
}

std::ostream &operator<<(std::ostream &os, const StringBad &st)
{
    os << st.str;
    return os;
}

#include <iostream>
#include <cstring>
#include "str.h"

using std::cout;

int String::nums = 0;

int String::howMany()
{
    return nums;
}

String::String(const char *s)
{
    len = std::strlen(s);
    str = new char[len + 1];
    std::strcpy(str, s);
    nums++;
    cout << nums << ": \"" << str << "\" created.\n";
}

String::String()
{
    len = 0;
    str = new char[1];
    str[0] = '\0';
    nums++;
}

String::String(const String &st)
{
    nums++;
    len = st.len;
    str = new char[len + 1];
    std::strcpy(str, st.str);
    // cout << nums << ": \"" << str << "\" created.\n";
}

String::~String()
{
    // cout << "\"" << str << "\" deleted.\n";
    --nums;
    // cout << nums << " left.\n";
    delete[] str;
}

int String::length() const
{
    return len;
}

String &String::operator=(const String &st)
{
    if (this == &st) // check self
        return *this;
    delete[] str; // delete original str
    len = st.len;
    str = new char[len + 1];
    std::strcpy(str, st.str);
    return *this;
}

String &String::operator=(const char *s)
{
    delete[] str;
    len = std::strlen(s);
    str = new char[len + 1];
    std::strcpy(str, s);
    return *this;
}

const char &String::operator[](int i) const // the const version
{
    return str[i];
}

char &String::operator[](int i) // the muting version
{
    return str[i];
}

std::ostream &operator<<(std::ostream &os, const String &st)
{
    os << st.str;
    return os;
}

std::istream &operator>>(std::istream &is, String &st)
{
    char temp[String::cinlen];
    is.get(temp, String::cinlen);
    if (is)
        st = temp;
    while (is && is.get() != '\n')
        continue;
    return is;
}

bool operator<(const String &st1, const String &st2)
{
    return std::strcmp(st1.str, st2.str) < 0;
}

bool operator>(const String &st1, const String &st2)
{
    return st2 < st1;
}

bool operator==(const String &st1, const String &st2)
{
    return std::strcmp(st1.str, st2.str) == 0;
}

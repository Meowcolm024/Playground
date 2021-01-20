#ifndef STR_H_
#define STR_H_

#include <iostream>

class String
{
private:
    char *str;
    int len;
    static int nums;
    static const int cinlen = 80;   //cin limit

public:
    String();
    String(const char *s);
    String(const String &);
    ~String();

    int length() const;

    String &operator=(const String &);
    String &operator=(const char *);
    const char &operator[](int) const;
    char &operator[](int);

    static int howMany();

    friend std::ostream &operator<<(std::ostream &, const String &);
    friend std::istream &operator>>(std::istream &, String &);
    friend bool operator<(const String &, const String &);
    friend bool operator>(const String &, const String &);
    friend bool operator==(const String &, const String &);
};

#endif
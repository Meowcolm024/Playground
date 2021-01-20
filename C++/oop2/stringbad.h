#ifndef STRINGBAD_H_
#define STRINGBAD_H_

#include <iostream>

class StringBad
{
private:
    char *str;
    int len;
    static int nums; // share by all

public:
    StringBad();
    StringBad(const char *s);
    ~StringBad();

    StringBad(const StringBad &);   // fix issue (copy constructor)

    StringBad & operator=(const StringBad &); //fix issue (assignment op)

    friend std::ostream &operator<<(std::ostream &, const StringBad &);
};

#endif
#ifndef STUDENTI_H_
#define STUDENTI_H_

#include <iostream>
#include <string>
#include <valarray>

class Student : private std::string, private std::valarray<double>
{
private:
    typedef std::valarray<double> ArrayDb;
    std::ostream &arrOut(std::ostream &os) const;

public:
    Student() : std::string("Null Student"), ArrayDb() {}
    explicit Student(const std::string &s) : std::string(s), ArrayDb() {}
    explicit Student(int n) : std::string("Nully"), ArrayDb(n) {}
    Student(const std::string &s, int n) : std::string(s), ArrayDb(n) {}
    Student(const std::string &s, const ArrayDb &a) : std::string(s), ArrayDb(a) {}
    Student(const char *str, const double *pd, int n) : std::string(str), ArrayDb(pd, n) {}

    ~Student() {}

    double Average() const;
    const std::string &Name() const;
    double &operator[](int);
    double operator[](int) const;

    // * turn private base method into public method of this
    using ArrayDb::max;
    using ArrayDb::min;

    friend std::istream &operator>>(std::istream &, Student &);
    friend std::istream &getline(std::istream &, Student &);
    friend std::ostream &operator<<(std::ostream &, const Student &);
};

#endif
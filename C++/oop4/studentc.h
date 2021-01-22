#ifndef STUDENTC_H_
#define STUDENTC_H_

#include <iostream>
#include <string>
#include <valarray>

class Student
{
private:
    typedef std::valarray<double> ArrayDb;
    std::string name;
    ArrayDb scores;
    std::ostream &arrOut(std::ostream &os) const;

public:
    Student() : name("Null Student"), scores() {}
    explicit Student(const std::string &s) : name(s), scores() {}
    explicit Student(int n) : name("Nully"), scores(n) {}
    Student(const std::string &s, int n) : name(s), scores(n) {}
    Student(const std::string &s, const ArrayDb &a) : name(s), scores(a) {}
    Student(const char *str, const double *pd, int n) : name(str), scores(pd, n) {}

    ~Student() {}

    double Average() const;
    const std::string &Name() const;
    double &operator[](int);
    double operator[](int) const;

    friend std::istream &operator>>(std::istream &, Student &);
    friend std::istream &getline(std::istream &, Student &);
    friend std::ostream &operator<<(std::ostream &, const Student &);
};

#endif
#include <iostream>
#include <string>
#include "person.h"

using std::cout;

Person::Person(std::string &fn, std::string &ln, int a)
{
    fname = fn;
    lname = ln;
    age = a;
}

Person::~Person() {}

void Person::showInfo()
{
    cout << "Person: " << fname << ", " << lname;
    cout << "\nAge: " << age << "\n";
}

GoodPerson::GoodPerson(std::string &fn, std::string &ln, int a, std::string &loc, int inc)
    : Person(fn, ln, a), location(loc), income(inc) {}

GoodPerson::GoodPerson(std::string &loc, int inc, const Person &p)
    : Person(p) // ! base class copy constructor
{
    location = loc;
    income = inc;
}

void GoodPerson::changeLocation(std::string& n)
{
    location = n;
}

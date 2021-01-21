#ifndef PERSON_H_
#define PERSON_H_

#include <string>

class Person
{
private:
    std::string fname;
    std::string lname;
    int age;
public:
    Person(std::string&, std::string&, int);
    ~Person();
    void showInfo();
};

class GoodPerson: public Person
{
private:
    std::string location;
    int income;
public:
    GoodPerson(std::string&, std::string&, int, std::string&, int);
    GoodPerson(std::string&, int, const Person&);   // ! use base class copy constructor
    void changeLocation(std::string&);
    // void showInfo();
};

#endif
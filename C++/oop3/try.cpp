#include <iostream>
#include <string>
#include "person.h"

int main()
{
    using namespace std;

    string fn = "Jack";
    string ln = "Tian";
    string fn2 = "Tom";
    string ln2 = "Jerry";
    string loc = "Island";
    string loc2 = "City";

    Person a = Person(fn ,ln, 20);
    GoodPerson b = GoodPerson(fn2, ln2, 10, loc, 10000);
    GoodPerson c = GoodPerson(loc2, 2500000, a);

    Person *p = &b; // pointer of base class to child class
    // GoodPerson *g = &a; ! not allowed

    a.showInfo();
    b.showInfo();
    p->showInfo();  // only base class method

    cout << p << " " << &b << endl;

    return 0;
}
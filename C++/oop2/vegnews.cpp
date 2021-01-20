#include <iostream>
#include "stringbad.h"

void callme1(StringBad &);
void callme2(StringBad);

using std::cout;

int main()
{
    using std::endl;
    {
        cout << "Starting an inner block.\n";

        StringBad headline1("Celery Stalks at Midnight");
        StringBad headline2("Lettuce Prey");
        StringBad sports("Spinach Leaves Bowl for Dollars");

        cout << "headline1: " << headline1 << endl;
        cout << "headline2: " << headline2 << endl;
        cout << "sports: " << sports << endl;

        callme1(headline1);
        cout << "headline1: " << headline1 << endl;

        callme2(headline2);
        cout << "headline2: " << headline2 << endl;

        cout << "Initialize\n";
        StringBad sailor = sports;
        cout << "sailor: " << sailor << endl;

        cout << "assign one to another\n";

        StringBad knot;
        knot = headline1;

        cout << "knot: " << knot << endl;
        cout << "bye block\n";
    }
    cout << "bye main\n";
}

void callme1(StringBad &rsb)
{
    cout << "ref: \"" << rsb << "\"\n";
}

void callme2(StringBad sb)
{
    cout << "val: \"" << sb << "\"\n";
}

#include <iostream>
#include <cstdlib>
#include <ctime>
#include "vect.h"

using namespace std;
using vec::Vector;

int main()
{
    srand(time(0));
    double direction;
    Vector step;
    Vector result(0, 0);
    unsigned long steps = 0;
    double target;
    double dstep;

    cout << "Enter target distance (q to quit): ";
    while (cin >> target)
    {
        cout << "Enter step length: ";
        if (!(cin >> dstep))
            break;
        
        while (result.magVal() < target)
        {
            direction = (rand() % 360) / (2*3.14159265);
            step.reset(dstep, direction, Vector::Mode::POL);
            result = result + step;
            steps ++;
        }

        cout << "After " << steps << " steps, he arrived [" << result << "] or [";
        result.polMode();
        cout << result << "]!\n";
        steps = 0;
        result.reset(0, 0);
        cout << "Enter target distance (q to quit): ";
    }

    cout << "Bye!" << endl;
    cin.clear();

    return 0;
}
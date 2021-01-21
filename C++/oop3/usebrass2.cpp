#include <iostream>
#include <string>
#include "brass.h"

const int CLIENTS = 4;

using namespace std;

int main()
{
    Brass *p_clients[CLIENTS];
    string temp;
    long temp_num;
    double temp_val;
    char kind;

    for (int i = 0; i < CLIENTS; i++)
    {
        cout << "Enter name: ";
        getline(cin, temp);
        cout << "Enter id: ";
        cin >> temp_num;
        cout << "Enter balance $";
        cin >> temp_val;
        cout << "Enter 1 for Brass, 2 for BrassPlus: ";
        while (cin >> kind && (kind != '1' && kind != '2'))
            cout << "Enter 1 for Brass, 2 for BrassPlus: ";
        if (kind == '1')
            p_clients[i] = new Brass(temp, temp_num, temp_val);
        else
        {
            double t_max, t_rate;
            cout << "Enter limit: ";
            cin >> t_max;
            cout << "Enter interest rate (dec frac): ";
            cin >> t_rate;
            p_clients[i] = new BrassPlus(temp, temp_num, temp_val, t_max, t_rate);
        }
        while (cin.get() != '\n')
            continue;
    }

    cout << endl;

    for (auto i : p_clients)
    {
        i->ViewAcct();
        cout << endl;
    }
    for (int i = 0; i < CLIENTS; i++)
        delete p_clients[i];

    cout << "Done.\n";

    return 0;
}
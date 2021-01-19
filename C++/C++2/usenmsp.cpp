#include <iostream>
#include "namesp.h"

void other(void);
void another(void);

int main() {
    using debts::Debt;
    using debts::showDebt;

    Debt golf = {{"Ben", "Fen"}, 120.0};
    showDebt(golf);
    other();
    another();

    return 0;
}

void other(void) {
    using std::cout;
    using std::endl;
    using namespace debts;

    Person dg = {"Dow", "Gop"};
    showPerson(dg);
    cout << endl;

    Debt zippy[3];
    int i;
    for (i = 0; i < 3; i ++)
        getDebt(zippy[i]);
    for (i = 0; i < 3; i++)
        showDebt(zippy[i]);

    cout << "Total: $" << sumDebts(zippy, 3) << endl;
}

void another(void) {
    using pers::Person;
    Person collector = {"Mill", "Pork"};
    pers::showPerson(collector);
    std::cout << "\n";
}
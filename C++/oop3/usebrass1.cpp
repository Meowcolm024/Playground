#include <iostream>
#include "brass.h"

int main()
{
    using std::cout;
    using std::endl;

    Brass Piggy("Piggy", 381299, 4000.00);
    BrassPlus Doge("Doge", 388888, 3000.00);

    Piggy.ViewAcct();
    cout << endl;

    Doge.ViewAcct();
    cout << endl;

    Doge.Deposit(1000.00);
    cout << "Doge new balance: $" << Doge.Balance() << endl;

    Piggy.Withdraw(4200.00);
    cout << "Piggy new balance: $" << Doge.Balance() << endl;

    Doge.Withdraw(4200.00);
    Doge.ViewAcct();

    return 0;
}
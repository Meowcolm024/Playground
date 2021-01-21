#include <iostream>
#include "brass.h"

using std::cout;
using std::endl;
using std::string;

typedef std::ios_base::fmtflags format;
typedef std::streamsize precis;

format setFormat();
void restore(format f, precis p);

Brass::Brass(const std::string &s, long an, double bal)
{
    fullName = s;
    acctNum = an;
    balance = bal;
}

void Brass::Deposit(double amt)
{
    if (amt < 0)
        cout << "Negative deposit. CANCELLED\n";
    else
        balance += amt;
}

void Brass::Withdraw(double amt)
{
    format initialState = setFormat();
    precis prec = cout.precision(2);

    if (amt < 0)
        cout << "Negative withdraw. CNACELLED\n";
    else if (amt <= balance)
        balance -= amt;
    else
        cout << "Withdraw amount $" << amt
             << " > balance. CANCELLED\n";

    restore(initialState, prec);
}

double Brass::Balance() const
{
    return balance;
}

void Brass::ViewAcct() const
{
    format initialState = setFormat();
    precis prec = cout.precision(2);

    cout << "Client: " << fullName << endl;
    cout << "Acct number: " << acctNum << endl;
    cout << "Balance: $" << balance << endl;

    restore(initialState, prec);
}

BrassPlus::BrassPlus(const std::string &s, long an,
                     double bal, double m1, double r) : Brass(s, an, bal)
{
    maxLoan = m1;
    owesBank = 0.0;
    rate = r;
}

BrassPlus::BrassPlus(const Brass &ba, double m1, double r) : Brass(ba)
{
    maxLoan = m1;
    owesBank = 0.0;
    rate = r;
}

void BrassPlus::ViewAcct() const
{
    format initialState = setFormat();
    precis prec = cout.precision(2);

    Brass::ViewAcct();
    cout << "Max loan: $" << maxLoan << endl;
    cout << "Owed to bank: $" << owesBank << endl;
    cout.precision(3);
    cout << "Loan rate: " << 100 * rate << "%\n";

    restore(initialState, prec);
}

void BrassPlus::Withdraw(double amt)
{
    format initialState = setFormat();
    precis prec = cout.precision(2);

    double bal = Balance();
    if (amt <= bal)
        Brass::Withdraw(amt);
    else if (amt <= bal + maxLoan - owesBank)
    {
        double advance = amt - bal;
        owesBank += advance * (1.0 + rate);
        cout << "Bank advance: $" << advance << endl;
        cout << "Charge: $" << advance * rate << endl;
        Deposit(advance);
        Brass::Withdraw(amt);
    }
    else
        cout << "Credit exceeded. CANCELLED\n";

    restore(initialState, prec);
}

format setFormat()
{
    return cout.setf(std::ios_base::fixed, std::ios_base::floatfield);
}

void restore(format f, precis p)
{
    cout.setf(f, std::ios_base::floatfield);
    cout.precision(p);
}

#include <iostream>
using namespace std;

const int LEAP[] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
const int NOT_LEAP[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

struct Date
{
    int year;
    int month;
    int day;
};

bool is_leap(int n)
{
    return (n % 4 == 0 && n % 100 != 0) || n % 400 == 0;
}

int year_len(int y)
{
    return is_leap(y) ? 366 : 365;
}

int days(Date d)
{
    // years
    int acc = 0;
    for (int i = 1; i < d.year; i++)
        acc += year_len(i);
    // months
    if (is_leap(d.year))
    {
        for (int i = 0; i < d.month - 1; i++)
            acc += LEAP[i];
    }
    else
    {
        for (int i = 0; i < d.month - 1; i++)
            acc += NOT_LEAP[i];
    }
    // days
    acc += d.day;
    return acc;
}

int date_delta(Date d1, Date d2)
{
    return days(d1) - days(d2);
}

int main()
{
    Date dates[2];
    for (int i = 0; i < 2; i++)
    {
        int ymd;
        cout << "Input a date: ";
        cin >> ymd;
        int md = ymd % 10000;
        int y = (ymd - md) / 10000;
        int d = md % 100;
        int m = (md - d) / 100;
        dates[i] = {y, m, d};
    }

    cout << date_delta(dates[1], dates[0]) << endl;

    return 0;
}
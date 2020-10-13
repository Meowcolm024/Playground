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
    string str_ymd[2];
    cout << "Input a date: ";
    cin >> str_ymd[0];
    cout << "Input another date: ";
    cin >> str_ymd[1];

    int ymd[2][8];
    for (int i = 0; i < 2; i++)
        for (int j = 0; j < 8; j++)
            ymd[i][j] = int(str_ymd[i][j]) - 48;

    Date dates[2];
    for (int i = 0; i < 2; i++)
    {
        int y = 0;
        for (int p = 0; p < 4; p++)
            y += ymd[i][p] * pow(10, (3 - p));
        int m = 0, d = 0;
        for (int p = 4; p < 6; p++)
        {
            m += ymd[i][p] * pow(10, (5 - p));
            d += ymd[i][p + 2] * pow(10, (5 - p));
        }
        dates[i] = {y, m, d};
    }

    cout << date_delta(dates[1], dates[0]) << endl;

    return 0;
}
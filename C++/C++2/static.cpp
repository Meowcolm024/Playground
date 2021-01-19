#include <iostream>

const int Arsize = 10;

void strcount(const char *str);

int main()
{
    using namespace std;
    char input[Arsize];
    char next;
    cout << "Enter a line:\n";
    cin.get(input, Arsize);
    while (cin)
    {
        cin.get(next);
        while (next != '\n')
            cin.get(next);
        strcount(input);
        cout << "Enter next line:\n";
        cin.get(input, Arsize);
    }
    cout << "Bye\n";
    return 0;
}

void strcount(const char *str)
{
    using namespace std;
    static int total = 0;
    int count = 0;
    cout << "\"" << str << "\" contains ";
    while (*str++)
        count++;
    total += count;
    cout << count << " chars\n";
    cout << total << " in total.\n";
}

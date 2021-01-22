#include <iostream>
#include "studentc.h"
// #include "studenti.h"

using namespace std;

void set(Student &sa, int n);

const int pupils = 3;
const int quizzes = 5;

int main()
{
    Student ada[pupils] =
        {Student(quizzes), Student(quizzes), Student(quizzes)};

    int i;

    for (i = 0; i < pupils; ++i)
        set(ada[i], quizzes);

    cout << "\nStudent List:\n";
    for (auto i : ada)
        cout << i.Name() << endl;

    cout << "\nREsults:\n";
    for (auto i : ada)
    {
        cout << endl
             << i;
        cout << "average: " << i.Average() << endl;
    }

    cout << "Done.\n";

    return 0;
}

void set(Student &sa, int n)
{
    cout << "Enter name: ";
    getline(cin, sa);
    cout << "Enter " << n << " quizz score:\n";
    for (int i = 0; i < n; i++)
        cin >> sa[i];
    while (cin.get() != '\n')
        continue;
}

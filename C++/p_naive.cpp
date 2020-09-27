#include <iostream>
using namespace std;

int main()
{
    int i = 2;
    while (i < 100)
    {
        bool is_prime = true;
        int j = 2;
        while (j < i)
        {
            if (i % j == 0)
            {
                is_prime = false;
                break;
            }
            j = j + 1;
        }
        if (is_prime)
            cout << i << endl;
        i = i + 1;
    }
    return 0;
}
#include <iostream>
using namespace std;
const int MAX = 1e8;
bool ps[MAX];

int main()
{
    ps[0] = false;
    ps[1] = false;
    for (int i = 2; i < MAX; i++)
        ps[i] = true;

    for (int s = 2; s < MAX; s++)
        if (ps[s])
            for (int i = s + s; i < MAX; i += s)
                ps[i] = false;

    int acc = 0;
    for (int i = 0; i < MAX; i++)
        if (ps[i])
            acc++;
    cout << acc << endl;

    return 0;
}
#include <iostream>
using namespace std;
const int64_t MAX = 1e8;
bool ps[MAX];

int main()
{
    ps[0] = false;
    ps[1] = false;
    for (int64_t i = 2; i < MAX; i++)
        ps[i] = true;

    for (int64_t s = 2; s < MAX; s++)
        if (ps[s])
            for (int64_t i = s + s; i < MAX; i += s)
                ps[i] = false;

    int64_t acc = 0;
    for (int64_t i = 0; i < MAX; i++)
        if (ps[i])
            acc++;
    cout << acc << endl;

    return 0;
}
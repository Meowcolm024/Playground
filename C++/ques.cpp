#include <iostream>
#include <stdlib.h> /* srand, rand */
#include <time.h>   /* time */
#include <thread>

using namespace std;

const long MAX = 1e7;
long chance1 = 0;
long chance2 = 0;

void test(long &chance)
{
    // srand(time(NULL));
    for (int i = 0; i < MAX; i++)
    {
        int acc[] = {0, 0, 0};
        for (int j = 0; j < 30; j++)
        {
            int x = rand() % 20;
            if (x < 3)
            {
                acc[x]++;
            }
        }
        int t = 0;
        for (int a : acc)
            t += a;
        if (t == 0)
            chance++;
    }
}

int main()
{
    srand(time(NULL));

    thread t1(test, ref(chance1));
    thread t2(test, ref(chance2));

    t1.join();
    t2.join();


    cout << chance1 << " " << chance2 << endl;

    return 0;
}
#include <iostream>
#include <stdlib.h> /* srand, rand */
#include <time.h>   /* time */
#include <thread>

using namespace std;

const long MAX = 1e8;
long chance1 = 0;
long chance2 = 0;

void test(long &chance)
{
    srand(time(NULL));
    for (int i = 0; i < MAX; i++)
    {
        bool acc[10];
        for (int j = 0; j < 10; j++)
            acc[j] = true;
        for (int j = 0; j < 20; j++)
        {
            int x = rand() % 10;
            acc[x] = false;
        }
        for (bool a : acc)
        {
            if (a)
            {
                // cout << i << endl;
                chance++;
                break;
            }
        }
    }
}

int main()
{
    // srand(time(NULL));

    thread t1(test, ref(chance1));
    thread t2(test, ref(chance2));

    t1.join();
    t2.join();

    // test(chance1);

    cout << chance1 << " " << chance2 << endl;

    return 0;
}
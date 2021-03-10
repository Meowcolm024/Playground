#include <iostream>
#include <new>

char buffer0[4];
char buffer1[16];
char buffer2[16];

using namespace std;

int main()
{
    short *p1, *p2;
    p1 = new (buffer0) short[16];
    p2 = new short[16];
    for (int i = 0; i < 16; i++)
    {
        p1[i] = i;
        p2[i] = i;
    }

    cout << (void *)buffer0 << endl;
    cout << (void *)buffer1 << endl;
    cout << "-----------" << endl;

    for (int i = 0; i < 16; i++)
        cout << &p1[i] << " " << &p2[i] << endl;

    for (int i = 0; i < 16; i++)
        cout << (int)buffer0[i] << " ";
    cout << endl;
    for (int i = 0; i < 16; i++)
        cout << (int)buffer1[i] << " ";
    cout << endl;

    int *p3, *p4;
    p3 = new (buffer2) int[4];
    for (int i : {0,1,2,3})
        p3[i] = i;
    for (int i : {0,1,2,3})
        cout << p3[i] << " ";
    cout << endl;

    p4 = new (buffer2) int[4];
    for (int i : {0,1,2,3}) // overwrite p3's content
        p4[i] = i*10;
    for (int i : {0,1,2,3})
        cout << p3[i] << " ";
    cout << endl;

    // don't need to delete p1, p3, p4!
    delete[] p2;

    return 0;
}
#include <iostream>

using namespace std;

void swap (int &a, int &b)
{
    int t = a;
    a = b;
    b = t;
}

int part(int *arr, int p, int r)
{
    int x = arr[r];
    int i = p - 1;

    for (int j = p; j < r; j++)
    {
        if (arr[j] >= x)
        {
            i += 1;

            swap(arr[i], arr[j]);
        }
    }

    swap(arr[i+1], arr[r]);

    return i+1;
}

void qsort(int *arr, int p, int r)
{
    if (p >= r)
        return;

    int q = part(arr, p, r);

    qsort(arr, p, q-1);
    qsort(arr, q+1, r);
}

int main() {

    int arr[] = {1,5,4,9,3,0,7,6,2,8};

    cout << "Before: ";
    for (auto i : arr)
        cout << i << " ";
    cout << endl;

    qsort(arr, 0, 9);

    cout << "After:  ";
    for (auto i : arr)
        cout << i << " ";
    cout << endl;
    
    return 0;
}
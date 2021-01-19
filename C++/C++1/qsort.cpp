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

    for (int j = p; j < r; j++)
    {
        if (arr[j] >= x)
        {
            swap(arr[p], arr[j]);
            p++;
        }
    }

    swap(arr[p], arr[r]);

    return p;
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

    int arr[] = {1,5,4,9,4,8,0,16,12,-4,-6,0,7,6,2,8};

    cout << "Before: ";
    for (auto i : arr)
        cout << i << " ";
    cout << endl;

    qsort(arr, 0, 15);

    cout << "After:  ";
    for (auto i : arr)
        cout << i << " ";
    cout << endl;
    
    return 0;
}
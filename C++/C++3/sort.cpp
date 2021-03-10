#include <iostream>

using namespace std;

void merge(int *arr, int i, int m, int j)
{
    if (i >= m || m >= j)
        return;
    int p = i, q = m, t = 0;
    int tmp[j - i];
    while (p < m && q < j)
        if (arr[p] < arr[q])
            tmp[t++] = arr[p++];
        else
            tmp[t++] = arr[q++];
    while (p < m)
        tmp[t++] = arr[p++];
    while (q < j)
        tmp[t++] = arr[q++];
    for (int x = i; x < j; x++)
        arr[x] = tmp[x - i];
}

void msort(int *arr, int i, int j)
{
    if (j <= i + 1)
        return;
    int mid = (i + j) / 2;
    msort(arr, i, mid);
    msort(arr, mid, j);
    merge(arr, i, mid, j);
}

void swap(int &a, int &b)
{
    int tmp = a;
    a = b;
    b = tmp;
}

void ssort(int *xs, int len)
{
    for (int i = 0; i < len; i++)
        for (int j = i + 1; j < len; j++)
            if (xs[i] > xs[j])
                swap(xs[i], xs[j]);
}

int main()
{
    int test[] = {5, 3, 8, 2, 0, 9, 1, 4, 7, 6};
    msort(test, 0, 10);
    for (auto i : test)
        cout << i << " ";
    cout << endl;
    return 0;
}

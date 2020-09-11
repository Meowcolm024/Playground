#include <iostream>

using namespace std;

void merge(int *xs, int a, int b, int c) {
    int tmp[c+1];
    int i = a;
    int j = b+1;
    int k = a;
    while (i <= b && j <= c) {
        if (xs[i] < xs [j]) {
            tmp[k] = xs[i];
            i++;
            k++;
        } else {
            tmp[k] = xs[j];
            j++;
            k++;
        }
    }
    while (i <= b) {
        tmp[k] = xs[i];
        i++;
        k++;
    }
    while (j <= c) {
        tmp[k] = xs[j];
        j++;
        k++;
    }
    //
}

void merge_sort(int *xs, int left, int right) {
    if (!xs || left >= right)
        return;
    int mid = (left+right)/2;
    merge_sort(xs, left, mid);
    merge_sort(xs, mid+1, right);
    merge(xs, left, mid, right);
}

int main() {
    int xs[9] = {3,4,6,2,7,2,0,9,6};
    merge_sort(xs, 0, 8);
    for (auto x: xs)
        cout << x << " ";
    cout << endl;
    return 0;
}
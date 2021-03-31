#include <iostream>
using namespace std;

const int N = 15;
int queens[N];
int counter = 0;

void placeQueens(int r)
{
    if (r == N)
    {
        counter++;
    }
    else
    {
        for (int j = 0; j < N; j++)
        {
            bool legal = true;
            for (int i = 0; i < r; i++)
                if (queens[i] == j || queens[i] == j + r - i || queens[i] == j - r + i)
                    legal = false;
            if (legal)
            {
                queens[r] = j;
                placeQueens(r + 1);
            }
        }
    }
}

int main() {
    placeQueens(0);
    cout << counter << endl;
    return 0;
}
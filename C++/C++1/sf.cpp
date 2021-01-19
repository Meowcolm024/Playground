#include <iostream>
#include <vector>
using namespace std;

template <class T>
vector<T> my_map(function<T(T)> f, vector<T> xs) {
    vector<T> tmp;
    for (T x : xs)
        tmp.push_back(f(x));
    return tmp;
}

int main() {
    vector<int> xs {1,2,3};
    vector<int> ys = my_map<int>([](int i){return i+1;}, xs);
    for (auto i : ys)
        cout << i << " ";
    cout << endl;
    return 0;
}
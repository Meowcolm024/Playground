#include <iostream>
#include <string>
using namespace std;

enum tag {Left, Right};

template<class a, class b>
struct Either {
    tag cat;
    union {a left ; b right;} val;
};

template<class a, class b>
void show_either(Either<a, b> x) {
    if (x.cat == Left)
        cout << "Left ";
    else
        cout << "Right ";
    cout << x.val.left << endl;
};

int main() {
    Either<int, char> x;
    x.cat = Left;
    x.val.left = 1;
    show_either(x);
    return 0;
}
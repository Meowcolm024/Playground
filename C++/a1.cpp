#include <iostream>
#include<cstring>
#include <functional>
using namespace std;

struct lk{
    int val;
    lk *next;
};

int len(lk *ls) {
    if (!ls)
    return 0;
    return (1+len(ls->next));
}

lk* add_one(lk *ls) {
    if(!ls) return 0;
    lk *b = new lk;
    b->val = ls->val+1;
    b->next = add_one(ls->next);
    return b;
}

void printlk(lk *ls) {
    if(!ls) return;
    cout << ls->val << endl;
    printlk(ls->next);
}

lk* assign(int* a,int* b) {
    if (a >= b) return 0;
    lk *tmp = new lk;
    tmp->val = *a;
    tmp->next = assign(a+1,b);
    return tmp;
}

int main() {
    int hello[] = {1,2,3,4,5};
    lk * x = assign(hello,hello+5);
    printlk(add_one(x));
    return 0;
}
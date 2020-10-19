#include <stdio.h>

float math(int x, int y, char op)
{
    float ans;
    switch (op)
    {
    case '+':
        ans = x + y;
        break;
    case '-':
        ans = x - y;
        break;
    case '*':
        ans = x * y;
        break;
    case '/':
        ans = x / y;
        break;
    default:
        ans = 0;
        break;
    }
    return ans;
}

int main()
{
    int x, y;
    char op;
    scanf("%d", &x);
    scanf("%c", &op);
    scanf("%d", &y);
    float ans = math(x, y, op);
    printf("ans = %2f \n", ans);
}
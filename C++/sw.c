#include <stdio.h>

int main()
{
    int number;

    scanf("%d", &number);

    switch (number) {
    case 1:
        printf("A");
    case 2:
        printf("B");
    case 3:
        printf("C");
    case 4:
        printf("D");
    case 5:
        printf("E");
        break;
    case 6:
        printf("F");
    case 7:
        printf("G");
    case 8:
        printf("H");
    case 9:
        printf("I");
        break;
    default:
        printf("Z");
    }

    printf("\n");
}
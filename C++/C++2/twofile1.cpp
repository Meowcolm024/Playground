#include <iostream>
int tom = 3;
int dick = 30;
static int harry = 300;

void remote_access();

int main() {
    std::cout << " main  => ";
    std::cout << "&tom: " << &tom << " &dick: " << &dick;
    std::cout << " &harry: " << &harry << std::endl;
    remote_access();
    return 0;
}
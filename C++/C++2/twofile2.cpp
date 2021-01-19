#include <iostream>
extern int tom;
static int dick = 10;
int harry = 200;

void remote_access() {
    std::cout << "remote => ";
    std::cout << "&tom: " << &tom << " &dick: " << &dick;
    std::cout << " &harry: " << &harry << std::endl;
}
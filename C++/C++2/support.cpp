#include <iostream>

extern double warming;
void update(double dt);
void local();

void update(double dt) {
    extern double warming;  // this line is optional
    warming += dt;          // `warming` in external.cpp
    std::cout << "updated to: " << warming << " degrees.\n";
}

void local() {
    double warming = 0.8;
    std::cout << "local: " << warming << " degrees.\n";     // `warming` in block
    std::cout << "global: " << ::warming << " degrees.\n";  // `warming` in external.cpp
}
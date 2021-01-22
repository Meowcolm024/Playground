#include <iostream>
#include <string>
using namespace std;

class Figure
{
private:
    string name;

protected:
    struct Pair
    {
        int x;
        int y;
    };
    Pair location;

public:
    Figure(const string &n, int x, int y)
    {
        name = n;
        location.x = x;
        location.y = y;
    };
    virtual ~Figure(){};
    virtual string getName() const { return name; };
    virtual void show() const = 0;
    virtual double area() const = 0;
    virtual void resetLoc(int x, int y)
    {
        location.x = x;
        location.y = y;
    };
};

class Rectangle : public Figure
{
private:
    int length;
    int width;

public:
    Rectangle(const string &n, int x, int y, int l, int w) : Figure(n, x, y)
    {
        length = l;
        width = w;
    }
    virtual ~Rectangle(){};
    virtual void show() const
    {
        cout << getName() << " at: (" << location.x << ", ";
        cout << location.y << ") with " << length << "x" << width;
        cout << endl;
    }
    virtual double area() const { return length * width; };
    void swap()
    {
        int t = length;
        length = width;
        width = t;
    }
};

class Circle : public Figure
{
private:
    double radius;

public:
    Circle(const string &n, int x, int y, int r) : Figure(n, x, y)
    {
        radius = r;
    };
    virtual ~Circle(){};
    virtual void show() const
    {
        cout << getName() << " at: (" << location.x << ", ";
        cout << location.y << ") with radius of " << radius;
        cout << endl;
    }
    virtual double area() const { return 2 * 3.14 * radius; };
    double diameter() const { return 2 * radius; };
    void move(int x, int y)
    {
        location.x += x;
        location.y += y;
    }
};

int main()
{
    Figure *figures[3];

    Rectangle rect("pig", 10, 10, 100, 50);
    Circle cir("sheep", -10, 213, 300);
    Rectangle squa("cow", 0, 0, 30, 30);

    figures[0] = &rect;
    figures[1] = &cir;
    figures[2] = &squa;

    for (Figure *i : figures)
        i->show();

    cout << "areas: " << cir.area() << " " << rect.area() << endl;
    cout << "cir's dia: " << cir.diameter() << endl;

    squa.resetLoc(-123, 321);
    cir.move(100, 200);
    rect.swap();

    for (Figure *i : figures)
        i->show();

    return 0;
}
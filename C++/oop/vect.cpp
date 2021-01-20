#include <cmath>
#include <iostream>
#include "vect.h"

namespace vec
{
    Vector::Vector()
    {
        x = y = mag = ang = 0;
        mode = Mode::RECT;
    };

    Vector::Vector(double n1, double n2, Mode m)
    {
        mode = m;
        if (m == Vector::Mode::RECT)
        {
            x = n1;
            y = n2;
            setMag();
            setAng();
        }
        else if (m == Vector::Mode::POL)
        {
            mag = n1;
            ang = n2;
            setX();
            setY();
        }
        else
        {
            x = y = mag = ang = 0;
            mode = Mode::RECT;
        }
    }

    void Vector::setX()
    {
        x = mag * std::cos(ang);
    }

    void Vector::setY()
    {
        y = mag * std::sin(ang);
    }

    void Vector::setMag()
    {
        mag = std::sqrt(x * x + y * y);
    }

    void Vector::setAng()
    {
        if (x == 0 && y == 0)
            ang = 0;
        else
            ang = std::atan2(y, x);
    }
    void Vector::reset(double n1, double n2, Mode m)
    {
        mode = m;
        if (m == Vector::Mode::RECT)
        {
            x = n1;
            y = n2;
            setMag();
            setAng();
        }
        else if (m == Vector::Mode::POL)
        {
            mag = n1;
            ang = n2;
            setX();
            setY();
        }
        else
        {
            x = y = mag = ang = 0;
            mode = Mode::RECT;
        }
    }

    Vector::~Vector(){};

    void Vector::polMode()
    {
        mode = Mode::POL;
    }

    void Vector::rectMode()
    {
        mode = Mode::RECT;
    }

    Vector Vector::operator+(const Vector &v) const
    {
        return Vector(x + v.x, y + v.y);
    }

    Vector Vector::operator-(const Vector &v) const
    {
        return Vector(x - v.x, y - v.y);
    }

    Vector Vector::operator-() const
    {
        return Vector(-x, -y);
    }

    Vector Vector::operator*(double n) const
    {
        return Vector(x * n, y * n);
    }

    double Vector::operator*(const Vector &v) const
    {
        return x * v.y + y * v.x;
    }

    Vector operator*(double n, const Vector &v)
    {
        return v * n;
    }

    std::ostream &operator<<(std::ostream &os, const Vector &v)
    {
        if (v.mode == Vector::Mode::POL)
            os << "mag: " << v.mag << " ang: " << v.ang;
        else if (v.mode == Vector::Mode::RECT)
            os << "x: " << v.x << " y: " << v.y;
        else
            os << "(unknown)";
        return os;
    }
} // namespace vec

#ifndef VECT_H_
#define VECT_H_

#include <iostream>

namespace vec
{
    class Vector
    {
    public:
        enum class Mode
        {
            RECT,
            POL
        };

    private:
        double x;
        double y;
        double mag;
        double ang;
        Mode mode;

        void setMag();
        void setAng();
        void setX();
        void setY();

    public:
        Vector();
        Vector(double n1, double n2, Mode m = Mode::RECT);
        void reset(double n1, double n2, Mode m = Mode::POL);
        ~Vector();

        double xVal() const { return x; };
        double yVal() const { return y; };
        double magVal() const { return mag; };
        double angVal() const { return ang; };
        void polMode();
        void rectMode();

        Vector operator+(const Vector &) const;
        Vector operator-(const Vector &) const;
        Vector operator-() const;
        Vector operator*(double) const;
        double operator*(const Vector &) const;

        friend Vector operator*(double, const Vector &);
        friend std::ostream &operator<<(std::ostream &, const Vector &);
    };
} // namespace vec

#endif
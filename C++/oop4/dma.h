#ifndef DMA_H_
#define DMA_H_

#include <iostream>

class baseDMA
{
private:
    char *label;
    int rating;

public:
    baseDMA(const char *l = "null", int r = 0);
    baseDMA(const baseDMA &);
    virtual ~baseDMA();
    baseDMA &operator=(const baseDMA &);

    friend std::ostream & operator<<(std::ostream&, const baseDMA &);
};

class hasDMA : public baseDMA
{
private:
    char *style;

public:
    hasDMA(const char *l = "null", int r = 0, const char *s = "nil");
    hasDMA(const hasDMA &);
    virtual ~hasDMA();
    hasDMA &operator=(const hasDMA &);

    friend std::ostream & operator<<(std::ostream&, const hasDMA &);
};

#endif
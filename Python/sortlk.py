def qsort(xs: tuple) -> tuple:
    if xs == ():
        return ()
    else:
        (x, y) = xs
        (l, r) = partition(lambda t: t <= x, (), (), y)
        return append(append(qsort(l), (x, ())), qsort(r))


def partition(f, l: tuple, r: tuple, xs: tuple) -> (tuple, tuple):
    if xs == ():
        return (l, r)
    else:
        (p, y) = xs
        if f(p):
            return partition(f, (p, l), r, y)
        else:
            return partition(f, l, (p, r), y)


def append(xs: tuple, ys: tuple) -> tuple:
    return ys if xs == () else (xs[0], append(xs[1], ys))


def fromList(xs: list) -> tuple:
    return () if xs == [] else (xs[0], fromList(xs[1:]))


print(qsort(fromList([3, 6, 9, 8, 7, 5, 1, 2, 4])))

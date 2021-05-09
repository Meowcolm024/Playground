"""
In Haskell:

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort (filter (<=x) xs) ++ [x] ++ qsort (filter (>x) xs)

"""

def qsort(xs: list):
    if xs == []:
        return []
    else:
        p = xs[0]
        return qsort(list(filter(lambda x: x <= p, xs[1:]))) + [p] + qsort(list(filter(lambda x: x > p, xs[1:])))

print(qsort([3,5,9,8,6,4,2]))

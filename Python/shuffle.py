import random
import time
import sys

sys.setrecursionlimit(1000000)
SIZE = 10

# O(n)
def shuffle(l: list):
    for i in range(len(l) - 1):
        x = random.randint(i, len(l) - 1)
        l[0], l[x] = l[x], l[0]

s = time.time()
x = list(range(SIZE))
shuffle(x)
e = time.time()
t1 = e -s
print(t1)

# O(nlogn)
def randmerge(l, r):
    if l == []:
        return r
    if r == []:
        return l
    if random.randint(0, 1):
        return [l[0]] + randmerge(l[1:], r)
    else:
        return [r[0]] + randmerge(l, r[1:])


def mshuffle(l):
    if len(l) <= 1:
        return l
    return randmerge(mshuffle(l[:len(l)//2]), mshuffle(l[len(l)//2:]))

s = time.time()
x = mshuffle(list(range(SIZE)))
e = time.time()
t2 = e - s
print(t2)

print(t2/t1)

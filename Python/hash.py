import random
import math

def trial(m, n):
    # m collisions, n bits
    counter = 0
    outcome = [0 for _ in range(2**n)]
    while outcome.count(2) < m:
        outcome[random.randint(0, 2**n-1)] += 1
        counter += 1
    return counter

def show(m, n):
    acc = 0
    for i in range(10): # take average
        acc += trial(m+1, n)
    x = acc/10
    e = math.sqrt(2*m*2**n)
    d = abs(2*(x-e)/(x+e))
    print("out: %5.2f, expect: %5.2f, delta: %5.2f" % (x, e, d))

for i in range(1, 11):
    show(i, 16)
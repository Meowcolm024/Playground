import random
import matplotlib.pyplot as plt
import functools


def test():
    c_male = [random.randrange(1, 4) in [1, 2] for i in range(2)]
    c_female = [random.randrange(1, 3) == 1 for i in range(2)]
    return functools.reduce(lambda x, y: x+1 if y else x, c_male+c_female, 0)


def counter():
    count = [0 for i in range(5)]
    for i in range(100000):
        count[test()] += 1
    return count


plt.pie(counter(), labels=['0', '1', '2', '3', '4'], autopct='%1.1f%%')
plt.show()


def genPy(n):
    def gen(t):
        x = list(range(1, t+1))
        return x[::-1] + x[1:]
    return list(map(gen, range(1, n+1)))


def show(n):
    l = [list(map(str, i)) for i in genPy(n)[::-1]]
    t = ['' for _ in range(n)]
    for i in range(1, len(l)):
        for j in range(i, len(l)):
            t[j] += ' ' * len(l[i-1][0]) + ' '
    return '\n'.join(reversed(list(map(lambda x, y: x + ' '.join(y), t, l))))


print(show(20))

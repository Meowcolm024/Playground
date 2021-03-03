def triangle(n):
    acc = [[1]]
    row = [1]
    for _ in range(n):
        new = list(map(lambda a, b: a + b, row+[0], [0]+row))
        acc.append(new)
        row = new
    return acc

def tri_rec(n):
    def iter(acc, xs, i):
        return acc + [xs] if i == 0 else iter(acc+[xs], list(map(lambda a, b: a + b, xs+[0], [0]+xs)), i-1)
    return iter([], [1], n)


print(triangle(5))
print(tri_rec(5))

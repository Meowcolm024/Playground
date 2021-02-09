def nqueens(n):
    def helper(qs, r):
        u = len(qs)
        if u == n: 
            return qs
        row = [True for i in range(n)]
        for i in qs:
            row[i] = False
            for p in [i+u, i-u]:
                if p >= 0 and p < n:
                    row[p] = False
            u -= 1
        for i in range(n):
            if row[i]:
                x = helper(qs + [i], r+1)
                if x != []:
                    return x
        return []
    return helper([], 0)

def print_chess(qs):
    size = len(qs)
    def print_pos(n):
        tmp = [' ' for i in range(size)]
        tmp[n] = '*'
        return '|'.join(tmp)
    print(''.join(['-' for i in range(2*size+1)]))
    for q in qs:
        print('|' + print_pos(q) + '|')
        print(''.join(['-' for i in range(2*size+1)]))

result = nqueens(8)
print(result)
print_chess(result)

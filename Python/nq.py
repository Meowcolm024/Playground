def nQueens(n: int):
    result = []
    def placeQueens(queens: list, r: int):
        if r == n:
            result.append(queens)
        else:
            for j in range(n):
                legal = True
                for i in range(r):
                    if queens[i] == j or queens[i] == j + r - i or queens[i] == j - r + i:
                        legal = False
                if legal:
                    queens[r] = j
                    placeQueens(queens, r+1)
    placeQueens(list(range(n)), 0)
    return result

print(nQueens(4))

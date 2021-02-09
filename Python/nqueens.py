import matplotlib.pyplot as plt
import numpy as np


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


# display
board = np.zeros((8, 8, 3))
board += 0.5  # "Black" color. Can also be a sequence of r,g,b with values 0-1.
board[::2, ::2] = 1  # "White" color
board[1::2, 1::2] = 1  # "White" color

positions = reversed(nqueens(8))

fig, ax = plt.subplots()
ax.imshow(board, interpolation='nearest')

for y, x in enumerate(positions):
    # Use "family='font name'" to change the font
    ax.text(x, y, u'\u2655', size=30, ha='center', va='center')

ax.set(xticks=[], yticks=[])
ax.axis('image')

plt.show()

x = [1,2,3,4,5]

for i in range(0, len(x)-1):
    if x[i] == 6:
        print(i)
        break
else:
    print(-1)

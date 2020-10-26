import random

MAXRUN = 10000000
chance = 0

for i in range(MAXRUN):
    acc = [0,0,0]
    for j in range(30):
        x = random.randint(1,20)
        if x in [1,2,3]:
            acc[x-1]+=1
    if sum(acc) == 0:
        chance += 1

print(chance/MAXRUN)

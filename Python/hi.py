def hi_1(val : (int, int)):
    if val[0] == 1:
        print("hi left")
    if val[1] == 1:
        print("hi right")

def hi_2(val: (int, int)):
    if val[0] == 1:
        print("hi left")
    elif val[1] == 1:
        print("hi right")

hi_1((1,1))
print("--------")
hi_1((1,2))
print("--------")
hi_2((1,1))
print("--------")
hi_2((1,2))
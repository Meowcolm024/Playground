while True:
    x = input("Number 1: ")
    if x == "q":
        break
    y = input("Number 2: ")
    if y == "q":
        break
    try:
        x = int(x)
        y = int(y)
    except:
        print("Invalid number")
    else:
        print('Do the math yourself :)')

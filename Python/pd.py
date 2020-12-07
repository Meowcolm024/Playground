import turtle

l = 100

def t1():
    for i in range(3):
        turtle.forward(l)
        turtle.left(120)

def t2():
    for i in range(3):
        turtle.forward(l)
        turtle.right(120)

t1()
turtle.left(180)
t2()
turtle.right(120)
turtle.forward(l)
turtle.left(120)
t2()
turtle.done() 
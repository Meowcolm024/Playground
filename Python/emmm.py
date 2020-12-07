import turtle

turtle.left(90)

def tick():
    turtle.circle(100, -6)
    # turtle.ontimer(tick, 1000)

for i in range(60):
    turtle.ontimer(tick, 1000*i)

turtle.done()
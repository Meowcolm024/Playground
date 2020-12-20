import turtle
import numpy


class tplot:
    def __init__(self, func, interval: (float, float, float), margin=1.5):
        self.interval = interval
        self.func = func
        self.margin = margin

    def plot(self):
        vals = []
        s = self.interval[0]
        while s <= self.interval[1]:
            vals.append((s, self.func(s)))
            s += self.interval[2]

        max_y = max([i[1] for i in vals])*self.margin
        min_y = min([i[1] for i in vals])*self.margin

        screen = turtle.Screen()
        screen.screensize(800, 600)
        screen.setworldcoordinates(
            self.interval[0], min_y, self.interval[1], max_y)

        axes = turtle.Turtle()
        axes._tracer(False)
        axes.goto(self.interval[0], 0)
        axes.goto(self.interval[1], 0)
        axes.home()
        axes.goto(0, max_y)
        axes.goto(0, min_y)
        axes._tracer(True)
        axes.hideturtle()

        plotter = turtle.Turtle()
        plotter.color("blue")
        plotter._tracer(False)
        plotter.pu()
        plotter.goto(vals[0])
        plotter.pd()

        for (x, y) in vals:
            plotter.goto(x, y)

        plotter._tracer(True)
        plotter.hideturtle()
        screen.mainloop()


p = tplot(numpy.sin, (-10, 10, 0.01))
p.plot()

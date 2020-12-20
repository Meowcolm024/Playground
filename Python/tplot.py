import turtle
import numpy


class tplot:
    def __init__(self, func, interval: (float, float, float), margin=1.5):
        self.interval = interval
        self.func = func
        self.margin = margin

    def plot(self):
        # get all cords
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

        # draw axes
        axes = turtle.Turtle()
        axes._tracer(False)
        while axes.xcor() > self.interval[0]:
            axes.dot()
            axes.goto(axes.xcor()-1,axes.ycor())
        axes.home()
        while axes.xcor() < self.interval[1]:
            axes.dot()
            axes.goto(axes.xcor()+1,axes.ycor())
        axes.home()
        while axes.ycor() > min_y:
            axes.dot()
            axes.goto(axes.xcor(),axes.ycor()-1)
        axes.home()
        while axes.ycor() < max_y:
            axes.dot()
            axes.goto(axes.xcor(),axes.ycor()+1)
        axes._tracer(True)
        axes.hideturtle()

        # plot
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

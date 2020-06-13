import matplotlib.pyplot as plt
import numpy as np


def plotter(f, x):
    ax = plt.subplot()
    ax.axhline(y=0, color='k')
    ax.axvline(x=0, color='k')
    plt.plot(x, f)
    plt.show()


x = np.linspace(0.5, 5)
f = np.log(x) / x
plotter(f, x)

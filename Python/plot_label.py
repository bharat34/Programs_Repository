import numpy as np
import matplotlib.pyplot as plt

x = np.arange(10)
y = 2 * x
z = x ** 2

fig, ax = plt.subplots()
ax.plot(x, y, 'bo-')

#for X, Y, Z in zip(x, y, z):
    #print X,Y,Z
    # Annotate the points 5 _points_ above and to the left of the vertex
ax.annotate('{:.0f}'.format(5), xy=(6,12), xytext=(-10, 10), ha='right',
                textcoords='offset points',
            arrowprops=dict(arrowstyle='->', shrinkA=0))
ax.annotate('{:.0f}'.format(6), xy=(6,12), xytext=(-10, 10), ha='left',
                textcoords='offset points',
            arrowprops=dict(arrowstyle='->', shrinkA=0))

plt.show()

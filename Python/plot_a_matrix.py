# programs takes a N X N matrix and plot it using matplot lib

import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
from numpy.random import randn
import sys

# Make plot with vertical (default) colorbar
fig = plt.figure()
ax = fig.add_subplot(111)

with open("1be9_bound_fulslt_250ns_combi.txt", 'r') as f:
    energy = [map(float, line.split()) for line in f]
    
length=len(energy)
print length
data = np.clip(randn(length, length), 0, 0)
i=0
j=0
for i in range(length):
    for j in range(length):
        data[i,j]=(energy[i][j])
    i+=1
        
cax = ax.imshow(data, interpolation='nearest', cmap=cm.coolwarm)
ax.set_title('1bfe energy correlation')
#ax.set_xticks((301,410,10))
#ax.set_yticks(np.arange(301,410,10))

# Add colorbar, make sure to specify tick locations to match desired ticklabels
cbar = fig.colorbar(cax, ticks=[0, 1])
cbar.ax.set_yticklabels(['0','1', '> 1'])# vertically oriented colorbar


plt.show()

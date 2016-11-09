# written by Bharat Lakhani (11/9/2016)
# The plots above are statistical 
# free energy landscapes for the simulations for first two PCA modes
# in Cartesian space. The population of vector termini Pij associated
# with each 2D grid element is calculated. 
# From this, normalized probabilities Pij/P0 are
# obtained, where P0 is the maximum population. 
# A free energy is then calculated as deltaGij =
# - KT ln (Pij/P0) and displayed as a contour map.

import matplotlib.pyplot as plt
import numpy as np


# file containing two PC modes
f = open('C:/Users/blakhani/Desktop/PC1-PC2.dat', 'r')
#writing output file
target = open('C:/Users/blakhani/Desktop/PC1-PC2-result.dat', 'w')

# define arrays to store each respective PC modes
x=[]
y=[]

for line in f:
    line.rstrip('\n')
    values = line.split("\t")
	# storing into arrays
    x.append(float(values[0]))
    y.append(float(values[1]))
        
f.close()

# make 2D histogram defined by 100 bins
H, xedges, yedges=np.histogram2d(y, x,bins=100)
target.write(str(H))
target.write(str(xedges[::1]))
target.write(str(yedges[::1]))
target.close()


# here K = 0.0019872041is boltzmann constant in Kcal/mol
# T is temperature in 298 Kelvin
H1=-0.0019872041*298*np.log(H/np.amax(H))
plt.title('Stastistical Free Eergy', fontsize=24, fontweight='bold')
plt.xlabel('PC1',fontsize=14, fontweight='bold')
plt.ylabel('PC2',fontsize=14, fontweight='bold')
plt.imshow(H1, interpolation='nearest', origin='low',
                extent=[xedges[0], xedges[-1], yedges[0], yedges[-1]])
#plt.show()
#cbar=plt.colorbar()
cbar = plt.colorbar()
#cbar.ax.set_yticklabels(['0','1','2','>3'])
cbar.set_label('Kcal/mol', rotation=90,fontsize=14)
plt.savefig('C:/Users/blakhani/Desktop/PC1-PC2.png',format='png')

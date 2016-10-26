"""
The pythons scripts peforms a gaussian network model
analysis on a given pdb file using Prody devlopmed by Bahar group (12/01/2014)
"""
from prody import *
from matplotlib.pylab import *
#ion() # turn interactive mode on

ubi = parsePDB('1aar')
ubi

calphas = ubi.select('calpha and chain A and resnum < 71')
calphas

gnm = GNM('Ubiquitin')

gnm.buildKirchhoff(calphas)

gnm.getKirchhoff()

gnm.getCutoff()
gnm.getGamma()

gnm.calcModes()
#gnm.calcModes(20, zeros=True)

gnm.getEigvals().round(3)
gnm.getEigvecs().round(3)

gnm.getCovariance().round(2)

slowest_mode = gnm[0]
slowest_mode.getEigval().round(3)
slowest_mode.getEigvec().round(3)

#showContactMap(gnm);
#plt.show()

#showCrossCorr(gnm);
#plt.show()

#showMode(gnm[0]);
#plt.grid();
#plt.show()

showSqFlucts(gnm[0]);
plt.show()

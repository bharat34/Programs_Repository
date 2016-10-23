# -*- coding: utf-8 -*-
# This code was copied from ProDy documentation.
# Title: Gaussian Network Model (GNM) — ProDy
# URL: http://www.csb.pitt.edu/prody/tutorials/enm_analysis/gnm.html

from prody import *
from matplotlib.pylab import *
#ion() # turn interactive mode on

ubi = parsePDB('1aar')
ubi

#calphas = ubi.select('protein and name CA')
calphas = ubi.select('calpha and chain A and resnum < 71')
calphas

gnm = GNM('1BE9 PDZ bound')

gnm.buildKirchhoff(calphas)

gnm.getKirchhoff()

gnm.getCutoff()
gnm.getGamma()

gnm.calcModes()
#gnm.calcModes(50, zeros=True)

gnm.getEigvals().round(3)
gnm.getEigvecs().round(3)

gnm.getCovariance().round(2)

slowest_mode = gnm[0]
slowest_mode.getEigval().round(3)
slowest_mode.getEigvec().round(3)

#showContactMap(gnm);

showCrossCorr(gnm);
plt.show()

#showMode(gnm[0]);
#plt.grid();

#showSqFlucts(gnm[0]);


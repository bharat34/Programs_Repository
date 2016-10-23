#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''This code was copied from ProDy 1.4.1 documentation.
Title: ANM analysis — ProDy
URL: http://www.csb.pitt.edu/prody/examples/dynamics/enm/anm.html
'''

__copyright__ = 'Copyright (C) 2010-2012, Ahmet Bakan'

from prody import *

p38 = parsePDB('3tgi')
p38

calphas = p38.select('protein and name CA')
calphas

calphas2 = p38.select('calpha')
calphas2

calphas == calphas2

anm = ANM('3tgi ANM analysis')

anm.buildHessian(calphas)

print( anm.getHessian().round(3) ) 

print( anm.getCutoff() )
print( anm.getGamma() )

anm.calcModes()

print( anm.getEigvals().round(3) ) 
print( anm.getEigvecs().round(3) ) 

print( anm.getCovariance().round(2) ) 

slowest_mode = anm[0]
print( slowest_mode.getEigval().round(3) )
print( slowest_mode.getEigvec().round(3) ) 

# write slowest 3 ANM modes into an NMD file
writeNMD('3tgi_anm_modes.nmd', anm[:3], calphas)

print( getVMDpath() )

# if this is incorrect use setVMDpath to correct it
viewNMDinVMD('3tgi_anm_modes.nmd')

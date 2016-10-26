# a Kaufmann net program representing a net with degree 2
# neighbours choosen randomly with 2-input boolean functions.
# LAst modifie by Bharat Lakhani (04/07/2016)

from random import *



def f0(val1,val2):
  return 0

def f1(val1,val2):
  return val1 

def f2(val1,val2):
  return 1-val1 

def f3(val1,val2):
  return val2 

def f4(val1,val2):
  return 1-val2 

def f5(val1,val2):
  if val1+val2 == 0:
    return 0
  else:
    return 1

def f6(val1,val2):
  if val1+val2 == 0:
    return 1
  else:
    return 0

def f7(val1,val2):
  if val1+val2 == 1:
    return 0
  else:
    return 1

def f8(val1,val2):
  if val1+val2 == 1:
    return 1
  else:
    return 0

def f9(val1,val2):
  if val1+val2 == 2:
    return 0
  else:
    return 1

def f10(val1, val2):
  if val1+val2 == 2:
    return 1
  else:
    return 0

def f11(val1, val2):
  if val1>val2:
    return 1
  else: 
    return 0

def f12(val1, val2):
  if val1>val2:
    return 0
  else: 
    return 1

def f13(val1, val2):
  if val2>val1:
    return 1
  else: 
    return 0

def f14(val1, val2):
  if val2>val1:
    return 0
  else: 
    return 1

def f15(val1, val2):
  return 1

#
# boolEval implements case statement evaluating boolean function of a given
# type with inputs val1 and val2
#

def boolEval(type, val1, val2):
  functions = {0: f0,
               1: f1,
               2: f2,
               3: f3,
               4: f4,
               5: f5,
               6: f6,
               7: f7,
               8: f8,
               9: f9,
               10: f10,
               11: f11,
               12: f12,
               13: f13,
               14: f14,
               15: f15
           }
  f = functions[type]
  return f(val1,val2) 

#
# Node class - two neighbors set to empty, type set to 0,
# value randomly set to 0 or 1.
# Note that oldvalue is required in order to correctly update net 
#

class node:

  def __init__(self):
    self.type = 0 
    self.neigh1 = None
    self.neigh2 = None
    self.value = choice([0,1])           
    self.oldvalue = self.value
    self.id = 0

  def setNeigh1(self,aNeigh):
    self.neigh1 = aNeigh

  def setNeigh2(self, aNeigh):
    self.neigh2 = aNeigh

  def evolveValue(self):
    #print self.neigh2
    self.value = boolEval(self.type,self.neigh1.oldvalue,self.neigh2.oldvalue)
    

  def getValue(self):
    return self.value
  
  def getNeigh2(self):
    return self.neigh2
  

#
# net class - size number of nodes are generated with two random neighbors
# and with random type 
#

class net:

  def __init__(self, size):
    self.size = size
    self.nodes = []
    for i in range(0,size): self.nodes.append(node())
    for i in range(0,size): self.nodes[i].id = i
    for i in range(0,size):
      self.nodes[i].setNeigh1(self.nodes[randrange(0,size)])
    
    for i in range(0,size):
      self.nodes[i].setNeigh2(self.nodes[randrange(0,size)])
      #print self.nodes[i].getNeigh2
    for i in range(0,size):
      self.nodes[i].type = randrange(0,16)
    
  def evolveNet(self):
    for i in range(0,self.size):  
      self.nodes[i].evolveValue()
    for i in range(0,self.size): 
      self.nodes[i].oldvalue = self.nodes[i].value     

  def printTypes(self):
    for i in range(0,self.size): print self.nodes[i].id," (",self.nodes[i].neigh1.id,",",self.nodes[i].neigh1.id,") ",self.nodes[i].type
    print "\n"

  def printNet(self):
    for i in range(0,self.size): print self.nodes[i].value,
    print

  def listvalues(self):
    l = []
    for i in range(0,self.size): l += [self.nodes[i].value]
    return l

# In order to run gene simulation
# here you have to define cycle and generun

def cycle(newstate, states):
  for i in range(len(states)):
    if states[i] == newstate:
      print 'cycle found of length: ', len(states) - i
      print 'path to cycle of length: ', i
      return 1

def generun(size):
  n = net(size)
  current = n.listvalues()
  states = []
  while cycle(current, states) != 1:
    n.evolveNet()
    states += [current]
    current = n.listvalues()
  states += [current]
  for i in states: print i
  print "id   neighb   boolean"
  n.printTypes()

generun(10)

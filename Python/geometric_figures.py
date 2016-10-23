"""
This file contains the code to implement a variety of geometric
figures including circles, rectangles and squares. Methods
available for each include computing the area. The
point class is provided to be used by the other classes.
"""


from math import *


#Class point implements a point on the Cartesian plane (x,y)

class point:

    #point constructor defaults to (0,0)
    
    def __init__(self,x=0,y=0):
        self.x = x
        self.y = y
     
    #Overwrite str method for pretty printing
        
    def __str__(self):  
        return '('+str(self.x)+','+str(self.y)+')'

    #get and set x and y values
    #or
    #accessor and mutator methods for attributes
    
    def getx(self):
        return self.x

    def gety(self):
        return self.y

    def setx(self,x):
        self.x = x

    def sety(self,y):
        self.y = y

    #Some other useful methods
        
    def distance_to(self,point):
        return sqrt((self.x-point.x)**2+(self.y-point.y)**2)

    def translate(self,p):
        x = self.x + p.x
        y = self.y + p.y
        return point(x,y)
    
#Class circle implements a circle with center at point p and with radius r.

class circle:

    def __init__(self,p,r):
        self.center = p
        self.radius = r

    def diameter(self):
        return 2*self.radius
    
    def area(self):
        return pi*self.radius**2


#Class rectangle implements a rectangle using two points: the lower
#left corner and the upper right corner. (Note: rectangles are assumed
#to have sides parallel to the axes.)
    
class rectangle:

    def __init__(self,p1,p2):
        self.btlft = p1
        self.tprht = p2

    def height(self):
        return self.tprht.gety() - self.btlft.gety()

    def width(self):
        return self.tprht.getx() - self.btlft.getx()

    def area(self):
        return self.height()*self.width()

#Class square implements a square as a rectangle using btlft corner and
#length of side

class square(rectangle):

    def __init__(self,corner,side):
        self.btlft = corner
        self.tprht = point(corner.getx() + side,corner.gety() + side)


    
    


    

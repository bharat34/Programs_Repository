
def Floor_matches(a,b):
    demo=0
    if(a==0):
        return 0
    elif(a>0):
        while(a>=b):
            a=a-b
            demo+=1
        return demo
    else:
        while(abs(a)>=b):
            a=a+b
            demo+=1
        if(abs(a)<b and abs(a)!=0):
            demo+=1
        return demo

print "11/4",Floor_matches(11,4)
print "3/5",Floor_matches(3,5)
print "11/5",Floor_matches(11,5)
print "10/1",Floor_matches(10,1)
print "14/2",Floor_matches(14,2)
print "13/7",Floor_matches(13,7)

print "-6/9",Floor_matches(-6,9)
print "-6/1",Floor_matches(-6,1)
print "-8/2",Floor_matches(-8,2)
print "-9/7",Floor_matches(-9,7)
print "-20/5",Floor_matches(-20,5)
print "-3/2",Floor_matches(-3,2)





    

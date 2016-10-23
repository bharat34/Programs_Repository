

from math import sqrt ##importing squareroot function from math

def verify_prime(number1):
    prime = False
    if ( number > 1):
        prime = True
        dummy=sqrt(number)
        k=2
        while(k<=dummy and prime==True):
            if(number%k==0):
                prime=False
            
            k+=1
        print prime
        
            



number = input('Enter your primenumber: ')
verify_prime(number)

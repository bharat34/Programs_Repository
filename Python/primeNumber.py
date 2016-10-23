
"""
Created on Wed Oct  5 22:24:05 2016

File:       primeNumber.py    
Date:       10/06/2016
Instructor: Nguyen Thai
Course:     CSC 7014 - The Practice of Computer Programming
Author:     Reshma Kapadnis
Description: A program in which we have to check the given numbers are prime numbers or not.
"""


from math import sqrt ##importing squareroot function from math


def isPrime(number): ## defining the function to check if a number is prime or not
    prime = False
    if number > 1: 
        prime = True
        y = 2
        z = sqrt(number) 
        while y <= z and prime == True:
            if number % y == 0:
                prime = False
            y += 1
    return prime

##Test case for the given list of numbers
numberlist = [21,29,109,163,227] ## creating a list of the provided numbers 
for a in numberlist: ##Calling each number from the list one by one
    isPrime(a)## calling the is_prime function defined in line11
    if isPrime(a):
        print (str(a)+ " is a prime number")## converting the int into string to display on the console
    else:
        print (str(a) + " is not a prime number")
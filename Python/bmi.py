"""
Created on Wed Oct  12 22:24:05 2016

File:       bmi.py    
Date:       10/13/2016
Instructor: Nguyen Thai
Course:     CSC 7014 - The Practice of Computer Programming
Author:     Reshma Kapadnis
Description: A program in which we have to calculate the BMI.
"""

class BMI:##creating the class
    def __init__(self, name, age, weight, height_foot, height_inch):
        self.name = str(name)###name in the string format
        self.age = int(age)##age in integer
        self.weight = float(weight) ##weight in float
        self.height_ft = float(height_foot)##height in float
        self.height_in = float(height_inch)###height in float
        
  
    def getBMI(self):
        if self.age < 16:##checking if user's age less than 16
            print ("BMI cannot be calculated")
        else:
            wt_in_kg = self.weight * 0.4535 ##coverting weight from lb to kg
            ht1= self.height_ft * 0.305 ##converting foot to meters
            ht2= self.height_in * 0.0254 ##converting inches to meters
            ht_in_meters= ht1 ++ ht2
            bmi = (wt_in_kg) / (ht_in_meters ** 2) ##using the bmi calculation formula
            
        return (bmi)   
  
    def getStatus(self):##function to classify if underweight or Normal or Overweight or Obese
        bmi = self.getBMI()
        if bmi < 18.50:  ###if bmi less than 18.5, underweight
            print ("BMI is " + str(bmi))
            print ("underweight ")
            print ("************")
            return "Underweight"
        elif (bmi >=18.50 and bmi <= 24.99): ###if bmi more than 18.5 and less than 24.9, Normal
            print ("BMI is " + str(bmi))
            print ("Normal")
            print ("************")
            return "Normal"
        elif (bmi >=25.00 and bmi <=29.99): ###if bmi more than 25 and less than 29.9, Overweight
            print ("BMI is " + str(bmi))
            print ("Overweight")
            print ("************")
            return "Overweight"
        else:
            print ("BMI is " + str(bmi))###if bmi more than 30, Obese
            print ("Obese")
            print ("************")
            return "Obese"
  
    def getName(self):  ###for getting the name
        print (self.name)
        return self.name
  
    def getAge(self): ## for gettign the age
        print (self.age)
        return self.age
  
    def getWeight(self): ## for getting the weight
        print (self.weight)
        return self.weight
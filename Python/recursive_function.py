
"""
Given an array of integers, return indices of the two
numbers such that they add up to a specific target.
You may assume that each input would have exactly one solution.

Example:

Given nums = [2, 7, 11, 15], target = 9, 
Because nums[0] + nums[1] = 2 + 7 = 9, 
return [0, 1].

"""
# -*- coding: utf-8 -*-
def sum_index(nums_list,target):
    index=[]
    for i in range(0,len(nums_list)):
        for j in range(i+1,len(nums_list)):
            if(nums_list[i]+nums_list[j]==target):
                index.append(i)
                index.append(j)
    return index

nums_list=[2,7,11,15]
target=26

# uncomment this to run the above function
print sum_index(nums_list,target)

"""
  Recursive function to calculate the n factorial
  Example
      1!=1
      2!=1*2=2
      4!=4*3*2*1=24
"""

def factorial(number):
    if(number==0):
        return 1
    elif(number==1):
        return 1
    else:
        return (number*factorial(number-1))

# uncomment this to run the above function
#print factorial(0)
#print factorial(4)
#print factorial(6)

"""
write a  recursive function to calculate the fibonacci series

Example

    1=0
    2=0,1
    3=0,1,1
    4=0,1,1,2
    
"""

def fibonacci_series(Fib_list,number):
    if(number==0):
        return Fib_list
    else:
        if((number-len(Fib_list)== number) or (len(Fib_list)==1)):
            Fib_list.append((number+len(Fib_list)-number))
            return fibonacci_series(Fib_list,number-1)
        else:
            Fib_list.append(Fib_list[-1]+Fib_list[-2])
            return fibonacci_series(Fib_list,number-1)
# uncomment this to run the above function
#Fib_list=[]
#print fibonacci_series(Fib_list,5)

#Fib_list=[]
#print fibonacci_series(Fib_list,7)

"""
Given a string s, find the longest palindromic substring in s.
You may assume that the maximum length of s is 1000.

Example:

Input: "babad"
Output: "bab"
Note: "aba" is also a valid answer.
Example:
Input: "cbbd"
Output: "bb"
"""

def Palindromic_Substring(length,string):
        if(length==0):
            return string
        else:
            
            for i in range((len(string)/length)+1):
                Dstring=string[i:length]
                if(Dstring[0]==Dstring[-1]):
                    return Dstring
            return Palindromic_Substring(length-1,string)
        
# uncomment this to run the above function
#print Palindromic_Substring(len('babad'),'babad')
#print Palindromic_Substring(len('cbbd'),'cbbd')
#print Palindromic_Substring(len('GEEKSFORGEEKS'),'GEEKSFORGEEKS')

def findSubstring(string,words):
    index=[]
    for i in range(0,len(words)):
        for j in range(i+1,len(words)):
            if(string.find(words[i]+words[j])!=-1):
               index.append(string.find(words[i]+words[j]))
            if(string.find(words[j]+words[i])!=-1):
                index.append(string.find(words[j]+words[i]))
    index.sort()
    return index

# uncomment this to run the above function
string="barfoothefoobarmannCooogCooomann"
words=["foo","bar","Cooo","mann"]
print findSubstring(string,words)




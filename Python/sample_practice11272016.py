def median(lst):
    lst = sorted(lst)
    
    if len(lst) < 1:
            return None
    if len(lst) %2 == 1:
            return int(lst[((len(lst)+1)/2)-1])
    else:   
            return int(sum(lst[(len(lst)/2)-1:(len(lst)/2)+1]))/2.0
    
def centered_average(nums):
  nums.sort()
  if(len(nums)%2==0):
    mid=len(nums)/2-1
  else:
    mid=len(nums)/2
  if(nums[mid]==nums[mid-1] and nums[mid+1]==nums[mid+2]):
      return (nums[mid]+nums[mid+1])/2
  else:
      return (nums[mid])
    
#print centered_average([1, 2, 3, 4, 100])
#print median([1, 1, 5, 5, 10, 8, 7])
#print median([-10, -4, -2, -4, -2, 0])
#print centered_average([-10, -4, -2, -4, -2, 0])
#print median([1, 1, 99, 99])
#print centered_average([1000, 0, 1, 99])
#print median([1000, 0, 1, 99])

def sum13(nums):
    nums=filter(lambda x: x==0 or x!=13 and x!=14,nums)
    if not nums:
        return 0
    else:
        return reduce(lambda x,y: x+y,filter(lambda x: x!=13 and x!=14,nums))


#print sum13([1, 2, 2, 1])	
#print sum13([1, 1])
#print sum13([1, 2, 2, 1, 13])	
#print sum13([1, 2, 13, 2, 1, 13])
#print sum13([13, 1, 2, 13, 2, 1, 13])
#print sum13([])
#print sum13([13])
#print sum13([13, 13])
#print sum13([13, 0, 13])
#print sum13([13, 1, 13])
#print sum13([5, 7, 2])	
#print sum13([5, 13, 2])
#print sum13([0])
#print sum13([13, 0])

def sum67(nums):
    summ=0
    flag=0
    for i in nums:
        if(i==6):
            flag=1
        elif(flag!=1):
            summ=summ+i
        elif(i==7 and flag==1):
            flag=0            
    if not nums:
        return 0
    else:
        return summ
    

#print sum67([1, 2, 2])
#print sum67([1, 2, 2, 6, 99, 99, 7])
#print sum67([1, 1, 6, 7, 2])
#print sum67([1, 2, 2, 6, 99, 99, 7,1, 2, 2, 6, 99, 99, 7,1,6,7,1])
#print sum67([6,7])
#print sum67([])

def has22(nums):
  for i in range(len(nums)-1):
    if(nums[i]==2 and nums[i+1]==2):
      return True
  return False


#Given an array of ints, return True if the array contains a 2 next to a 2 somewhere.
#print has22([1, 2, 2])
#print has22([1, 2, 1, 2])
#print has22([2, 1, 2])

def sum14(nums):
  sum=0
  for i in range(len(nums)):
    if(nums[i]==13 and i+1!=len(nums)):
        nums[i+1]=  0
    elif(nums[i]==13):
        nums[i]=0
    else:
        sum+=nums[i]
  return sum

#print sum14([1, 2, 2, 1])	
#print sum14([1, 1])
#print sum14([1, 2, 2, 1, 13])	
#print sum14([1, 2, 13, 2, 1, 13])
#print sum14([13, 1, 2, 13, 2, 1, 13])
#print sum14([])
#print sum14([13])
#print sum14([13, 13])
#print sum14([13, 0, 13])
#print sum14([13, 1, 13])
#print sum14([5, 7, 2])	
#print sum14([5, 13, 2])
#print sum14([0])
#print sum14([13, 0])


def double_char(string):
 a = []
 for i in range(len(string)):
    a.append(string[i]+string[i])
 return ''.join(a)
print double_char('The')
print double_char('AAbb')
print double_char('Hi-There')

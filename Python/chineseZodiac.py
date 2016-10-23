"""
File:       ChineseZodiac.py    
Date:       9/29/2016
Instructor: Nguyen Thai
Course:     CSC 7014 - The Practice of Computer Programming
Author:     Reshma Kapadnis
Description: A program in which we have to calculate the Chinese zodiac sign, taking year as an input.
"""

import turtle
## set up screen##

turtle.speed(0)
turtle.setup(800,800) ##screen dimensions
screen = turtle.Screen()
turtle.hideturtle()
turtle.bgcolor("white") ##screen background
screen.title("Chinese Zodiac")

##define pensize and title location ##
ballpen =turtle.Turtle()
##pen for writing monkey
monkeypen =turtle.Turtle()
monkeypen.hideturtle()
##Pen for rooster
Roosterpen =turtle.Turtle()
Roosterpen.hideturtle()
##pen for dog
Dogpen =turtle.Turtle()
Dogpen.hideturtle()
##Pen for pig
pigpen =turtle.Turtle()
pigpen.hideturtle()
##pen for rat
Ratpen =turtle.Turtle()
Ratpen.hideturtle()
##pen for Oc 
Oxpen =turtle.Turtle()
Oxpen.hideturtle()
##pen for tiger
Tigerpen =turtle.Turtle()
Tigerpen.hideturtle()
##pen for rabbit
Rabbitpen =turtle.Turtle()
Rabbitpen.hideturtle()
##pen for Dragon
Dragonpen =turtle.Turtle()
Dragonpen.hideturtle()
##pen for Snake
Snakepen =turtle.Turtle()
Snakepen.hideturtle()
##pen for Horse
Horsepen =turtle.Turtle()
Horsepen.hideturtle()
##pen for Sheep
Sheeppen =turtle.Turtle()
Sheeppen.hideturtle()
ballpen.pensize(1)
ballpen.penup()
color1 = ("black")
color2 = ("red")
color3 = ("blue")
ballpen.color(color1)

answer = input ('Enter your birth year ') ##taking user's input and saving it as answer 

##setting up the screen with the title and the circle

ballpen.goto(-350,250) ##position for title##
ballpen.pendown()
ballpen.color("green")
ballpen.write("Year to Chinese Zodiac sign conversion" , font=("Arial",20, "bold")) ##screen title and its font
ballpen.position()
ballpen.speed(0) ##speed of drawing
ballpen.hideturtle()
## drawing circle and lines inside circle##

##draw circle with radius 200
ballpen.penup()
ballpen.goto(0,-200)
ballpen.pendown()
ballpen.color(color1)
ballpen.circle(200)
ballpen.penup()
ballpen.goto (0,200)
turtle.home()
    
## draw section lines
turtle.right(30)##30 degrees angle for deviding the circle in equal sectors
turtle.forward(200)
ballpen.penup()
turtle.home()
Rabbitpen.penup()
Rabbitpen.goto(140,-50)
Rabbitpen.color(color3)
Rabbitpen.write("Rabbit", font=("Arial" ,8, "bold"))  #Rabbit label inside particular section
turtle.right(60)
turtle.forward(200)
ballpen.penup()
turtle.home()
Dragonpen.penup()
Dragonpen.goto(95,-120)
Dragonpen.color(color3)
Dragonpen.write("Dragon", font=("Arial" ,8, "bold")) #Dragon label inside particular section
turtle.right(90)
turtle.forward(200)
ballpen.penup()
turtle.home()
Snakepen.penup()
Snakepen.goto(30,-150)
Snakepen.color(color3)
Snakepen.write("Snake", font=("Arial" ,8, "bold")) #Snake label inside particular section
turtle.right(120)
turtle.forward(200)
ballpen.penup()
turtle.home()
Horsepen.penup()
Horsepen.goto(-50,-150)
Horsepen.color(color3)
Horsepen.write("Horse", font=("Arial" ,8, "bold")) #Horse label inside particular section
turtle.right(150)
turtle.forward(200)
ballpen.penup()
turtle.home()
Sheeppen.penup()
Sheeppen.goto(-115,-110)
Sheeppen.color(color3)
Sheeppen.write("Sheep", font=("Arial" ,8, "bold"))  #Sheep label inside particular section
turtle.right(180)
turtle.forward(200)
ballpen.penup()
turtle.home()
monkeypen.penup()
monkeypen.goto(-150,-40)
monkeypen.color(color3)
monkeypen.write("Monkey", font=("Arial" ,8, "bold")) #Monkey label inside particular section
turtle.right(210)
turtle.forward(200)
ballpen.penup()
turtle.home()
Roosterpen.penup()
Roosterpen.goto(-150,30)
Roosterpen.color(color3)
Roosterpen.write("Rooster", font=("Arial" ,8, "bold")) #Rooster label inside particular section
turtle.right(240)
turtle.forward(200)
ballpen.penup()
turtle.home()
Dogpen.penup()
Dogpen.goto(-110,95)
Dogpen.color(color3)
Dogpen.write("Dog", font=("Arial" ,8, "bold"))  #Dog label inside particular section
turtle.right(270)
turtle.forward(200)
ballpen.penup()
turtle.home()
pigpen.penup()
pigpen.goto(-45,150)
pigpen.color(color3)
pigpen.write("Pig", font=("Arial" ,8, "bold")) #Pig label inside particular section
turtle.right(300)
turtle.forward(200)
ballpen.penup()
turtle.home()
Ratpen.penup()
Ratpen.goto(30,150)
Ratpen.color(color3)
Ratpen.write("Rat", font=("Arial" ,8, "bold"))  #Rat label inside particular section
turtle.right(330)
turtle.forward(200)
ballpen.penup()
turtle.home()
Oxpen.penup()
Oxpen.goto(110,110)
Oxpen.color(color3)
Oxpen.write("Ox", font=("Arial" ,8, "bold"))  #Ox label inside particular section
turtle.right(360)
turtle.forward(200)
ballpen.penup()
turtle.home()
Tigerpen.penup()
Tigerpen.goto(140,30)
Tigerpen.color(color3)
Tigerpen.write("Tiger", font=("Arial" ,8, "bold"))  #Tiger label inside particular section
ballpen.hideturtle() ## hiding turtle
turtle.penup()
turtle.goto(-200,-300)
turtle.pendown()
ballpen.hideturtle()
## Calculating the modulas and assigning it to acurate animal with if else statement
    
if str.isdigit(answer):## checking if the user input is in digits
    ans = int(answer) ##converting user input string to integer and saving it as ans
    if ans > 0 and ans <= 2016: ##checking the condition if user i/p greater than 0 and less than current year 2016
            y = ans % 12;
            if y == 0:
                turtle.write("Year "+ answer +"  is the Monkey!", font=("ariel",25,"bold"))
                turtle.penup()
                ballpen.goto(-150,-40)
                monkeypen.clear()
                ballpen.color(color2)
                ballpen.write("Monkey", font=("Arial" ,8, "bold"))
                turtle.pendown()
            elif y == 1:
                turtle.write("Year "+ answer +" is the Rooster!", font=("ariel",25,"bold"))
                turtle.penup()
                ballpen.goto(-150,30)
                Roosterpen.clear()
                ballpen.color(color2)
                ballpen.write("Rooster", font=("Arial" ,8, "bold"))
                turtle.pendown()
            elif (y == 2):
                turtle.write("Year "+ answer +" is the Dog!", font=("ariel",25,"bold"))
                turtle.penup()
                ballpen.goto(-110,95)
                Dogpen.clear()
                ballpen.color(color2)
                ballpen.write("Dog", font=("Arial" ,8, "bold"))
                turtle.pendown()
            elif (y == 3):
                turtle.write("Year "+ answer +" is the Pig!", font=("ariel",25,"bold"))
                turtle.penup()
                ballpen.goto(-45,150)
                pigpen.clear()
                ballpen.color(color2)
                ballpen.write("Pig", font=("Arial" ,8, "bold"))
                turtle.pendown()
            elif (y == 4):
                turtle.write("Year "+ answer +" is the Rat!", font=("ariel",25,"bold"))
                turtle.penup()        
                ballpen.goto(30,150)
                Ratpen.clear()
                ballpen.color(color2)
                ballpen.write("Rat", font=("Arial" ,8, "bold"))
                turtle.pendown()
            elif (y == 5):
                turtle.write("Year "+ answer +" is the Ox!", font=("ariel",25,"bold"))
                turtle.penup()
                ballpen.goto(110,110)
                Oxpen.clear()
                ballpen.color(color2)
                ballpen.write("Ox", font=("Arial" ,8, "bold"))
                turtle.pendown()
            elif (y == 6):
                turtle.write("Year "+ answer +" is the Tiger!", font=("ariel",25,"bold"))
                turtle.penup()
                ballpen.goto(140,30)
                Tigerpen.clear()
                ballpen.color(color2)
                ballpen.write("Tiger", font=("Arial" ,8, "bold"))
                turtle.pendown()
            elif (y == 7):
                turtle.write("Year "+ answer +" is the Rabbit!", font=("ariel",25,"bold"))
                turtle.penup()
                ballpen.goto(140,-50)
                Rabbitpen.clear()
                ballpen.color(color2)
                ballpen.write("Rabbit", font=("Arial" ,8, "bold"))
                turtle.pendown()
            elif (y == 8):
                turtle.write("Year "+ answer +" is the Dragon!", font=("ariel",25,"bold"))
                turtle.penup()
                ballpen.goto(95,-120)
                Dragonpen.clear()
                ballpen.color(color2)
                ballpen.write("Dragon", font=("Arial" ,8, "bold"))
                turtle.pendown()
            elif (y == 9):
                turtle.write("Year "+ answer +" is the Snake!", font=("ariel",25,"bold"))
                turtle.penup()
                ballpen.goto(30,-150)
                Snakepen.clear()
                ballpen.color(color2)
                ballpen.write("Snake", font=("Arial" ,8, "bold"))
                turtle.pendown()
            elif (y == 10):
                turtle.write("Year "+ answer +" is the Horse!", font=("ariel",25,"bold"))
                turtle.penup()
                ballpen.goto(-50,-150)
                Horsepen.clear()
                ballpen.color(color2)
                ballpen.write("Horse", font=("Arial" ,8, "bold"))
                turtle.pendown()
            elif (y == 11):
                turtle.write("Year "+ answer +" is the Sheep!", font=("ariel",25,"bold"))
                turtle.penup()
                ballpen.goto(-115,-110)
                Sheeppen.clear()
                ballpen.color(color2)
                ballpen.write("Sheep", font=("Arial" ,8, "bold"))
                turtle.pendown()
            else:
                turtle.write("****** Invalid Input ! ******", font=("ariel",25,"bold")) 
    elif ans > 2016:
            turtle.write("Sorry birth year cannot be in the future !", font=("ariel",15,"bold")) ##if the user i/p is greater than 2016
            ballpen.hideturtle()
    else:
        turtle.write("******Invalid Input ! ******", font=("ariel",25,"bold")) ##if user input isn't greater than 0
else:    
    turtle.write("****** Invalid Input ! ******", font=("ariel",25,"bold")) ##if the user input isn't in digits(0-9)

turtle.done()








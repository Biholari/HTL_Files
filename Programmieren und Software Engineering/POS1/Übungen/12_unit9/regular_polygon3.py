"""
author: Oppermann Fabian
file_name: regular_polygon3.py
"""


import turtle 

def regular_polygon3():
    length = int(input("Seitenlänge: "))
    sides = int(input("Anzahl der Seiten: "))
    colors = []
    turtle.colormode(255)
    for i in range(sides):
        red = int(input(f"Rotanteil der Farbe {i+1}: "))
        green = int(input(f"Grünanteil der Farbe {i+1}: "))
        blue = int(input(f"Blauanteil der Farbe {i+1}: "))
        colors.append((red, green, blue))
    for color in colors:
        turtle.pencolor(color)
        turtle.forward(length)
        turtle.left(360/sides)


regular_polygon3()
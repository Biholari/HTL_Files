"""
author: Oppermann Fabian
file_name regular_polygon.py
"""

import turtle as tr

length = int(input("Seitenlänge: "))
sides = int(input("Anzahl der Seiten: "))


def regular_polygon2():
    colT = []
    indx = 0
    for i in range(sides):
        colN = input(f"Farbe {i+1}: ")
        colT.append(colN)
    for j in colT:
        tr.pencolor(j)
        tr.fd(length)
        tr.lt(360 / sides)

    
regular_polygon2()
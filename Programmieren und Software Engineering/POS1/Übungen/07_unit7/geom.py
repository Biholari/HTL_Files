"""
author = Oppermann Fabian
file_name: geom.py
"""

from geomlib import *
import getpass
from math import sqrt


print("Willkommen beim geometrischen Wunderzwerg!\n")
eingabe = getpass.getpass("(1) Berchnung der Entfernung: eindimensional\n(2) Berchnung der Entfernung: zweidimensional\n(3) Berchnung der Entfernung: dreidimensional\n")


def eindimensional():
    x1 = input("Bitte geben Sie den x-Wert von Punkt 1 ein: ")
    y1 = input("Bitte geben Sie den y-Wert von Punkt 1 ein: ")
    try:
        val = float(x1), float(y1)
    except ValueError:
        print("Das Sind keine Zahlen. ValueError")
    print(distance1(float(x1), float(y1)))


def zweidimensional():
    x1 = input("Bitte geben Sie den x-Wert von Punkt 1 ein: ")
    y1 = input("Bitte geben Sie den y-Wert von Punkt 1 ein: ")
    x2 = input("Bitte geben Sie den x-Wert von Punkt 2 ein: ")
    y2 = input("Bitte geben Sie den y-Wert von Punkt 2 ein: ")
    try:
        val = float(x1), float(y1), float(x2), float(y2)
    except ValueError:
        print("Mindestens eine Eingabe ist keine Zahl. ValueError")
    print(distance2(float(x1), float(y1), float(x2), float(y2)))


def dreidimensional():
    x1 = input("Bitte geben Sie den x-Wert von Punkt 1 ein: ")
    y1 = input("Bitte geben Sie den y-Wert von Punkt 1 ein: ")
    z1 = input("Bitte geben Sie den z-Wert von Punkt 1 ein: ")
    x2 = input("Bitte geben Sie den x-Wert von Punkt 2 ein: ")
    y2 = input("Bitte geben Sie den y-Wert von Punkt 2 ein: ")
    z2 = input("Bitte geben Sie den z-Wert von Punkt 2 ein: ")
    try:
        val = float(x1), float(y1), float(x2), float(y2), float(z1), float(z2)
    except ValueError:
        print("Mindestens eine Eingabe ist keine Zahl. ValueError")
    print(distance3(float(x1), float(y1), float(z1), float(x2), float(y2), float(z2)))


if eingabe == "1":
    eindimensional()
elif eingabe == "2":
    zweidimensional()
elif eingabe == "3":
    dreidimensional()
else:
    print("Falsche Eingabe!")
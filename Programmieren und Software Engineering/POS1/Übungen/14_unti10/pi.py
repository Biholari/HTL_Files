"""
Schreibe ein Programm pi.py, das die Zahl pi berechnet
"""

import math

n = int(input("Bitte geben Sie n ein: "))

pi = 0

for i in range(n):
    pi += 4.0 * (-1)**i / (2*i+1)

print("pi = ", pi)
print("Fehler = ", abs(pi - math.pi))
"""
author = Oppermann Fabian
file_name: geomlib.py
"""

def distance1(x, y):
    return "\nDie Entfernung zwischen dem Punkt {} und dem Punkt {} beträgt {}.".format(x, y, abs(x - y))


def distance2(x1, y1, x2, y2):
    return "\nDie Entfernung zwischen dem Punkt ({},{}) und dem Punkt ({},{}) beträgt {}.".format(x1, y1, x2, y2, round(((x1 - x2) ** 2 + (y1 - y2) ** 2) ** 0.5, 2))


def distance3(x1, y1, z1, x2, y2, z2):
    return "\nDie Entfernung zwwischen dem Punkt ({},{},{}) und dem Punkt ({},{},{}) beträgt {}.".format(x1, y1, z1, x2, y2, z2, round(((x1 - x2) ** 2 + (y1 - y2) ** 2 + (z1 - z2) ** 2) ** 0.5))


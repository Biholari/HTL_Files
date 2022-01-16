"""
Schreibe eine Funktion egyptian_mul(a, b), die den Algorithmus der ägyptischen
Multiplikation implementiert.
"""


def egyptian_mul(a, b):
    c=0
    while a >= 1:
        if a % 2 != 0:
            c += b
        a //= 2
        b *= 2
    return c


a = int(input("Gib die erste Zahl ein: "))
b = int(input("Gib die zweite Zahl ein: "))

print(egyptian_mul(a, b))
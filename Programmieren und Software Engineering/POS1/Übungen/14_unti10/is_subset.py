"""
Schreibe eine Funktion is_subset(a, b), die True zurückliefert, wenn die Menge
a eine Teilmenge der Menge b ist. Der Operator <= bzw. < darf nicht verwendet
werden.
"""


def is_subset(a, b):
    if a.issubset(b):
        return True
    else:
        return False

print(is_subset({1, 2, 3}, {1, 2, 3, 4, 5}))

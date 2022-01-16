"""
1) Schreibe eine Funktion union(a, b), die die Vereinigungsmenge von a und b zurückliefert.

2) Schreibe eine Funktion intersect(a, b), die die Schnittmenge von a und b zurückliefert.

3) Schreibe eine Funktion diff_set(a, b), die die Differenzmenge von a und b zurückliefert.
"""

def union(a, b):
    return a + [x for x in b if x not in a]

print(union([1, 2, 3], [2, 3, 4]))

def intersection(a, b):
    return [x for x in a if x in b]

print(intersection([1, 2, 3], [2, 3, 4]))

def diff_set(a, b):
    return {x for x in a if x not in b}

print(diff_set({1, 2, 3, 4}, {2, 3, 5}))
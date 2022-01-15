"""
author: Oppermann Fabian
file_name: e.py
"""

def e(n):
    """
    Berechnet die Zahl e.
    :param n: Anzahl der Summanden
    :return: e
    """
    summe = 0
    for i in range(n+1):
        summe += 1/factorial(i)
    return summe


def factorial(n):
    """
    Berechnet die Fakultät von n.
    :param n: n
    :return: n!
    """
    if n == 0:
        return 1
    else:
        return n * factorial(n-1)



n = int(input("Bitte geben Sie n ein: "))
print(e(n))

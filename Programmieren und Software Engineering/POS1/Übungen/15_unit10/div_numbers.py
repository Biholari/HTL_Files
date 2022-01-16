"""
Schreibe eine Funktion div_numbers(numbers, i1, i2), die ein Tupel numbers
sowie zwei Zahlen i1 und i2 als Parameter bekommt und den Quotienten der
zweier Zahlen berechnet und zurückliefert.

Der Dividend wird durch den Index i1 im Tupel ermittelt und der Divisor durch
den Index i2 im Tupel ermittelt.

Tritt eine Division durch Null auf, dann soll ein NaN (not a number) Wert zurückgeliefert
werden.
"""

def div_numbers(numbers, i1, i2):
    try:
        return numbers[i1] / numbers[i2]
    except ZeroDivisionError:
        return float("nan")
    except IndexError:
        return None


print(div_numbers((1, 2, 3, 4, 5), 1, 2))
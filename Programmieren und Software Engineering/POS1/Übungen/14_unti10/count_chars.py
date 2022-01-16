"""
Schreibe eine Funktion count_chars(s, c), die die Anzahl der Buchstaben im
String s zurückliefert, die durch den Buchstaben im Parameter c festgelegt worden
sind.
"""


def count_chars(s, c):
    len = 0
    for i in s:
        if c in i:
            len += 1
    print(len)


count_chars("abcabcabc" ,"a")
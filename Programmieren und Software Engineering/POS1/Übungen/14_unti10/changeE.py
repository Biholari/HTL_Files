"""
Schreibe eine Funktion changeE(s), die einen String als Parameter bekommt und
einen String zurückliefert, der alle enthaltenen e in Großbuchstaben gewandelt hat.
"""


n = input("Wort: ")

def changeE(s):
    result = ""
    for c in s:
        if c == "e":
            result += "E"
        else:
            result += c
    return result

print(changeE(n))
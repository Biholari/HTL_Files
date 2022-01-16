"""
Schreibe nun ein Programm divide.py, das den Benutzer nach zwei Indizes fragt
und den Quotienten ausgibt.
"""

def divide(tupel, index1, index2):
    try:
        return tupel[index1] / tupel[index2]
    except ZeroDivisionError:
        print("Division durch 0 nicht möglich")
    except IndexError:
        print("Index nicht vorhanden")
    finally:
        print("Ende")


print(divide((2, 5, 0, 3, 6, 3, 1, 9, 8, 0, 2, 8), 1, 2))
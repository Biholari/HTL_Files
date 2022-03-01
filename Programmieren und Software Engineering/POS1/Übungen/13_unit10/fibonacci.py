"""
author: Oppermann Fabian
file_name: fibonacci.py
"""

def getFibNth(n):
    if n == 1:
        return 0
    if n <= 3:
        return 1
    
    return getFibNth(n - 1) + getFibNth(n - 2)

print(getFibNth(4))

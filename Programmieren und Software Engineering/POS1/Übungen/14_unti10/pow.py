"""
Verwende folgenden in Pseudocode verfassten Algorithmus zum schnellen Potenzieren
zweier Zahlen um eine Python Funktion pow(a, b) zu schreiben:
x := a; y := b; z := 1;
while y > 0 do
begin
if odd(y) then z := z*x;
y := y div 2;
x := x*x;
end;
"""


def pow(a, b):
    x = a
    y = b
    z = 1
    while y > 0:
        if y % 2 == 1:
            z = z * x
        y = y // 2
        x = x * x
    return z


print(pow(2, 3))
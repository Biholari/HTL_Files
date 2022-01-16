import random


def stein_papier_schere():
    userDict = {}
    punkte_mensch = 0
    punkte_computer = 0
    punkte_mensch_definiert = int(input("Wieviele Punkte sind zum Sieg nötig? "))
    username = input("Geben deinen Namen ein: ")
    while punkte_mensch <= punkte_mensch_definiert or punkte_computer <= punkte_mensch_definiert:
        print("Wähle: (1)Stein (2)Papier (3)Schere")
        wahl_mensch = int(input("Mensch: "))
        wahl_computer = random.randint(1,3)
        if wahl_mensch == 1 and wahl_computer == 2:
            print(f"{username[:5]}: Stein Computer: Papier => Computer gewinnt!")
            punkte_computer += 1
        elif wahl_mensch == 1 and wahl_computer == 3:
            print(f"{username[:5]}: Stein Computer: Schere => Mensch gewinnt!")
            punkte_mensch += 1
        elif wahl_mensch == 2 and wahl_computer == 1:
            print(f"{username[:5]}: Papier Computer: Stein => Mensch gewinnt!")
            punkte_mensch += 1
        elif wahl_mensch == 2 and wahl_computer == 3:
            print(f"{username[:5]}: Papier Computer: Schere => Computer gewinnt!")
            punkte_computer += 1
        elif wahl_mensch == 3 and wahl_computer == 1:
            print(f"{username[:5]}: Schere Computer: Stein => Computer gewinnt!")
            punkte_computer += 1
        elif wahl_mensch == 3 and wahl_computer == 2:
            print(f"{username[:5]}: Schere Computer: Papier => Mensch gewinnt!")
            punkte_mensch += 1
        else:
            print("Unentschieden!")
        print(f"Punkte: {username[:5]}", punkte_mensch, "Computer", punkte_computer)
        userDict[username[:5]] = punkte_mensch
        if punkte_mensch >= punkte_mensch_definiert:
            print(f"{username[:5]} hat gewonnen!")
            for key, value in userDict.items():
                print(f"Der Benutzer {key}, hat {value} Punkte!")
                exit()
        elif punkte_computer >= punkte_mensch_definiert:
            print("Computer hat gewonnen!")
            for key, value in userDict.items():
                print(f"Der Benutzer {key}, hat {value} Punkte!")
                exit()


stein_papier_schere()
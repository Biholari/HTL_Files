USE Aufgabe7;

DROP TABLE IF EXISTS Verkauf;
DROP TABLE IF EXISTS Fahrzeug;
DROP TABLE IF EXISTS Modell;
DROP TABLE IF EXISTS Kunde;
DROP TABLE IF EXISTS Hersteller;

CREATE TABLE Hersteller
(
    HerstellerID INT PRIMARY KEY,
    Herstellername VARCHAR(50),
    Land VARCHAR(50)
);

CREATE TABLE Kunde
(
    KundenID INT PRIMARY KEY,
    Name VARCHAR(80),
    Adresse VARCHAR(120),
    Email VARCHAR(100)
);

CREATE TABLE Modell
(
    ModellID INT PRIMARY KEY,
    HerstellerID INT,
    Modellname VARCHAR(50),
    Fahrzeugtyp VARCHAR(20),
    FOREIGN KEY (HerstellerID) REFERENCES Hersteller(HerstellerID)
);

CREATE TABLE Fahrzeug
(
    FahrzeugID INT PRIMARY KEY,
    ModellID INT,
    Baujahr INT,
    Farbe VARCHAR(10),
    Kilometerstand INT,
    Preis DECIMAL(10, 2),
    FOREIGN KEY (ModellID) REFERENCES Modell(ModellID)
);

CREATE TABLE Verkauf
(
    VerkaufID INT PRIMARY KEY,
    FahrzeugID INT,
    KundenID INT,
    Verkaufsdatum DATE,
    Verkaufspreis DECIMAL (10, 2),
    FOREIGN KEY
    (FahrzeugID) REFERENCES Fahrzeug
    (FahrzeugID),
    FOREIGN KEY
    (KundenID) REFERENCES Kunde
    (KundenID)
);

INSERT INTO Hersteller
VALUES
    (1, 'Volkswagen', 'Deutschland'),
    (2, 'Toyota', 'Japan'),
    (3, 'Ford', 'USA'),
    (4, 'Tesla', 'USA'),
    (5, 'BMW', 'Deutschland'),
    (6, 'Audi', 'Deutschland'),
    (7, 'Honda', 'Japan');


INSERT INTO Kunde
VALUES
    (1, 'Lukas M ller', 'Hauptstra e 1, Wien', 'lukas@gmail.at'),
    (2, 'Sarah Huber', 'Marktplatz 2, Graz', 'sarah@gmx.at'),
    (3, 'Felix Bauer', 'Schlossgasse 3, Salzburg', 'felix@yahoo.at'),
    (4, 'Anna Wagner', 'Rathausplatz 4, Innsbruck', 'anna@gmx.at'),
    (5, 'Julia Lehner', 'Donaustra e 5, Linz', 'julia@gmail.at'),
    (6, 'Maximilian Schmid', 'Bergweg 6, Klagenfurt', 'maximilian@gmail.at'),
    (7, 'Laura Fischer', 'Rosengasse 7, Villach', 'laura@gmx.at'),
    (8, 'David Berger', 'Sonnenallee 8, Bregenz', 'david@yahoo.at');

INSERT INTO Modell
VALUES
    (1, 1, 'Golf', 'Kompakt'),
    (2, 2, 'Corolla', 'Kompakt'),
    (3, 3, 'F-150', 'Pickup'),
    (4, 4, 'Model S', 'Sedan'),
    (5, 5, '3 Series', 'Sedan'),
    (6, 7, 'Civic', 'Kompakt'),
    (7, 6, 'A4 Avant', 'Kombi'),
    (8, 6, 'Q2', 'SUV'),
    (9, 1, 'T-Roc', 'SUV'),
    (10, 2, 'Hilux', 'Pickup'),
    (11, 5, 'Passat', 'Kombi');

INSERT INTO Fahrzeug
VALUES
    (1, 1, 2016, 'Antrazit', 150000, 6000.00),
    (2, 1, 2019, 'Silber', 90000, 8000.00),
    (3, 2, 2022, 'Schwarz', 10000, 15000.00),
    (4, 3, 2018, 'Antrazit', 75000, 45000.00),
    (5, 4, 2019, 'Silber', 60000, 48000.00),
    (6, 5, 2020, 'Antrazit', 45000, 25000.00),
    (7, 6, 2017, 'Antrazit', 50000, 15000.00),
    (8, 7, 2019, 'Weiss', 30000, 18000.00),
    (9, 8, 2020, 'Silber', 23000, 25000.00),
    (10, 8, 2022, 'Weiss', 12000, 29000.00),
    (11, 9, 2019, 'Antrazit', 30000, 28000.00),
    (12, 9, 2020, 'Silber', 38000, 27000.00),
    (13, 10, 2018, 'Antrazit', 65000, 31000.00),
    (14, 11, 2021, 'Schwarz', 30000, 21000.00),
    (15, 3, 2023, 'Antrazit', 10, 65000.00);

INSERT INTO Verkauf
VALUES
    (1, 1, 1, '2023-11-15', 6200.00),
    (2, 2, 2, '2022-05-05', 7800.00),
    (3, 3, 5, '2022-03-20', 14444.00),
    (4, 4, 4, '2023-01-22', 38000.00),
    (5, 5, 6, '2023-06-11', 49999.00),
    (6, 6, 2, '2022-08-18', 24000.00),
    (7, 7, 1, '2022-12-08', 15000.00),
    (8, 8, 3, '2023-11-10', 16500.00),
    (9, 9, 6, '2023-01-16', 23000.00),
    (10, 10, 5, '2023-09-12', 28000.00),
    (11, 11, 3, '2022-03-30', 28500.00),
    (12, 12, 1, '2022-07-28', 25000.00),
    (13, 13, 4, '2022-04-04', 30100.00),
    (14, 14, 2, '2022-02-25', 22300.00),
    (15, 15, 5, '2023-10-13', 67999.00);

-- Ermitteln Sie die Anzahl an verkauften Fahrzeugen pro Hersteller absteigend nach der Anzahl der Verkauften Fahrzeuge
SELECT h.Herstellername, COUNT(*) AS 'Anzahl'
FROM Verkauf v
    JOIN Fahrzeug f ON v.FahrzeugID = f.FahrzeugID
    JOIN Modell m ON f.ModellID = m.ModellID
    JOIN Hersteller h ON h.HerstellerID = m.HerstellerID
GROUP BY h.Herstellername
ORDER BY Anzahl;

-- Ermitteln Sie den Gesamtwert aller Fahrzeuge und die Summe der Verkaufserlöse
SELECT m.Modellname, SUM(f.Preis) AS 'Gesamtwert', SUM(f.Preis - v.Verkaufspreis) AS 'Verkaufserlöse'
FROM Fahrzeug f
    JOIN Modell m ON f.ModellID = m.ModellID
    JOIN Verkauf v ON v.FahrzeugID = f.FahrzeugID
GROUP BY m.Modellname;

-- Ermitteln Sie den durchschnittlichen Verkaufspreis pro Herkunftsland aufsteigend nach dem Verkaufspreis ab einem Baujahr größer gleich 2020Ermitteln Sie den durchschnittlichen Verkaufspreis pro Herkunftsland aufsteigend nach dem Verkaufspreis ab einem Baujahr größer gleich 2020
SELECT h.Land, AVG(v.Verkaufspreis) 'Durch. Verkaufspreis'
FROM Verkauf v
    JOIN Fahrzeug f ON v.FahrzeugID = f.FahrzeugID
    JOIN Modell m ON f.ModellID = m.ModellID
    JOIN Hersteller h ON m.HerstellerID = h.HerstellerID
GROUP BY h.Land;

-- Ermitteln Sie die Fahrzeugtypkategorie mit dem höchsten Durchschnittspreis
SELECT TOP 1
    m.Fahrzeugtyp, AVG(f.Preis) AS 'Durchschnittspreis'
FROM Fahrzeug f
    JOIN Modell m ON f.ModellID = m.ModellID
GROUP BY m.Fahrzeugtyp
ORDER BY Durchschnittspreis DESC;

-- Ermitteln Sie pro Autofarbe die Anzahl an Verkäufe und den Gewinn
SELECT f.Farbe, COUNT(*) AS 'Anzahl', SUM(f.Preis - v.Verkaufspreis) AS 'Gewinn'
FROM Verkauf v
    JOIN Fahrzeug f ON v.FahrzeugID = f.FahrzeugID
GROUP BY f.Farbe;

-- Ermitteln Sie die Anzahl an gekauften Autos pro Kunde und die Summe, die er dafür ausgegeben hat
SELECT k.Name, COUNT(*) AS 'Anzahl', SUM(v.Verkaufspreis) AS 'Ausgaben'
FROM Verkauf v
    JOIN Kunde k ON v.KundenID = k.KundenID
GROUP BY k.Name;

-- Ermitteln Sie die Gesamtanzahl der verkauften Fahrzeuge pro Herkunftsland mit mehr als 5 Verkäufen und das Herstellerland mehr als 5 Zeichen aufweist
SELECT COUNT(*) AS 'Anzahl', h.Land
FROM Verkauf v
    JOIN Fahrzeug f ON v.FahrzeugID = f.FahrzeugID
    JOIN Modell m ON f.ModellID = m.ModellID
    JOIN Hersteller h ON m.HerstellerID = m.HerstellerID
WHERE LEN(h.Land) > 5
GROUP BY h.Land
HAVING COUNT(*) > 5;
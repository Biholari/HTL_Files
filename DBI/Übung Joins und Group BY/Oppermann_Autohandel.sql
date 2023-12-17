USE Autohandel;

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
    Verkaufspreis DECIMAL(10, 2),
    FOREIGN KEY (FahrzeugID) REFERENCES Fahrzeug(FahrzeugID),
    FOREIGN KEY (KundenID) REFERENCES Kunde(KundenID)
);


INSERT INTO Hersteller
VALUES
    (1, 'Volkswagen', 'Deutschland');
INSERT INTO Hersteller
VALUES
    (2, 'Toyota', 'Japan');
INSERT INTO Hersteller
VALUES
    (3, 'Ford', 'USA');
INSERT INTO Hersteller
VALUES
    (4, 'Tesla', 'USA');
INSERT INTO Hersteller
VALUES
    (5, 'BMW', 'Deutschland');
INSERT INTO Hersteller
VALUES
    (6, 'Audi', 'Deutschland');
INSERT INTO Hersteller
VALUES
    (7, 'Honda', 'Japan');

INSERT INTO Kunde
VALUES
    (1, 'Lukas M ller', 'Hauptstra e 1, Wien', 'lukas@gmail.at');
INSERT INTO Kunde
VALUES
    (2, 'Sarah Huber', 'Marktplatz 2, Graz', 'sarah@gmx.at');
INSERT INTO Kunde
VALUES
    (3, 'Felix Bauer', 'Schlossgasse 3, Salzburg', 'felix@yahoo.at');
INSERT INTO Kunde
VALUES
    (4, 'Anna Wagner', 'Rathausplatz 4, Innsbruck', 'anna@gmx.at');
INSERT INTO Kunde
VALUES
    (5, 'Julia Lehner', 'Donaustra e 5, Linz', 'julia@gmail.at');
INSERT INTO Kunde
VALUES
    (6, 'Maximilian Schmid', 'Bergweg 6, Klagenfurt', 'maximilian@gmail.at');
INSERT INTO Kunde
VALUES
    (7, 'Laura Fischer', 'Rosengasse 7, Villach', 'laura@gmx.at');
INSERT INTO Kunde
VALUES
    (8, 'David Berger', 'Sonnenallee 8, Bregenz', 'david@yahoo.at');

INSERT INTO Modell
VALUES
    (1, 1, 'Golf', 'Kompakt');
INSERT INTO Modell
VALUES
    (2, 2, 'Corolla', 'Kompakt');
INSERT INTO Modell
VALUES
    (3, 3, 'F-150', 'Pickup');
INSERT INTO Modell
VALUES
    (4, 4, 'Model S', 'Sedan');
INSERT INTO Modell
VALUES
    (5, 5, '3 Series', 'Sedan');
INSERT INTO Modell
VALUES
    (6, 7, 'Civic', 'Kompakt');
INSERT INTO Modell
VALUES
    (7, 6, 'A4 Avant', 'Kombi');
INSERT INTO Modell
VALUES
    (8, 6, 'Q2', 'SUV');
INSERT INTO Modell
VALUES
    (9, 1, 'T-Roc', 'SUV');
INSERT INTO Modell
VALUES
    (10, 2, 'Hilux', 'Pickup');
INSERT INTO Modell
VALUES
    (11, 5, 'Passat', 'Kombi');

INSERT INTO Fahrzeug
VALUES
    (1, 1, 2016, 'Antrazit', 150000, 6000.00);
INSERT INTO Fahrzeug
VALUES
    (2, 1, 2019, 'Silber', 90000, 8000.00);
INSERT INTO Fahrzeug
VALUES
    (3, 2, 2022, 'Schwarz', 10000, 15000.00);
INSERT INTO Fahrzeug
VALUES
    (4, 3, 2018, 'Antrazit', 75000, 45000.00);
INSERT INTO Fahrzeug
VALUES
    (5, 4, 2019, 'Silber', 60000, 48000.00);
INSERT INTO Fahrzeug
VALUES
    (6, 5, 2020, 'Antrazit', 45000, 25000.00);
INSERT INTO Fahrzeug
VALUES
    (7, 6, 2017, 'Antrazit', 50000, 15000.00);
INSERT INTO Fahrzeug
VALUES
    (8, 7, 2019, 'Weiss', 30000, 18000.00);
INSERT INTO Fahrzeug
VALUES
    (9, 8, 2020, 'Silber', 23000, 25000.00);
INSERT INTO Fahrzeug
VALUES
    (10, 8, 2022, 'Weiss', 12000, 29000.00);
INSERT INTO Fahrzeug
VALUES
    (11, 9, 2019, 'Antrazit', 30000, 28000.00);
INSERT INTO Fahrzeug
VALUES
    (12, 9, 2020, 'Silber', 38000, 27000.00);
INSERT INTO Fahrzeug
VALUES
    (13, 10, 2018, 'Antrazit', 65000, 31000.00);
INSERT INTO Fahrzeug
VALUES
    (14, 11, 2021, 'Schwarz', 30000, 21000.00);
INSERT INTO Fahrzeug
VALUES
    (15, 3, 2023, 'Antrazit', 10, 65000.00);

INSERT INTO Verkauf
VALUES
    (1, 1, 1, '2023-11-15', 6200.00);
INSERT INTO Verkauf
VALUES
    (2, 2, 2, '2022-05-05', 7800.00);
INSERT INTO Verkauf
VALUES
    (3, 3, 5, '2022-03-20', 14444.00);
INSERT INTO Verkauf
VALUES
    (4, 4, 4, '2023-01-22', 38000.00);
INSERT INTO Verkauf
VALUES
    (5, 5, 6, '2023-06-11', 49999.00);
INSERT INTO Verkauf
VALUES
    (6, 6, 2, '2022-08-18', 24000.00);
INSERT INTO Verkauf
VALUES
    (7, 7, 1, '2022-12-08', 15000.00);
INSERT INTO Verkauf
VALUES
    (8, 8, 3, '2023-11-10', 16500.00);
INSERT INTO Verkauf
VALUES
    (9, 9, 6, '2023-01-16', 23000.00);
INSERT INTO Verkauf
VALUES
    (10, 10, 5, '2023-09-12', 28000.00);
INSERT INTO Verkauf
VALUES
    (11, 11, 3, '2022-03-30', 28500.00);
INSERT INTO Verkauf
VALUES
    (12, 12, 1, '2022-07-28', 25000.00);
INSERT INTO Verkauf
VALUES
    (13, 13, 4, '2022-04-04', 30100.00);
INSERT INTO Verkauf
VALUES
    (14, 14, 2, '2022-02-25', 22300.00);
INSERT INTO Verkauf
VALUES
    (15, 15, 5, '2023-10-13', 67999.00);

-- 1. Ermitteln Sie die Anzahl an verkauften Fahrzeugen pro Hersteller absteigend nach der Anzahl der Verkauften Fahrzeuge
SELECT Herstellername, COUNT(*) AS Anzahl
FROM Verkauf
    JOIN Fahrzeug ON Verkauf.FahrzeugID = Fahrzeug.FahrzeugID
    JOIN Modell ON Fahrzeug.ModellID = Modell.ModellID
    JOIN Hersteller ON Modell.HerstellerID = Hersteller.HerstellerID
GROUP BY Herstellername
ORDER BY Anzahl DESC;

-- 2. Ermitteln Sie den Gesamtwert aller Fahrzeuge und die Summe der Verkaufserlöse
SELECT Herstellername, SUM(Preis) AS Gesamtwert, SUM(Verkaufspreis) AS Verkaufserlöse
FROM Fahrzeug
    JOIN Modell ON Fahrzeug.ModellID = Modell.ModellID
    JOIN Hersteller ON Modell.HerstellerID = Hersteller.HerstellerID
    JOIN Verkauf ON Fahrzeug.FahrzeugID = Verkauf.FahrzeugID
GROUP BY Herstellername;

-- 3. Ermitteln Sie den durchschnittlichen Verkaufspreis pro Herkunftsland aufsteigend nach dem Verkaufspreis ab einem Baujahr größer gleich 2020
SELECT Land, AVG(Verkaufspreis) AS Durchschnittspreis
FROM Fahrzeug
    JOIN Modell ON Fahrzeug.ModellID = Modell.ModellID
    JOIN Hersteller ON Modell.HerstellerID = Hersteller.HerstellerID
    JOIN Verkauf ON Fahrzeug.FahrzeugID = Verkauf.FahrzeugID
WHERE Baujahr >= 2020
GROUP BY Land
ORDER BY Durchschnittspreis ASC;

-- 4. Ermitteln Sie die Fahrzeugtypkategorie mit dem höchsten Durchschnittspreis
SELECT TOP 1
    Fahrzeugtyp, AVG(Preis) AS Durchschnittspreis
FROM Fahrzeug
    JOIN Modell ON Fahrzeug.ModellID = Modell.ModellID
GROUP BY Fahrzeugtyp
ORDER BY Durchschnittspreis DESC;

-- 5. Ermitteln Sie pro Autofarbe die Anzahl an Verkäufe und den Gewinn
SELECT Farbe, COUNT(*) AS Anzahl, SUM(Preis - Verkaufspreis) AS Gewinn
FROM Fahrzeug
    JOIN Verkauf ON Fahrzeug.FahrzeugID = Verkauf.FahrzeugID
GROUP BY Farbe;

-- 6. Ermitteln Sie die Anzahl an gekauften Autos pro Kunde und die Summe, die er dafür ausgegeben hat
SELECT Name, COUNT(*) AS Anzahl, SUM(Verkaufspreis) AS Ausgaben
FROM Kunde
    JOIN Verkauf ON Kunde.KundenID = Verkauf.KundenID
GROUP BY Name;

-- 7. Ermitteln Sie die Gesamtanzahl der verkauften Fahrzeuge pro Herkunftsland mit mehr als 5 Verkäufen und das Herstellerland mehr als 5 Zeichen aufweist
SELECT Land, COUNT(*) AS Anzahl
FROM Fahrzeug
    JOIN Modell ON Fahrzeug.ModellID = Modell.ModellID
    JOIN Hersteller ON Modell.HerstellerID = Hersteller.HerstellerID
GROUP BY Land
HAVING COUNT(*) > 5 AND LEN(Land) > 5;
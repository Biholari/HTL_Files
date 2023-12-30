CREATE DATABASE Aufgabe6;
USE Aufgabe6;

DROP TABLE IF EXISTS Buch_Bestellung;
DROP TABLE IF EXISTS Bestellung;
DROP TABLE IF EXISTS Buch;
DROP TABLE IF EXISTS Kunde;

CREATE TABLE Kunde
(
    KundeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Ort VARCHAR(40)
);

CREATE TABLE Buch
(
    BuchID INT PRIMARY KEY,
    Titel VARCHAR(100),
    Autor VARCHAR(60),
    Preis DECIMAL(10,2),
    Veröffentlichungsjahr INT
);

CREATE TABLE Bestellung
(
    BestellungID INT PRIMARY KEY,
    KundeID INT,
    Bestelldatum DATE,
    FOREIGN KEY (KundeID) REFERENCES Kunde(KundeID)
);

CREATE TABLE Buch_Bestellung
(
    Buch_BestellungID INT PRIMARY KEY,
    BestellungID INT,
    BuchID INT,
    Anzahl INT,
    FOREIGN KEY (BestellungID) REFERENCES Bestellung(BestellungID),
    FOREIGN KEY (BuchID) REFERENCES Buch(BuchID)
);

INSERT INTO Kunde
    (KundeID, Name, Ort, Email)
VALUES
    (1, 'Anna Schmidt', 'Berlin', 'anna.schmidt@example.com'),
    (2, 'Bernd Müller', 'München', 'bernd.mueller@example.com'),
    (3, 'Christine Bauer', 'Berlin', 'christine.bauer@example.com'),
    (4, 'David Koch', 'Frankfurt', 'david.koch@example.com'),
    (5, 'Erika Mustermann', 'Hamburg', 'erika.mustermann@example.com'),
    (6, 'Frank Weber', 'Stuttgart', 'frank.weber@example.com'),
    (7, 'Greta Lorenz', 'München', 'greta.lorenz@example.com'),
    (8, 'Heiko Klein', 'Dortmund', 'heiko.klein@example.com'),
    (9, 'Ingrid Fischer', 'Essen', 'ingrid.fischer@example.com'),
    (10, 'Jens Vogel', 'Bremen', 'jens.vogel@example.com');

INSERT INTO Buch
    (BuchID, Titel, Autor, Preis, Veröffentlichungsjahr)
VALUES
    (1, 'Die unendliche Geschichte', 'Michael Ende', 18.00, 1979),
    (2, 'Momo', 'Michael Ende', 12.00, 1973),
    (3, 'Der Prozess', 'Franz Kafka', 15.00, 1925),
    (4, 'Das Schloss', 'Franz Kafka', 22.00, 1926),
    (5, 'Demian', 'Hermann Hesse', 9.00, 1919),
    (6, 'Steppenwolf', 'Hermann Hesse', 7.50, 1927),
    (7, 'Der Zauberberg', 'Thomas Mann', 25.00, 1924),
    (8, 'Buddenbrooks', 'Thomas Mann', 14.50, 1901),
    (9, 'Die Blechtrommel', 'Günter Grass', 19.90, 1959),
    (10, 'Im Westen nichts Neues', 'Erich Maria Remarque', 13.00, 1928);

INSERT INTO Bestellung
    (BestellungID, KundeID, Bestelldatum)
VALUES
    (1, 1, '2023-10-01'),
    (2, 2, '2023-10-02'),
    (3, 3, '2023-10-03'),
    (4, 4, '2023-10-04'),
    (5, 5, '2023-10-05'),
    (6, 6, '2023-10-06'),
    (7, 7, '2023-10-07'),
    (8, 8, '2023-10-08'),
    (9, 9, '2023-10-09'),
    (10, 10, '2023-10-10');

INSERT INTO Buch_Bestellung
    (Buch_BestellungID, BestellungID, BuchID, Anzahl)
VALUES
    (1, 1, 1, 1),
    (2, 1, 2, 2),
    (3, 2, 2, 1),
    (4, 2, 3, 1),
    (5, 3, 4, 1),
    (6, 3, 5, 2),
    (7, 4, 6, 1),
    (8, 4, 7, 1),
    (9, 5, 8, 1),
    (10, 5, 9, 3),
    (11, 6, 10, 2),
    (12, 7, 1, 1),
    (13, 7, 3, 1),
    (14, 8, 2, 2),
    (15, 8, 4, 2),
    (16, 9, 5, 3),
    (17, 9, 7, 1),
    (18, 10, 6, 1),
    (19, 10, 8, 1);

-- Ermitteln Sie alle Bücher die mehr als 20 Euro kosten
SELECT *
FROM Buch
WHERE Preis > 20;

-- Ermitteln Sie alle Kunden, die im selben Ort wohnen (JOIN)
SELECT *
FROM Kunde AS k1
    JOIN Kunde k2 ON k1.Ort = k2.Ort
        AND k1.KundeID != k2.KundeID;

-- Ermitteln Sie die Anzahl an Bestellen Büchern für die Bestellung 2
SELECT SUM(Anzahl) AS 'Anzahl bestellter Bücher'
FROM Buch_Bestellung
WHERE BestellungID = 2;

-- Ermitteln Sie alle Kunden (Kundenname) die Bücher (Buchtitel) von Franz Kafka bestellt (Bestelldatum) haben
SELECT k.Name, bu.Titel
FROM Kunde k
    JOIN Bestellung b ON k.KundeID = b.KundeID
    JOIN Buch_Bestellung bb ON b.BestellungID = bb.BestellungID
    JOIN Buch bu ON bb.BuchID = bu.BuchID
WHERE bu.Autor = 'Franz Kafka';

-- Ermitteln Sie den Gesamtwert (Summe) aller Bestellten Bücher
SELECT SUM(bu.Preis * bb.Anzahl) AS 'Gesamtwert'
FROM Buch bu
    JOIN Buch_Bestellung bb ON bu.BuchID = bb.BuchID;

-- Ermitteln Sie alle Bestellungen Kundenname, Bestelldatum die nach dem 4.10.2023 eingegangen sind
SELECT k.Name, b.Bestelldatum
FROM Kunde k
    JOIN Bestellung b ON k.KundeID = b.KundeID
WHERE b.Bestelldatum > '2023-10-04';

-- Ermitteln Sie alle Bestellungen mit dem Buchtitel „Die unendliche Geschichte“
SELECT b.BestellungID, bu.Titel
FROM Bestellung b
    JOIN Buch_Bestellung bb ON b.BestellungID = bb.BestellungID
    JOIN Buch bu ON bu.BuchID = bb.BuchID
WHERE bu.Titel = 'Die unendliche Geschichte';

-- Ermitteln Sie alle Kunden mit der E-Mail - Domain gmail.com
SELECT Name
FROM Kunde
WHERE Email LIKE '%gmail.com';

-- Ermitteln Sie alle Bestellungen, die nur Bücher im Preisbereich zwischen 10 und 15 Euro
SELECT b.BestellungID, bu.Preis
FROM Bestellung b
    JOIN Buch_Bestellung bb ON b.BestellungID = bb.BestellungID
    JOIN Buch bu ON bu.BuchID = bb.BuchID
WHERE bu.Preis BETWEEN 10 AND 15;

-- Ermitteln Sie alle Bestellungen, der Kunden aus „München“ die das Buch „Der Prozess“ bestellt haben
SELECT b.BestellungID, k.Name, k.Ort, bu.Titel
FROM Bestellung b
    JOIN Buch_Bestellung bb ON b.BestellungID = bb.BestellungID
    JOIN Kunde k ON k.KundeID = b.KundeID
    JOIN Buch bu ON bb.BuchID = bu.BuchID
WHERE k.Ort = 'München' AND
    bu.Titel = 'Der Prozess';
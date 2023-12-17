USE Buchladen;

Drop Table if exists Buch_Bestellung;
Drop Table if exists Bestellung;
Drop Table if exists Buch;
Drop Table if exists Kunde;

CREATE TABLE Kunde (
    KundeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Ort VARCHAR(40)
);

CREATE TABLE Buch (
    BuchID INT PRIMARY KEY,
    Titel VARCHAR(100),
    Autor VARCHAR(60),
    Preis DECIMAL(10,2),
    Veröffentlichungsjahr INT
);

CREATE TABLE Bestellung (
    BestellungID INT PRIMARY KEY,
    KundeID INT,
    Bestelldatum DATE,
    FOREIGN KEY (KundeID) REFERENCES Kunde(KundeID)
);

CREATE TABLE Buch_Bestellung (
    Buch_BestellungID INT PRIMARY KEY,
    BestellungID INT,
    BuchID INT,
    Anzahl INT,
    FOREIGN KEY (BestellungID) REFERENCES Bestellung(BestellungID),
    FOREIGN KEY (BuchID) REFERENCES Buch(BuchID)
);

INSERT INTO Kunde (KundeID, Name, Ort, Email) VALUES
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

INSERT INTO Buch (BuchID, Titel, Autor, Preis, Veröffentlichungsjahr) VALUES
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

INSERT INTO Bestellung (BestellungID, KundeID, Bestelldatum) VALUES
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

INSERT INTO Buch_Bestellung (Buch_BestellungID, BestellungID, BuchID, Anzahl) VALUES
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

-- a. Ermitteln Sie alle Bücher die mehr als 20 Euro kosten
SELECT Titel, Preis
FROM Buch
WHERE Preis > 20;

-- b. Ermitteln Sie alle Kunden, die im selben Ort wohnen
SELECT DISTINCT
    k1.KundeID AS Kunde1ID,
    k1.Name AS Kunde1Name,
    k1.Ort AS Kunde1Ort,
    k2.KundeID AS Kunde2ID,
    k2.Name AS Kunde2Name,
    k2.Ort AS Kunde2Ort
FROM
    Kunde k1
JOIN
    Kunde k2 ON k1.Ort = k2.Ort AND k1.KundeID < k2.KundeID;

-- Ermitteln Sie alle Kunden (Kundenname) die Bücher (Buchtitel) von Franz Kafka bestellt (Bestelldatum) haben
SELECT
    Kunde.Name AS Kundenname,
    Buch.Titel AS Buchtitel,
    BUCH.Autor
FROM
    Kunde
JOIN Bestellung ON Kunde.KundeID = Bestellung.KundeID
JOIN Buch_Bestellung ON Bestellung.BestellungID = Buch_Bestellung.BestellungID
JOIN Buch ON Buch_Bestellung.BuchID = Buch.BuchID
WHERE
    Buch.Autor = 'Franz Kafka';

-- Ermitteln Sie den Gesamtwert (Summe) aller Bestellten Bücher
SELECT SUM(Buch.Preis * Buch_Bestellung.Anzahl) AS Gesamtwer
FROM Bestellung
JOIN Buch_Bestellung ON Bestellung.BestellungID = Buch_Bestellung.BestellungID
JOIN Buch ON Buch_Bestellung.BuchID = Buch.BuchID;

-- Ermitteln Sie alle Bestellungen Kundenname, Bestelldatum die nach dem 4.10.2023 eingegangen sind
SELECT BestellungID, K.Name, Bestelldatum
FROM Bestellung
JOIN Kunde K on Bestellung.KundeID = K.KundeID
WHERE Bestelldatum > '10.04.2023';

-- Ermitteln Sie alle Bestellungen mit dem Buchtitel „Die unendliche Geschichte“
SELECT
    *
FROM Kunde
JOIN Bestellung B ON Kunde.KundeID = B.KundeID
JOIN Buch_Bestellung BB on B.BestellungID = BB.BestellungID
JOIN Buch B2 on BB.BuchID = B2.BuchID
WHERE B2.Titel = 'Die unendliche Geschichte';

-- Ermitteln Sie alle Kunden mit der E-Mail - Domain gmail.com
SELECT Name, Email
FROM Kunde
WHERE Email LIKE '%@gmail.com';

-- Ermitteln Sie alle Bestellungen, die nur Bücher im Preisbereich zwischen 10 und 15 Euro
SELECT Be.BestellungID, Titel, B.Preis
FROM Bestellung Be
JOIN Buch_Bestellung BB on Be.BestellungID = BB.BestellungID
JOIN Buch B on BB.BuchID = B.BuchID
WHERE Preis BETWEEN 10 AND 15;

-- Ermitteln Sie alle Bestellungen, der Kunden aus „München“ die das Buch „Der Prozess“ bestellt haben
SELECT Bestellung.BestellungID, K.Name, B.Titel
FROM Bestellung
JOIN Buch_Bestellung BB on Bestellung.BestellungID = BB.BestellungID
JOIN Buch B on BB.BuchID = B.BuchID
JOIN Kunde K on Bestellung.KundeID = K.KundeID
WHERE
    B.Titel = 'Der Prozess' AND
    K.Ort = N'München';
CREATE DATABASE Aufgabe8;
USE Aufgabe8;

DROP TABLE IF EXISTS Note;
DROP TABLE IF EXISTS Fach;
DROP TABLE IF EXISTS Schueler;
DROP TABLE IF EXISTS Klasse;
DROP TABLE IF EXISTS Lehrer;

CREATE TABLE Lehrer
(
    LehrerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Fachbereich VARCHAR(100),
    Email VARCHAR(100),
    CHECK (Email LIKE '%@htlwrn.ac.at'),
);

CREATE TABLE Klasse
(
    KlasseID INT PRIMARY KEY,
    Klassenbezeichnung VARCHAR(50),
    KlassenlehrerID INT,
    Schuljahr INT,
    Raumnummer VARCHAR(10),
    FOREIGN KEY (KlassenlehrerID) REFERENCES Lehrer(LehrerID),
    CHECK (Raumnummer LIKE 'Z%'),
);

CREATE TABLE Schueler
(
    SchuelerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Geburtsjahr INT,
    KlasseID INT,
    FOREIGN KEY (KlasseID) REFERENCES Klasse(KlasseID),
    CHECK (Geburtsjahr > 2000),
);

CREATE TABLE Fach
(
    FachID INT PRIMARY KEY,
    Fachbezeichnung VARCHAR(100),
    LehrerID INT,
    FOREIGN KEY (LehrerID) REFERENCES Lehrer(LehrerID),
    CHECK (Fachbezeichnung IN ('DBI', 'AM', 'E', 'D', 'BWM', 'WMC', 'CABS', 'SYP', 'NSCS')),
);

CREATE TABLE Note
(
    NotenID INT PRIMARY KEY,
    SchuelerID INT,
    FachID INT,
    Note VARCHAR(5),
    Datum DATE,
    FOREIGN KEY (SchuelerID) REFERENCES Schueler(SchuelerID),
    FOREIGN KEY (FachID) REFERENCES Fach(FachID),
    CHECK (Note IN ('1', '2', '3', '4', '5')),
);


INSERT INTO Lehrer
    (LehrerID, Name, Fachbereich, Email)
VALUES
    (1, 'Huber Thomas', 'Mathematik', 'hut@htlwrn.ac.at'),
    (2, 'Brunner Susanne', 'Englisch', 'brs@htlwrn.ac.at'),
    (3, 'Steiger-Lechner Sabine', 'Deutsch', 'sg@htlwrn.ac.at'),
    (4, 'Lackner Sabina', 'Betriebswirtschaft & Management', 'lr@htlwrn.ac.at'),
    (5, 'Reiterer Barbara', 'Fachtheorie Informatik', 'reb@htlwrn.ac.at'),
    (6, 'Eichbarger Jakob', 'Fachtehorie Informatik', 'eij@htlwrn.ac.at'),
    (7, 'Berner Christine', 'Betriebswirtschaft & Management', 'bec@htlwrn.ac.at'),
    (8, 'Weber Margit', 'Fachtheorie Informatik', 'web@htlwrn.ac.at'),
    (9, 'Dorner Elisabeth', 'Mathematik', 'doe@htlwrn.ac.at');

INSERT INTO Klasse
    (KlasseID, Klassenbezeichnung, KlassenlehrerID, Schuljahr, Raumnummer)
VALUES
    (1, '3CHIF', 8, 2023, 'Z104'),
    (2, '4AHIF', 1, 2023, 'Z310'),
    (3, '1AHIF', 2, 2023, 'Z108'),
    (4, '2BHIF', 8, 2023, 'Z101'),
    (5, '1BHIF', 3, 2023, 'Z307'),
    (6, '2AHIF', 9, 2023, 'Z201');

INSERT INTO Schueler
    (SchuelerID, Name, Geburtsjahr, KlasseID)
VALUES
    (1, 'Lee Monade', 2007, 1),
    (2, 'Anna Gramm', 2006, 1),
    (3, 'James Bond', 2005, 2),
    (4, 'Klara Fall', 2004, 2),
    (5, 'Frank Reich', 2009, 3),
    (6, 'Ellen Lang', 2009, 3),
    (7, 'Rob Otter', 2009, 5),
    (8, 'Nick Olaus', 2009, 5),
    (9, 'Reiner Zufall', 2008, 4),
    (10, 'Markus Platz', 2008, 4),
    (11, 'Anna Nass', 2008, 6),
    (12, 'Peter Silie', 2008, 6);

INSERT INTO Fach
    (FachID, Fachbezeichnung, LehrerID)
VALUES
    (1, 'DBI', 8),
    (2, 'DBI', 5),
    (3, 'AM', 1),
    (4, 'AM', 9),
    (5, 'E', 2),
    (6, 'D', 3),
    (7, 'BWM', 4),
    (8, 'BWM', 7),
    (9, 'WMC', 8),
    (10, 'CABS', 8),
    (11, 'SYP', 5),
    (12, 'NSCS', 6);

INSERT INTO Note
    (NotenID, SchuelerID, FachID, Note, Datum)
VALUES
    (1, 1, 1, 2, '2023-06-30'),
    (2, 2, 1, 1, '2023-06-30'),
    (3, 3, 2, 4, '2023-06-30'),
    (4, 4, 5, 5, '2023-06-30'),
    (5, 5, 6, 3, '2023-06-30'),
    (6, 6, 10, 2, '2023-06-30'),
    (7, 7, 12, 2, '2023-06-30'),
    (8, 8, 7, 4, '2023-06-30'),
    (9, 9, 4, 4, '2023-06-30'),
    (10, 10, 11, 1, '2023-06-30'),
    (11, 11, 12, 1, '2023-06-30'),
    (12, 12, 2, 3, '2023-06-30'),
    (13, 12, 1, 3, '2023-06-30'),
    (14, 11, 3, 3, '2023-06-30'),
    (15, 10, 8, 3, '2023-06-30'),
    (16, 9, 9, 4, '2023-06-30'),
    (17, 8, 2, 5, '2023-06-30'),
    (18, 7, 3, 1, '2023-06-30'),
    (19, 6, 1, 1, '2023-06-30'),
    (20, 5, 5, 5, '2023-06-30'),
    (21, 4, 6, 2, '2023-06-30'),
    (22, 3, 7, 3, '2023-06-30'),
    (23, 2, 8, 4, '2023-06-30'),
    (24, 1, 9, 2, '2023-06-30'),
    (25, 1, 10, 3, '2023-06-30'),
    (26, 2, 11, 4, '2023-06-30'),
    (27, 3, 12, 4, '2023-06-30'),
    (28, 4, 6, 3, '2023-06-30'),
    (29, 5, 8, 3, '2023-06-30');

-- Ermitteln Sie die Anzahl der Schüler pro Klasse. Ausgegeben soll die Klasse, Anzahl der Schüler und der Name des Klassenvorstands werden
SELECT
    k.Klassenbezeichnung,
    COUNT(s.SchuelerID) AS 'Schueleranzahl',
    l.Name AS Klassenvorstand
FROM Klasse k
    JOIN Schueler s ON k.KlasseID = s.KlasseID
    JOIN Lehrer l ON k.KlassenlehrerID = l.LehrerID
GROUP BY k.Klassenbezeichnung, l.Name;

-- Ermitteln Sie eine Notenübersicht für alle Noten zum 30.6.2023 im Format. Klasse, Fach, Schüler und Note
SELECT
    k.Klassenbezeichnung,
    f.Fachbezeichnung,
    s.Name,
    n.Note
FROM Note n
    JOIN Schueler s ON n.SchuelerID = s.SchuelerID
    JOIN Fach f ON n.FachID = f.FachID
    JOIN Klasse k ON s.KlasseID = k.KlasseID
WHERE n.Datum = '2023-06-30';

-- Ermitteln Sie welche Lehrer denselben Gegenstand unterrichten. Ausgegeben soll Name des Gegenstandes und die Namen der Lehrer, die dieses unterrichten
SELECT f.Fachbezeichnung, l1.Name, l2.Name
FROM Fach f
    JOIN Lehrer l1 ON f.LehrerID = l1.LehrerID
    JOIN Lehrer l2 ON l2.Fachbereich = l1.Fachbereich
WHERE l1.LehrerID <> l2.LehrerID
    AND l1.LehrerID > l2.LehrerID;

-- Ermitteln Sie wie viele Schüler pro Geburtsjahr in welche Klasse gehen. In der Ausgabe soll das Geburtsjahr, die Klasse und die Anzahl der Schüler enthalten sein
SELECT
    s.Geburtsjahr,
    k.Klassenbezeichnung,
    COUNT(s.SchuelerID) AS 'Schueleranzahl'
FROM Schueler s
    JOIN Klasse k ON s.KlasseID = k.KlasseID
GROUP BY s.Geburtsjahr, k.Klassenbezeichnung;

-- Ermitteln Sie wie viele 1er, 2er und 3er pro Gegenstand vergeben wurden
SELECT
    f.Fachbezeichnung,
    COUNT(IIF(n.Note = 1, 1, NULL)) AS '1er',
    COUNT(IIF(n.Note = 2, 1, NULL)) AS '2er',
    COUNT(IIF(n.Note = 3, 1, NULL)) AS '3er',
    COUNT(IIF(n.Note = 4, 1, NULL)) AS '4er',
    COUNT(IIF(n.Note = 5, 1, NULL)) AS '5er'
FROM Fach f
    JOIN Note n ON f.FachID = n.FachID
GROUP BY f.Fachbezeichnung;
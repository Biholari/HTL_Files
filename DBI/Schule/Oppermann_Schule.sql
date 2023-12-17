Drop Table if exists Note;
Drop Table if exists Fach;
Drop Table if exists Schueler;
Drop Table if exists Klasse;
Drop Table if exists Lehrer;

CREATE TABLE Lehrer (
    LehrerID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Fachbereich VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE INDEX idx_Lehrer_Name ON Lehrer(Name);

Insert Into Lehrer (LehrerID, Name, Fachbereich, Email)
Values (1, 'Huber Thomas', 'Mathematik', 'hut@htlwrn.ac.at'),
       (2, 'Brunner Susanne', 'Englisch', 'brs@htlwrn.ac.at'),
       (3, 'Steiger-Lechner Sabine', 'Deutsch', 'sg@htlwrn.ac.at'),
       (4, 'Lackner Sabina', 'Betriebswirtschaft & Management', 'lr@htlwrn.ac.at'),
       (5, 'Reiterer Barbara', 'Fachtheorie Informatik', 'reb@htlwrn.ac.at'),
       (6, 'Eichbarger Jakob', 'Fachtehorie Informatik', 'eij@htlwrn.ac.at'),
       (7, 'Berner Christine', 'Betriebswirtschaft & Management', 'bec@htlwrn.ac.at'),
       (8, 'Weber Margit', 'Fachtheorie Informatik', 'web@htlwrn.ac.at'),
       (9, 'Dorner Elisabeth', 'Mathematik', 'doe@htlwrn.ac.at');

CREATE TABLE Klasse (
    KlasseID INT PRIMARY KEY NOT NULL,
    Klassenbezeichnung VARCHAR(50) NOT NULL,
    KlassenlehrerID INT,
    Schuljahr INT,
    Raumnummer VARCHAR(10) NOT NULL,
    FOREIGN KEY (KlassenlehrerID) REFERENCES Lehrer(LehrerID)
);

CREATE INDEX idx_Klasse_Raumnummer ON Klasse(Raumnummer);

Insert Into Klasse(KlasseID, Klassenbezeichnung, KlassenlehrerID, Schuljahr, Raumnummer)
Values (1, '3CHIF', 8, 2023, 'Z104'),
       (2, '4AHIF', 1, 2023, 'Z310'),
       (3, '1AHIF', 2, 2023, 'Z108'),
       (4, '2BHIF', 8, 2023, 'Z101'),
       (5, '1BHIF', 3, 2023, 'Z307'),
       (6, '2AHIF', 9, 2023, 'Z201');

CREATE TABLE Schueler (
    SchuelerID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Geburtsjahr INT NOT NULL,
    KlasseID INT NOT NULL,
    FOREIGN KEY (KlasseID) REFERENCES Klasse(KlasseID)
);

CREATE INDEX idx_Schueler_Name ON Schueler(Name);

Insert Into Schueler(SchuelerID, Name, Geburtsjahr, KlasseID)
Values (1, 'Lee Monade', 2007, 1),
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

CREATE TABLE Fach (
    FachID INT PRIMARY KEY NOT NULL,
    Fachbezeichnung VARCHAR(100) NOT NULL,
    LehrerID INT NOT NULL,
    FOREIGN KEY (LehrerID) REFERENCES Lehrer(LehrerID)
);

CREATE INDEX idx_Fach_Fachbezeichnung ON Fach(Fachbezeichnung);

Insert Into Fach(FachID, Fachbezeichnung, LehrerID)
Values (1, 'DBI', 8),
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

CREATE TABLE Note (
    NotenID INT PRIMARY KEY NOT NULL,
    SchuelerID INT NOT NULL,
    FachID INT NOT NULL,
    Note VARCHAR(5) NOT NULL,
    Datum DATE NOT NULL,
    FOREIGN KEY (SchuelerID) REFERENCES Schueler(SchuelerID),
    FOREIGN KEY (FachID) REFERENCES Fach(FachID)
);

CREATE INDEX idx_Note_Note ON Note(Note);

Insert Into Note(NotenID, SchuelerID, FachID, Note, Datum)
Values (1, 1, 1, 2, '2023-06-30'),
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


-- 1. Ermitteln Sie die Anzahl der Schüler pro Klasse. Ausgegeben soll die Klasse, Anzahl der Schüler und der Name des Klassenvorstands werden
SELECT
    Klassenbezeichnung,
    COUNT(S.SchuelerID) AS Anzahl,
    L.Name AS Klassenvorstand
FROM Klasse
JOIN Lehrer L on Klasse.KlassenlehrerID = L.LehrerID
JOIN Schueler S on Klasse.KlasseID = S.KlasseID
GROUP BY L.Name, Klassenbezeichnung;

-- 2. Ermitteln Sie eine Notenübersicht für alle Noten zum 30.6.2023 im Format. Klasse, Fach, Schüler und Note
SELECT
    K.Klassenbezeichnung,
    F.Fachbezeichnung,
    S.Name AS Schueler,
    N.Note
FROM Note N
JOIN Schueler S ON N.SchuelerID = S.SchuelerID
JOIN Fach F ON N.FachID = F.FachID
JOIN Klasse K ON S.KlasseID = K.KlasseID
WHERE N.Datum = '2023-06-30';

-- 3. Ermitteln Sie welche Lehrer denselben Gegenstand unterrichten. Ausgegeben soll Name des Gegenstandes und die Namen der Lehrer, die dieses unterrichten.
SELECT
    F.Fachbezeichnung AS Gegenstand,
    L1.Name AS Lehrer1,
    L2.Name AS Lehrer2
FROM Fach F
JOIN Lehrer L1 ON F.LehrerID = L1.LehrerID
JOIN Lehrer L2 ON F.LehrerID = L2.LehrerID AND L1.LehrerID <> L2.LehrerID;


-- 4. Ermitteln Sie wie viele Schüler pro Geburtsjahr in welche Klasse gehen. In der Ausgabe soll das Geburtsjahr, die Klasse und die Anzahl der Schüler enthalten sein.
SELECT
    S.Geburtsjahr,
    K.Klassenbezeichnung AS Klasse,
    COUNT(S.SchuelerID) AS AnzahlSchueler
FROM Schueler S
JOIN Klasse K ON S.KlasseID = K.KlasseID
GROUP BY S.Geburtsjahr, K.Klassenbezeichnung
ORDER BY S.Geburtsjahr, K.Klassenbezeichnung;

-- 5. Ermitteln Sie wie viele 1er, 2er und 3er pro Gegenstand vergeben wurden
SELECT
    F.Fachbezeichnung AS Gegenstand,
    COUNT(IIF(N.Note = 1, 1, NULL)) AS 'Anzahl 1er',
    COUNT(IIF(N.Note = 2, 1, NULL)) AS 'Anzahl 2er',
    COUNT(IIF(N.Note = 3, 1, NULL)) AS 'Anzahl 3er'
FROM Fach F
JOIN Note N ON F.FachID = N.FachID
GROUP BY F.Fachbezeichnung;

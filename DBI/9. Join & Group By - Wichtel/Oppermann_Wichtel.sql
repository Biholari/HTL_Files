CREATE DATABASE Aufgabe9;
USE Aufgabe9;

DROP TABLE IF EXISTS Wichtel;
DROP TABLE IF EXISTS Geschenk;
DROP TABLE IF EXISTS Schueler;
DROP TABLE IF EXISTS Klasse;

CREATE TABLE Klasse
(
    ID INTEGER IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(10)
);

CREATE TABLE Schueler
(
    ID INTEGER IDENTITY(1,1) PRIMARY KEY,
    Vorname VARCHAR(100),
    Nachname VARCHAR(100),
    KlasseID INTEGER REFERENCES Klasse(ID)
);

CREATE TABLE Geschenk
(
    ID INTEGER IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Wichtel
(
    VonID INTEGER REFERENCES Schueler(ID),
    FuerID INTEGER REFERENCES Schueler(ID),
    GeschenkID INTEGER REFERENCES Geschenk(ID)
        PRIMARY KEY (VonID, FuerID, GeschenkID)
);

INSERT INTO Klasse
    (Name)
VALUES
    ('3AHIF'),
    ('3BHIF'),
    ('3CHIF');

INSERT INTO Schueler
    (Nachname, Vorname, KlasseID)
VALUES
    ('Biholari', 'Peruta-Denisa', 1),
    ('Böjte', 'Attila', 1),
    ('Brzozowski', 'Jakub', 1),
    ('Fass', 'Daniel', 1),
    ('Gosling', 'James', 1),
    ('Hasel', 'Philipp', 1),
    ('Hausegger', 'Clemens', 1),
    ('Jakab', 'Oliver', 1),
    ('Kientzl', 'Lennard', 1),
    ('Kleinschuster', 'Daniel', 1),
    ('Kovacs', 'Kristof', 1),
    ('Meixner', 'Bill', 1),
    ('Müllner', 'Alexander', 1),
    ('Onur', 'Alperen', 1),
    ('Oppermann', 'Fabian', 1),
    ('Peinthor', 'Theresa', 1),
    ('Reisner', 'Jan', 1),
    ('Reithofer', 'Viktor', 1),
    ('Römer', 'Florian', 1),
    ('Rottensteiner', 'Matthias', 1),
    ('Schnabl', 'Oliver', 1),
    ('Schrammel', 'Felix', 1),
    ('Schumy', 'Michael', 1),
    ('Steurer', 'Tanja Maria', 1),
    ('Weghofer', 'Samuel', 1),
    ('Yildiz', 'Muhammet Fatih', 1),
    ('Al-Ramahi', 'Josef', 2),
    ('Al-Yadumi', 'Osama', 2),
    ('Basdogan', 'Tugba', 2),
    ('Bernhardt', 'Alexander', 2),
    ('Edris', 'Khaled', 2),
    ('Forthuber', 'Paul Flynn', 2),
    ('Golban', 'Denis Nicolae', 2),
    ('Jungmann', 'Jakob', 2),
    ('Kelta', 'Ellias', 2),
    ('Kizarmis', 'Cem', 2),
    ('Kucharko', 'Filip', 2),
    ('Operschall', 'Robin', 2),
    ('Pauly', 'Eric', 2),
    ('Pestitschek', 'Benjamin', 2),
    ('Pobenberger', 'Niklas', 2),
    ('Rodax', 'Elias', 2),
    ('Seewald', 'Oliver', 2),
    ('Spreitzgrabner', 'Sebastian', 2),
    ('Stiller', 'Johannes', 2),
    ('Völkerer', 'Andreas', 2),
    ('Wirth', 'Maximilian', 2),
    ('Zejma', 'Gabriel', 2),
    ('Alam', 'Itmam', 3),
    ('Behr', 'Reinhard Sebastian', 3),
    ('BRANDauer', 'Simon', 3),
    ('Chapman', 'Maximilian', 3),
    ('David', 'Constantin', 3),
    ('Depisch', 'Nico', 3),
    ('Graf', 'Julian', 3),
    ('Hartner', 'Max', 3),
    ('Hofbauer', 'Elias', 3),
    ('Honsowitz', 'Lukas', 3),
    ('Lehmann', 'Jonas', 3),
    ('Lehner', 'Faris', 3),
    ('Lottenbach', 'Nico', 3),
    ('Meerkatz', 'Manuel', 3),
    ('Miletic', 'Danijel', 3),
    ('Moser', 'Sven', 3),
    ('Müller', 'Tim', 3),
    ('Neugebauer', 'Moritz', 3),
    ('Oltean', 'Nico', 3),
    ('Papp', 'Akos', 3),
    ('Pöttschacher', 'Moritz', 3),
    ('Redzic', 'Eldin', 3),
    ('Salama', 'Marawan', 3),
    ('Schmidtberger', 'Ben', 3),
    ('Schmikal', 'Stefan', 3),
    ('Solak', 'Lazar', 3),
    ('Stojic', 'David', 3);

INSERT INTO Geschenk
    (Name)
VALUES
    ('Socken'),
    ('Krawatte'),
    ('Poker Koffer'),
    ('Poker Karten'),
    ('Netflix für 1 Monat'),
    ('Disney+ für 1 Monat'),
    ('Demon Slayer Band 15'),
    ('GTA 6'),
    ('Groot Figur'),
    ('Boo Hoo Figur'),
    ('Programmieren für Dummies'),
    ('Datenbanken für Dummies'),
    ('Yoshi Figur'),
    ('Fifa 23'),
    ('Princess Peach Showtime!'),
    ('Pokemon Sticker'),
    ('Codenames');

WHILE (SELECT COUNT(*)
FROM Wichtel) <= 75
BEGIN
    INSERT INTO Wichtel
        (VonID, FuerID, GeschenkID)
    VALUES
        (
            (CAST((RAND() * 100) AS INT)) % 75 + 1,
            (CAST((RAND() * 100) AS INT)) % 75 + 1,
            (CAST((RAND() * 100) AS INT)) % (SELECT COUNT(*)
            FROM Geschenk) + 1
    );
END;

-- Ermitteln Sie alle Schüler, die anderen Schülern etwas schenken. Ausgegebene Spalten: Secret Santa (Vorname + Nachname), Schüler (Vorname + Nachname), Geschenk
SELECT CONCAT(s1.Vorname, ' ', s1.Nachname) AS 'Secret Santa', CONCAT(s2.Vorname, ' ', s2.Nachname) AS 'Geschenk', g.Name
FROM Wichtel w
    JOIN Schueler s1 ON w.VonID = s1.ID
    JOIN Schueler s2 ON w.FuerID = s2.ID
    JOIN Geschenk g ON w.GeschenkID = g.ID
WHERE s1.ID <> s2.ID;

-- Überprüfen Sie, ob es einen Schüler gibt, der sich selbst etwas schenkt.
SELECT CONCAT(s1.Vorname, ' ', s1.Nachname)
FROM Wichtel w
    JOIN Schueler s1 ON w.VonID = s1.ID
    JOIN Schueler s2 ON w.FuerID = s2.ID
WHERE s1.ID = s2.ID;

-- Überprüfen Sie, ob es einen Schüler gibt, der niemanden etwas schenkt.
SELECT CONCAT(s.Vorname, ' ', s.Nachname) AS FullName
FROM Schueler s
    LEFT JOIN Wichtel w ON s.ID = w.VonID
WHERE w.VonID IS NULL OR w.VonID IS NULL;


-- Ermitteln Sie alle Schüler, die mindestens 2 anderen Schülern etwas schenken.
SELECT CONCAT(s.Vorname, ' ', s.Nachname) AS 'Secret Santa', COUNT(w.VonID) AS 'Anzahl'
FROM Wichtel w
    JOIN Schueler s ON w.VonID = s.ID
GROUP BY s.Vorname, s.Nachname
HAVING COUNT(w.VonID) >= 2;

-- Ermitteln Sie wie oft ein Geschenk verschenkt wurde.
SELECT g.Name, COUNT(g.ID) AS Anzahl
FROM Wichtel w
    JOIN Geschenk g ON w.GeschenkID = g.ID
GROUP BY g.Name;

-- Ermitteln Sie welche Schüler klassenübergreifend anderen Schülern etwas schenken. Gruppieren Sie dabei nach der Klasse und zählen Sie die Anzahl der Schüler.
SELECT
    K.Name AS VonKlasse,
    K2.Name AS FuerKlasse,
    COUNT(DISTINCT W.VonID) AS AnzahlSchueler
FROM Klasse K
    JOIN Schueler S ON K.ID = S.KlasseID
    JOIN Wichtel W ON S.ID = W.VonID
    JOIN Schueler S2 ON W.FuerID = S2.ID
    JOIN Klasse K2 ON S2.KlasseID = K2.ID
WHERE K.ID <> K2.ID
GROUP BY K.Name, K2.Name;


-- Ermitteln Sie die Top 3 unbeliebteren Geschenke.
SELECT TOP 3
    g.Name, COUNT(g.ID) AS Anzahl
FROM Wichtel w
    JOIN Geschenk g ON w.GeschenkID = g.ID
GROUP BY g.Name
ORDER BY Anzahl ASC;
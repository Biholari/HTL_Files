-- Datum: 15.04.2024
-- Name: Fabian Oppermann
-- Aufgabe: Praktische Arbeit 3

CREATE DATABASE PA3;
USE PA3;

DROP TABLE IF EXISTS Mahnung;
DROP TABLE IF EXISTS Entlehnung;
DROP TABLE IF EXISTS Exemplar;
DROP TABLE IF EXISTS Buch;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Mahntyp;

CREATE TABLE Mahntyp
(
    MahntypID INT PRIMARY KEY,
    Bezeichnung VARCHAR(255),
    FaelligInTagen DATE
);

CREATE TABLE Person
(
    PNr INT PRIMARY KEY,
    Name VARCHAR(255),
    Vorname VARCHAR(255),
    Geburtsdatum DATE,
    Jahresbetrag DECIMAL(10, 2),
    Entlengebuehren DECIMAL(10, 2),
    MahntypID INT REFERENCES Mahntyp(MahntypID)
);

CREATE TABLE Buch
(
    ISBN VARCHAR(255) PRIMARY KEY,
    Titel VARCHAR(255),
    Gebiet VARCHAR(255),
    Auflage INT,
    Erscheinungsjahr DATE,
);

CREATE TABLE Exemplar
(
    ISBN VARCHAR(255) REFERENCES Buch(ISBN),
    LfndNr INT,
    Kaufdatum DATE,
    Kaufort VARCHAR(255),
    Einkaufspreis DECIMAL(10, 2),
    Verkaufspreis DECIMAL(10, 2),
    Zustand VARCHAR(255),
    PRIMARY KEY(ISBN, LfndNr)
);

CREATE TABLE Entlehnung
(
    EntlehnungID INT PRIMARY KEY,
    ISBN VARCHAR(255),
    LfndNr INT,
    PNr INT,
    VerleihDat DATE,
    RueckDat DATE,
    FOREIGN KEY(ISBN, LfndNr) REFERENCES Exemplar(ISBN, LfndNr),
    FOREIGN KEY(PNr) REFERENCES Person(PNr)
);

CREATE TABLE Mahnung
(
    EntlehnungID INT REFERENCES Entlehnung(EntlehnungID),
    MahntypID INT REFERENCES Mahntyp(MahntypID),
);


-- 1
/*
Ermitteln Sie die 3 Exemplare, die nicht oder am seltensten zwischen 1.12.2015 und 1.1.2016
ausgeliehen wurden und deren Kaufort bekannt ist
Ausgabespalten: ISBN, Titel, Anzahl der Entlehnungen
*/
SELECT TOP 3
    e.ISBN, b.Titel, COUNT(e.ISBN) AS [Anzahl der Entlehnungen]
FROM Exemplar e
    JOIN Buch b ON e.ISBN = b.ISBN
    LEFT JOIN Entlehnung ent ON e.ISBN = ent.ISBN AND e.LfndNr = ent.LfndNr
WHERE e.Kaufort IS NOT NULL AND (ent.VerleihDat BETWEEN '2015-12-01' AND '2016-01-01')
GROUP BY e.ISBN, b.Titel
ORDER BY COUNT(e.ISBN) ASC;

-- 2 
/*
Ermitteln Sie die Entlehngebühr pro Buch für die Dauer der Entlehnung. Hinweis: datediff(day,
datum, datum)+1. Ausgabespalten: Titel, Summe der Entlehngebühr
*/
SELECT 
    b.Titel, 
    SUM(DATEDIFF(DAY, ent.VerleihDat, ent.RueckDat) + 1 * e.Einkaufspreis) AS [Summe der Entlehngebühr]
FROM Buch b
    JOIN Exemplar e ON b.ISBN = e.ISBN
    JOIN Entlehnung ent ON e.ISBN = ent.ISBN AND e.LfndNr = ent.LfndNr
GROUP BY b.Titel;

-- 3
/*
Ermitteln Sie die Bücher, die länger als die durchschnittliche Entlehndauer aller Bücher,
ausgeborgt wurden. Hinweis: datediff(day, datum, datum)+1. Ausgabespalten: ISBN, Titel,
Durchschnittle Entlehndauer
*/
SELECT b.ISBN, b.Titel, AVG(DATEDIFF(DAY, ent.RueckDat, ent.VerleihDat) + 1) AS [Durchschnittliche Entlehndauer]
FROM Buch b
    JOIN Exemplar e ON b.ISBN = e.ISBN
    JOIN Entlehnung ent ON e.ISBN = ent.ISBN AND e.LfndNr = ent.LfndNr
GROUP BY b.ISBN, b.Titel
HAVING AVG(DATEDIFF(DAY, ent.RueckDat, ent.VerleihDat) + 1) > (
    SELECT AVG(DATEDIFF(DAY, ent1.RueckDat, ent1.VerleihDat) + 1)
    FROM Entlehnung ent1
);

-- 4
/*
Ermitteln Sie alle Exemplare, die mindestens 4 Mahnungen erhalten haben.
Ausgabespalten: ISBN, Anzahl der Mahnungen
*/
SELECT e.ISBN, COUNT(m.EntlehnungID) AS [Anzahl der Mahnungen]
FROM Exemplar e
    JOIN Entlehnung ent ON e.ISBN = ent.ISBN AND e.LfndNr = ent.LfndNr
    JOIN Mahnung m ON ent.EntlehnungID = m.EntlehnungID
GROUP BY e.ISBN
HAVING COUNT(m.EntlehnungID) >= 4;

-- 5
/*
Ermitteln Sie alle Entlehnungen, die alle Mahntypen erhalten haben
*/
SELECT *
FROM Entlehnung e
WHERE NOT EXISTS (
    SELECT m.MahntypID
    FROM Mahntyp m
    WHERE NOT EXISTS (
        SELECT *
        FROM Mahnung mn
        WHERE mn.EntlehnungID = e.EntlehnungID AND mn.MahntypID = m.MahntypID
    )
);

-- 6
/*
Ermitteln Sie alle Personen, die nichts entlehnt haben. Ausgabespalten: PNr, Vorname,
Nachname
a) Lösen Sie diese Aufgabe mit Join und/oder Subselects
b) Lösen Sie diese Aufgabe mit Mengenoperation
*/
-- a
SELECT p.PNr, p.Vorname, p.Name
FROM Person p
    LEFT JOIN Entlehnung ent ON p.PNr = ent.PNr
WHERE ent.PNr IS NULL;

-- b
    SELECT PNr, Vorname, Name
    FROM Person
EXCEPT
    SELECT ent.PNr, p.Vorname, Name
    FROM Entlehnung ent
        JOIN Person p ON ent.PNr = p.PNr;

-- 7
/*
Ermitteln Sie alle Personen, deren MahntypID einen inkorrekten Wert haben, indem Sie für die
Mahnung den "höchsten" Mahntyp finden und mit dem der Person vergleichen. Hinweis: Nutzen
Sie coalesce(Spalte, defaultwert) für mögliche NULL-Werte.
Ausgabespalte: Vorname + Nachname
*/
SELECT p.Vorname + ' ' + p.Name AS [Name]
FROM Person p
    JOIN Mahntyp m ON p.MahntypID = m.MahntypID
    JOIN Entlehnung ent ON p.PNr = ent.PNr
    JOIN Mahnung mn ON ent.EntlehnungID = mn.EntlehnungID
GROUP BY p.Vorname, p.Name, p.MahntypID
HAVING p.MahntypID <> COALESCE((
    SELECT MAX(m1.MahntypID)
    FROM Mahntyp m1
), 0);

-- 8
/*
Ermitteln Sie a) mit Hilfe einer lokalen View die Bücher, die kein Exemplar besitzen sowie noch
nie entlehnt wurden. Nutzen Sie diese lokale View um b) die Anzahl der Exemplare (inkl. Bücher,
die kein Exemplar besitzen) zu ermitteln. Ausgabespalten: ISBN, Titel, Anzahl Bücher
*/
-- a
GO
CREATE VIEW BuchOhneExemplar AS
SELECT b.ISBN, b.Titel
FROM Buch b
    LEFT JOIN Exemplar e ON b.ISBN = e.ISBN
WHERE e.ISBN IS NULL;
GO

SELECT *
FROM BuchOhneExemplar;

-- b
SELECT COUNT(*) AS [Anzahl Buecher]
FROM BuchOhneExemplar
GROUP BY BuchOhneExemplar.ISBN, BuchOhneExemplar.Titel;

-- 9
/*
Ermitteln Sie alle Exemplare, die nicht im Zeitraum zwischen 1.12.2015 und 1.1.2016 entlehnt
wurden oder deren Buch im Titel den Buchstaben 'e' enthalten. Lösen Sie diese Aufgabe mit
Subselect(s). Ausgabespalte: ISBN, Kaufdatum, Kaufort
*/
SELECT e.ISBN,
    e.Kaufdatum,
    e.Kaufort
FROM Exemplar e
WHERE e.ISBN NOT IN (
        SELECT e1.ISBN
        FROM Entlehnung ent
            JOIN Exemplar e1 ON ent.ISBN = e1.ISBN
            AND ent.LfndNr = e1.LfndNr
        WHERE ent.VerleihDat BETWEEN '2015-12-01' AND '2016-01-01'
    )
    OR e.ISBN IN (
        SELECT e2.ISBN
        FROM Buch b
            JOIN Exemplar e2 ON b.ISBN = e2.ISBN
        WHERE b.Titel LIKE '%e%'
    );

-- 10
/*
Die Person mit der ID 1 hat mehrmals entlehnte Exemplare in einem sehr schlechten Zustand
zurück gebracht, deshalb wird diese Person aus dem System gelöscht, damit sie keine
Entlehnungen durchführen kann. Wie gehen Sie mit den dazugehörigen Daten um? Was sind die
Vor- und Nachteile Ihrer Lösung?
*/
-- Lösung:
/*
Die Person wird aus der Tabelle Person gelöscht. Die dazugehörigen Entlehnungen werden
ebenfalls gelöscht, da sie sonst keine Referenz mehr auf die Person haben. Die dazugehörigen
Mahnungen werden ebenfalls gelöscht, da sie sonst keine Referenz mehr auf die Entlehnung haben.
Die dazugehörigen Exemplare werden nicht gelöscht, da sie noch von anderen Personen entlehnt
werden können. Die dazugehörigen Bücher werden ebenfalls nicht gelöscht, da sie noch von
anderen Exemplaren entlehnt werden können.
Vorteile:
- Die Person kann keine Entlehnungen mehr durchführen
- Die Entlehnungen und Mahnungen der Person werden gelöscht
Nachteile:
*/

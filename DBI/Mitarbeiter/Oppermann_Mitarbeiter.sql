PRAGMA foreign_keys=ON;
.headers on
.mode column
.nullvalue NULL

Drop Table if exists Mitarbeiter;

DROP INDEX IF EXISTS MitarbeiterIDX_Nachname;
DROP INDEX IF EXISTS MitarbeiterIDX_Vorname;
DROP INDEX IF EXISTS MitarbeiterIDX_Position;
DROP INDEX IF EXISTS MitarbeiterIDX_Abteilung;

CREATE TABLE Mitarbeiter (
    MitarbeiterID INT PRIMARY KEY NOT NULL,
    Vorname VARCHAR(50) NOT NULL,
    Nachname VARCHAR(50) NOT NULL,
    Geburtsdatum DATE NOT NULL CHECK ( Geburtsdatum < Eintrittsdatum ),
    Eintrittsdatum DATE NOT NULL CHECK ( Eintrittsdatum > Geburtsdatum ),
    Gehalt DECIMAL(8,2) NOT NULL CHECK ( Gehalt >= 12000 ),
    Position VARCHAR(50) NOT NULL,
    Abteilung VARCHAR(50) NOT NULL,
    CHECK ( length(Vorname) > 0 AND length(Nachname) > 0),
    UNIQUE (Nachname, Vorname)
);

-- Index erstellen
CREATE INDEX MitarbeiterIDX_Nachname ON Mitarbeiter(Nachname);
CREATE INDEX MitarbeiterIDX_Vorname ON Mitarbeiter(Vorname);
CREATE INDEX MitarbeiterIDX_Position ON Mitarbeiter(Position);
CREATE INDEX MitarbeiterIDX_Abteilung ON Mitarbeiter(Abteilung);

INSERT INTO Mitarbeiter (MitarbeiterID, Vorname, Nachname, Geburtsdatum, Eintrittsdatum, Gehalt, Position, Abteilung) VALUES
(1, 'Anna', 'M�ller', '1985-03-15', '2015-05-10', 60000, 'Entwickler', 'IT'),
(2, 'Bernd', 'Schmidt', '1990-07-22', '2018-03-12', 55000, 'Vertriebsmanager', 'Vertrieb'),
(3, 'Carla', 'Klein', '1982-11-03', '2010-01-15', 65000, 'HR Manager', 'HR'),
(4, 'Daniel', 'Gro�', '1975-02-28', '2005-09-30', 70000, 'Teamleiter', 'IT'),
(5, 'Elisabeth', 'Fuchs', '1988-05-19', '2016-11-02', 72000, 'Marketing Spezialist', 'Marketing'),
(6, 'Felix', 'Weber', '1971-12-12', '2003-08-18', 80000, 'CFO', 'Finanzen'),
(7, 'Gabi', 'Fischer', '1992-04-07', '2019-07-10', 62000, 'Data Analyst', 'IT'),
(8, 'Hans', 'Meier', '1987-06-23', '2012-05-05', 75000, 'Produktmanager', 'Marketing'),
(9, 'Irina', 'Schwarz', '1993-01-29', '2021-02-01', 60000, 'Rekruter', 'HR'),
(10, 'Johann', 'Braun', '1980-08-15', '2007-10-20', 68000, 'Buchhalter', 'Finanzen');


-- Vorname, Nachname und Geburtsdatum der Mitarbeiter
SELECT Vorname, Nachname, Geburtsdatum
FROM Mitarbeiter;

-- Mitarbeiter mit Vorname, Nachname und Alter
SELECT Vorname, Nachname, strftime('%Y', 'now') - strftime('%Y', Geburtsdatum) AS 'Alter'
FROM Mitarbeiter;

-- Mitarbeiter mit monatlichem Gehalt und Nachname in Großbuchstaben
SELECT UPPER(Nachname) AS Nachname, Gehalt / 12 AS Monatliches_Gehalt
FROM Mitarbeiter;

-- Mitarbeiter mit Vorname, Nachname, Anzahl an Tagen und Monaten im Unternehmen
SELECT
   Vorname,
   Nachname,
   CAST((julianday('now') - julianday(Eintrittsdatum)) AS INTEGER) AS Tage,
   (abs(strftime('%Y', 'now') - strftime('%Y', Eintrittsdatum))) * 12 + abs(strftime('%m', 'now') - strftime('%m', Eintrittsdatum)) AS Monate
FROM Mitarbeiter;

-- Durchschnittsgehalt aller Mitarbeiter mit Alias "Durchschnittsgehalt"
SELECT AVG(Gehalt) AS Durchschnittsgehalt
FROM Mitarbeiter;

-- Abteilungen im Unternehmen
SELECT DISTINCT Abteilung
FROM Mitarbeiter;

-- Mitarbeiter mit um 10% erhöhtem Gehalt
SELECT Vorname, Nachname, Gehalt * 1.10 AS 'Gehalt +10%'
FROM Mitarbeiter;

-- Name und Jahresgehalt nach Steuern (20% Steuersatz)
SELECT Vorname, Nachname, (Gehalt * 0.80) AS 'Netto-Jahresgehalt'
FROM Mitarbeiter;

-- Vollständiger Name, Position und Abteilung in einem formatierten String
SELECT Vorname || ' ' || Nachname || ', ' || Position || ' in ' || Abteilung AS 'Mitarbeiter'
FROM Mitarbeiter;

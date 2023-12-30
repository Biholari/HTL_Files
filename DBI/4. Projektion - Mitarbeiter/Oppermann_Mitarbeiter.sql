CREATE DATABASE Aufgabe4;
USE Aufgabe4;

DROP TABLE IF EXISTS Mitarbeiter;
DROP INDEX IF EXISTS idx_Mitarbeiter_MitarbeiterID ON Mitarbeiter;

CREATE TABLE Mitarbeiter
(
    MitarbeiterID INT PRIMARY KEY,
    Vorname VARCHAR(50),
    Nachname VARCHAR(50),
    Geburtsdatum DATE,
    Eintrittsdatum DATE,
    Gehalt DECIMAL(8,2),
    Position VARCHAR(50),
    Abteilung VARCHAR(50),
    CHECK (Gehalt > 1000),
    CHECK (Geburtsdatum < Eintrittsdatum),
    CHECK (Position IN ('Entwickler', 'Vertriebsmanager', 'HR Manager', 'Teamleiter', 'Marketing Spezialist', 'CFO', 'Data Analyst', 'Produktmanager', 'Rekruter', 'Buchhalter')),
    CHECK (Abteilung IN ('IT', 'Vertrieb', 'HR', 'Marketing', 'Finanzen')),
    UNIQUE (Vorname, Nachname)
);

CREATE INDEX idx_Mitarbeiter_MitarbeiterID ON Mitarbeiter (MitarbeiterID);

INSERT INTO Mitarbeiter
    (MitarbeiterID, Vorname, Nachname, Geburtsdatum, Eintrittsdatum, Gehalt, Position, Abteilung)
VALUES
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

-- Listen Sie den Vor- und Nachnamen inkl. Geburtsdatum aller Mitarbeiter auf
SELECT Vorname, Nachname, Geburtsdatum
FROM Mitarbeiter;

-- Listen Sie alle Mitarbeiter mit ihrem Alter sowie dem Vor- und Nachnamen auf
SELECT Vorname, Nachname, YEAR(GETDATE()) - YEAR(Geburtsdatum) AS 'Alter'
FROM Mitarbeiter;

-- Listen Sie alle Mitarbeiter mit ihrem monatlichen Gehalt auf und stellen Sie den Nachnamen in Großbuchstaben dar
SELECT UPPER(Nachname) AS 'Nachname', (Gehalt / 12) AS 'Monatsgehalt'
FROM Mitarbeiter;

-- Listen Sie alle Mitarbeiter mit ihrem Vor- und Nachnamen, der Anzahl an Tagen und die Anzahl an Monaten die jeder im Unternehmen ist auf
SELECT
    Vorname,
    Nachname,
    DATEDIFF(DAY, Eintrittsdatum, GETDATE()) AS 'Tage im Unternehmen',
    DATEDIFF(MONTH, Eintrittsdatum, GETDATE()) AS 'Monate im Unternehmen'
FROM Mitarbeiter;

-- Ermitteln Sie das Durchschnittsgehalt aller Mitarbeiter. Verwenden Sie für das Ergebnisattribut einen geeigneten Alias
SELECT AVG(Gehalt) AS 'Durchschnittsgehalt'
FROM Mitarbeiter;

-- Ermitteln Sie welche Abteilungen es im Unternehmen gibt
SELECT DISTINCT Abteilung
FROM Mitarbeiter;

-- Listen Sie alle Mitarbeiter inkl. einem um 10% erhöhten Gehalt auf
SELECT Vorname, Nachname, Gehalt, (Gehalt * 1.1) AS 'Gehalt + 10%'
FROM Mitarbeiter;

-- Ermitteln Sie für jeden Mitarbeiter den Namen und das Jahresgehalt nach Steuern an. Nehmen wir an, dass die Steuer 20% des Gehalts beträgt
SELECT Vorname, Nachname, Gehalt, (Gehalt * 0.8) AS 'Jahresgehalt nach Steuern'
FROM Mitarbeiter;

-- Erstelle eine Abfrage, die den vollständigen Namen (Vorname und Nachname) sowie die Position und die Abteilung in einem formatierten String für jeden Mitarbeiter zurückgibt
SELECT CONCAT(Vorname, ' ', Nachname) AS 'Name', CONCAT(Position, ' in der Abteilung ', Abteilung) AS 'Position'
FROM Mitarbeiter;
PRAGMA foreign_keys=ON;
.headers on
.mode column
.nullvalue NULL

DROP TABLE IF EXISTS Inspektionen;
DROP TABLE IF EXISTS Vermietungen;
DROP TABLE IF EXISTS Kunden;
DROP TABLE IF EXISTS Fahrzeuge;
DROP TABLE IF EXISTS Hersteller;

CREATE TABLE Hersteller (
    HerstellerID int PRIMARY KEY NOT NULL,
    Name varchar(100) NOT NULL UNIQUE,
    Land varchar(100) NOT NULL
);

CREATE TABLE Fahrzeuge (
    FahrzeugID int PRIMARY KEY NOT NULL,
    Modell varchar(100) NOT NULL,
    HerstellerID int REFERENCES Hersteller(HerstellerID) NOT NULL,
    Baujahr int NOT NULL CHECK ( Baujahr > 1945 ),
    Kilometerstand int CHECK ( Kilometerstand > 0 )
);

CREATE TABLE Kunden (
    KundenID int PRIMARY KEY NOT NULL,
    Name varchar(100) NOT NULL,
    Email varchar(255) NOT NULL UNIQUE,
    Telefonnummer varchar(15) NOT NULL UNIQUE
);

CREATE TABLE Vermietungen (
    VermietungID int PRIMARY KEY NOT NULL,
    KundenID int REFERENCES Kunden(KundenID) NOT NULL,
    FahrzeugID int REFERENCES Fahrzeuge(FahrzeugID) NOT NULL,
    Startdatum Date NOT NULL,
    Enddatum Date NOT NULL CHECK ( Enddatum > Startdatum ),
    Preis float NOT NULL CHECK ( Preis > 0 )
);

CREATE TABLE Inspektionen (
    InspektionID int PRIMARY KEY NOT NULL,
    FahrzeugID int REFERENCES Fahrzeuge(FahrzeugID) NOT NULL,
    Datum Date NOT NULL,
    Beschreibung varchar(100) NOT NULL,
    Kosten float NOT NULL CHECK ( Kosten > 0 )
);

-- Hersteller
CREATE INDEX idx_Hersteller_name ON Hersteller(Name); -- Index auf den Namen des Herstellers, da der Name in Abfragen häufig verwendet wird, z.B. um nach Fahrzeugen eines bestimmten Herstellers zu suchen.

-- Fahrzeug
CREATE INDEX idx_Farhzeug_HerustellerID ON Fahrzeuge(HerstellerID); -- Index auf die HerstellerID, um Abfragen zu beschleunigen, bei denen nach Fahrzeugen eines bestimmten Herstellers gesucht wird.
CREATE INDEX idx_Fahrzeug_modell ON Fahrzeuge(Modell); -- Index auf das Modell, da das Modell in Abfragen zur Identifizierung von Fahrzeugen verwendet wird.

-- Kunden
CREATE INDEX idx_Kunden_Email ON Kunden(Email); -- Index auf die E-Mail, um Kunden anhand ihrer E-Mail-Adresse zu identifizieren.
CREATE INDEX idx_Kunden_Telefonnummer ON Kunden(Telefonnummer); -- Index auf die E-Mail, um Kunden anhand ihrer Telefonnummer zu identifizieren.

-- Vermietung
CREATE INDEX idx_Vermietungen_KundenID ON Vermietungen(KundenID); -- Index auf die KundenID, um Abfragen zu beschleunigen, bei denen nach Vermietungen eines bestimmten Kunden gesucht wird.
CREATE INDEX idx_Vermietungen_FahrzeugID ON Vermietungen(FahrzeugID); -- Index auf die FahrzeugID, um Abfragen zu beschleunigen, bei denen nach Vermietungen eines bestimmten Fahrzeugs gesucht wird.

-- Inspektion
CREATE INDEX idx_Inspektion_FahrzeugID ON Inspektionen(FahrzeugID); -- Index auf die FahrzeugID, um Abfragen zu beschleunigen, bei denen nach Inspektionen für bestimmte Fahrzeuge gesucht wird.
CREATE INDEX idx_Inspektion_Datum ON Inspektionen(Datum); -- Index auf das Datum, um Abfragen zu beschleunigen, bei denen nach Inspektionen in einem bestimmten Zeitraum gesucht wird.

INSERT INTO Hersteller (HerstellerID, Name, Land) VALUES
(1, 'Tesla', 'USA'),
(2, 'BMW', 'Deutschland'),
(3, 'Toyota', 'Japan'),
(4, 'Ford', 'USA'),
(5, 'Volkswagen', 'Deutschland'),
(6, 'Audi', 'Deutschland'),
(7, 'Hyundai', 'S�dkorea'),
(8, 'Mercedes-Benz', 'Deutschland'),
(9, 'Kia', 'S�dkorea'),
(10, 'Nissan', 'Japan');

INSERT INTO Fahrzeuge (FahrzeugID, Modell, HerstellerID, Baujahr, Kilometerstand) VALUES
(1, 'Model S', 1, 2021, 5000),
(2, 'Model X', 1, 2021, 15000),
(3, 'Model Y', 1, 2022, 1000),
(4, '3er', 2, 2019, 20000),
(5, '5er', 2, 2018, 25000),
(6, '7er', 2, 2022, 500),
(7, 'Camry', 3, 2018, 35000),
(8, 'Corolla', 3, 2021, 12000),
(9, 'Prius', 3, 2019, 20000),
(10, 'Fiesta', 4, 2020, 15000),
(11, 'Focus', 4, 2021, 9000),
(12, 'Mustang', 4, 2022, 3000),
(13, 'Golf', 5, 2017, 40000),
(14, 'Passat', 5, 2018, 31000),
(15, 'Polo', 5, 2021, 7000),
(16, 'A4', 6, 2022, 1000),
(17, 'A6', 6, 2020, 13000),
(18, 'A8', 6, 2021, 5000),
(19, 'Q2', 6, 2016, 35000),
(20, 'Santa Fe', 7, 2020, 18000);

INSERT INTO Kunden (KundenID, Name, Email, Telefonnummer) VALUES
(1, 'Anna M�ller', 'anna.mueller@email.com', '0123456789'),
(2, 'Bert Schmidt', 'bert.schmidt@email.com', '0123456790'),
(3, 'Cara Klein', 'cara.klein@email.com', '0123456791'),
(4, 'Dennis Gross', 'dennis.gross@email.com', '0123456792'),
(5, 'Eva Schmidt', 'eva.schmidt@email.com', '0123456793');

INSERT INTO Vermietungen (VermietungID, KundenID, FahrzeugID, Startdatum, Enddatum, Preis) VALUES
(1, 1, 1, '2023-05-01', '2023-05-07', 500),
(2, 2, 20, '2023-05-03', '2023-05-10', 700),
(3, 3, 3, '2023-05-05', '2023-05-12', 650),
(4, 4, 4, '2023-05-08', '2023-05-15', 450),
(5, 5, 15, '2023-05-10', '2023-05-17', 750),
(6, 1, 6, '2023-05-15', '2023-05-22', 800),
(7, 2, 7, '2023-05-20', '2023-05-27', 600),
(8, 3, 8, '2023-05-22', '2023-05-29', 900),
(9, 4, 19, '2023-05-25', '2023-05-30', 550),
(10, 5, 10, '2023-05-28', '2023-06-04', 700);

INSERT INTO Inspektionen (InspektionID, FahrzeugID, Datum, Beschreibung, Kosten) VALUES
(1, 1, '2023-04-10', 'Jahresinspektion', 300),
(2, 12, '2023-04-11', 'Bremsen erneuern', 500),
(3, 13, '2023-04-12', '�lwechsel', 100),
(4, 4, '2023-04-15', 'Reifenwechsel', 400),
(5, 5, '2023-04-20', 'Jahresinspektion', 350),
(6, 16, '2023-04-21', 'Bremsen erneuern', 500),
(7, 17, '2023-04-25', 'Licht einstellen', 50),
(8, 8, '2023-04-28', 'Bremsfl�ssigkeit wechseln', 150),
(9, 9, '2023-04-29', 'Jahresinspektion', 320),
(10, 20, '2023-04-30', 'Keilriemen erneuern', 180);

SELECT Name
FROM Hersteller
WHERE Land IN ('Japan', 'Deutschland')
ORDER BY Name;

SELECT Baujahr, Kilometerstand
FROM Fahrzeuge
WHERE
    Baujahr >= 2020 AND
    Kilometerstand BETWEEN 5000 AND 10000;

SELECT Name
FROM Kunden
WHERE Name LIKE '%nn%';

SELECT Startdatum, Enddatum
FROM Vermietungen
WHERE julianday(Enddatum) - julianday(Startdatum) < 7;

SELECT AVG(Preis) AS 'Durchscnittspreis'
FROM Vermietungen;

SELECT
    Preis / (julianday(Enddatum) - julianday(Startdatum)) AS 'tägliche Kosten'
FROM Vermietungen;

SELECT *
FROM Inspektionen
WHERE
    Beschreibung LIKE '%erneuern%' OR Beschreibung LIKE '%wechseln%' AND
    Kosten < 500
ORDER BY Kosten DESC;


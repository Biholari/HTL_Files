-- USE Formel1;
-- CREATE DATABASE Aufgabe10;
-- USE Aufgabe10;

DROP TABLE IF EXISTS Resultate;
DROP TABLE IF EXISTS Rennen;
DROP TABLE IF EXISTS Team;
DROP TABLE IF EXISTS Fahrer;

CREATE TABLE Fahrer
(
    FahrerNr INT PRIMARY KEY,
    VName VARCHAR(30),
    NName VARCHAR(50),
    Land VARCHAR(30)
);

CREATE TABLE Team
(
    TeamNr INT PRIMARY KEY,
    TeamName VARCHAR(50),
    Motorenhersteller VARCHAR(20) CHECK (Motorenhersteller IN ('Honda', 'Ferrari', 'Mercedes', 'Renault')),
    FahrerNr1 INT REFERENCES Fahrer,
    FahrerNr2 INT REFERENCES Fahrer,
    CHECK (FahrerNr1 <> FahrerNr2)
);

CREATE TABLE Rennen
(
    RennenNr INT PRIMARY KEY,
    Ort VARCHAR(30),
    Land VARCHAR(30),
    Sprintrace VARCHAR(1),
    Jahr INT,
    Runden INT,
    Kilometer FLOAT CHECK (Kilometer Between 305 AND 309),
    SchnellsteRunde INT REFERENCES Fahrer
);

CREATE TABLE Resultate
(
    RID INT,
    RennenNr INT REFERENCES Rennen,
    Platz INT CHECK (Platz Between 1 And 10),
    FahrerID INT REFERENCES Fahrer,
    PRIMARY KEY(RID, RennenNr, Platz)
);

INSERT INTO Fahrer
    (FahrerNr, VName, NName, Land)
VALUES
    (1, 'Max', 'Verstappen', 'Niederlande'),
    (11, 'Sergio', 'Perez', 'Mexiko'),
    (16, 'Charles', 'Leclerc', 'Monaco'),
    (55, 'Charlos', 'Sainz', 'Spanien'),
    (4, 'Lando', 'Norris', 'England'),
    (81, 'Oscar', 'Piastri', 'Australien'),
    (14, 'Fernando', 'Alonso', 'Spanien'),
    (63, 'George', 'Russell', 'England'),
    (53, 'Mick', 'Schuhmacher', 'Deutschland');

INSERT INTO Team
    (TeamNr, TeamName, Motorenhersteller, FahrerNr1, FahrerNr2)
VALUES
    (1, 'Oracle Red Bull Racing', 'Honda', 1, 11),
    (2, 'Scuderia Ferrari', 'Ferrari', 16, 55),
    (3, 'McLaren Formula 1 Team', 'Mercedes', 4, 81),
    (4, 'Aston Martin Aramco Cognizant Formula One Team', 'Mercedes', 14, NULL),
    (5, 'Mercedes-AMG PETRONAS Formula One Team', 'Mercedes', 63, NULL);

INSERT INTO Rennen
    (RennenNr, Ort, Land, Sprintrace, Jahr, Runden, Kilometer, SchnellsteRunde)
VALUES
    (1, 'Zandvoort', 'Niederlande', 'F', 2023, 72, 306.587, 14 ),
    (2, 'Silverstone', 'England', 'F', 2023, 52, 306.332 , 1),
    (3, 'Spielfeld', 'Oesterreich', 'T', 2023, 71, 306.452, 1),
    (4, 'Barcelona', 'Spanien', 'F', 2023, 66, 307.236, 1),
    (5, 'Spa', 'Belgien', 'T', 2023, 44, 308.176, 16),
    (6, 'Suzuka', 'Spanien', 'F', 2023, 53, 307.771, 11),
    (7, 'Budapest', 'Ungarn', 'T', 2022, 70, 307.542, 1),
    (8, 'Montreal', 'Kanada', 'F', 2022, 70, 306.623, 1);

INSERT INTO Resultate
    (RID, RennenNr, Platz, FahrerID)
VALUES
    (1, 1, 1, 1),
    (2, 1, 2, 11),
    (3, 1, 3, 4),
    (4, 1, 4, 81),
    (5, 2, 1, 1),
    (6, 2, 2, 16),
    (7, 2, 3, 4),
    (8, 2, 4, 14),
    (9, 3, 1, 11),
    (10, 3, 2, 1),
    (11, 3, 3, 63),
    (12, 3, 4, 55),
    (13, 4, 1, 1),
    (14, 4, 2, 14),
    (15, 4, 3, 55),
    (16, 4, 4, 4),
    (17, 5, 1, 16),
    (18, 5, 2, 81),
    (19, 5, 3, 1),
    (20, 5, 4, 4),
    (21, 6, 1, 1),
    (22, 6, 2, 63),
    (23, 6, 3, 4),
    (24, 6, 4, 81),
    (25, 7, 1, 1),
    (26, 7, 2, 53),
    (27, 7, 3, 4),
    (28, 7, 4, 81);

-- In welchen Heimatländern der Piloten finden keine Rennen statt?
SELECT DISTINCT f.Land
FROM Fahrer f
    LEFT JOIN Rennen r ON f.Land = r.Land
WHERE r.Land IS NULL;

-- Welche Piloten haben, wie oft keinen Top 3 Platz belegt?
SELECT f.VName, f.NName, COUNT(r.Platz) AS 'Anzahl'
FROM Fahrer f
    JOIN Resultate r ON f.FahrerNr = r.FahrerID
WHERE r.Platz > 3
GROUP BY f.VName, f.NName;

-- Welche Piloten haben keine schnellste Runde gefahren?
SELECT f.VName, f.NName
FROM Fahrer f
    LEFT JOIN Rennen r ON f.FahrerNr = r.SchnellsteRunde
WHERE r.SchnellsteRunde IS NULL;

-- Ermitteln Sie welche Fahrer wie oft kein Resultat erzielt haben?
SELECT F.FahrerNr, F.VName, F.NName, COUNT(R.FahrerID) AS NoOfResults
FROM Fahrer F
    LEFT JOIN Resultate R ON F.FahrerNr = R.FahrerID
WHERE R.FahrerID IS NULL
GROUP BY F.FahrerNr, F.VName, F.NName;

-- Welche Fahrer hatte 2022 ein Resultat und ist 2023 in keinem Team?
SELECT f.VName, f.NName
FROM Fahrer f
    LEFT JOIN Team t ON t.FahrerNr1 = f.FahrerNr OR t.FahrerNr2 = f.FahrerNr
    JOIN Resultate res ON f.FahrerNr = res.FahrerID
    JOIN Rennen r ON res.RennenNr = r.RennenNr
WHERE t.TeamNr IS NULL AND r.Jahr = 2022;

-- In welchen Ländern wurde 2023 kein Rennen mehr gefahren?
SELECT r1.Land, r2.Land
FROM Rennen r1
    JOIN Rennen r2 ON r1.Land = r2.Land
WHERE r1.Jahr = 2023 AND r2.Jahr < 2023;
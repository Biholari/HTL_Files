-- CREATE DATABASE Aufgabe11;
-- USE Aufgabe11;

-- use Formel1;

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
	SprINTrace VARCHAR(1),
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
VALUES(1, 'Oracle Red Bull Racing', 'Honda', 1, 11),
	(2, 'Scuderia Ferrari', 'Ferrari', 16, 55),
	(3, 'McLaren Formula 1 Team', 'Mercedes', 4, 81),
	(4, 'Aston Martin Aramco Cognizant Formula One Team', 'Mercedes', 14, NULL),
	(5, 'Mercedes-AMG PETRONAS Formula One Team', 'Mercedes', 63, NULL);

INSERT INTO Rennen
	(RennenNr, Ort, Land, SprINTrace, Jahr, Runden, Kilometer, SchnellsteRunde)
VALUES(1, 'Zandvoort', 'Niederlande', 'F', 2023, 72, 306.587, 14 ),
	(2, 'Silverstone', 'England', 'F', 2023, 52, 306.332 , 1),
	(3, 'Spielfeld', 'Oesterreich', 'T', 2023, 71, 306.452, 1),
	(4, 'Barcelona', 'Spanien', 'F', 2023, 66, 307.236, 1),
	(5, 'Spa', 'Belgien', 'T', 2023, 44, 308.176, 16),
	(6, 'Suzuka', 'Spanien', 'F', 2023, 53, 307.771, 11),
	(7, 'Budapest', 'Ungarn', 'T', 2022, 70, 307.542, 1),
	(9, 'Spielfeld', 'Oesterreich', 'T', 2022, 71, 306.452, 1),
	(8, 'Montreal', 'Kanada', 'F', 2022, 70, 306.623, 1);

INSERT INTO Resultate
	(RID, RennenNr, Platz, FahrerID)
VALUES(1, 1, 1, 1),
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

-- Für welches Rennen (Nr, Ort) gibt es kein Resultat? (JOIN)
SELECT r.RennenNr, r.Ort
FROM Fahrer f
	LEFT JOIN Resultate res ON f.FahrerNr = res.FahrerID
	RIGHT JOIN Rennen r ON res.RennenNr = r.RennenNr
WHERE res.RennenNr IS NULL;
-- EXCEPT oder INTERSECT
	SELECT RennenNr
	FROM Rennen
EXCEPT
	SELECT RennenNr
	FROM Resultate;

-- In welchen Ländern wurde 2023 kein Rennen mehr gefahren?
SELECT *
FROM Rennen r
	LEFT JOIN Resultate res ON r.RennenNr = res.RennenNr
WHERE Jahr = 2023 AND RID IS NULL;
-- INTERSECT oder EXCEPT
	SELECT Land
	FROM Rennen
	WHERE Jahr = 2023
EXCEPT
	SELECT Land
	FROM Resultate
		JOIN Rennen ON Resultate.RennenNr = Rennen.RennenNr;

-- An welchen Rennen haben Max Verstappen und Lando Norris teilgenommen?
SELECT r.RennenNr, r.Ort, r.Land
FROM Rennen r
	JOIN Resultate res ON r.RennenNr = res.RennenNr
	JOIN Fahrer f ON res.FahrerID = f.FahrerNr
WHERE f.VName in ('Max', 'Lando') AND f.NName IN ('Verstappen', 'Norris')
GROUP BY r.RennenNr, r.Ort, r.Land
HAVING COUNT(*) >= 2;
-- INTERSECT oder EXCEPT
	SELECT RennenNr, Ort, Land
	FROM Rennen
INTERSECT
	SELECT r.RennenNr, r.Ort, r.Land
	FROM Resultate
		JOIN Fahrer ON Resultate.FahrerID = Fahrer.FahrerNr
		JOIN Rennen r ON Resultate.RennenNr = r.RennenNr
	WHERE VName in ('Max', 'Lando') AND NName IN ('Verstappen', 'Norris')
	GROUP BY r.RennenNr, r.Ort, r.Land
	HAVING COUNT(*) >= 2;
			
					

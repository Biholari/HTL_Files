-- create database wichtel;
use wichtel;

drop table if exists Wichtel;
drop table if exists Geschenk;
drop table if exists Schueler;
drop table if exists Klasse;

create table Klasse (
	ID integer IDENTITY(1,1) primary key,
	Name varchar(10)
);

create table Schueler (
	ID integer IDENTITY(1,1) primary key,
	Vorname varchar(100),
	Nachname varchar(100),
	KlasseID integer references Klasse(ID)
);

create table Geschenk (
	ID integer IDENTITY(1,1) primary key,
	Name varchar(100)
);

create table Wichtel (
	VonID integer references Schueler(ID),
	FuerID integer references Schueler(ID),
	GeschenkID integer references Geschenk(ID)
);

insert into Klasse (Name) values
	('3AHIF'),
	('3BHIF'),
	('3CHIF');

insert into Schueler (Vorname, Nachname, KlasseID) values
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
	('Brandauer', 'Simon', 3),
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

insert into Geschenk (Name) values
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

DECLARE @SchuelerCount INT;
DECLARE @GeschenkCount INT;
DECLARE @Counter INT = 1;

SELECT @SchuelerCount = COUNT(*) FROM Schueler;
SELECT @GeschenkCount = COUNT(*) FROM Geschenk;

WHILE @Counter <= @SchuelerCount
BEGIN
    INSERT INTO Wichtel (VonID, FuerID, GeschenkID)
    VALUES (
        (CAST((RAND() * 100) AS INT)) % @SchuelerCount + 1,
        (CAST((RAND() * 100) AS INT)) % @SchuelerCount + 1,
        (CAST((RAND() * 100) AS INT)) % @GeschenkCount + 1
    );

    SET @Counter = @Counter + 1;
END;

-- a. Ermitteln Sie alle Schüler, die anderen Schülern etwas schenken.
SELECT
    SecretSanta.Vorname +  ' ' + SecretSanta.Nachname AS 'Secret Santa',
    Schueler.Vorname + ' ' + Schueler.Nachname AS 'Schüler',
    Geschenk.Name AS 'Geschenk'
FROM Wichtel
JOIN Schueler AS SecretSanta ON Wichtel.VonID = SecretSanta.ID
JOIN Schueler ON Wichtel.FuerID = Schueler.ID
JOIN Geschenk ON Wichtel.GeschenkID = Geschenk.ID;

-- b. Überprüfen Sie, ob es einen Schüler gibt, der sich selbst etwas schenkt.
SELECT
    Von.Vorname + ' ' + Von.Nachname AS 'Schüler'
FROM Wichtel
JOIN Schueler AS Von ON Wichtel.VonID = Von.ID
WHERE Wichtel.FuerID = Wichtel.VonID;

-- c. Überprüfen Sie, ob es einen Schüler gibt, der niemanden etwas schenkt.
SELECT
    Von.Vorname + ' ' + Von.Nachname AS 'Schüler'
FROM Schueler AS Von
WHERE Von.ID NOT IN (SELECT DISTINCT FuerID FROM Wichtel);

-- d. Ermitteln Sie alle Schüler, die mindestens 2 anderen Schülern etwas schenken.
SELECT
    CONCAT(Von.Vorname, ' ', Von.Nachname) AS 'Schüler',
    COUNT(DISTINCT Wichtel.FuerID) AS 'Anzahl der Beschenkten'
FROM Wichtel
JOIN Schueler AS Von ON Wichtel.VonID = Von.ID
GROUP BY Von.ID, Von.Vorname, Von.Nachname
HAVING COUNT(DISTINCT Wichtel.FuerID) >= 2;

-- e. Ermitteln Sie wie oft ein Geschenk verschenkt wurde.
SELECT
    Geschenk.Name AS 'Geschenk',
    COUNT(*) AS 'Anzahl der Verschenkungen'
FROM Wichtel
JOIN Geschenk ON Wichtel.GeschenkID = Geschenk.ID
GROUP BY Geschenk.ID, Geschenk.Name;

-- f. Ermitteln Sie welche Schüler klassenübergreifend anderen Schülern etwas schenken.
SELECT
    Schueler.KlasseID,
    COUNT(DISTINCT Schueler.ID) AS 'Anzahl der Schüler, die anderen Schülern etwas schenken'
FROM Wichtel
JOIN Schueler ON Wichtel.VonID = Schueler.ID
GROUP BY Schueler.KlasseID;

-- g. Ermitteln Sie die Top 3 unbeliebteren Geschenke.
SELECT TOP 3
    Geschenk.Name AS 'Geschenk',
    COUNT(*) AS 'Anzahl der Verschenkungen'
FROM Wichtel
RIGHT JOIN Geschenk ON Wichtel.GeschenkID = Geschenk.ID
GROUP BY Geschenk.ID, Geschenk.Name
ORDER BY COUNT(*);

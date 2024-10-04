DROP TABLE IF EXISTS Fuehrungskraft1A;
DROP TABLE IF EXISTS Lektor1A;
DROP TABLE IF EXISTS Mitarbeiter1A;
DROP TABLE IF EXISTS Fuehrungskraft1B;
DROP TABLE IF EXISTS Lektor1B;
DROP TABLE IF EXISTS Mitarbeiter1B;

-- 1A create
CREATE TABLE Mitarbeiter1A (
    Mitarbeiter_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Geburtsdatum DATE
);

-- Sub-Entit�t: F�hrungskraft
CREATE TABLE Fuehrungskraft1A (
    Fuehrungskraft_ID INT PRIMARY KEY,
    Mitarbeiter_ID INT,
    Management_Ebene VARCHAR(50),
	Gehalt INT,
    FOREIGN KEY (Mitarbeiter_ID) REFERENCES Mitarbeiter1A(Mitarbeiter_ID)
);

-- Sub-Entit�t: Lektor
CREATE TABLE Lektor1A (
    Lektor_ID INT PRIMARY KEY,
    Mitarbeiter_ID INT,
    Spezialgebiet VARCHAR(100),
	Gehalt INT,
    FOREIGN KEY (Mitarbeiter_ID) REFERENCES Mitarbeiter1A(Mitarbeiter_ID)
);

-- 1B create
CREATE TABLE Mitarbeiter1B (
    Mitarbeiter_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Geburtsdatum DATE
);
CREATE TABLE Fuehrungskraft1B (
    Fuehrungskraft_ID INT PRIMARY KEY,
	Mitarbeiter_ID INT,
    Name VARCHAR(100),
    Geburtsdatum DATE,
    Management_Ebene VARCHAR(50),
	Gehalt INT,
	FOREIGN KEY (Mitarbeiter_ID) REFERENCES Mitarbeiter1B(Mitarbeiter_ID)
);
CREATE TABLE Lektor1B (
    Lektor_ID INT PRIMARY KEY,
	Mitarbeiter_ID INT,
    Name VARCHAR(100),
    Geburtsdatum DATE,
    Spezialgebiet VARCHAR(100),
	Gehalt INT,
	FOREIGN KEY (Mitarbeiter_ID) REFERENCES Mitarbeiter1B(Mitarbeiter_ID)
);

/*
1A: Da die Sub-Entit�ten nur den Prim�rschl�ssel der Super-Entit�t enthalten, 
ist kein redundanter Speicherbedarf f�r Attribute wie Name oder Geburtsdatum 
notwendig. Dies minimiert den Speicherbedarf und vermeidet Datenredundanz.

1B: Hier m�ssen alle Attribute der Super-Entit�t in den Sub-Entit�ten 
gespeichert werden, was zu erh�hter Redundanz und gr��erem Speicherbedarf 
f�hrt. �nderungen an einem Attribut m�ssen in jeder betroffenen Sub-Entit�t
durchgef�hrt werden, was die Konsistenz gef�hrden kann.
*/

SELECT * FROM Mitarbeiter1A m
	LEFT JOIN Lektor1A f ON m.Mitarbeiter_ID = f.Mitarbeiter_ID;

-- 1A insert
INSERT INTO Mitarbeiter1A(Mitarbeiter_ID, Name, Geburtsdatum) VALUES 
    (4, 'Clara Fischer', '1982-11-11'),
    (5, 'Michael Wagner', '1992-05-25'),
    (6, 'Laura Beck', '1987-09-13');
INSERT INTO Fuehrungskraft1A(Fuehrungskraft_ID, Mitarbeiter_ID, Management_Ebene, Gehalt) VALUES 
    (2, 4, 'Abteilung 2', 3000),
    (3, 5, 'Abteilung 3', 2800),
    (4, 6, 'Abteilung 4', 3100);
INSERT INTO Lektor1A(Lektor_ID, Mitarbeiter_ID, Spezialgebiet, Gehalt) VALUES 
    (2, 4, 'Informatik', 2600),
    (3, 5, 'Physik', 2400),
    (4, 6, 'Biologie', 2700);

-- 1B insert
INSERT INTO Mitarbeiter1B(Mitarbeiter_ID, Name, Geburtsdatum) VALUES 
    (4, 'Clara Fischer', '1982-11-11'),
    (5, 'Michael Wagner', '1992-05-25'),
    (6, 'Laura Beck', '1987-09-13');
INSERT INTO Fuehrungskraft1B(Fuehrungskraft_ID, Mitarbeiter_ID, Name, Geburtsdatum, Management_Ebene, Gehalt) VALUES 
    (2, 4, 'Clara Fischer', '1982-11-11', 'Abteilung 2', 3000),
    (3, 5, 'Michael Wagner', '1992-05-25', 'Abteilung 3', 2800),
    (4, 6, 'Laura Beck', '1987-09-13', 'Abteilung 4', 3100);
INSERT INTO Lektor1B(Lektor_ID, Mitarbeiter_ID, Name, Geburtsdatum, Spezialgebiet, Gehalt) VALUES 
    (2, 4, 'Clara Fischer', '1982-11-11', 'Informatik', 2600),
    (3, 5, 'Michael Wagner', '1992-05-25', 'Physik', 2400),
    (4, 6, 'Laura Beck', '1987-09-13', 'Biologie', 2700);

-- 1A select
SELECT F.*
FROM Fuehrungskraft1A F
	JOIN Mitarbeiter1A M ON F.Mitarbeiter_ID = M.Mitarbeiter_ID;
/*
Die Performance wird hier leicht eingeschr�nkt wegen dem JOINow.
Daher ist auch due Komplexit�t etwas gro�er.
*/

SELECT *
FROM Mitarbeiter1A M
	LEFT JOIN Fuehrungskraft1A F ON M.Mitarbeiter_ID = F.Mitarbeiter_ID
	LEFT JOIN Lektor1A L ON M.Mitarbeiter_ID = L.Mitarbeiter_ID;
/*
Da wir hier 2 LEFT JOINS benutzen wird die Performance ziemlich eingeschr�nkt,
daher ist die Komplexit�t auch ein wenig gro�er.
*/

-- 1B select
SELECT Fuehrungskraft_ID, Management_Ebene, Gehalt
FROM Fuehrungskraft1B;
/*
Da wir alle Informationen in der Tabelle haben ist die Komplexit�t und
die Performance hier sehr gut.
*/

SELECT * 
FROM Mitarbeiter1B m
	LEFT JOIN Fuehrungskraft1B f ON m.Mitarbeiter_ID = f.Mitarbeiter_ID
	LEFT JOIN Lektor1B l ON l.Mitarbeiter_ID = m.Mitarbeiter_ID;
/*
Hier m�ssen wir auch 2 LEFT JOINS machen, was die Komplexit�t steigert und
die Performance verschl�chert.
*/
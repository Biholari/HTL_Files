-- 1
/*
 1. Ich muss zuerst alle Foreign-Keys die auf 'Dorner' zeigen auf NULL setzen.
 2. Löschen des Lehrers 'Dorner'
 */
-- 2

/*
Definieren Sie nun die nötigen DML – Kommandos
*/
UPDATE Faecher
SET LehrerID = (
    SELECT LehrerID
    FROM Lehrer
    WHERE Name LIKE 'Dorner Elisabeth'
)
WHERE LehrerID IN (
        SELECT LehrerID
        FROM Lehrer
        WHERE Name LIKE 'Dorner Elisabeth'
    );

UPDATE Klassen
SET KlassenlehrerID = (
    SELECT TOP 1 LehrerID
    FROM Lehrer
    )
WHERE KlassenlehrerID IN (
        SELECT LehrerID
        FROM Lehrer
        WHERE Name LIKE 'Dorner Elisabeth'
    );

DELETE FROM Lehrer
WHERE Name LIKE 'Dorner Elisabeth';

-- 3
/*
Aktualisieren Sie bei den Schülern Hafner und Brandtner das Datum der Noten auf
2.2.2024
*/
UPDATE Noten
SET Datum = '02.02.2024'
WHERE SchuelerID IN (
        SELECT SchuelerID
        FROM Schueler
        WHERE Name LIKE '%Hafner%'
            OR Name LIKE '%Brandtner%'
    );

-- 4 
/*
Fügen Sie den Schüler Max Mustermann hinzu. Er geht in die 3CHIF und ist 2007
geboren. Fügen Sie nun für den Schüler Noten in jedem Fach hinzu. Wird das Fach
von mehr als einem Lehrer unterrichtet, dann wählen Sie ein unterschiedliches
Datum (30.6.2023, 2.2.2024 oder 28.6.2024).
*/
INSERT INTO Schueler (SchuelerID, Name, Geburtsjahr, KlasseID)
VALUES (
        (
            SELECT COUNT(*)
            FROM Schueler
        ) + 1,
        'Mustermann Max',
        2007,
        (
            SELECT KlasseID
            FROM Klassen
            WHERE Klassenbezeichnung = '3CHIF'
        )
    );

DECLARE @i INT = 1;
WHILE @i <= (
    SELECT COUNT(*)
    FROM Faecher
) BEGIN
INSERT INTO Noten (NotenID, SchuelerID, FachID, Note, Datum)
VALUES (
        (
            SELECT COUNT(*)
            FROM Noten
        ) + 1,
        (
            SELECT SchuelerID
            FROM Schueler
            WHERE Name LIKE 'Mustermann Max'
        ),
        @i,
        1,
        CASE
            WHEN (
                SELECT COUNT(*)
                FROM Faecher
                WHERE LehrerID = (
                        SELECT LehrerID
                        FROM Faecher
                        WHERE FachID = @i
                    )
                GROUP BY LehrerID
            ) >= 2 THEN '2023-06-30'
            ELSE GETDATE()
        END
    );
SET @i = @i + 1;
END;

-- 1 
/*
Ermitteln Sie für alle Schüler ihren Notendurchschnitt. Ausgabespalten: Name,
Notendurchschnitt
*/
SELECT Name,
    (
        SELECT AVG(Note)
        FROM Noten
        WHERE SchuelerID = (
                SELECT SchuelerID
                FROM Schueler
                WHERE Name = s.Name
            )
    ) AS Notendurchschnitt
FROM Schueler s
WHERE SchuelerID IN (
        SELECT SchuelerID
        FROM Noten
    )
GROUP BY Name;

-- 2
/*
Ermitteln Sie alle Schüler (Name) die am 30.6.2023 keine Noten erhalten
*/
SELECT Name
FROM Schueler
WHERE SchuelerID NOT IN (
    SELECT SchuelerID
    FROM Noten
    WHERE Datum = '2023-06-30'
);


-- 3
/*
Ermitteln Sie alle Schüler, die in irgendeinem Fach eine bessere Note als der
Durchschnitt aller Noten in diesem Fach haben
*/
SELECT s.Name,
    f.Fachbezeichnung,
    n.Note,
    (
        SELECT AVG(Note)
        FROM Noten
        WHERE FachID = n.FachID
    ) AS Notendurchschnitt
FROM Noten n
    JOIN Schueler s ON n.SchuelerID = s.SchuelerID
    JOIN Faecher f ON n.FachID = f.FachID
WHERE n.Note < (
        SELECT AVG(Note)
        FROM Noten
        WHERE FachID = n.FachID
    )
ORDER BY Fachbezeichnung;

-- 4
/*
Ermitteln Sie alle Fächer, deren durchschnittliche Note über dem
Notendurchschnitt aller anderen Fächer liegen
*/
SELECT f.Fachbezeichnung,
    AVG(n.Note) AS Notendurchschnitt
FROM Noten n
    JOIN Faecher f ON n.FachID = f.FachID
GROUP BY f.Fachbezeichnung, f.FachID
HAVING AVG(n.Note) > (
        SELECT AVG(Note)
        FROM Noten
        WHERE FachID <> f.FachID
    );

-- 5
SELECT s.Name
FROM Schueler s
WHERE s.SchuelerID IN (
        SELECT SchuelerID
        FROM Noten
        GROUP BY SchuelerID
        HAVING COUNT(*) = (
                SELECT COUNT(*)
                FROM Faecher
            )
    );

-- 6
/*
Lösen Sie Aufgabe 1 und 4 mit einer lokalen view
*/
CREATE VIEW SchuelerNotendurchschnitt AS
SELECT Name,
    (
        SELECT AVG(Note)
        FROM Noten
        WHERE SchuelerID = (
                SELECT SchuelerID
                FROM Schueler
                WHERE Name = s.Name
            )
    ) AS Notendurchschnitt
FROM Schueler s
WHERE SchuelerID IN (
        SELECT SchuelerID
        FROM Noten
    )
GROUP BY Name;


SELECT *
FROM SchuelerNotendurchschnitt;

CREATE VIEW BessereFaecher AS 
SELECT f.Fachbezeichnung,
    AVG(n.Note) AS Notendurchschnitt
FROM Noten n
    JOIN Faecher f ON n.FachID = f.FachID
GROUP BY f.Fachbezeichnung, f.FachID
HAVING AVG(n.Note) > (
        SELECT AVG(Note)
        FROM Noten
        WHERE FachID <> f.FachID
    );

SELECT *
FROM BessereFaecher;
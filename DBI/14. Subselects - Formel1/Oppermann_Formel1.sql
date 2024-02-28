-- 1. Ermitteln Sie alle Rennen, bei denen der Sieger für Ferrari fuhr
SELECT r.RennenNr
FROM Resultate res
    JOIN Rennen r ON r.RennenNr = res.RennenNr
    JOIN Fahrer f ON res.FahrerID = f.FahrerNr
    JOIN Team t ON t.FahrerNr1 = f.FahrerNr OR t.FahrerNr2 = f.FahrerNr
WHERE res.Platz = 1 AND t.Motorenhersteller = 'Ferrari';

SELECT r.RennenNr
FROM Rennen r
WHERE r.RennenNr IN (
        SELECT res.RennenNr
        FROM Resultate res
            JOIN Fahrer f ON res.FahrerID = f.FahrerNr
            JOIN Team t ON t.FahrerNr1 = f.FahrerNr OR t.FahrerNr2 = f.FahrerNr
        WHERE res.Platz = 1 AND t.Motorenhersteller = 'Ferrari'
);

-- 2. Ermitteln Sie die Fahrer, die nie ein Rennen gewonnen haben
SELECT f.VName + ' ' + f.NName AS Fahrer
FROM Fahrer f
WHERE NOT EXISTS (
    SELECT res.FahrerID
    FROM Resultate res
    WHERE res.FahrerID = f.FahrerNr AND res.Platz = 1
);

SELECT f.VName + ' ' + f.NName AS Fahrer
FROM Fahrer f
    LEFT JOIN Resultate res ON f.FahrerNr = res.FahrerID AND res.Platz = 1
WHERE res.FahrerID IS NULL;


-- 3. Ermitteln Sie alle Fahrer, die für ein Team mit Mercedes-Motoren fahren
SELECT f.VName + ' ' + f.NName AS Fahrer
FROM Team t
    JOIN Fahrer f ON t.FahrerNr1 = f.FahrerNr
    OR t.FahrerNr2 = f.FahrerNr
WHERE t.Motorenhersteller = 'Mercedes';

SELECT f.VName + ' ' + f.NName AS Fahrer
FROM Fahrer f
WHERE f.FahrerNr IN (
    SELECT t.FahrerNr1
    FROM Team t
    WHERE t.Motorenhersteller = 'Mercedes'
    UNION
    SELECT t.FahrerNr2
    FROM Team t
    WHERE t.Motorenhersteller = 'Mercedes'
);

-- 4. Ermittle das Team mit den meisten Rennsiegen
SELECT TOP 1
    t.TeamName, COUNT(res.Platz) AS Anzahl
FROM Team t
    JOIN Resultate res ON t.FahrerNr1 = res.FahrerID OR t.FahrerNr2 = res.FahrerID
WHERE res.Platz = 1
GROUP BY t.TeamName
ORDER BY Anzahl DESC;

SELECT TOP 1
    t.TeamName,
    (
        SELECT COUNT(*)
        FROM Resultate res
        WHERE (
                t.FahrerNr1 = res.FahrerID
                OR t.FahrerNr2 = res.FahrerID
            )
            AND res.Platz = 1
    ) AS Anzahl
FROM Team t
ORDER BY Anzahl DESC;
USE Formel1;

-- Für welches Rennen (Nr, Ort) gibt es kein Resultat?
SELECT *
FROM Rennen r
    LEFT JOIN Resultate res ON res.RennenNr = r.RennenNr
WHERE res.RID IS NULL;

-- In welchen Ländern wurde 2023 kein Rennen mehr gefahren?
SELECT r.Land
FROM Rennen r
    LEFT JOIN Resultate res ON res.RennenNr = r.RennenNr AND r.Jahr = 2023
WHERE res.RID IS NULL;

-- An welchen Rennen haben Max Verstappen und Lando Norris teilgenommen?
SELECT r.RennenNr
FROM Rennen r
    JOIN Resultate res ON res.RennenNr = r.RennenNr
    JOIN Fahrer f ON res.FahrerID = f.FahrerNr
WHERE f.VName IN ('Max', 'Lando') AND f.NName IN ('Verstappen', 'Norris')
GROUP BY r.RennenNr
HAVING COUNT(r.RennenNr) = 2;
USE Schule;

-- Ermitteln Sie die Anzahl der Schüler pro Klasse. Ausgegeben soll die Klasse, Anzahl der Schüler und der Name des Klassenvorstands werden
SELECT k.Klassenbezeichnung, COUNT(s.SchuelerID), l.Name
FROM Klasse k
    JOIN Schueler s ON k.KlasseID = s.KlasseID
    JOIN Lehrer l ON k.KlassenlehrerID = l.LehrerID
GROUP BY k.Klassenbezeichnung, l.Name

-- Ermitteln Sie eine Notenübersicht für alle Noten bis zum 30.6.2023 im Format: Klasse, Fach, Schüler und Note
SELECT k.Klassenbezeichnung, s.Name, f.Fachbezeichnung, n.Note
FROM Klasse k
    JOIN Schueler s ON k.KlasseID = s.KlasseID
    JOIN Note n ON n.SchuelerID = s.SchuelerID
    JOIN Fach f ON f.FachID = n.FachID
WHERE n.Datum <= '2023-06-30';

-- Ermitteln Sie welche Lehrer denselben Gegenstand unterrichten. Ausgegeben soll Name des Gegenstandes und die Namen der Lehrer, die dieses unterrichten
SELECT f.Fachbezeichnung, STRING_AGG(L.Name, ', ')
FROM Fach f
    JOIN Lehrer l ON f.LehrerID = l.LehrerID
GROUP BY f.Fachbezeichnung;

-- Ermitteln Sie wie viele Schüler pro Geburtsjahr in welche Klasse gehen, im Format: Geburtsjahr, Klasse, Anzahl der Schüler
SELECT s.Geburtsjahr, k.Klassenbezeichnung, COUNT(*)
FROM Klasse k
    JOIN Schueler s ON k.KlasseID = s.KlasseID
GROUP BY s.Geburtsjahr, k.Klassenbezeichnung;

-- Ermitteln Sie wie viele 1er, 2er und 3er pro Gegenstand vergeben wurden
SELECT f.Fachbezeichnung, n.Note, COUNT(*)
FROM Fach f
    JOIN Note n ON n.FachID = f.FachID
WHERE n.Note IN (1, 2, 3)
GROUP BY f.Fachbezeichnung, n.Note
ORDER BY f.Fachbezeichnung;
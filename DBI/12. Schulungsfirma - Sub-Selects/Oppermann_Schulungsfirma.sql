USE Schulungsfirma;

-- 21. Welche Personen besuchen Kursveranstaltungen, die in ihrem Wohnort abgehalten werden und länger als zwei Tage dauern?
SELECT p.*
FROM person p
    JOIN besucht be ON p.pnr = be.pnr
    JOIN kveranst kv ON kv.knr = be.knr AND kv.knrlfnd = be.knrlfnd
WHERE p.ort = kv.ort AND DATEDIFF(DAY, kv.von, kv.bis) > 1;

-- 22. Welche Kursveranstaltungen werden von Referenten gehalten, die für den Kurs auch geeignet sind?
SELECT kv.*
FROM geeignet ge
    JOIN referent re ON ge.pnr = re.pnr
    JOIN kveranst kv ON kv.knr = ge.knr AND kv.pnr = ge.pnr;

-- 23. Alle Referenten, die Kursveranstaltungen gehalten haben bevor / nachdem sie in die Firma eingetreten sind.
SELECT *, IIF(kv.von > re.seit, 'Nach', 'Vor')
FROM kveranst kv
    JOIN referent re ON re.pnr = kv.pnr;

-- 24. Alle Personen (PNr, FName), die einen Kurs in 'Wien' besucht oder gehalten haben.

-- 25. Dauer der Kursveranstaltungen im Vergleich mit der im Kurs angegebenen Dauer (geht die Veranstaltung über ein Wochenende / Sa,So?)

-- 26. Welche Referenten, haben Kursveranstaltungen in einem Alter von über 60 Jahren gehalten?

-- 27. Welche Kursveranstaltungen gibt es, zu denen eine vorausgesetzte Kursveranstaltung zeitlich davor und am selben Ort abgehalten wird?

-- 28. Welche Kursveranstaltungen überschneiden einander terminlich?

-- 29. Gibt es Personen, bei denen Kursbesuche einander terminlich überschneiden?

-- 30. Gibt es Referenten, bei denen Kursveranstaltungen, die sie halten, einander terminlich überschneiden?
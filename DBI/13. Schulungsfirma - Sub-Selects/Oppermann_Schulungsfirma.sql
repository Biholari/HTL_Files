-- CREATE DATABASE Aufgabe13;
-- USE Aufgabe13;

-- 31
SELECT p.vname + ' ' + p.fname AS [Name]
FROM referent r
    LEFT JOIN geeignet ge ON r.pnr = ge.pnr
    LEFT JOIN person p ON r.pnr = p.pnr
WHERE ge.knr IS NULL;

-- 32
SELECT ku.bezeichn
FROM kurs ku
WHERE ku.preis < (
        SELECT preis
        FROM kurs
        WHERE bezeichn = 'Dirigieren'
);

-- 33
SELECT ku.bezeichn
FROM kurs ku
WHERE ku.preis > ALL (
        SELECT preis
        FROM kurs
            JOIN kveranst kv ON kurs.knr = kv.knr
        WHERE kv.ort = 'Paris'
);

-- 34
SELECT ku.bezeichn
FROM kurs ku
WHERE ku.knr NOT IN (
        SELECT knr
        FROM setztvor
    );

-- 35
SELECT p.vname + ' ' + p.fname AS [Name]
FROM person p
WHERE pnr NOT IN (
        SELECT pnr
        FROM kveranst kv
        WHERE YEAR(kv.von) BETWEEN 2003 AND 2005
);

-- 37
SELECT p.fname + ' ' + p.fname AS [Name]
FROM person p
    JOIN besucht b ON p.pnr = b.pnr
    JOIN kurs k ON b.knr = k.knr
WHERE k.preis < ANY (
        SELECT k2.preis
        FROM kurs k2
            JOIN kveranst v ON k2.knr = v.knr
        WHERE v.ort = 'Moskau'
);

-- 38
SELECT k.knr, k.bezeichn, kv.knrlfnd, kv.von
FROM kurs k
    JOIN kveranst kv ON k.knr = kv.knr
    JOIN referent r ON kv.pnr = r.pnr
WHERE NOT EXISTS (
        SELECT 1
        FROM geeignet g
        WHERE g.knr = k.knr
            AND g.pnr = r.pnr
);

-- 39
SELECT p.fname + ' ' + p.fname AS [Name]
FROM person p
WHERE p.pnr IN (
        SELECT b.pnr
        FROM besucht b
            JOIN kveranst kv ON b.knr = kv.knr AND b.knrlfnd = kv.knrlfnd
        WHERE kv.ort = 'Paris'
    )
    AND p.pnr IN (
        SELECT b.pnr
        FROM besucht b
            JOIN kveranst kv ON b.knr = kv.knr AND b.knrlfnd = kv.knrlfnd
        WHERE kv.ort = 'Wien'
);

SELECT p.pnr, p.fname
FROM person p
WHERE p.pnr IN (
        SELECT b.pnr
        FROM besucht b
            JOIN kveranst kv ON b.knr = kv.knr
            AND b.knrlfnd = kv.knrlfnd
        WHERE kv.ort = 'Wien'
    )
    AND p.pnr NOT IN (
        SELECT b.pnr
        FROM besucht b
            JOIN kveranst kv ON b.knr = kv.knr
            AND b.knrlfnd = kv.knrlfnd
        WHERE kv.ort = 'Paris'
);

-- 40
SELECT k.bezeichn
FROM kurs k
    JOIN kveranst kv ON k.knr = kv.knr
WHERE kv.ort = 'Wien' AND 
        k.knr IN (
            SELECT k.knr
            FROM kurs k
                JOIN kveranst kv ON k.knr = kv.knr
            WHERE kv.ort = 'Paris'
);

SELECT k.bezeichn
FROM kurs k
    JOIN kveranst kv ON k.knr = kv.knr
WHERE kv.ort = 'Wien' AND 
        k.knr NOT IN (
            SELECT k.knr
            FROM kurs k
                JOIN kveranst kv ON k.knr = kv.knr
            WHERE kv.ort = 'Paris'
);
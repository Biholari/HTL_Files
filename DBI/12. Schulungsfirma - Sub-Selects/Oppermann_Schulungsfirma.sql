CREATE DATABASE Aufgabe12;
USE Aufgabe12;
SET DATEFORMAT dmy;
DROP TABLE IF EXISTS besucht;
DROP TABLE IF EXISTS kveranst;
DROP TABLE IF EXISTS geeignet;
DROP TABLE IF EXISTS setztvor;
DROP TABLE IF EXISTS kurs;
DROP TABLE IF EXISTS referent;
DROP TABLE IF EXISTS person;
CREATE TABLE person (
    pnr INTEGER PRIMARY KEY,
    fname VARCHAR(16),
    vname VARCHAR(16),
    ort VARCHAR(10),
    land CHAR(3) CHECK (land IN ('A', 'D', 'F', 'GB', 'I', 'RUS'))
);
CREATE TABLE referent (
    pnr INTEGER PRIMARY KEY REFERENCES person,
    gebdat DATE,
    seit DATE,
    titel VARCHAR(6),
    CHECK (gebdat < seit)
);
CREATE TABLE kurs (
    knr INTEGER PRIMARY KEY,
    bezeichn CHAR(20),
    tage INTEGER CHECK (
        tage BETWEEN 1 AND 10
    ),
    preis DECIMAL(7, 2)
);
CREATE TABLE setztvor (
    knr INTEGER REFERENCES kurs,
    knrvor INTEGER REFERENCES kurs,
    PRIMARY KEY (knr, knrvor),
    CHECK (knr <> knrvor)
);
CREATE TABLE geeignet (
    knr INTEGER REFERENCES kurs,
    pnr INTEGER REFERENCES referent,
    PRIMARY KEY (knr, pnr)
);
CREATE TABLE kveranst (
    knr INTEGER REFERENCES kurs,
    knrlfnd INTEGER,
    von DATE,
    bis DATE,
    ort VARCHAR(10),
    plaetze INTEGER,
    pnr INTEGER REFERENCES referent,
    PRIMARY KEY (knr, knrlfnd),
    CHECK (von <= bis)
);
CREATE TABLE besucht (
    knr INTEGER,
    knrlfnd INTEGER,
    pnr INTEGER REFERENCES person,
    bezahlt DATE,
    PRIMARY KEY (knr, knrlfnd, pnr),
    FOREIGN KEY (knr, knrlfnd) REFERENCES kveranst
);
INSERT INTO person
VALUES (101, 'Bach', 'Johann Sebastian', 'Leipzig', 'D'),
    (
        102,
        'Haendel',
        'Georg Friedrich',
        'London',
        'GB'
    ),
    (103, 'Haydn', 'Joseph', 'Wien', 'A'),
    (
        104,
        'Mozart',
        'Wolfgang Amadeus',
        'Salzburg',
        'A'
    ),
    (105, 'Beethoven', 'Ludwig van', 'Wien', 'A'),
    (106, 'Schubert', 'Franz', 'Wien', 'A'),
    (107, 'Berlioz', 'Hector', 'Paris', 'F'),
    (108, 'Liszt', 'Franz', 'Wien', 'A'),
    (109, 'Wagner', 'Richard', 'Muenchen', 'D'),
    (110, 'Verdi', 'Giuseppe', 'Busseto', 'I'),
    (111, 'Bruckner', 'Anton', 'Linz', 'A'),
    (112, 'Brahms', 'Johannes', 'Wien', 'A'),
    (113, 'Bizet', 'Georges', 'Paris', 'F'),
    (114, 'Tschaikowskij', 'Peter', 'Moskau', 'RUS'),
    (115, 'Puccini', 'Giacomo', 'Mailand', 'I'),
    (116, 'Strauss', 'Richard', 'Muenchen', 'D'),
    (117, 'Schoenberg', 'Arnold', 'Wien', 'A');
INSERT INTO referent
VALUES (101, '21.03.1935', '01.01.1980', NULL),
    (103, '01.04.1932', '01.01.1991', NULL),
    (104, '27.01.1956', '01.07.1985', NULL),
    (111, '04.09.1924', '01.07.1990', 'Mag'),
    (114, '25.04.1940', '01.07.1980', NULL),
    (116, '11.06.1964', '01.01.1994', 'Dr');
INSERT INTO kurs
VALUES (1, 'Notenkunde', 2, 1400.00),
    (2, 'Harmonielehre', 3, 2000.00),
    (3, 'Rhythmik', 1, 700.00),
    (4, 'Instrumentenkunde', 2, 1500.00),
    (5, 'Dirigieren', 3, 1900.00),
    (6, 'Musikgeschichte', 2, 1400.00),
    (7, 'Komposition', 4, 3000.00);
INSERT INTO setztvor
VALUES (2, 1),
    (3, 1),
    (5, 2),
    (5, 3),
    (5, 4),
    (7, 5),
    (7, 6);
INSERT INTO geeignet
VALUES (1, 103),
    (1, 114),
    (2, 104),
    (2, 111),
    (3, 103),
    (4, 104),
    (5, 101),
    (5, 114),
    (6, 111),
    (7, 103),
    (7, 116);
INSERT INTO kveranst
VALUES (1, 1, '07.04.2013', '08.04.2013', 'Wien', 3, 103),
    (
        1,
        2,
        '23.06.2014',
        '24.06.2014',
        'Moskau',
        4,
        114
    ),
    (
        1,
        3,
        '10.04.2015',
        '11.04.2015',
        'Paris',
        3,
        NULL
    ),
    (2, 1, '09.10.2013', '11.10.2013', 'Wien', 4, 104),
    (
        3,
        1,
        '17.11.2013',
        '17.11.2013',
        'Moskau',
        3,
        103
    ),
    (4, 1, '12.01.2014', '13.01.2014', 'Wien', 3, 116),
    (4, 2, '28.03.2014', '29.03.2014', 'Wien', 4, 104),
    (
        5,
        1,
        '18.05.2014',
        '20.05.2014',
        'Paris',
        3,
        101
    ),
    (5, 2, '23.09.2014', '26.09.2014', 'Wien', 2, 101),
    (5, 3, '30.03.2015', '01.04.2015', 'Rom', 3, NULL),
    (7, 1, '09.03.2015', '13.03.2015', 'Wien', 5, 103),
    (
        7,
        2,
        '14.09.2015',
        '18.09.2015',
        'Muenchen',
        4,
        116
    );
INSERT INTO besucht
VALUES (1, 1, 108, '01.05.2013'),
    (1, 1, 109, NULL),
    (1, 1, 114, NULL),
    (1, 2, 110, '01.07.2014'),
    (1, 2, 112, '03.07.2014'),
    (1, 2, 113, '20.07.2014'),
    (1, 2, 116, NULL),
    (1, 3, 110, NULL),
    (2, 1, 105, '15.10.2013'),
    (2, 1, 109, '03.11.2013'),
    (2, 1, 112, '28.10.2013'),
    (2, 1, 116, NULL),
    (3, 1, 101, NULL),
    (3, 1, 109, NULL),
    (3, 1, 117, '20.11.2013'),
    (4, 1, 102, '20.01.2014'),
    (4, 1, 107, '01.02.2014'),
    (4, 1, 111, NULL),
    (4, 2, 106, '07.04.2014'),
    (4, 2, 109, '15.04.2014'),
    (5, 1, 103, NULL),
    (5, 1, 109, '07.06.2014'),
    (5, 2, 115, '07.10.2014'),
    (5, 2, 116, NULL),
    (7, 1, 109, '20.03.2015'),
    (7, 1, 113, NULL),
    (7, 1, 117, '08.04.2015');
-- 21. Welche Personen besuchen Kursveranstaltungen, die in ihrem Wohnort abgehalten werden und länger als zwei Tage dauern?
SELECT p.fname
FROM person p
WHERE p.pnr IN (
        SELECT b.pnr
        FROM besucht b
            JOIN kveranst kv ON b.knr = kv.knr
            AND b.knrlfnd = kv.knrlfnd
        WHERE kv.ort = p.ort
            AND DATEDIFF(day, von, bis) > 1
    );
-- 22. Welche Kursveranstaltungen werden von Referenten gehalten, die für den Kurs auch geeignet sind?
SELECT (
        SELECT k.bezeichn
        FROM kurs k
        WHERE k.knr = kv.knr
    ) AS [Kurs],
    kv.knrlfnd
FROM kveranst kv
WHERE kv.pnr IN (
        SELECT g.pnr
        FROM geeignet g
        WHERE g.knr = kv.knr
    )
    AND kv.knr IN (
        SELECT k.knr
        FROM kurs k
    );
-- 23. Alle Referenten, die Kursveranstaltungen gehalten haben bevor / nachdem sie in die Firma eingetreten sind.
SELECT DISTINCT p.pnr,
    p.fname + ' ' + p.vname as [Name]
FROM person p
WHERE p.pnr IN (
        SELECT r.pnr
        FROM referent r
            JOIN kveranst kv ON r.pnr = kv.pnr
        WHERE kv.von < r.seit
            OR kv.von > r.seit
    );
-- 24. Alle Personen (PNr, FName), die einen Kurs in 'Wien' besucht oder gehalten haben.
SELECT p.pnr,
    p.fname
FROM person p
WHERE p.pnr IN (
        SELECT b.pnr
        FROM besucht b
        WHERE b.knr IN (
                SELECT kv.knr
                FROM kveranst kv
                WHERE kv.ort = 'Wien'
            )
            AND b.knrlfnd IN (
                SELECT kv.knrlfnd
                FROM kveranst kv
                WHERE kv.ort = 'Wien'
            )
    );
-- 25. Dauer der Kursveranstaltungen im Vergleich mit der im Kurs angegebenen Dauer (geht die Veranstaltung über ein Wochenende / Sa,So?)
select *
from kveranst v
where DATEDIFF(day, von, bis) + 1 > any(
        select k.tage
        from kurs k
        where k.knr = v.knr
    );
-- 26. Welche Referenten, haben Kursveranstaltungen in einem Alter von über 60 Jahren gehalten?
SELECT p.pnr,
    p.fname + ' ' + p.vname as [Name]
FROM person p
WHERE p.pnr IN (
        SELECT r.pnr
        FROM referent r
            JOIN kveranst kv ON r.pnr = kv.pnr
        WHERE DATEDIFF(YEAR, r.gebdat, kv.von) > 60
    );
-- 27. Welche Kursveranstaltungen gibt es, zu denen eine vorausgesetzte Kursveranstaltung zeitlich davor und am selben Ort abgehalten wird?
SELECT v1.*,
    v2.*
FROM setztvor s
    JOIN kveranst v1 ON s.knr = v1.knr
    JOIN kveranst v2 ON s.knrvor = v2.knr
WHERE v2.bis < v1.von
    AND v1.ort = v2.ort;
-- 28. Welche Kursveranstaltungen überschneiden einander terminlich?
SELECT KV1.*,
    KV2.*
FROM kveranst KV1
    JOIN kveranst KV2 ON KV1.knr = KV2.knr
    AND KV1.knrlfnd <> KV2.knrlfnd
    AND KV2.von < KV1.bis
    AND KV2.von > KV1.von;
-- 29. Gibt es Personen, bei denen Kursbesuche einander terminlich überschneiden?
-- ???
-- 30. Gibt es Referenten, bei denen Kursveranstaltungen, die sie halten, einander terminlich überschneiden?
-- ???
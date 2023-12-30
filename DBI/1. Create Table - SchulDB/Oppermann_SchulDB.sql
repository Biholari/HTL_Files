CREATE TABLE Unterricht
(
    persnr INTEGER,
    kuerzel VARCHAR(10),
    name VARCHAR(20),
    stundenanzahl INTEGER,
    PRIMARY KEY (persnr, kuerzel, name),
    FOREIGN KEY (persnr) REFERENCES Lehrkraft(persnr),
    FOREIGN KEY (kuerzel) REFERENCES Fach(kuerzel),
    FOREIGN KEY (name) REFERENCES Klasse (name)
)

CREATE TABLE Fach
(
    kuerzel VARCHAR(10) PRIMARY KEY,
    name VARCHAR(20)
)

CREATE TABLE Lehrkraft
(
    persnr INTEGER PRIMARY KEY,
    name VARCHAR(20),
    geschl VARCHAR(1),
    wohnort VARCHAR(20),
    geb_jarh INTEGER
)

CREATE TABLE Klasse
(
    name VARCHAR(10) PRIMARY KEY,
    zimmer VARCHAR(10),
    persnr INTEGER
)
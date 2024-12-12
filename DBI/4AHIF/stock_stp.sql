create database stock;
use stock;
go;

create table product
(
    prodnr int primary key,
    [description] varchar(50)
);

create table Lager
(
    LNr int primary key,
    Ort varchar(50),
    StueckKap int
);

create table Lieferung
(
    LNr int,
    LfndNr int,
    ANr int,
    Datum date,
    Stueck int,
    primary key (LNr, LfndNr),
    foreign key (LNr) references Lager(LNr),
    foreign key (ANr) references product(prodnr)
);

-- Insert into product table
INSERT INTO product (prodnr, [description]) VALUES (1, 'Product A');
INSERT INTO product (prodnr, [description]) VALUES (2, 'Product B');
INSERT INTO product (prodnr, [description]) VALUES (3, 'Product C');
INSERT INTO product (prodnr, [description]) VALUES (4, 'Product D');
INSERT INTO product (prodnr, [description]) VALUES (5, 'Product E');

-- Insert into Lager table
INSERT INTO Lager (LNr, Ort, StueckKap) VALUES (1, 'Warehouse 1', 1000);
INSERT INTO Lager (LNr, Ort, StueckKap) VALUES (2, 'Warehouse 2', 2000);
INSERT INTO Lager (LNr, Ort, StueckKap) VALUES (3, 'Warehouse 3', 1500);

-- Insert into Lieferung table
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (1, 1, 1, '2023-01-01', 100);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (1, 2, 2, '2023-01-02', 200);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (1, 3, 3, '2023-01-03', 150);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (1, 4, 4, '2023-01-04', 120);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (1, 5, 5, '2023-01-05', 180);

INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (2, 6, 1, '2023-01-06', 130);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (2, 7, 2, '2023-01-07', 220);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (2, 8, 3, '2023-01-08', 160);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (2, 9, 4, '2023-01-09', 190);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (2, 10, 5, '2023-01-10', 210);

INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (3, 11, 1, '2023-01-11', 170);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (3, 12, 2, '2023-01-12', 240);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (3, 13, 3, '2023-01-13', 190);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (3, 14, 4, '2023-01-14', 220);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (3, 15, 5, '2023-01-15', 200);

-- Additional entries to reach 30 insert statements
INSERT INTO product (prodnr, [description]) VALUES (6, 'Product F');
INSERT INTO product (prodnr, [description]) VALUES (7, 'Product G');
INSERT INTO product (prodnr, [description]) VALUES (8, 'Product H');
INSERT INTO product (prodnr, [description]) VALUES (9, 'Product I');
INSERT INTO product (prodnr, [description]) VALUES (10, 'Product J');

INSERT INTO Lager (LNr, Ort, StueckKap) VALUES (4, 'Warehouse 4', 1800);
INSERT INTO Lager (LNr, Ort, StueckKap) VALUES (5, 'Warehouse 5', 2200);

INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (4, 16, 6, '2023-01-16', 250);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (4, 17, 7, '2023-01-17', 260);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (4, 18, 8, '2023-01-18', 270);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (5, 19, 9, '2023-01-19', 280);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (5, 20, 10, '2023-01-20', 290);

INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (5, 21, 6, '2023-01-21', 300);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (5, 22, 7, '2023-01-22', 310);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (5, 23, 8, '2023-01-23', 320);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (4, 24, 9, '2023-01-24', 330);
INSERT INTO Lieferung (LNr, LfndNr, ANr, Datum, Stueck) VALUES (4, 25, 10, '2023-01-25', 340);

-- go
-- ANr: Product Number
go
create procedure Anlieferung (@ANr int, @Datum datetime, @Stueck int)
as
begin
    create table #Lager
    (
        LNr int primary key,
        Produktstand int
    );

    select LNr, sum(Stueck) as Produktstand
        into #Lager
    from Lieferung
    where ANr = @ANr
    group by LNr;

    drop table #Lager;
END;
go
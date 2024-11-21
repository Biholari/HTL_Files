use stp_uebg;

DROP TABLE if exists lt
go
DROP TABLE if exists l
go
DROP TABLE if exists t
go

---------------------------------------------------------
-- Tabelle der Lieferanten
---------------------------------------------------------
CREATE TABLE l (
       lnr    CHAR(2) PRIMARY KEY,
       lname  VARCHAR(6),
       rabatt DECIMAL(2),
       stadt  VARCHAR(6))
go

---------------------------------------------------------
-- Tabelle der Teile
---------------------------------------------------------
CREATE TABLE t (
       tnr    CHAR(2) PRIMARY KEY,
       tname  VARCHAR(8),
       farbe  VARCHAR(5),
       preis  DECIMAL(10,2),
       stadt  VARCHAR(6))
go

---------------------------------------------------------
-- Tabelle der Lieferungen
---------------------------------------------------------
CREATE TABLE lt (
       lnr    CHAR(2) REFERENCES l,
       tnr    CHAR(2) REFERENCES t,
       menge  DECIMAL(4),
       PRIMARY KEY (lnr,tnr))
go

INSERT INTO l VALUES ('L1','Schmid',20,'London')
INSERT INTO l VALUES ('L2','Jonas', 10,'Paris' )
INSERT INTO l VALUES ('L3','Berger',30,'Paris' )
INSERT INTO l VALUES ('L4','Klein', 20,'London')
INSERT INTO l VALUES ('L5','Adam',  30,'Athen' )
go
INSERT INTO t VALUES ('T1','Mutter',  'rot',  12,'London')
INSERT INTO t VALUES ('T2','Bolzen',  'gelb', 17,'Paris' )
INSERT INTO t VALUES ('T3','Schraube','blau', 17,'Rom'   )
INSERT INTO t VALUES ('T4','Schraube','rot',  14,'London')
INSERT INTO t VALUES ('T5','Welle',   'blau', 12,'Paris' )
INSERT INTO t VALUES ('T6','Zahnrad', 'rot',  19,'London')
go
INSERT INTO lt VALUES ('L1','T1',300)
INSERT INTO lt VALUES ('L1','T2',200)
INSERT INTO lt VALUES ('L1','T3',400)
INSERT INTO lt VALUES ('L1','T4',200)
INSERT INTO lt VALUES ('L1','T5',100)
INSERT INTO lt VALUES ('L1','T6',100)
INSERT INTO lt VALUES ('L2','T1',300)
INSERT INTO lt VALUES ('L2','T2',400)
INSERT INTO lt VALUES ('L3','T2',200)
INSERT INTO lt VALUES ('L4','T2',200)
INSERT INTO lt VALUES ('L4','T4',300)
INSERT INTO lt VALUES ('L4','T5',400)
go

select * from l;
select * from t;
select * from lt;

--------------------------------------------------------------
--------------------------------------------------------------
-- Die Verwendung von IF 
--Wenn die Anzahl der Teile am Lager 'L1' gr��er als 10 ist, dann Meldung ausgeben,
--sonst von jedem Teil am Lager 'L1' Name des Teils, Farbe, Menge ausgeben
go
if (select sum(menge) from lt where lnr='L1') > 10
   print 'zu viele Teile am Lager'
else
   select tname, farbe, menge from t, lt where lnr='L1' and t.tnr=lt.tnr;
go

--------------------------------------------------------------
--------------------------------------------------------------
--Die while Anweisung
--Solange die Summe der Menge aller Artikel im Lager kleiner als 10000 ist,
--soll die Menge um 10 % erh�ht werden. 
--Wenn jedoch der Maximalwert der Menge eines Teiles gr��er als 500 ist,
--soll abgebrochen werden
go
declare @summe decimal(10)
select @summe = sum(menge) from lt
while @summe < 10000
begin
   update lt set menge = menge * 1.1
   select @summe = sum(menge) from lt
   if (select max(menge) from lt) > 500
      break
end
select * from lt
go;

----------------------------------------------------------
----------------------------------------------------------
-- Lokale Variablen
--'Durchschnitt' und 'Grenze' sind zwei Variablen
--'Grenze' hat den fixen Wert 300
--'Durchschnitt' von Menge in Tabelle lt
--Falls die Maximalmenge eines Artikels im Lager 'L1' größer als 'Grenze' ist,
--soll die Menge vom 'L1'im Lager um den Durchschnitt erhöht werden.
go
declare @durchschnitt decimal(10)  
declare @grenze decimal(10)
select @grenze = 300
select @durchschnitt = avg(menge) from lt
if (select max(menge) from lt where lnr='L1') > @grenze
       update lt set menge = menge + @durchschnitt where lnr='L1'
select * from lt
go;

-------------------------------------------------------
-------------------------------------------------------
-- Stored Procedure 1
-- die Mengen der Tabelle lt sollen um einen mitübergebenen Prozentwert erhöht werden
-- anlegen:
go
create procedure erhoehe_menge (@prozent decimal(3))
as
begin
   update lt set menge = menge * (1 + @prozent/100)
end
go
--aufrufen:
exec erhoehe_menge 5
select * from lt
go

---------------------------------------------------------
---------------------------------------------------------
--stored Procedure 2
--es soll der übergebene Artikel aus lt gelöscht werden und die mengen der restlichen artikel
--um 5 % erhöht werden. - verschachtelter prozeduraufruf
-- anlegen:
go
create procedure del_t (@tnr char(2))
as
begin
   delete from lt where tnr=@tnr
   exec erhoehe_menge 5
end
go
--aufrufen:
exec del_t 'T1'
select * from lt
go

-------------------------------------------------------------
-- Erstellen Sie eine Prozedur del_l (lnr) mit Output-Parameter:
-- Zeile aus L löschen; dabei eventuell vorher entsprechende Zeilen aus lt löschen;
-- zurückgeben, wie viele Zeilen aus lt gelöscht werden mussten
go
create procedure del_l (@lnr char(2), @anz int output)
as
begin
   select @anz = count(*) from lt where lnr=@lnr
   delete from lt where lnr=@lnr
   delete from l where lnr=@lnr
end
go
declare @anz int
exec del_l 'L1', @anz output
print @anz
select * from l
select * from lt
go

-----------------------------------------------------------------
-- Erstellen Sie eine Prozedur clear_lt(m) returning
-- Solange die Summe der Mengen in lt größer als m ist, die Lieferung mit der jeweils niedrigsten Menge
-- löschen; zurückgeben, wie viele Lieferungen gelöscht wurden; keine rekursive Lösung einsetzen
------------------------------------
create procedure clear_lt (@m decimal(10), @anz int output)
as
begin
   declare @minmenge decimal(10)
   declare @lnr char(2)
   declare @tnr char(2)
   declare @menge decimal(4)
   select @anz = 0
   while (select sum(menge) from lt) > @m
   begin
      select @minmenge = min(menge) from lt
      select @lnr = lnr, @tnr = tnr, @menge = menge from lt where menge = @minmenge
      delete from lt where lnr=@lnr and tnr=@tnr
      select @anz = @anz + 1
   end
end
go
declare @anz int
exec clear_lt 1000, @anz output
print @anz
select * from lt
go
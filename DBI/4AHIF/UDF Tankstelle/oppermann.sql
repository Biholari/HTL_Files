use Tankstelle
go


-- a
drop function if exists udfTag_mit_MaxUmsatz

go
create or alter function udfTag_mit_MaxUmsatz(@Monat int)
returns datetime
as
begin
	declare @MaxUmsatzTag date

    select top 1 @MaxUmsatzTag = cast(v.Verkaufszeitpunkt as date)
    from Verkauf v
        join Zapfsaeule zs on v.ZNr = zs.ZNr
        join Tagespreis tp on tp.KName = zs.KName and cast(v.VerkaufsZeitpunkt as date) = tp.Tagesdatum
    where month(v.VerkaufsZeitpunkt) = @Monat
    group by cast(v.VerkaufsZeitpunkt as date)
    order by sum(v.MengeL * tp.Preis) desc

    return @MaxUmsatzTag
end
go

    select top 1 cast(v.Verkaufszeitpunkt as date)
    from Verkauf v
        join Zapfsaeule zs on v.ZNr = zs.ZNr
        join Tagespreis tp on tp.KName = zs.KName and convert(date, v.VerkaufsZeitpunkt ) = tp.Tagesdatum
    where month(v.VerkaufsZeitpunkt) = 10
    group by cast(v.VerkaufsZeitpunkt as date)
    order by sum(v.MengeL * tp.Preis) desc

go
select dbo.udfTag_mit_MaxUmsatz (4)
go


-- b
drop function if exists udfPreisaenderung_in_Prozent

go
create function udfPreisaenderung_in_Prozent(@AlterPreis int, @NeuerPreis int)
returns int
as
begin
	return cast((@NeuerPreis / 100) * @AlterPreis as int)
end
go

-- c
drop proc if exists stpPreisentwicklung

-- TODO
go
create or alter proc stpPreisentwicklung 
    @Kraftstoffname varchar(50), 
    @Monat int
as
begin
    declare @Change table (Tageswert decimal(10,4), AbsWert decimal(10,4), ProzWert decimal(10,4))

    declare @StartPreis decimal(10,4), @Preis decimal(10,4)

    -- Get first price
    select top 1 @StartPreis = tp.Preis 
    from Tagespreis tp 
    where month(tp.Tagesdatum) = @Monat and tp.KName = @Kraftstoffname 
    order by tp.Tagesdatum 

    if @StartPreis is null or @StartPreis = 0
    begin
        raiserror('StartPreis ist null oder 0', 16, 1)
        return
    end

    insert into @Change
    select 
        tp.Preis,
        cast(@StartPreis - tp.Preis as decimal(10,4)),
        cast((tp.Preis * 100) / @StartPreis as decimal(10,2))
    from Tagespreis tp
    where month(tp.Tagesdatum) = @Monat and tp.KName = @Kraftstoffname 
    order by tp.Tagesdatum 

    select * from @Change
end
go

exec dbo.stpPreisentwicklung 'Benzin', 10


-- c
drop proc if exists stpBetrag

go
create or alter proc stpBetrag 
    @ZNr int, 
    @Menge int, 
    @ZahlenderBetrag int output
as
begin
    if not exists (select 1 from Zapfsaeule zs where zs.ZNr = @ZNr)
        raiserror ('Zapfsäule gibt es nicht', 16, 1)

    if (@Menge > (select zs.aktMengeL from Zapfsaeule zs where zs.ZNr = @ZNr))
        raiserror ('Es gibt nicht so viel Kraftstoff', 16, 1)

    select @ZahlenderBetrag = @ZahlenderBetrag + (
        select tp.Preis * @Menge
        from Zapfsaeule zs
            join Kraftstoff ks on ks.KName = zs.KName
            join Tagespreis tp on tp.KName = ks.KName
        where zs.ZNr = @ZNr and tp.Tagesdatum = getdate()
    )

    update Zapfsaeule 
    set aktMengeL = aktMengeL - @Menge
    where ZNr = @ZNr

    insert into Verkauf values
    ((select top 1 coalesce(v.VNr+1,0) from Verkauf v order by v.VNr), 
        @Menge, getdate(), @ZNr);
end
go
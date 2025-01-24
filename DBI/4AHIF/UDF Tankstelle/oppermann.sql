drop function if exists udfTag_mit_MaxUmsatz

go
create function udfTag_mit_MaxUmsatz(@Monat int)
returns datetime
as
begin
	declare @tempt table (preis int, tag datetime)

	insert into @tempt
	select sum(vk.MengeL * tp.Preis), vk.VerkaufsZeitpunkt
	from Tagespreis tp
		join Kraftstoff ks on ks.KName = tp.KName
		join Zapfsaeule zs on zs.KName = ks.KName
		join Verkauf vk on vk.ZNr = zs.ZNr
	where month(tp.Tagesdatum) = @Monat and month(vk.VerkaufsZeitpunkt) = @Monat 
	group by vk.VerkaufsZeitpunkt


	return (
		select top 1 tag
		from @tempt
		order by preis
	)
end
go

go
select dbo.udfTag_mit_MaxUmsatz (10)
go

go
create function udfPreisaenderung_in_Prozent(@AlterPreis int, @NeuerPreis int)
return int
as
begin
	select 1;
end
go
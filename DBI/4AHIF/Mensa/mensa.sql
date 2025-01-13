use mensa;

drop proc if exists Zutatenslite;

go
create proc Zutatenslite 
	@MenueNr int, 
	@Portionen int
as
begin
	declare @ErgebnisTabelle table (
		ZutatenNr int, 
		Bezeichnung varchar(35), 
		BenoetigteMenge int, 
		Einheit varchar(5),
		FehlendeMenge int);

	declare @SpeiseNr int;

	declare SpeiseCursor cursor for
	select SpeiseNr
	from speise;

	open SpeiseCursor
	fetch next from SpeiseCursor into @SpeiseNr;

	while @@FETCH_STATUS = 0
	begin
		insert into @ErgebnisTabelle
		select z.ZutatenNr,
				z.Bezeichnung,
				sba.Menge,
				z.Einheit,
				case
					when z.aktBestand >= (sba.Menge * @Portionen) then 0
					else (sba.Menge * @Portionen) - z.aktBestand
				end as AktuellerBestand
		from Speise_besteht_aus sba
			join zutat z on z.ZutatenNr = sba.Zutatennr
		where sba.SpeiseNr = @SpeiseNr;

		update z
		set z.aktBestand = case
				when z.aktBestand >= (sba.Menge * @Portionen) 
				then z.aktBestand - (sba.Menge * @Portionen)
				else 0
			end
		from zutat z
			join Speise_besteht_aus sba on z.ZutatenNr = sba.Zutatennr
		where sba.SpeiseNr = @SpeiseNr;

		fetch next from SpeiseCursor into @SpeiseNr;
	end

	select * from @ErgebnisTabelle;

	close SpeiseCursor
	deallocate SpeiseCursor
end
go

exec Zutatenslite 1, 1;

select *
from Speise_besteht_aus
where SpeiseNr = 101
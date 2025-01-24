use mensa;

drop proc if exists Zutatenslite;

go
CREATE PROCEDURE Zutatenliste
    @MenueNummer INT,
    @AnzahlPortionen INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Tempor�re Tabelle f�r die Ausgabe
    declare @ZutatenListe table (
        Zutatennummer INT,
        Bezeichnung NVARCHAR(255),
        Ben�tigteMenge DECIMAL(10, 2),
        Einheit NVARCHAR(50),
        FehlendeMenge DECIMAL(10, 2)
    );

    -- Cursor zur Iteration �ber die ben�tigten Zutaten des Men�s
    DECLARE ZutatenCursor CURSOR FOR
    SELECT 
        z.ZutatenNr,
        z.Bezeichnung,
        z.Einheit,
        z.aktBestand,
        SUM(sb.Menge * @AnzahlPortionen) AS Ben�tigteMenge
    FROM Menue_besteht_aus mb
    INNER JOIN Speise_besteht_aus sb ON mb.SpeiseNr= sb.SpeiseNr
    INNER JOIN Zutat z ON sb.Zutatennr = z.ZutatenNr
    WHERE mb.MenueNr= @MenueNummer
    GROUP BY z.ZutatenNr, z.Bezeichnung, z.Einheit, z.aktBestand;

    -- Variablen f�r den Cursor
    DECLARE @Zutatennummer INT;
    DECLARE @Bezeichnung NVARCHAR(255);
    DECLARE @Einheit NVARCHAR(50);
    DECLARE @Bestand DECIMAL(10, 2);
    DECLARE @Ben�tigteMenge DECIMAL(10, 2);
    DECLARE @FehlendeMenge DECIMAL(10, 2);

    -- Cursor �ffnen
    OPEN ZutatenCursor;

    -- Lesen der ersten Zeile des Cursors
    FETCH NEXT FROM ZutatenCursor INTO @Zutatennummer, @Bezeichnung, @Einheit, @Bestand, @Ben�tigteMenge;

    -- Schleife �ber alle Datens�tze
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Fehlende Menge berechnen
        IF @Bestand < @Ben�tigteMenge
        BEGIN
            SET @FehlendeMenge = @Ben�tigteMenge - @Bestand;
        END
        ELSE
        BEGIN
            SET @FehlendeMenge = 0;
        END;

        -- Einf�gen der Ergebnisse in die tempor�re Tabelle
        INSERT INTO @ZutatenListe (Zutatennummer, Bezeichnung, Ben�tigteMenge, Einheit, FehlendeMenge)
        VALUES (@Zutatennummer, @Bezeichnung, @Ben�tigteMenge, @Einheit, @FehlendeMenge);

        -- Bestand aktualisieren
        UPDATE Zutat
        SET aktBestand = CASE 
                        WHEN aktBestand - @Ben�tigteMenge < 0 THEN 0
                        ELSE aktBestand - @Ben�tigteMenge
                      END
        WHERE ZutatenNr = @Zutatennummer;

        -- N�chste Zeile des Cursors lesen
        FETCH NEXT FROM ZutatenCursor INTO @Zutatennummer, @Bezeichnung, @Einheit, @Bestand, @Ben�tigteMenge;
    END;

    -- Cursor schlie�en und freigeben
    CLOSE ZutatenCursor;
    DEALLOCATE ZutatenCursor;

    -- Ausgabe der Ergebnisse
    SELECT * FROM @ZutatenListe;
END;
GO

begin try
	exec dbo.Zutatenliste 44, 1
end try
begin catch
	print error_message()
end catch
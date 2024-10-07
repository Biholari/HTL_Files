-- 1. Legen Sie einen Serveruser an
CREATE LOGIN ServerBenutzer WITH PASSWORD='Birnenapfel-2006';
GO

-- 2. Weisen Sie Ihrem neu erstellten Benutzer die Serverrolle „dbcreator“ zu
EXEC sp_addsrvrolemember 'ServerBenutzer', 'dbcreator';
GO

-- 3
-- d. Gewähren Sie den Windows-Gruppen Serverzugriff.
CREATE LOGIN [ADMIN-LAPTOP\Verkauf] FROM WINDOWS;
GRANT CONNECT SQL TO [ADMIN-LAPTOP\Verkauf]
GO
CREATE LOGIN [ADMIN-LAPTOP\Marketing] FROM WINDOWS;
GRANT CONNECT SQL TO [ADMIN-LAPTOP\Marketing]
GO

-- e. Legen Sie die Datenbanken an
CREATE DATABASE VerkaufsDB
ON
(
	NAME=VerkaufsDB_data,
	FILENAME='C:\Users\fabia\SQL_Data\VerkaufsDB_data.mdf',
	SIZE=10MB,
	FILEGROWTH=5MB
)
LOG ON 
(
	NAME = VerkaufsDB_log,  
	FILENAME='C:\Users\fabia\SQL_Data\VerkaufsDB_log.ldf',
	SIZE=10MB,
	FILEGROWTH=5MB
);
GO

CREATE DATABASE MarketingDB
ON 
( 
	NAME = MarketingDB_data,
	FILENAME = 'C:\Pfad\Zu\MarketingDB_data.mdf',  
	SIZE = 10MB, 
	FILEGROWTH = 5MB 
)
LOG ON 
( 
	NAME = MarketingDB_log,  
	FILENAME = 'C:\Pfad\Zu\MarketingDB_log.ldf', 
	SIZE = 10MB, 
	FILEGROWTH = 5MB 
);
GO

-- f. Die Marketing Gruppe soll alle Berechtigungen für die Datenbank Marketing haben.
USE MarketingDB;
/*CREATE USER [DOMAIN\Marketing] FOR LOGIN [DOMAIN\Marketing];
EXEC sp_addrolemember N'db_owner', N'DOMAIN\Marketing';
*/
GRANT CONTROL ON DATABASE::MarketingDB TO [ADMIN-LAPTOP\Marketing];
GO

-- g. Die Gruppe Marketing hat nur Leseberechtigung auf alle Objekte der "VerkaufsDB".
USE VerkaufsDB;
/*CREATE USER [DOMAIN\Marketing] FOR LOGIN [DOMAIN\Marketing];
EXEC sp_addrolemember N'db_datareader', N'DOMAIN\Marketing';*/
GRANT SELECT ON DATABASE::VerkaufsDB TO [ADMIN-LAPTOP\Marketing];
GO
-- Abfrage des System und Datenkataloges = Data Dictionary
use master
go

select * from sys.servers


-- Verzeichnis aller *mdf, *ldf Dateien
select * from sys.master_files

-- Verzeichnis aller Datenbanken
select * from sys.sysdatabases


-- Verzeichnis aller Windows Logins
select * from sys.server_principals

select * from sys.sql_logins


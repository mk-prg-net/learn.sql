-- =============================================
-- Create Database Snapshot Template
-- =============================================
USE master
GO

-- Anlegen des 1. Schnappschusses
-- Drop database snapshot if it already exists
IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'test_restore_1'
)
DROP DATABASE [test-restore_1]
GO

-- Create the database snapshot
CREATE DATABASE [test-restore_1] ON
( NAME = [test-restore], FILENAME = 
'C:\Program Files\Microsoft SQL Server\MSSQL13.SQL2016DEV\MSSQL\DATA\test-restore_1.ss' )
AS SNAPSHOT OF [test-restore];
GO


-- !!!! Hier ca. 1/2 Minute warten bis zur Ausführung der nächsten Befehle

-- Anlegen des 2. Schnappschusses
-- Drop database snapshot if it already exists
IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'test_restore_2'
)
DROP DATABASE [test-restore_2]
GO

-- Create the database snapshot
CREATE DATABASE [test-restore_2] ON
( NAME = [test-restore], FILENAME = 
'C:\Program Files\Microsoft SQL Server\MSSQL13.SQL2016DEV\MSSQL\DATA\test-restore_2.ss' )
AS SNAPSHOT OF [test-restore];
GO

-- Ergebnisse prüfen
use [test-restore_1]
select max(uhrzeit)
from data

use [test-restore_2]
select max(uhrzeit)
from data

use [test-restore]
select max(uhrzeit)
from data

-- Die Maximale Uhrzeit in test-restore_1 und test-restore_2 entspricht 
-- den Zeitpunkten, zu denen die Momentaufnahmen erfolgten


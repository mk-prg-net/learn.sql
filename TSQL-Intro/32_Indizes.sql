-- 25.07.03, mko
-- Anwenden von Indizes
-- 13.3.2017, mko
-- TestIndex Prozedur schreibt jetzt ihre Zeitmessungen in die Tabelle dbo.benchmark
-- Achtung: 
--          Bitte vor Ausführung von TestIndex im SSMS Menü  
--          Abfrage\Abfrageoptionen\Ergebnisse\Raster\Ergebnisse nach Ausführung verwerfen anhaken.
--			Sonst werden tausende Ergebnisse an SSMS zurückgesendet, und online in die Rateransicht ein-
--			getragen, so dass 99% der Arbeitslast auf die Darstellung der Ergebnisse in SSMS entfallen.
--			Im Taksmanager kann dieser Sachverhalt nachgeprüft werden.

use master
go

if exists(select name from master.dbo.sysdatabases where name = 'db_indextest')
	drop database db_indextest
go

create database db_indextest
go

use db_indextest
go

--===================================================================================================
-- Tabelle Anlegen, in die alle Primzahlen eingespeist werden

create table dbo.primzahlen (

	nr	int	identity(1,1),
	wert	int

)
go

create table dbo.benchmark(
	run int identity(1,1),
	duration_in_ms int,
	info nvarchar(1000)
)
go

truncate table primzahlen
go

use [db_indextest]
go

-- Testfunktion zur Prüfung der Leistungsfähigkeit von Indizes
create Procedure TestIndex
	@info nvarchar(1000)
as
declare @startzeit datetime
set @startzeit = current_timestamp

declare @zahl as int
declare @treffer as int

set @zahl = 101

while @zahl < 1000000
begin
   select @treffer=wert from primzahlen where wert = @zahl
   set @zahl = @zahl + 107
end

declare @dauer int
set @dauer = datediff(ms, @startzeit, current_timestamp)

insert into dbo.benchmark (duration_in_ms, info)
values (@dauer, @info)

--print 'Dauer ' + cast(@dauer as varchar(20))

go


--===================================================================================================
-- Berechnen alle Primzahlen, und speichern in Tabelle Primzahlen
print 'Primzahlenberechnung startet, bitte warten ...'
declare @startzeit datetime
set @startzeit = current_timestamp

declare @kandidat int, @teiler int

set @kandidat = 2
while (@kandidat <= 1000000)
begin
  declare @wurzel_aus_kandidat float
  set @wurzel_aus_kandidat = sqrt(@kandidat)
  set @teiler = 2
  while @teiler < @wurzel_aus_kandidat and (@kandidat % @teiler) <> 0
     set @teiler = @teiler + 1
  
  if @teiler >= @wurzel_aus_kandidat
     insert into primzahlen (wert) values (@kandidat)
	
  set @kandidat = @kandidat + 1

end 

print 'fertig mit anlegen von Tabellen' 

declare @dauer int

go


select * from primzahlen where wert = 662939
go

--===================================================================================================
-- Zugriff auf eine Primzahl in der Tabelle ohne Index
use [db_indextest]
go

exec TestIndex @info= 'ohne Index'
go

--===================================================================================================
-- Index anlegen
use [db_indextest]
go
create index ix_test on primzahlen (wert)
go

--===================================================================================================
-- Zugriff auf eine Primzahl in der Tabelle mit Index
use [db_indextest]
go
exec TestIndex  @info= 'mit Index'
go


exec sp_monitor
go
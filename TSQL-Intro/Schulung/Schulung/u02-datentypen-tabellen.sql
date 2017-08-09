use master
go

-- eine neue Datenbank anlegen
create database TestDB
go

use TestDB
go

-- Tabelle zur Demo von Datentypen anlegen
create table dbo.termine (
  zeit datetime,
  thema varchar(256)
)

create table dbo.termine2 (zeit datetime, thema varchar(256))

go
set dateformate dmy
go
insert into termine values
('3/9/2003 19:00', 'Zahnartzt')
go
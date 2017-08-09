drop database uedb
go

create database uedb
go

use uedb
go

drop table dbo.kunde

create table dbo.kunde (
  kd_nr int identity(100,1) not null,  -- Kleinere Kundennummern als 100 werden nie erzeugt
  name  varchar(100),
  vorname varchar(100),
  adresse varchar(255),
  primary key (kd_nr)
)
go


insert into dbo.kunde(name, vorname) values('Hugendubel', 'Franz')
select IDENT_CURRENT('kunde')

insert into dbo.kunde(name, vorname) values('Durchblick', 'Clara')
select IDENT_CURRENT('kunde')

-- Standardwerte

drop table rechnung
go

create table rechnung (
  nr int primary key identity(1,1),
  zahlungsart int default 1,
  zahlungsart2 int ,
  adresse varchar(255)
)
go  

insert into rechnung (adresse) values('Entenhausen')
select * from rechnung

--
drop table mitarbeiter
go

-- Check- Einschränkungen
create table mitarbeiter
(
  mnr           int not null primary key check(mnr >= 100),  
  plz           char(5) not null check (plz like '[0-9][0-9][0-9][0-9][0-9]'),  
  geschlecht    char(1) not null default 'm',
  eingestellt_am datetime not null
)
go
-- Durch try catch wird erreicht, das bei Verletzung der Integrität durch 
-- die erste Anweisung nicht die nachfolgenden ausgeführt werden
begin try
	insert into mitarbeiter (mnr, plz, eingestellt_am) 
	values (99, '12345', '1.1.2009 10:00')

	insert into mitarbeiter (mnr, plz, eingestellt_am) 
	values (100, '12345', '1.1.2009 10:00')
end try
begin catch
  print( 'aus catch')
  SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage
  print ERROR_MESSAGE()

end catch

	select * from mitarbeiter

go

-- Integritätregeln abschalten
alter table mitarbeiter nocheck constraint all  -- Alle Integritätsregeln für words werden abgeschaltet
go

begin try
	insert into mitarbeiter (mnr, plz, eingestellt_am) 
	values (99, '12345', '1.1.2009 10:00')

	insert into mitarbeiter (mnr, plz, eingestellt_am) 
	values (100, '12345', '1.1.2009 10:00')
end try
begin catch
  print( 'aus catch')
  SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage
  print ERROR_MESSAGE()

end catch

	select * from mitarbeiter

go

alter table mitarbeiter check constraint all  -- Alle Integritätsregeln für mitarbeiter werden eingeschaltet
go

begin try
	insert into mitarbeiter (mnr, plz, eingestellt_am) 
	values (99, '12345', '1.1.2009 10:00')

	insert into mitarbeiter (mnr, plz, eingestellt_am) 
	values (100, '12345', '1.1.2009 10:00')
end try
begin catch
  print( 'aus catch')
  SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage
  print ERROR_MESSAGE()

end catch

	select * from mitarbeiter

go
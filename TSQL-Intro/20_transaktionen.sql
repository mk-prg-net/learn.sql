-- u11 Transaktionen
--

-- Neue Datenbank Konten

use master
go

if exists(select * from master.dbo.sysdatabases where name = 'konten')
   drop database Bank

go

create database Bank
go

use Bank
go

create table dbo.sparkonto (

	ktonr	int primary key not null,
	guthaben money
)


create table dbo.girokonto (
	ktonr	int primary key not null,
	guthaben money
)
go


insert into sparkonto (ktonr, guthaben) values(4711, 1000)
insert into sparkonto (ktonr, guthaben) values(1815, 2000)

insert into girokonto (ktonr, guthaben) values(4711, -500)
insert into girokonto (ktonr, guthaben) values(1815, 3000)

go

-- u12 Buchungstransaktion
-- Buchen von Spar auf Girokonto

use konten
go

print 'vor der Buchung'
select * from dbo.sparkonto
select * from dbo.girokonto
go

begin tran

	declare @ktonr as int
	set @ktonr = 4711
	declare @betrag as money
	set @betrag = 600

	-- Abbuchen vom Sparkonto
	update dbo.sparkonto set guthaben = guthaben - @betrag where ktonr = @ktonr

	-- Buchen auf dem Girokonto
	update dbo.girokonto set guthaben = guthaben + @betrag where ktonr = @ktonr


	-- Alles zurückrollen, wenn guthaben auf dem Sparkonto < 0 wird
	declare @neues_sparguthaben as money 
	select @neues_sparguthaben = guthaben from dbo.sparkonto where ktonr = @ktonr

	if @neues_sparguthaben < 0 
		begin
			print 'Buchung abgebrochen: Sparkonto ungedeckt'
			rollback tran
		end
	else
		commit tran
go


print 'nach der Buchung'
select * from dbo.sparkonto
select * from dbo.girokonto
go


-- Legt die Datenbanklogins für Anton, Berta und Caesar an
use keplerBi
go
create proc CreateAntonBertaCaesar
as
	-- Datenbankbenutzer anlegen
	create user Anton for login Anton
	create user Berta for login Berta
	create user Caesar for login Caesar
go
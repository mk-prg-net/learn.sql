-- Löscht die Datenbankbenutzer Anto, Berta Caesar
use KeplerBI
go
create proc dropAntonBertaCaesar
as
	drop user Anton
	drop user Berta
	drop user Caesar
go

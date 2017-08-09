-- Freischalten des Datenbank Email Features 

EXEC sp_configure 'Database Mail Xps', 1
go

reconfigure with override
go
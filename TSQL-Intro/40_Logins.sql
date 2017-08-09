use master
go

-- liste aller Prozesse
exec sp_who 'Werk12\Martin'
go

-- Liste aller aktuellen Anmeldungen
exec sp_helplogins
go

-- Liefert Infos zu den Datenbanken
exec sp_helpdb
go

select * from sys.sysdatabases
go

select * from sys.databases
go

exec sp_helprole
go

-- Listet alle Rollen, die ein User hat, sowie die Anmeldung, der er zugeordnet ist

exec sp_helpuser 'dbo'
go

use KeplerDB
go
exec sp_helpuser 
go

-- Listet alle Member einer Datenbankrolle auf
exec sp_helprolemember 'Import_Manager'
go

select * from sys.database_principals
go 

-- Auflisten von Berechtigungen 
-- http://msdn.microsoft.com/de-de/library/ms187328.aspx
SELECT pr.principal_id, pr.name, pr.type_desc, 
    pr.authentication_type_desc, pe.state_desc, pe.permission_name
FROM sys.database_principals AS pr
JOIN sys.database_permissions AS pe
    ON pe.grantee_principal_id = pr.principal_id;

go

SELECT pr.principal_id, pr.name, pr.type_desc, 
    pr.authentication_type_desc, pe.state_desc, 
    pe.permission_name, s.name + '.' + o.name AS ObjectName
FROM sys.database_principals AS pr
JOIN sys.database_permissions AS pe
    ON pe.grantee_principal_id = pr.principal_id
JOIN sys.objects AS o
    ON pe.major_id = o.object_id
JOIN sys.schemas AS s
    ON o.schema_id = s.schema_id;
go



use KeplerDB
go
-- Liste aller Anmeldungen
select * from sys.credentials

select * from sys.linked_logins

select * from sys.remote_logins

select * from sys.server_principals

select * from sys.objects
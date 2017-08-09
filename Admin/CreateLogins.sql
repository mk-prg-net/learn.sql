-- Anlegen von SQL Server Logins in der KeplerBI
use KeplerBI
go

-- Auflisten aller vorhandenen Logins
select [name] from sys.sql_logins
go


-- Anton, Berta und C�sar als SQL Server Logins anlegen
create login Anton
with password='1234'

create login Berta
with password='Pa$$w0rd' must_change, check_expiration=on, check_policy=on

create login Caesar
with password='Pa$$w0rd' must_change, check_expiration=on, check_policy=on
go

-- Passworte von Anton, Berta und C�sar muss komplex sein
alter login Anton
with check_policy=on

-- Auflisten aller vorhandenen Logins
select [name] from sys.sql_logins
go

-- Alle Logins wieder l�schen
drop login Anton
drop login Berta
drop login Caesar


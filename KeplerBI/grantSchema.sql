-- Anton und Berta sind forschende Astronomen. Sie bekommen Lesezugriff auf alle Entitäten im 
-- Kosmos- Schema
grant select on schema::KOSMOS to Anton
grant select, update on schema::KOSMOS to Berta
-- Cäsar erhält keinen Zugriff auf den Kosmos. Dafü ist er Admin
grant select, insert, update, delete on schema::[Admin] to Caesar
go

use keplerBI
go

-- Impersionation als Anton
execute as user = 'Anton'
go

select * from kosmos.CelestialBodyBases where [name]='Jupiter'
revert
go

execute as user = 'Caesar'
go

-- Wird scheitern, da Cäsar kein Leserecht hat
select * from kosmos.CelestialBodyBases where [name]='Jupiter'
revert
go

execute as user = 'Berta'
go

-- Berta hat auch das Recht zu aktualisieren
update kosmos.CelestialBodyBases 
Set RankSum += 1, RankCount += 1 
where [Name] = 'Jupiter'
select * from kosmos.CelestialBodyBases where [name]='Jupiter'
revert
go

-- Berta das Recht entziehen, kosmische Objekte zu aktualisieren
deny update on schema::kosmos to Berta
go

execute as user = 'Berta'
go
-- Berta hat auch das jektz kein Recht zu aktualisieren
update kosmos.CelestialBodyBases 
Set RankSum += 1, RankCount += 1 
where [Name] = 'Jupiter'
select * from kosmos.CelestialBodyBases where [name]='Jupiter'
revert
go

revoke select on schema::kosmos from Caesar
go

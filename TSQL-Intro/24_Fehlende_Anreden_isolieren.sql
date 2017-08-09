use ImperialESP
go


-- Alle alten Einträge in der Zwischentabelle löschen
truncate table schulung.Geschlechtertrennung
go

-- Alternativ:
--delete from schulung.Geschlechtertrennung
go


-- Einschränken auf user, die keiner Filiale zugeordnet sind
-- Einfügen in die Tabelle Geschlechtertrennung
-- Die kleine Tabelle Geschlechtertrennung kann direkt in SQL Management- Studio 
-- bearbeitet werden
insert into [Schulung].[Geschlechtertrennung]
([Personal_PK], [Name] , [Vorname1])
select A.Personal_PK, A.Name, A.Vorname1
from dbo.Personal as A  left outer join dbo.Filiale as C on A.Filiale_FK = C.Filiale_PK
						left outer join dbo.Anrede as B on A.Anrede_FK = B.Anrede_PK 
where B.Anrede_PK is Null and C.Filiale_PK is null and A.Ist_Kassierer < 0 and A.aktiv < 0

-- Aufgabe: Finde alle Personaldatensätze, für die es noch keinen
-- Anrede gibt.

use ImperialESP
go

select A.Name, A.Vorname1, B.Anrede_PK, B.Bezeichnung
from dbo.Personal as A left outer join dbo.Anrede as B on A.Anrede_FK = B.Anrede_PK 
where B.Anrede_PK is Null 

select A.Name, A.Vorname1, B.Anrede_PK, B.Bezeichnung
from dbo.Personal as A left outer join dbo.Anrede as B on A.Anrede_FK = B.Anrede_PK 
where B.Anrede_PK is Null and A.Name = 'Baur'

select A.Name, A.Vorname1, B.Anrede_PK, B.Bezeichnung
from dbo.Personal as A left outer join dbo.Anrede as B on A.Anrede_FK = B.Anrede_PK 
where B.Anrede_PK is Null and (A.Name in ('Baur', 'Weigel'))

-- Zusätzlich mit Filiale

select A.Name, A.Vorname1, A.Ist_Kassierer, A.aktiv, B.Bezeichnung as Anrede, C.Bezeichnung as Filiale
from dbo.Personal as A  join dbo.Filiale as C on A.Filiale_FK = C.Filiale_PK
						left outer join dbo.Anrede as B on A.Anrede_FK = B.Anrede_PK 
where B.Anrede_PK is Null 

select A.Name, A.Vorname1, A.Ist_Kassierer, A.aktiv, B.Bezeichnung as Anrede, C.Bezeichnung as Filiale
from dbo.Personal as A  join dbo.Filiale as C on A.Filiale_FK = C.Filiale_PK
						left outer join dbo.Anrede as B on A.Anrede_FK = B.Anrede_PK 
where B.Anrede_PK is Null and A.Ist_Kassierer < 0 and A.aktiv < 0


-- Einschränken auf user, die keiner Filiale zugeordnet sind
select A.Name, A.Vorname1, A.Ist_Kassierer, A.aktiv, B.Bezeichnung as Anrede, C.Bezeichnung as Filiale
from dbo.Personal as A  left outer join dbo.Filiale as C on A.Filiale_FK = C.Filiale_PK
						left outer join dbo.Anrede as B on A.Anrede_FK = B.Anrede_PK 
where B.Anrede_PK is Null and C.Filiale_PK is null and A.Ist_Kassierer < 0 and A.aktiv < 0

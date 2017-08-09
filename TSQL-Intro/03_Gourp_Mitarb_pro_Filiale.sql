use ImperialESP
go

-- Anzahl der Mitarbeiter pro Filiale berechnen durch Gruppieren
select A.Bezeichnung, Count(*) as [Anzahl Mitarbeiter] 
from dbo.Filiale as A Join dbo.Personal as B on A.Filiale_PK = B.Filiale_FK
Group By A.Filiale_PK, A.Bezeichnung
Order By Bezeichnung

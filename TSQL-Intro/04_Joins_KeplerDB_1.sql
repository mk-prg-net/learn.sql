use KeplerDB
go

Select *
from dbo.HimmelskoerperTab

Select *
from dbo.HimmelskoerperTypenTab Join dbo.HimmelskoerperTab 
on dbo.HimmelskoerperTypenTab.ID = dbo.HimmelskoerperTab.HimmelskoerperTyp_ID

Select A.Name as TypName, B.*
from dbo.HimmelskoerperTypenTab as A Join dbo.HimmelskoerperTab as B 
on A.ID = B.HimmelskoerperTyp_ID


-- Tabellen mit Aliasnamen versehen. So wird die on- Klausel vereinfacht
Select *
from dbo.HimmelskoerperTypenTab as A Join dbo.HimmelskoerperTab as B 
on A.ID = B.HimmelskoerperTyp_ID


-- Tabellen mit Aliasnamen versehen. So wird die on- Klausel vereinfacht und 
-- auch in der Spaltenauswahl werden Mehrdeutigkeiten der Spaltennamen aufgelöst
Select A.Name as Typ, B.Name as Name, B.Masse_in_kg
from dbo.HimmelskoerperTypenTab as A Join dbo.HimmelskoerperTab as B 
on A.ID = B.HimmelskoerperTyp_ID

-- Tabellen mit Aliasnamen versehen. So wird die on- Klausel vereinfacht und 
-- auch in der Spaltenauswahl werden Mehrdeutigkeiten der Spaltennamen aufgelöst
Select A.Name as Typ, B.Name as Name, B.Masse_in_kg, C.Umlaufdauer_in_Tagen as HJahr
from dbo.HimmelskoerperTypenTab as A Join dbo.HimmelskoerperTab as B 
on A.ID = B.HimmelskoerperTyp_ID 
Join dbo.UmlaufbahnenTab as C 
on B.ID = C.TrabantID

-- Klassische Formulierung des Joins mittels Kreuzprodukt
Select A.Name as Typ, B.Name as Name, B.Masse_in_kg, C.Umlaufdauer_in_Tagen as HJahr
from dbo.HimmelskoerperTypenTab as A, dbo.HimmelskoerperTab as B, dbo.UmlaufbahnenTab as C 
where A.ID = B.HimmelskoerperTyp_ID and B.ID = C.TrabantID



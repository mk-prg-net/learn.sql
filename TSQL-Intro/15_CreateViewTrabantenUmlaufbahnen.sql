use KeplerDB
go

-- (c) Martin Korneffel, Stuttgart 2015
-- Erzeugt eine View mit denromalisierter Darstellung der Umlaufbahnen
create view TrabantenUmlaufbahnen
as
-- Abruf aller Trabanten
select  Z.ID as ZentralID, Z.Name as Zentralkoerper, Z.Masse_in_kg as Zentralmasse, 
		T.ID as TrabantID, T.Name as Trabant, T.Masse_in_kg as Trabantmasse,
		U.Umlaufdauer_in_Tagen as Umlaufdauer_Tage	
from [dbo].[UmlaufbahnenTab] as U join [dbo].[HimmelskoerperTab] as Z on U.Zentralobjekt_ID = Z.ID
                                  Join [dbo].[HimmelskoerperTab] as T on U.TrabantID = T.ID


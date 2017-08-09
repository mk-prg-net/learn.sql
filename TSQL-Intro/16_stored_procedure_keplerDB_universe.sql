use KeplerDB
go

create procedure GetUniverse
as
 Select H.Name as [Zentralkoerper],
	   T.ZentralkoerperTyp as [ZK_Typ],
	   H.Masse_in_kg as ZK_Masse_kg, 
	   T.Trabant as Trabant,
	   T.Umlaufdauer_Tage,	   
	   T.Bahnradius,
	   T.Bahngeschwindigkeit_km_pro_sec,
	   T.TrabantTyp as [Trabant_Typ],
	   T.Trabantmasse as Trabantmasse_kg
from [dbo].[HimmelskoerperTab] as H CROSS APPLY dbo.Trabanten_von(H.Name) as T
order by Zentralkoerper, Bahnradius



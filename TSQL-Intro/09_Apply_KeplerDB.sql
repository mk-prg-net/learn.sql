use KeplerDB
go

-- Beim Join einer Tabelle mit einer Tabellenwertfuktion können als Parameter der Tabellenwertfunktion nur Konstanten oder 
-- TSQL- Variablen eingesetzt werden. 
-- Folgender Join liefert nur die Trabanten der Sonne

Select H.Name as [Zentralkörper],
	   T.ZentralkoerperTyp as [Typ],
	   H.Masse_in_kg as Masse, 
	   T.Trabant as Trabant,
	   T.Umlaufdauer_Tage,
	   
	   T.TrabantTyp as [Typ Trabant]
from [dbo].[HimmelskoerperTab] as H Join dbo.Trabanten_von('Sonne') as T on H.ID = T.ZentralID
order by Masse desc, Umlaufdauer_Tage 

-- Mittels des CROSS APPLY Operators kann diese Einschränkung überwunden werden. Parameter können hier an Attribute von Datensätzen
-- gebunden werden, welcher der linke Teil von CROSS APPLY liefert.
-- Folgender CROSS APPLY liefert die Trabanten der Sonne, der Planeten usw. 

Select H.Name as [Zentralkörper],
	   T.ZentralkoerperTyp as [Typ],
	   H.Masse_in_kg / dbo.Erdmasse() as Masse, 
	   T.Trabant as Trabant,
	   T.Umlaufdauer_Tage,	   
	   T.TrabantTyp as [Typ Trabant],
	   T.Trabantmasse / dbo.Erdmasse() as Trabantmasse
from [dbo].[HimmelskoerperTab] as H CROSS APPLY dbo.Trabanten_von(H.Name) as T
order by Masse desc, Umlaufdauer_Tage 


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
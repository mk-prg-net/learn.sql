-- (c) Martin Korneffel 2015
-- Common Table Expressions
use KeplerDB
go

-- Abrufen der TrabantUmlaufbahnen- View
Select * from dbo.TrabantenUmlaufbahnen;

-- Mangel am Ergebnis: Masseangaben in unanschaulichen kg -> Umrechnen in Erdmassen
-- Lösung 1: mit Variablen

-- 1) Bestimmen der Erdmasse aus der Tabelle dbo.HimmelskoerperTab
-- Erdmasse soll in einer Variablen zwischengespeichert werden
declare @Erdmasse float

select @Erdmasse = [Masse_in_kg]
from dbo.HimmelskoerperTab
where Name = 'Erde'

-- 2) Umrechnen in Erdmassen beim Abruf der View
Select 'Variable', [Zentralkoerper], [Zentralmasse]  / @Erdmasse as [Zentralmasse in Erden],
        [Trabant],  [Trabantmasse] / @Erdmasse as [Trabantmasse in Erden]
from dbo.TrabantenUmlaufbahnen
go

-- Variable eliminiren mittels Subselect
Select 'Subselect',  [Zentralkoerper], [Zentralmasse]  / (select [Masse_in_kg] from dbo.HimmelskoerperTab where Name = 'Erde') as [Zentralmasse in Erden],
        [Trabant],  [Trabantmasse] / (select [Masse_in_kg] from dbo.HimmelskoerperTab where Name = 'Erde') as [Trabantmasse in Erden]
from dbo.TrabantenUmlaufbahnen
go

-- CTE:
-- Subselects ausklammern, um die unschöne Wiederholung im Masterselect zu vermeiden
-- Erfolgt mittels einer Common Table Expression (CTE). Dabei wird der Subselect hinter dem  
-- With- Schlüsselwort mit einem Namen versehen. Diese beannte Ergebnismenge kann 
-- schließlich im folgenden Select eingesetzt werden, wo zuvor vollständige Subselects nötig waren.

With sub_EM  as(
	select [Masse_in_kg] from dbo.HimmelskoerperTab where Name = 'Erde'
)
Select 'CTE', [Zentralkoerper], [Zentralmasse]  / (select * From sub_EM) as [Zentralmasse in Erden],
        [Trabant],  [Trabantmasse] / (Select * From sub_EM) as [Trabantmasse in Erden]
from dbo.TrabantenUmlaufbahnen
go

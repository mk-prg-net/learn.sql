use KeplerDB
go

-- Abrufen der TrabantUmlaufbahnen- View
Select * from dbo.TrabantenUmlaufbahnen;

-- Mangel am Ergebnis: Masseangaben in unanschaulichen kg -> Umrechnen in Erdmassen

-- 1) Bestimmen der Erdmasse aus der Tabelle dbo.HimmelskoerperTab

-- Erdmasse soll in einer Variablen zwischengespeichert werden
declare @Erdmasse float

select @Erdmasse = [Masse_in_kg]
from dbo.HimmelskoerperTab
where Name = 'Erde'

-- 2) Umrechnen in Erdmassen beim Abruf der View

Select  [Zentralkoerper], [Zentralmasse]  / @Erdmasse as [Zentralmasse in Erden],
        [Trabant],  [Trabantmasse] / @Erdmasse as [Trabantmasse in Erden]
from dbo.TrabantenUmlaufbahnen
go

-- Variable eleminiren mittels Subselect

Select  [Zentralkoerper], [Zentralmasse]  / (select [Masse_in_kg] from dbo.HimmelskoerperTab where Name = 'Erde') as [Zentralmasse in Erden],
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
Select  [Zentralkoerper], [Zentralmasse]  / (select * From sub_EM) as [Zentralmasse in Erden],
        [Trabant],  [Trabantmasse] / (Select * From sub_EM) as [Trabantmasse in Erden]
from dbo.TrabantenUmlaufbahnen
go


-- Anzahl der Trabanten eines Zentralkörpers mittels Gruppierung bestimmen

select [Zentralkoerper], Count([Trabant]) as [# Trabanten]
from [dbo].[TrabantenUmlaufbahnen]
group by Zentralkoerper
order by [# Trabanten]

-- Einschränken auf Zentralkörper mit mehr als 2 Trabanten

select [Zentralkoerper], Count([Trabant]) as [# Trabanten]
from [dbo].[TrabantenUmlaufbahnen]
group by Zentralkoerper
having Count([Trabant]) > 1
order by [# Trabanten]
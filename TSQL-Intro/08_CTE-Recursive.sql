use dmsmin
go


with ParentPath as (
	
	Select	 id, parent_id, [name]
	from	dbo.DirHierarchy
	where   id = 9

	union all

	select	M.id as id, M.parent_id as parent_id, M.[name] as name
	from	ParentPath as S join dbo.DirHierarchy as M	on   S.parent_id = M.id
	where M.id <> 0
)

select * from ParentPath

use KeplerDB
go
-- Rekursive Abfrage aller Trabanten und ihrer Trabanten eines Zentralkörpers

declare @zentralkoerper_name nvarchar(255)
set @zentralkoerper_name = 'Sonne'
go 

with Trabant as (

	select	T.Name as Trabant,				
			TY.Name as Typ, 
			Z.Name as [Zentralkörper],
			Z.ID as [Zentralkörper_ID]
	from [dbo].[HimmelskoerperTab] as T inner join [dbo].[HimmelskoerperTypenTab] as TY on T.[HimmelskoerperTyp_ID] = TY.ID
									    inner join [dbo].[UmlaufbahnenTab] as U on T.ID = U.TrabantID
										inner join [dbo].[HimmelskoerperTab] as Z on U.Zentralobjekt_ID = Z.ID
	where T.Name =  'Mond'--'Apollo 11'

	union all

	select	T.Name as Trabant,				
			TY.Name as Typ, 
			Z.Name as [Zentralkörper],
			Z.ID as [Zentralkörper_ID]
	from Trabant	inner join [dbo].[HimmelskoerperTab] as T on Trabant.Zentralkörper_ID = T.ID
					inner join [dbo].[HimmelskoerperTypenTab] as TY on T.[HimmelskoerperTyp_ID] = TY.ID
					inner join [dbo].[UmlaufbahnenTab] as U on T.ID = U.TrabantID
					inner join [dbo].[HimmelskoerperTab] as Z on U.Zentralobjekt_ID = Z.ID
	--where T.ID <> -1
	
)
select * from Trabant

-- Berechnet Bahnabstände. Funktioniert leider mit max. 100 Asteroiden, da dann die maximale 
-- Rekursionstiefe ausgeschöfpt ist

use KeplerDB
go

with asteroid as (

	Select Top 1 Nr, [Name], Masse_in_kg, Umlauf_in_Tage, R, Cast(0.0 as float) as Bahnabstand
	from [dbo].[NummerierteAsteroiden]
	order by R

	union all

	Select NA.Nr, NA.[Name], NA.Masse_in_kg, NA.Umlauf_in_Tage, NA.R, (NA.R - A.R) as Bahnabstand
	from  [dbo].[NummerierteAsteroiden] as NA, asteroid as A
	where A.Nr + 1 = NA.Nr and NA.NR < 101
	
)
select * from asteroid


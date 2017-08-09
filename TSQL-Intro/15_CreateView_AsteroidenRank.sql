use KeplerDB
go


create view dbo.NummerierteAsteroiden
as

	select ROW_NUMBER() OVER (ORDER BY U.Laenge_grosse_Halbachse_in_km) as Nr, 
			H.[Name] as [Name], 
			H.Masse_in_kg as Masse_in_kg, 
			U.Umlaufdauer_in_Tagen as Umlauf_in_Tage, 
			U.Laenge_grosse_Halbachse_in_km as R	            
	from dbo.HimmelskoerperTab as H inner join dbo.UmlaufbahnenTab as U on H.ID = U.TrabantID
	where H.HimmelskoerperTyp_ID = (select id from	dbo.HimmelskoerperTypenTab where [Name] = 'Asteroid')
	
go


-----

--declare @astroTypeId int
--select @astroTypeId = id
--from	dbo.HimmelskoerperTypenTab
--where	[Name] = 'Asteroid';

--with astroid as (


--	union all

--	select H.[Name] as [Name], H.Masse_in_kg as Masse_in_kg, U.Umlaufdauer_in_Tagen as Umlauf_in_Tage, U.Laenge_grosse_Halbachse_in_km as R,
--	             A.R - R as Bahnabstand
--	from dbo.HimmelskoerperTab as H inner join dbo.UmlaufbahnenTab as U on H.ID = U.TrabantID, astroid as A
--	where H.HimmelskoerperTyp_ID = (select id from	dbo.HimmelskoerperTypenTab where [Name] = 'Asteroid') 
--	      and R = (select max(UU.Laenge_grosse_Halbachse_in_km) from dbo.HimmelskoerperTab as HH inner join dbo.UmlaufbahnenTab as UU on HH.ID = UU.TrabantID where UU.Laenge_grosse_Halbachse_in_km < A.R)		   
	
--)
--select * from astroid
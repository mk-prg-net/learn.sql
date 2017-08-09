USE [KeplerDB]
GO

/****** Object:  UserDefinedFunction [dbo].[Erdmasse]    Script Date: 08.12.2014 23:19:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Martin Korneffel
-- Create date: 2.12.2014
-- Description:	Liefert die Erdmasse
-- =============================================
CREATE FUNCTION [dbo].[Erdmasse] 
(
	-- Add the parameters for the function here
	
)
RETURNS float
AS
BEGIN
	-- Declare the return variable here
	DECLARE @EM float

	-- Add the T-SQL statements to compute the return value here
	SELECT @EM = [Masse_in_kg]
	from [dbo].[HimmelskoerperTab]
	where [Name] = 'Erde'

	-- Return the result of the function
	RETURN @EM

END
GO


select masse_in_kg / dbo.Erdmasse() as Jupitermasse_in_Erdmassen
from dbo.HimmelskoerperTab
where name = 'Jupiter'

select name
from dbo.HimmelskoerperTab
where Masse_in_kg > dbo.Erdmasse()

go


create function dbo.Trabanten_von( @Zentralkoerpername as nvarchar(1000))
returns table
as return (
	-- (c) Martin Korneffel, Stuttgart 2015
	-- Erzeugt eine View mit denromalisierter Darstellung der Umlaufbahnen

	-- Abruf aller Trabanten
	select  Z.ID as ZentralID, Z.Name as Zentralkoerper, ZY.Name as ZentralkoerperTyp, ZY.ID as ZentralkoerperTypId, Z.Masse_in_kg as Zentralmasse, 
			T.ID as TrabantID, T.Name as Trabant, TY.Name as TrabantTyp, TY.ID as TrabantTypId, T.Masse_in_kg as Trabantmasse,
			U.Umlaufdauer_in_Tagen as Umlaufdauer_Tage, U.Laenge_grosse_Halbachse_in_km as Bahnradius, U.Mittlere_Umlaufgeschwindigkeit_in_km_pro_sec as Bahngeschwindigkeit_km_pro_sec	
	from [dbo].[UmlaufbahnenTab] as U join [dbo].[HimmelskoerperTab] as Z on U.Zentralobjekt_ID = Z.ID
									  Join [dbo].[HimmelskoerperTab] as T on U.TrabantID = T.ID
									  Join [dbo].[HimmelskoerperTypenTab] as ZY On Z.HimmelskoerperTyp_ID = ZY.ID
									  Join [dbo].[HimmelskoerperTypenTab] as TY On T.HimmelskoerperTyp_ID = TY.ID
	where Z.Name = @Zentralkoerpername
)
go

-- Test
select *
from dbo.Trabanten_von('Jupiter') 
--where TrabantTyp ='Planet'
go

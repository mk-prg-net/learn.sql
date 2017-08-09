-- (c) Martin Korneffel 2016
-- Berechnet die Bahnabstände von bis zu 100 Asteroiden

USE KeplerDB
GO

IF OBJECT_ID (N'dbo.AsteroidenBahnabstaende') IS NOT NULL
   DROP FUNCTION dbo.AsteroidenBahnabstaende
GO

CREATE FUNCTION dbo.AsteroidenBahnabstaende(@StartNr int)
RETURNS TABLE 
AS Return
(
-- body of the function  
	with asteroid as (

		Select Top 1 Nr, [Name], Masse_in_kg, Umlauf_in_Tage, R, Cast(0.0 as float) as Bahnabstand
		from [dbo].[NummerierteAsteroiden]
		where Nr > @StartNr
		order by R

		union all

		Select NA.Nr, NA.[Name], NA.Masse_in_kg, NA.Umlauf_in_Tage, NA.R, (NA.R - A.R) as Bahnabstand
		from  [dbo].[NummerierteAsteroiden] as NA, asteroid as A
		where A.Nr + 1 = NA.Nr and NA.NR < @StartNr + 101
	
	)
	select * from asteroid   
	)
GO


-- Test
declare @nrCeres int
select @nrCeres = Nr from [dbo].[NummerierteAsteroiden] where Name = 'Ceres'
Select * from dbo.AsteroidenBahnabstaende(@nrCeres- 50)



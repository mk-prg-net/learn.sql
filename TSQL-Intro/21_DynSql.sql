-- (c) Martin Korneffel, Stuttgart 2015
--
use KeplerBI
go

-- Spezielle Abfrage von Daten zu Planeten
Select Base.Name as Name, Base.[Type] as CBType, 
       NCBs.MassInEarthmasses as MassInEarthmasses, NCBs.EquatorialDiameterInKilometer as D_km, NCBs.GravityInMeterPerSec as Gravity_km_per_sec2	    
from [dbo].[CelestialBodyBases] as Base Join [dbo].[NCBs] as NCBs On Base.ID = NCBs.ID
										Join [dbo].[Planets] as T On NCBs.ID = T.ID

go

-- Verallgemeiner für alle natürlichen Himmelskörper mittels einer Stored Procedure und dynamischen SQL
create procedure dbo.NCBs_of_Type(@Typename as nvarchar(1000))
as
	
	exec('Select Base.Name as Name, Base.[Type] as CBType, '
		 + 'NCBs.MassInEarthmasses as MassInEarthmasses, NCBs.EquatorialDiameterInKilometer as D_km, NCBs.GravityInMeterPerSec as Gravity_km_per_sec2 '	    
		 + 'from [dbo].[CelestialBodyBases] as Base Join [dbo].[NCBs] as NCBs On Base.ID = NCBs.ID '
		 + 'Join ' + @Typename + ' as T On NCBs.ID = T.ID')

go

-- Jetzt können für verschiedene Himmelsköpertypen einfach die Daten abgerufen werden
exec dbo.NCBs_of_Type 'Planets'

exec dbo.NCBs_of_Type 'Moons'
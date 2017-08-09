-- (c) Martin Korneffel, Stuttgart 2015
-- Mittels TabA Cross Apply (TabBFunc) wird die Tabellenfunktion oder Abfrage auf der rechten Seite auf jede 
-- Datenzeile der linken Seite angewendet.
-- Ohne Cross Apply können die Ergebnisse nur mittels Cursor 
use KeplerBI
go

-- Aufg. Aus Kepler BI eine Tabelle erzeugen, die zu jedem Planeten alle Monde bestimmt
-- Planetensysteme abrufen

-- 1. Linke Abfrage lifert die ID's aller Planeten
select  P.ID as PlanetID, X.* 
from dbo.Planets as P
Cross Apply (

-- 2. Rechte Abfrage liefert zu jeder Planeten- ID aus der linken Abfrage eine Liste der zugehörigen Monde.
	select CBB.Name as Moon
	from dbo.CelesticalBodySystems as CBS Join dbo.Orbits as Orb on CBS.ID = Orb.CelesticalBodySystem_ID
	Join dbo.CelestialBodyBases as CBB On Orb.Satellite_ID = CBB.ID
	where CBS.CentralBody_ID = P.ID 
	) as X
	 
go

-- Mittels einer Common Table Expression (CTE) wird zuerst die mittels Apply definierte (PlanetenID, Monn) Tabelle
-- als innere Abfrage gespeichert
With M as (
select  P.ID as PlanetID, X.* 
from dbo.Planets as P
Cross Apply (
	select CBB.Name as Moon
	from dbo.CelesticalBodySystems as CBS Join dbo.Orbits as Orb on CBS.ID = Orb.CelesticalBodySystem_ID
	Join dbo.CelestialBodyBases as CBB On Orb.Satellite_ID = CBB.ID
	where CBS.CentralBody_ID = P.ID 
	) as X)

	-- Über die äußere Abfrage werden die Abfrageergebnisse der inneren Abfrage mit weiteren Detaildaten
	-- angereichert wie

	Select CBB.Name as [Zentralkörper], M.Moon as Mond
	from M Join CelestialBodyBases CBB ON M.PlanetID = CBB.ID 

-- Weitere Aufgabe:
-- Zu jedem Verzeichnisse alle in Ihm enthaltenen Elemente auflisten
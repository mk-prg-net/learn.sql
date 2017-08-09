use KeplerDB
go

CREATE VIEW [dbo].[NatuerlicheHimmelskoerper_v2]
AS
SELECT T.Name as [Typ],  H.Name, H.Masse_in_kg / dbo.Erdmasse() AS Masse_in_Erdmassen, 
                         dbo.Sterne_Planeten_MondeTab.Aequatordurchmesser_in_km, dbo.Sterne_Planeten_MondeTab.Polardurchmesser_in_km, 
                         dbo.Sterne_Planeten_MondeTab.Oberflaechentemperatur_in_K, dbo.UmlaufbahnenTab.Umlaufdauer_in_Tagen / 365.0 AS Jahr_in_Erdjahren, 
                         dbo.Sterne_Planeten_MondeTab.Rotationsperiode_in_Stunden AS Tag_in_h, dbo.Sterne_Planeten_MondeTab.Fallbeschleunigung_in_meter_pro_sec, 
                         dbo.Sterne_Planeten_MondeTab.Rotationsachsenneigung_in_Grad
FROM    dbo.HimmelskoerperTab as H INNER JOIN dbo.Sterne_Planeten_MondeTab ON H.ID = dbo.Sterne_Planeten_MondeTab.HimmelskoerperID
							  INNER JOIN dbo.UmlaufbahnenTab ON H.ID = dbo.UmlaufbahnenTab.TrabantID
							  INNER JOIN dbo.HimmelskoerperTypenTab as T On T.ID = H.HimmelskoerperTyp_ID

GO
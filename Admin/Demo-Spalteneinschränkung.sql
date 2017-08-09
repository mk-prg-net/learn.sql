use KeplerDB
go

-- Das Recht, auf die Spalte [Aequatordurchmesser_in_km] zuzugreifen, wird dem [Testuser_UserName] entzogen
REVOKE SELECT ON [dbo].[Sterne_Planeten_MondeTab] ([Aequatordurchmesser_in_km]) TO [Testuser_UserName] AS [dbo]
GO

-- Für den Testuser wurde der lesende Zugriff auf die Spalte Äquatordurchmesser verweigert
-- Deshalb wird folgende Abfrage scheitern
select * from dbo.Sterne_Planeten_MondeTab
go

-- Speziell für den Polardurchmesser bestehen keine Einschränkungen-> Abfrage ist erfolgreich.
select Polardurchmesser_in_km from dbo.Sterne_Planeten_MondeTab
go
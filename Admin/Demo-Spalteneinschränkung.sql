use KeplerDB
go

-- Das Recht, auf die Spalte [Aequatordurchmesser_in_km] zuzugreifen, wird dem [Testuser_UserName] entzogen
REVOKE SELECT ON [dbo].[Sterne_Planeten_MondeTab] ([Aequatordurchmesser_in_km]) TO [Testuser_UserName] AS [dbo]
GO

-- F�r den Testuser wurde der lesende Zugriff auf die Spalte �quatordurchmesser verweigert
-- Deshalb wird folgende Abfrage scheitern
select * from dbo.Sterne_Planeten_MondeTab
go

-- Speziell f�r den Polardurchmesser bestehen keine Einschr�nkungen-> Abfrage ist erfolgreich.
select Polardurchmesser_in_km from dbo.Sterne_Planeten_MondeTab
go
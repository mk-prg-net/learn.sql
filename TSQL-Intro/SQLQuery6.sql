/****** Skript für SelectTopNRows-Befehl aus SSMS ******/
SELECT TOP (1000) [ID]
      ,[Name]
      ,[Masse_in_kg]
      ,[HimmelskoerperTyp_ID]
      ,[SpektralklasseId]
  FROM [KeplerDB].[dbo].[HimmelskoerperTab]

  select count(*) from dbo.HimmelskoerperTab
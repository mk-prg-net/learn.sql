/****** Skript für SelectTopNRows-Befehl aus SSMS ******/
use KeplerDB
go

SELECT TOP 1000 
      [Name]
      ,[Masse_in_Erdmassen]
      ,[Jahr_in_Erdjahren]
  FROM [dbo].[NatuerlicheHimmelskoerper]
  where  [Jahr_in_Erdjahren]< 200
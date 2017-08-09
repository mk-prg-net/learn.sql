USE [KeplerDB]
GO

/****** Object:  StoredProcedure [dbo].[Raumschiffaufgaben]    Script Date: 08.12.2014 23:20:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Martin Korneffel
-- Create date: 2.12.2014
-- Description:	Gibt alle Aufgaben, die ein Raumschiff erfüllt, zurück
-- =============================================
CREATE PROCEDURE [dbo].[Raumschiffaufgaben] 
	-- Add the parameters for the stored procedure here
	@RaumschiffID as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ID as AufgabeID, Aufgabenbeschreibung 
	From [dbo].[AufgabenTab] as A Join [dbo].[RaumschiffAufgabenTab] as B on A.ID = B.[Aufgaben_ID]
	Where B.[Raumschiffe_HimmelskoerperID] = @RaumschiffID
END


GO



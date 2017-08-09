USE [dmsmin]
GO

drop view [data].[FileTypeSizeTop15View2]
go

/****** Object:  View [data].[FileTypeSizeTop15View]    Script Date: 08.12.2014 23:07:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* View , die den Speicherplatzbedarf der ersten bezüglich des Speichervolumens 
 größten Typen auflistet*/
CREATE VIEW [data].[FileTypeSizeTop15View2]
AS
SELECT     TOP (15) ext, SUM(SizeInBytes)/(1024*1024.0) AS SumSizeInMB
FROM         data.FileInfos
GROUP BY ext
ORDER BY SumSizeInMB DESC

GO


select * from [data].[FileTypeSizeTop15View2]
go



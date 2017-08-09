use KeplerDB_Import_Export
go

DECLARE @root nvarchar(100);
DECLARE @fullpath nvarchar(1000);

SELECT @root = FileTableRootPath();

SELECT name, @root as Wurzel, [file_stream].GetFileNamespacePath() as Pfad
    FROM [dbo].[Bildergalerie]


insert into [dbo].[Bildergalerie]([name], file_stream)
values('MyTxt' + REPLACE(Convert(nvarchar(400),getdate(), 21), ':', '_') + '.txt', Cast('HAllo Welt' as varbinary(max)))


-- Abfragen einer in der Freigabe angelegte und beschriebene Datei
select name, Cast(file_stream as varchar(4000))
from [dbo].[Bildergalerie]
where name like 'ich%'
use dmsmin
go

-- Name der größten Datei bestimmen

-- 1) Größe der größten Datei
declare @max_size bigint

select @max_size = Max(SizeInBytes)
from data.FileInfos

-- 2) Liste aller Dateien mit der Größe der größten Datei herausfiltern

select path, name, ext, SizeInBytes
from data.FileInfos
where SizeInBytes = @max_size

-- Verschmelzen mittels subselect

select path, name, ext, SizeInBytes
from data.FileInfos
where SizeInBytes = (select Max(SizeInBytes) from data.FileInfos)


-- Subselect in der From Klausel (auch abgeleitete Tabelle = derived Table genannt)
select ext, Tab1.SumSizeInKB
from (	select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB
		from data.FileInfos
		group by ext) as Tab1
order by Tab1.SumSizeInKb 

select SumPerExt.ext as Ext, SumPerExt.SumSizeInKB as SumPerExt, Fi.SizeInBytes, Fi.SizeInBytes *100.0/(SumPerExt.SumSizeInKB*1024.0) as PercentExt
from (	select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB
		from data.FileInfos
		group by ext) as SumPerExt join
		data.FileInfos as FI on SumPerExt.ext = FI.ext
order by SumPerExt.ext, SumPerExt.SumSizeInKb 


-- Subslect in der select- Klausel
select path, name, ext, SizeInBytes, ((100 * SizeInBytes) / (select Cast(Max(SizeInBytes) as float) from data.FileInfos))  as AnteilVonMaxInProzent
from data.FileInfos
order by AnteilVonMaxInProzent


-- Subslect in der select- Klausel 
select path, name, ext, SizeInBytes, Round((100* SizeInBytes) / (select Cast(Max(SizeInBytes) as float) from data.FileInfos), 1) as AnteilVonMax
from data.FileInfos
order by AnteilVonMax

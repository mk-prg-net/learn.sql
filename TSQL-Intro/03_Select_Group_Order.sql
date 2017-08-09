-- Einfache Abfragen
use dmsmin
go

-- Ausgabe aller Datan aus Tab FileInfos

select * 
from data.FileInfos
go

select name, ext, SizeInBytes 
from data.FileInfos
go

-- Spalte als berechneter Ausdruck
select [name] as Dateiname, ext, SizeInBytes/1024 
from data.FileInfos
go

-- Spalte als berechneter Ausdruck, der einen Aliasname erhält
select [name] as Dateiname, ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
go

-- Mit Zeilennummer (erfordert over(order by ...)
select ROW_NUMBER() over(order by ext) as Zeile, [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
go

-- Sinnvoller ?! Einsatz von Subselect
select * 
from (select ROW_NUMBER() over(order by ext) as Zeile, [name], ext, SizeInBytes/1024.0 as SizeInKB
      from data.FileInfos) as SRC
where SRC.Zeile between 50 and 100



-- Spaltenfunktionen

-- Wieviel Datensätze hat FileInfos
select Count(*), sum(SizeInBytes) 
from data.FileInfos
go

select Count(SizeInBytes) as Anz, sum(SizeInBytes) 
from data.FileInfos
go


-- Wieviel Speicherplatz wird durch alle gelisteten Dateien verbraucht
Select Sum(SizeInBytes)/(1024.0*1024.0) as [Summe Speicherplatz insgesammt inMB]
from data.FileInfos
go

-- Wieviel Speicherplatz durchschnittlich wird durch alle gelisteten Dateien verbraucht
Select Avg(SizeInBytes)/(1024.0*1024.0) as [Durchschnittlicher Speicherplatz in MB]
from data.FileInfos
go

Select Min(SizeInBytes)/(1024.0*1024.0) as [Kleinster Speicherplatz in MB]
from data.FileInfos
go

Select Max(SizeInBytes)/(1024.0*1024.0) as [Größter Speicherplatz in MB]
from data.FileInfos
go

-- Fensterfunktionen

-- Wieviel Speicherplatz wird durch alle gelisteten Dateien verbraucht
Select  [path], [SizeInBytes],  Sum(SizeInBytes) over (Partition by ext) /(1024.0*1024.0) as [Summe Speicherplatz pro Typ in MB],
		100.0 * [SizeInBytes]/  Sum(SizeInBytes) over (Partition by ext) as Prozent
from data.FileInfos
order by ext, Prozent
go



-- Einschränken des Resultsets mittels where Klausel

select [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
where ext = '.htm'
go

select [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
where ext like '.htm%'
go

select [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
where ext = '.htm' or ext='.html' or ext = '.xml'
go

-- Zeile 82 fast sematisch gleich der Zeile 88
select [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
where ext in ('.htm', '.html', '.xml')
go

-- Bereiche selektieren
select [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
where ext in ('.htm', '.html', '.xml') and SizeInBytes >= 1024 and SizeInBytes < 2048
order by SizeInBytes 

select [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
where ext in ('.htm', '.html', '.xml') and SizeInBytes >= 1024 and SizeInBytes < 2048
order by ext, SizeInBytes 

select [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
where ext in ('.htm', '.html', '.xml') and SizeInBytes >= 1024 and SizeInBytes <= 2048
order by ext asc, SizeInBytes desc

select [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
where ext in ('.htm', '.html', '.xml') and SizeInBytes between 1024 and 2048
order by ext desc, SizeInBytes asc

select hierarchy_id, path from data.files order by hierarchy_id

select distinct hierarchy_id, [path] from data.files order by hierarchy_id
select count(*) from data.files
select count(*) from (select distinct hierarchy_id from data.files) as T

select  distinct hierarchy_id --, [path]  
from data.files 
--where hierarchy_id between 3 and 9
order by hierarchy_id

-- Top Klausel
select Top(3) [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos

select Top(3) [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
order by SizeInBytes desc

select Top(10) PERCENT [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
order by SizeInBytes desc

select Top(10) PERCENT  [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
order by ext desc

select Top(10) PERCENT With Ties ext, [name], SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
order by ext desc

-- Ein Fester ausschneiden: Datensätze ab 100 bis 110
-- Mit Zeilennummer (erfordert over(order by ...)
Select *
-- In From findet ein Subselect statt
from (select ROW_NUMBER() over(order by ext) as Zeile, [name], ext, SizeInBytes/1024.0 as SizeInKB
	  from data.FileInfos) as T
where T.Zeile >= 100 and T.Zeile <= 110
go

-- Gruppieren
select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB
from data.FileInfos
group by ext
order by SumSizeInKb

-- 
--select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB
--from data.FileInfos
--where Sum(SizeInBytes)/1024.0 between 100 and 200
--group by ext
--having Sum(SizeInBytes)/1024.0 between 100 and 200
--order by SumSizeInKb 


select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB
from data.FileInfos
--where SumSizeInKb between 100 and 200
group by ext
having Sum(SizeInBytes)/1024.0 between 100 and 200
--having SumSizeInKB between 100 and 200
order by SumSizeInKb 


select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB
from data.FileInfos
where SizeInBytes / 1024 between 100 and 200
group by ext
having Sum(SizeInBytes)/1024.0 > 1000
order by SumSizeInKb 


-- Das ganze nochmal als subselect

select ext, Tab1.SumSizeInKB
from (	select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB
		from data.FileInfos
		group by ext) as Tab1
where Tab1.SumSizeInKB between 100 and 200
order by Tab1.SumSizeInKb 

-- Rollup liefert Details + Zwischenwerte
select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB, Avg(SizeInBytes)/1024.0 as D
from data.FileInfos
group by ext
with rollup

-- Rollup liefert Details + Zwischenwerte
select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB, Avg(SizeInBytes)/1024.0 as D
from data.FileInfos
group by ext
with cube

select Avg(SizeInBytes)/1024.0 as D
from data.FileInfos


select [photography_place], [taxonomy_of_content],  sum([widthInPix]*[heightInPix]) / 1024.0 as KPix
from dbo.FotosView
group by [taxonomy_of_content], [photography_place] with cube
order by photography_place

-- Zugriff auf die FotosView der anderen SQL Server Instanz
-- Achtung: .\MeineZweite ist der in dieser Instanz eingerichtete Verbindungsserver
-- (unter Serverobjekte im Objektexplorer)
select *
from [.\MeineZweite].dmsmin.dbo.FotosView









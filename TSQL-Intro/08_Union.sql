use dmsmin
go

select [name], ext, SizeInBytes/1024.0 as SizeInKB
from data.FileInfos
where ext in ('.htm', '.html', '.xml')

declare @anz_daten int

select count(*)
from data.FileInfos
where ext in ('.htm', '.html', '.xml')

-- Mittels Union implementieren

select count(*)
	from data.FileInfos
	where ext = '.html'

select count(*)
from
(
	select * -- 100
	from data.FileInfos
	where ext = '.htm'
	union -- 473
	select * 
	from data.FileInfos
	where ext = '.html'
	union
	select * 
	from data.FileInfos
	where ext = '.xml'
) as Tab

select a.name, a.ext, b.name, b.ext
from
(	select file_id, [name], ext, SizeInBytes/1024.0 as SizeInKB
	from data.FileInfos
	where ext in ('.htm', '.html', '.xml')) as a 
left outer join

(	select file_id, [name], ext, SizeInBytes/1024.0 as SizeInKB
	from data.FileInfos
	where ext = '.htm'
	union
	select file_id, [name], ext, SizeInBytes/1024.0 as SizeInKB
	from data.FileInfos
	where ext = '.html'
	union
	select file_id, [name], ext, SizeInBytes/1024.0 as SizeInKB
	from data.FileInfos
	where ext = '.xml'
) as b
on a.file_id = b.file_id
where b.name is null






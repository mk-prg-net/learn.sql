use dmsmin
go


select ext, Tb.file_id
from data.FileInfos as Ta left outer join data.FotoFileInfos as Tb on Ta.file_id = Tb.file_id
--where Tb.file_id is Null


select ext
from data.FileInfos as Ta left outer join data.FotoFileInfos as Tb on Ta.file_id = Tb.file_id
where Tb.file_id is Null
group by ext
order by ext

select taxonomy_of_content
from data.files
group by taxonomy_of_content

-- Vergleichen der Mächtigkeit der Mengen von Datensätzen mit taxonomy_of_content = picture/photo
-- und dem Ergebnis von outer join

declare @anz_join int

--Set @anz_join = (
--select count(*)
--from data.FileInfos as Ta left outer join data.FotoFileInfos as Tb on Ta.file_id = Tb.file_id
--where Tb.file_id is Null
--)

select @anz_join =  count(*)
from data.FileInfos as Ta left outer join data.FotoFileInfos as Tb on Ta.file_id = Tb.file_id
where Tb.file_id is Null

print Cast(@anz_join as char(10))

declare @anz_taxo int
select @anz_taxo = count(*)
from data.files
where taxonomy_of_content not in ('picture/photo', 'picture/web')

print Cast(@anz_taxo as char(10))


-- Welche Dateien, die <> 'picture/photo' sind ebenfalls in fotofileinfos erfasst

select A.file_id, A.taxonomy_of_content, b.fid
from 
(select file_id, taxonomy_of_content
 from data.files
 where taxonomy_of_content not in ('picture/photo', 'picture/web')) as A
right outer join
(select Ta.file_id as fid
 from data.FileInfos as Ta left outer join data.FotoFileInfos as Tb on Ta.file_id = Tb.file_id
 where Tb.file_id is Null) as B on A.file_id = B.fid
--where b.fid is Null



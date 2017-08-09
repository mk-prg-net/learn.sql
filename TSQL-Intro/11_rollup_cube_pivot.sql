--USE AdventureWorks;
--GO
--SELECT VendorID, [164] AS Emp1, [198] AS Emp2, [223] AS Emp3, [231] AS Emp4, [233] AS Emp5, [244] AS Emp6
--FROM 
--(SELECT PurchaseOrderID, EmployeeID, VendorID
--FROM Purchasing.PurchaseOrderHeader) p
--PIVOT
--(
--COUNT (PurchaseOrderID)
--FOR EmployeeID IN
--( [164], [198], [223], [231], [233], [244] )
--) AS pvt
--ORDER BY VendorID


use dmsmin
go

select *
from
(select  ext as e
 from data.fileinfos
 group by ext) as SubTab
go

--select ext, SizeInBytes
--from data.fileinfos
--order by ext
--compute by sum(SizeInBytes) by ext 

select ext, sum(SizeInBytes)
from data.fileinfos
group by ext
--order by ext
with rollup

select hierarchy_id, ext, sum(SizeInBytes)
from data.fileinfos  a join data.files  b on a.file_id = b.file_id
group by hierarchy_id, ext
--order by ext
with rollup

select hierarchy_id, ext, sum(SizeInBytes)
from data.fileinfos  a join data.files  b on a.file_id = b.file_id
group by hierarchy_id, ext
--order by ext
with cube


select * 
from (select hierarchy_id, ext, sum(SizeInBytes) as Summe
		from data.fileinfos  a join data.files  b on a.file_id = b.file_id
		group by hierarchy_id, ext
		--order by ext
		with cube) as Tab
where ext is null and hierarchy_id is null


select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB
	from data.FileInfos
	where ext in ('.htm', '.xml')
	group by ext

select [0], [1]
from 
	(select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB
	from data.FileInfos
	where ext in ('.htm', '.xml')
	group by ext) as Tab
pivot (
	Count(ext)
	for ext in ([0], [1])
) as pv

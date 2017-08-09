use dmsmin
go

drop table #sizepertype
go

-- Liste des Speicherplatzverbrauches pro typ in temp- Tabelle speichern
select ext, Sum(SizeInBytes)/1024.0 as SumSizeInKB
into #SizePerType
from data.FileInfos
group by ext
order by SumSizeInKb 

select * from #SizePerType

-- Wie groﬂ ist der Anteil des Speichers pro Typ in bezug auf den Gesamtverbrauch

select ext, Round(100 * SumSizeInKB / (select Sum(SizeInBytes)/1024.0 from data.FileInfos), 1) as [Anteil an Gesamt]
from #SizePerType


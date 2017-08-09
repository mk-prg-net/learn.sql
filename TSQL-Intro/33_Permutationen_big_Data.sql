-- Erzeugen einer Tabelle mit Permutationen

use KeplerDB
go

if Exists(select * from sys.tables where name = 'Domain')
	drop table dbo.Domain
go

create Table dbo.Domain (
	symbol int	
);

insert into dbo.Domain (symbol)
values (1), (2), (3), (4), (5), (6), (7); --, (8)
go

if Exists(select * from sys.tables where name = 'Tupel')
	drop table dbo.Tupel
go

select	[1].symbol as [1], 
		[2].symbol as [2], 
		[3].symbol as [3], 
		[4].symbol as [4],  
		[5].symbol as [5], 
		[6].symbol as [6],
		[7].symbol as [7]
		--[8].symbol as [8]
into dbo.Tupel
from dbo.Domain as [1] 
	cross Join dbo.Domain as [2]
	cross Join dbo.Domain as [3]
	cross Join dbo.Domain as [4]
	cross Join dbo.Domain as [5]
	cross Join dbo.Domain as [6]
	cross Join dbo.Domain as [7]
	--cross Join dbo.Domain as [8]

go

if Exists(select * from sys.tables where name = 'Permutationen')
	drop table dbo.Permutationen
go

-- Alle Permutationen herausfiltern
select	[1], 
		[2], 
		[3], 
		[4],  
		[5], 
		[6],
		[7]
		--[8]
into dbo.Permutationen
from dbo.Tupel  
where [1] <> [2] and [1] <> [3] and [1] <> [4] and [1] <> [5] and [1] <> [6] and [1] <> [7]
				 and [2] <> [3] and [2] <> [4] and [2] <> [5] and [2] <> [6] and [2] <> [7]
								and [3] <> [4] and [3] <> [5] and [3] <> [6] and [3] <> [7]
											   and [4] <> [5] and [4] <> [6] and [4] <> [7]
															  and [5] <> [6] and [5] <> [7]
																			 and [6] <> [7]
go

-- Exportieren mittels bcp
-- 1) Formatdatei anlegen
--    bcp keplerdb.dbo.Tupel format nul -T -S .<servername> -c -f Tupel.fmt
--
-- 2) Exportieren
--    bcp keplerdb.dbo.Tupel out Tupel.csv -T -S .<servername> -f Tupel.fmt

truncate table dbo.Tupel
go

bulk insert dbo.Tupel
from 'D:\trac\projekt\lernen_sql\2015-08-31-Bechtle\Tupel.csv'
with
(
	formatfile = 'D:\trac\projekt\lernen_sql\2015-08-31-Bechtle\Tupel.fmt'
)
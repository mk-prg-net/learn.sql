use master
go
drop database u4Joins
go
create database u4Joins
go
use u4Joins
go

create table TA (
        col char(1) Not Null
		--primary key (col)
)

insert into TA values('A')
insert into TA values('B')

create table TB (
        col1 char(1),
        col2 char(1),
        -- foreign key(col2) references TA(col)
)

insert into TB (col1, col2) values('1', 'A')
insert into TB values('2', 'B')
insert into TB values('3', 'C')
go

-- Natürlicher Join (math.: Kreuzprodukt) 
select TA.col, TB.col1, TB.col2
from TA, TB

-- InnerJoin
select TA.col, TB.col1
from TA, TB
where TB.Col1 < 3

-- Spezialform des Innerjoin: Equijoin
select TA.col, TB.col1
from TA, TB
where TA.col = TB.Col2

-- Alternative Syntax
select TA.col, TB.col1
from TA join TB on TA.col = TB.Col2

select TA.col, TB.col1, TA.col + '99' as C3
from TA join TB on TA.col = TB.Col2
where TA.col + '99' = 'B99'

-- Outer Joins

-- Left outer Join
select TA.col, TB.col1 as LeftCol1
from TA left outer join TB on TA.col = TB.Col2

-- Right Outer Join
select TA.col, TB.col1 as RightCol1
from TA right outer join TB on TA.col = TB.Col2

-- 
use master
go
drop database JoinsInner
go
create database JoinsInner
go
use JoinsInner
go

create table HK (
		ID int  primary key,
        Name varchar(255)
)

insert into HK values(1, 'Sonne')
insert into HK values(3, 'Mond')

create table EM (
		ID int identity,
		HK_ID int, --foreign key references HK(ID),
        Masse float
)

insert into EM (HK_ID, Masse) values(1, 332981)
insert into EM (HK_ID, Masse) values(3, 0.0123)

-- Um einen Datensatz für die Erde, zu der es keinen Masterdatensatz in HK gibt,
-- einzufügen, müssen kurzfristig Einschränkungen abgeschaltet werden
--alter table EM nocheck constraint all
insert into EM (HK_ID, Masse) values(2, 1)
--alter table EM check constraint all
go

-- Inner Join (math.: Einschränkung des Kreuzprodukts durch ein Filterkriterium => Relation) 
select 'inner Join', Name, Masse
from HK inner join EM 
on HK.ID = EM.HK_ID

-- Alternativ
select 'alternativ mit ,', Name, Masse
from HK, EM
where HK.ID = EM.HK_ID

-- Inner Joins sind Kommutativ
select 'kommutativ!', Name, Masse
from EM inner join HK 
on HK.ID = EM.HK_ID


-- Outer Joins
-- sind nicht Kommutativ !

select 'left outer', Name, Masse
from HK left outer join EM 
on HK.ID = EM.HK_ID

select 'right outer', Name, Masse
from HK right outer join EM 
on HK.ID = EM.HK_ID

-- Inkonsitente Daten mittels outer join und filtern von
-- Null- Werten finden
select 'left outer', Name, Masse
from HK left outer join EM on HK.ID = EM.HK_ID
where EM.Masse is null

select 'right outer', Name, Masse
from HK right outer join EM on HK.ID = EM.HK_ID
where HK.Name is null

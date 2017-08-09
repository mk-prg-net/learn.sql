-- 
use master
go
drop database JoinsIntro
go
create database JoinsIntro
go
use JoinsIntro
go

create table HK (
        Name varchar(255)
)

insert into HK values('Sonne')
insert into HK values('Mond')

create table EM (
        Masse float
)

insert into EM values(332981)
insert into EM values(1)
insert into EM values(0.0123)
go

-- Natürlicher Join (math.: Kreuzprodukt) 
select Name, Masse
from HK, EM

-- Alternativ
select Name, Masse
from HK CROSS JOIN EM

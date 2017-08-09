drop database uedb
go

create database uedb
go

use uedb
go

-- Regel für Emails anlegel
exec sp_unbindrule  'address.mail'
drop rule R_FORM_EMAIL
go

CREATE RULE R_FORM_EMAIL AS @email LIKE '%@%.[A-Z][A-Z]'
go

drop table address
go

create table address (
	id int primary key identity(1,1),
	mail varchar(255)
)
go


exec sp_bindrule 'R_FORM_EMAIL', 'address.mail'
go

insert into address (mail) values('info@tracs.de')
go

insert into address (mail) values('info@tracs.de')

select * from address
go

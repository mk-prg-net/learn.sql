--
use dmsmin
go

insert into data.EventLog (EventLogType_id, created, author, [log])
output  inserted.id -- <=> select id from inserted -> Ergebnis ist ein Resultset
values  (1, getdate(), 'ich', 'Eine neue Meldung')
go
create proc Info1
	@meldung as varchar(255)
as 
	insert into data.EventLog (EventLogType_id, created, author, [log])
	output  inserted.id -- <=> select id from inserted -> Ergebnis ist ein Resultset
	values  (1, getdate(), 'ich', 'Eine neue Meldung')

go	

-- 

Declare @line Table(id int)

insert into data.EventLog (EventLogType_id, created, author, [log])
output  inserted.id into @line -- <=> select id into @line from inserted -> Ergebnis ist ein Resultset
values  (1, getdate(), 'ich', 'Eine neue Meldung')

declare @id int
select @id = id from @line
print @id
go

create proc Info2
	@meldung as varchar(255),
	@id int output
as 
	Declare @line Table(id int)

	insert into data.EventLog (EventLogType_id, created, author, [log])
	output  inserted.id into @line -- <=> select id into @line from inserted -> Ergebnis ist ein Resultset
	values  (1, getdate(), 'ich', 'Eine neue Meldung')

	select @id = id from @line
	print @id
go

-- 
exec Info1 'Hallo 1'

declare @id int
exec Info2 'Hallo 2', @id output
print @id



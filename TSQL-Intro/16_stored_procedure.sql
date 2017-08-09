use dmsmin
go

drop procedure data.LogMyInfo
go

create procedure data.LogMyInfo
	@info varchar(1000),
	@anz_logs int output
as 
	insert into data.EventLog (EventLogType_id, created, author, [log])
	values (1, getdate(), 'mko', '<info>' + @info + '</info>')

	select @anz_logs = count(*)
	from data.EventLog

go


-- Test
declare @anz int

exec data.LogMyInfo 'SQL ist toll', @anz output

select @anz as [Anzahl Einträge in EventLog]
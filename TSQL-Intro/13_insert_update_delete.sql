use dmsmin
go

insert into data.EventLog (EventLogType_id, created, author, [log])
values (1, getdate(), 'mko', '<info>Hallo, ich bin mko</info>')

select * from data.EventLog


-- Ändern eines Datensatzes
update data.EventLog Set [log] = '<info>Hallo, ich bin Martin</info>' where id = 67

select * from data.EventLog


update data.EventLog Set [log] = '<info>Hallo, ich bin Roland</info>' 
where [log].value('/info[1]', 'varchar(1000)') like '%Martin%' 

select * from data.EventLog


-- löschen eines Datensatzes

-- löscht alle Datensätze
-- delete data.EventLog 


-- löscht Datensatz mit id 67
delete data.EventLog where id = 67

select * from data.EventLog

-- Schnelles leeren einer Tabelle
-- truncate table data.EventLog

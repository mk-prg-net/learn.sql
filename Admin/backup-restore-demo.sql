use master
go

exec sp_addumpdevice 'disk',
                     'test-restore-bak',
                     '.\test-restore.bak'
go


-- Testdatenbank für backup- Übungen anlegen
create database [test-restore]
go

use [test-restore]
go

create table [data] (
  uhrzeit datetime
)
go

-- Mittels eines folgender Insert- Anweisung, die periodisch 
-- aus dem SQL- Server Agent angestartet wird, werden fortlaufend 
-- Datensätze mit einem Zeitstempel in der Datenbank produziert.

use [test-restore]
go

insert into data values(getdate())
go

use master
go

-- Als erstes erfolg eine vollständige Sicherung:
backup database [test-restore] to [test-restore-bak]

-- Zu einem späteren Zeitpunkt erfolgt eine Sicherung des Transaktionsprotokolles
backup log [test-restore] to [test-restore-bak]

-- Die Datenbank wird gelöscht, und anschließend mit folgenden Anweisungen
-- bis zum Zeitpunkt X wiederhergestellt

restore database [test-restore] from [test-restore-bak] with file=1, norecovery
go

restore log [test-restore] from [test-restore-bak] with file=2, stopat='20.12.2016 14:38:30', recovery
go

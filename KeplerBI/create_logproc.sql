-- Erstellt eine Prozedur zum eintragen von Logmeldungen in der admin.Logs Tabelle
use KeplerBI
go


	create procedure admin.LogMessage
	@user nvarchar(100),
	@Message nvarchar(1000)
	as
		-- MEldungstypen: 0 = Info, 1 = Warning, 2 = Error
		insert into admin.Logs (LogTime, Message, Type, [User])
		Values
		(GETDATE(), @Message, 0, @User)
	go

	create procedure admin.LogWarning
	@user nvarchar(100),
	@Message nvarchar(1000)
	as
		-- MEldungstypen: 0 = Info, 1 = Warning, 2 = Error
		insert into admin.Logs (LogTime, Message, Type, [User])
		Values
		(GETDATE(), @Message, 1, @User)
	go

	create procedure admin.LogError
	@user nvarchar(100),
	@Message nvarchar(1000)
	as
		-- MEldungstypen: 0 = Info, 1 = Warning, 2 = Error
		insert into admin.Logs (LogTime, Message, Type, [User])
		Values
		(GETDATE(), @Message, 2, @User)
	go

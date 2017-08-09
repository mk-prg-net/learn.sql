use master 
go

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'mko',
    @recipients = 'Martin.Korneffel@t-online.de',    
    @subject = 'Testmail von SQL Server', 
	@body = 'Dies ist eine Testmail, um die erfolgreiche Database Email Konfiguration von SQL Server nachzuweisen';
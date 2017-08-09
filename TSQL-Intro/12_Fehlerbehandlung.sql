-- Fehlermeldungen
--
use dmsmin
go

-- Fehlerbehandlung klassisch

declare @quotient as int
declare @save_error as int

--select * from dbo.fantasy
--exec make_error
set @quotient = 199 / 0

-- Fehlerstatus wird nach Abruf automat. auf 0 gesetzt. Deshalb muß er hier gesichert werden
set @save_error = @@error

if @save_error <> 0
	begin
		print 'Akt @@error= ' + cast(@save_error as nvarchar(100))
		select * from master.dbo.sysmessages
		where error = @save_error and msglangid = 1031
	end

else 
	select 'Kein Fehler aufgetreten'


-- Fehler auslösen direkt
raiserror('HAllo', 11, 1)
raiserror('HAllo Eventlog', 11, 1) with log

-- Fehlerbehandlung modern mit Try ... Catch Block

begin try
  RAISERROR ('ich bin ein selbstdefinierter Fehler', 15, 2) WITH LOG
  print('nach Raiseerror')
end try
begin catch
  print( 'aus catch')
  SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage
  print ERROR_MESSAGE()
end catch

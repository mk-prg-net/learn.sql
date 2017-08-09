---- primzahlen ermitteln:  gespeicherte Procedure
---- dbo. allg. gültig
---- zum anlegen: 1x durchlaufen --> gespeicherte Proz. enterprisemanager

use KeplerDB
go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[primzahlenermitteln]'))
drop procedure [dbo].[primzahlenermitteln]
GO


-- dbo = allm. verfügbar sonst nur Benutzerprocedure!!!
create procedure [dbo].[primzahlenermitteln]

-- Eingabeparameter von bis
@pruefzahl as int,
--z.zt. nur einzelne zahl geprüft
@biswert as int,


-- Ausgabeparameter mit 'output' erforderlich!!!
-- Ergebnis: 0=ohne Berechnung, 1=Primzahl, -1=keine Primzah
@ergebnis as bit output,

-- True, wenn ein Fehler vorliegt (=1)
@fehlerstatus as bit output

-- Procedurerumpf zwischen as und go
as
	declare @zaehler as int
        declare @maxwert as decimal(20,7)

--      einzelne primzahl ab 2 bis wurzel aus pruefzahl ermitteln
	set @zaehler = 2
	set @maxwert = sqrt(@pruefzahl)

--      Ergebnis: 0=ohne Berechnung, 1=Primzahl, -1=keine Primzahl
        set @fehlerstatus = 0

-- 	Annahme: Prüfling ist eine Primzahl
	set @ergebnis = 1


-- prüfen, ob Berechnung möglich ist
   if	not (@pruefzahl < 2 or @biswert < @pruefzahl)
--!!!!!!!!!!!!!!!!!!!begin erforderlich !!!!!!!!!!!!!!!!!!!!!!!
      begin
        print cast(@pruefzahl as nvarchar(100)) + 'D1'
        print cast(@biswert as nvarchar(100)) + 'D2'

	while @zaehler <= @maxwert
	      begin			
--			Test Div.Rest
                        if  @pruefzahl % @zaehler = 0
			   begin
--	   		    ohne Rest teilbar = Keine Primzahl
			    set @ergebnis = 0
                            break
                          end
			else
			    set @zaehler = @zaehler + 1
			-- befehl nach if hier möglich oder else in begin-end


		end		
--		@ergebnis wird zu true aufgelöst				
		if @ergebnis = 1
		   print Cast(@pruefzahl as nvarchar(100)) + ' ist Primzahl'
             end
   else
	begin
--         keine Berechnung möglich
           set @fehlerstatus = 1
--	   unicodetyp!!! n...
           print 'Fehlermeldung primzahlen-ermitteln: ' + cast(@pruefzahl as nvarchar(100)) + ' Status: '
		        + cast(@fehlerstatus  as nvarchar(100))
	end
	
	print 'Primzahl ermitteln beendet'
go

-- Test
--Ausgabestatus 0=ohne Berechnung 1=Primzahl -1=keine Primzahl
declare @ergebnis as bit
declare @fehlerstatus as bit

-- Aufrufen der ALLG.. Procedure (dbo...)
--Parameter = 1. und letzte zu prüfende Zahl, ob Primzahl
exec [dbo].[primzahlenermitteln] 744447, 99999999, @ergebnis out, @fehlerstatus out
--db angeben:
--exec uedb.[dbo].[primzahlenermitteln] 5, 5, @ergebnis out

print 'Ergebnisstatus: ' + Cast(@ergebnis as nvarchar(200))



go

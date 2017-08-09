-- Einzeiliger Kommentar: nach dem doppelten Minus werden alle Eingaben bis zum Zeilenende ignoriert

/*
  Mehrzeiliger Kommentar:
  Zeile 1 ...
  Zeile 2 ...
*/

use dmsmin
go

create table _T1(
	ID int,
	___Name char(10),

	-- ung�ltiger Bezeichner: regul�re Bezeichner  m�ssen mit einem Buchstaben oder _ beginnen
	--1a int
	--� int,
	-- als Begrenzter Bezeichner m�glich
	[1�] int

)

declare @_A1 int
declare @1 int
--declare [@1 a] int


-- Anweisungen: Ausw�hlen einer Datenbank f�r alle Folgeoperationen
use master
go -- go- Anweisung schliesst einen BAtchh ab und sendet ihn an den Datenbankserver

-- Anweisungen: Meldungen an den Client zur�cksenden
print 'Hallo Welt'
go

-- Anweisungen: Variablen deklarieren
declare @A int

-- Anweisungen: Werte von Variablen setzen
set @A = 99

-- Wert von A an den Client als Meldung zur�cksenden. Da Meldungen nur Texte sein d�rfen,
-- muss das nummerische A in ein Text gewandelt werden. Das ist die Aufgabe von Cast
print Cast(@A as nchar(10))
go
-- Achtung: Variablen gelten nur innerhalb eines Batch (=Abschnitt zwischen zwei go's)

print Cast(@A as nchar(10))
go

-- exec Anweisung zum starten von gespeicherten Prozedzuren
exec KeplerDB.dbo.Raumschiffaufgaben 36
go

--Anweisungen: TSQL- Programmschnipsel ausf�hren lassen
declare @TabellenName as varchar(100)
declare @TSQL_Prog as varchar(1000)

Set @TabellenName =  '[sys].[sysdatabases]'
Set @TSQL_Prog = 'Select * From ' + @TabellenName

exec(@TSQL_Prog)

-- Nun eine andere Tabelle abfragen
Set @TabellenName =  '[sys].[syslogins]'
Set @TSQL_Prog = 'Select * From ' + @TabellenName

exec(@TSQL_Prog)


-- Achtung: exec �ffnet das Tor f�r Script Injections- Angriffe
declare @ParameterAusTextbox as varchar(1000)
Set @ParameterAusTextbox = 'KeplerDB; Delete from Sys.databases'

Set @TSQL_Prog = 'Select * From ' + @TabellenName + ' where name = ' + @ParameterAusTextbox





-- Anweisungen: eine gespeicherte Prozedur ausf�hren
exec sp_helplogins
go

exec sp_who


-- Kontrollanweisungen: Bedingte Anweisung
if Exists(select * from master.sys.databases where name = 'FileFeaturesDb')
	print 'Die Datenbank FileFeatureDb existiert'
else
	print 'Die Datenbank FileFeatureDb existiert nicht'

go


-- Kontrollanweisungen: while- Schleife
declare @InstructionCounter as bigint = 0
declare @jetzt as Time = getdate()
declare @in10Sec as Time = dateadd(second, 10, @jetzt)
while Cast(getdate() as time) < @in10Sec
begin
	 Set @InstructionCounter = @InstructionCounter + 1 
end

print 'Anzahl Schleifendurchl�ufe in 10 sec ' + Cast(@InstructionCounter as char(20))
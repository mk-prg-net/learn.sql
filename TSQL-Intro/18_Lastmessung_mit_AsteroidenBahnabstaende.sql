-- (c) Martin Korneffel 2016
-- Aufwendige Abfrage für Lastmessungen

use KeplerDB

print 'Lastmessung startet: alle Bahnabstände von zwischen Asteroiden werden berechnet'
print 'bitte warten ...'
declare @startzeit datetime
set @startzeit = current_timestamp

declare @maxNr int
select @maxNr = max(Nr) - 100 from [dbo].[NummerierteAsteroiden] 

declare @StartNr int = 0
while(@StartNr < @maxNr)
begin
	
	print Cast(@StartNr + 100 as varchar(50))

	select * from [dbo].[AsteroidenBahnabstaende](@StartNr)

	Set @StartNr = @StartNr + 100

end

declare @dauer int
set @dauer = datediff(ms, @startzeit, current_timestamp)
print 'Dauer ' + cast(@dauer as varchar(20))
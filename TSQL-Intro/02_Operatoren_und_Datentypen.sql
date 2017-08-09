use FileFeaturesDb
go

--======================================================================================================
-- Numerische Operatoren auf Gleitpunktoperationen und Typen- und Festpunktdaten
-- float als Gleitpunkttyp

declare @MasseJupiterInKg float = 1.8986E+27
declare @MasseErdeInKg float = 5.9736E+24
declare @MasseJupiterInErdmassen float 

Set @MasseJupiterInErdmassen = @MasseJupiterInKg / @MasseErdeInKg

declare @X float
declare @Y float = 1
declare @Z float

-- Numerische Operatoren
Set @X = 1 + 2
Set @Y = (@X + 1) *2

Set @X = 1
-- Polynom x^2 - 2x + 1 in TSQL
Set @Z = SQUARE(@X) - 2*@X + 1  

Set @X = 3
-- Polynom x^3 - 4x^2 + 9 in TSQL
Set @Z = POWER(@X, 3) - 4*SQUARE(@X) + 9

-- Satz von Pythagoras
Set @X = 1
Set @Y = 1
Set @Z = SQRT(SQUARE(@X) + SQUARE(@Y))

-- Trigonometrie
Set @Z = SIN(PI())

-- Umrechnen in Bogenmaß
if PI() = RADIANS(90.0)
	print 'PI ist das Bogenmaß von 90°'
else 
    print 'Rundungsfehler'

-- Runden
if ROUND(PI(), 5) = ROUND(RADIANS(90), 5, 0)
	print 'NAch Runden auf 5 Stellen: PI ist das Bogenmaß von 90°'

-- Mint ROUND können auch Nachkommastellen abgeschnitten werden, wenn 3. optionaler Parameter <> 1
Set @Z = ROUND(PI(), 5, 1)
Set @Z = ROUND(PI(), 5, 2)

-- Vergleichsoperatoren
if PI() > ROUND(PI(), 5)
	print 'Größer'

if PI() < ROUND(PI(), 5)
	print 'Kleiner'

if PI() >= ROUND(PI(), 5)
	print 'Größer oder gleich'

if PI() <= ROUND(PI(), 5)
	print 'Kleiner oder gleich'

if PI() != ROUND(PI(), 5)
	print 'ungleich'


-- Genauigkeit von Float ist einstellbar:
-- ohne Längenangabe
declare @flt as float
set @flt = 1.23456789012345678901234567890
select @flt as FloatPur

-- mit Längenangabe 53 bit
declare @fltL as float(53)
set @fltL = 1.23456789012345678901234567890
select @fltL as Float53


-- ======================================================================================================
-- Währungsangaben 8.12.2014
-- http://www.staatsverschuldung.de/schuldenuhr.htm
declare @Staatschulden_D money = 2146822797932.1234

-- http://www.haushaltssteuerung.de/schuldenuhr-staatsverschuldung-usa.html
declare @Staatsschulden_USA_in_Dollar money =  18056442914868.00
declare @Wechselkurs_Dolar_pro_Euro money =  1.2324
declare @Staatsschulden_USA_in_Euro money = @Staatsschulden_USA_in_Dollar / @Wechselkurs_Dolar_pro_Euro


-- ======================================================================================================
-- int als Festkommatyp
-- 
declare @A int = 3
declare @B int
declare @C int 

-- Integerdivision schneidet Nachkommastellen ab
Set @B = @A / 2

-- Modulo- Operation liefert den Rest
Set @C = @A % 2

-- Gleitpunktdivision liefert Nachkommastellen
Set @Z = @X / 2
print @Z

go

-- ======================================================================================================
-- Bit als Boolean
-- 
declare @ich_sehe_fern bit

if @ich_sehe_fern = 0 or @ich_sehe_fern = 1
	print 'Deutsche Realitaet der Jahre 2014, 2015, ...'



-- ===============================================================================================
-- Binaries
declare @OpCode as binary(3) = 0xA1F2D3
declare @BinWorm as varbinary(100) = 0xA1A2A3A4A5A6A7A8A9AAABACADAEAF

--=================================================================================================
-- Operationen auf Zeichenketten
declare @txt nvarchar(50)
declare @txt2 nvarchar(50)

Set @txt = N'Hallo'
Set @txt2 = N'Welt'

declare @Textmontage nvarchar(100) = @txt + ' ' + @txt2

-- Wie kann man ein Apostroph in einem Text darstellen, wenn Apostrophe Textbegrenzer sind ?
-- Antwort: mit doppeltem Apostroph ''
Set @txt = N'Nu is''s vollbracht'
print @txt

set @txt = N'A9911'
set @txt2 = N'09911'

-- Vergleich mittels Like

-- Vergleichen mit dem Muster einer PLZ
declare @resultat bit -- bit ist der boolsche Datentyp

--set @resultat = (@txt like '[0-9][0-9][0-9][0-9][0-9]')
if @txt like N'[0-9][0-9][0-9][0-9][0-9]'
	print N'txt ist plz'
else 
	print N'txt ist keine plz'

if @txt2 like N'[0-9][0-9][0-9][0-9][0-9]'
	print 'txt2 ist plz'
else 
	print 'txt2 ist keine plz'

Set @txt = '@b'

if @txt like N'[1X@][a-f]'
	print @txt + ' ok'
else 
	print @txt + ' nok'

Set @txt = '0b'

if @txt like N'[1X@][a-f]'
	print @txt + ' ok'
else 
	print @txt + ' nok'


-- Zeichenkettenfunktionen

--Zahlenlänge space12345.12
select str(12345.1234567, 12,2)

select upper('sdPsdOtz')

select '[' + ltrim('  asbgre   ') + ']'
select '[' + rtrim('  asbgre   ') + ']'

--0x202078787878787878
select convert(varbinary(20), rtrim('  xxxxxxx   '))
--0x20206162636465
select cast(rtrim('  abcde    ') as varbinary(20))

--0x616263646520202020
select cast(ltrim('  abcde    ') as varbinary(20))

--0x2020616263646520202020
select cast('  abcde    ' as varbinary(20))


--9
select len('123scf.56')

--11
select len('  123scf.56')

--11 !!!!!
select len('  123scf.56   ')


--sv
select substring ('   asvr     ', 5, 2) 

--svrBBBB
select cast(substring  ('   asvr     ', 5, 7) as varbinary(200)) 

-- Ähnlich klingende Worte haben den gleichen Soundex- Code
select soundex('Meier'), soundex('Maier'), soundex('Meyer'), soundex('Moier'), soundex('Mama'), soundex('Maus'), soundex('Haus')

go
-- ================================================================================================================
-- Typen für Datum und Uhrzeit
-- Date, Time, DateTime, DateTime2

-- Format von Datumsliteralen definieren
set dateformat dmy

declare @datHeute as Date = getdate()
declare @timeJetzt as Time = getdate()
declare @datTimeJetzt as DateTime = getdate()

declare @datTime as DateTime = 0

print 'DateTime.Std ' + Cast(@datTime as varchar(100))
Set @datTime = Cast('1/1/1753' as DateTime)
print 'DateTime.Min '  + Cast(@datTime as varchar(100))
Set @datTime = Cast('31/12/9999' as DateTime)
print 'DateTime.Max '  + Cast(@datTime as varchar(100))

-- Datumsberechnungen

-- Wieviel Tage lebe ich
declare @gbt as Datetime
set @gbt = '7/6/68'

declare @tage as int
set @tage = datediff(day, @gbt, getdate())
print 'Ich lebe seit ' + cast(@tage as varchar(10)) + ' Tagen'

set @tage = datediff(day, '1/2/2012', '1/3/2012')
print 'Tage Feb. Schaltjahr ' + cast(@tage as varchar(10)) + ' Tagen'


-- welcher Tag ist heute in einem Jahr
declare @zukunft as datetime
set @zukunft = dateadd(year, 1, getdate())

print 'Heute in einem Jahr ist der ' + Cast(Day(@zukunft) as char(2)) + '-' + Cast(Month(@zukunft) as char(2)) 
	+ '-' + Cast(Year(@zukunft) as char(4)) 
go

-- Test ohne Tab:
select cast ('31/12/2006' as datetime) 
go

--=================================================================================================================
-- Testfunktionen für Datentypen
declare @txt  varchar(100)

select isnumeric(@txt) as IstZahl, isdate(@txt) as IstDatum, isnull(@txt, '1') as IstNull

Set @txt = '123,456'
select isnumeric(@txt) as IstZahl, isdate(@txt) as IstDatum, isnull(@txt, '1') as IstNull
--Select cast(@txt as float) as [123,456]

Set @txt = '123.456'
select isnumeric(@txt) as IstZahl, isdate(@txt) as IstDatum, isnull(@txt, '1') as IstNull
Select cast(@txt as float) as [123.456]

Set @txt = GETDATE()
select isnumeric(@txt) as IstZahl, isdate(@txt) as IstDatum, isnull(@txt, '1') as IstNull

-- ===============================================================================================================
-- XML- Typen
DECLARE @logmsg xml 
Set @logmsg = '<def>   <AddNewSchema n  =  "doktyp.xsd">Hallo</AddNewSchema>   </def>'

select @logmsg
Select @logmsg.value('(/def/AddNewSchema/@n)[1]', 'nvarchar(400)')
Select @logmsg.value('(/def/AddNewSchema)[1]', 'nvarchar(400)')

-- Zugriff einschränken auf die Statusmeldungen
use dmsmin
go
select log 
from data.EventLog
where 1 = log.exist('/Status')

select log.value('(/Status/msg)[1]', 'nvarchar(255)') as Meldung
from data.EventLog
where 1 = log.exist('/Status')

select log.query('/Status/msg') as Meldung
from data.EventLog
where 1 = log.exist('/Status')


--=================================================================================================================
-- UNiqueidentifiers
select NewId() as ID
select NewId() as ID


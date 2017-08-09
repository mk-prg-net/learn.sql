use dmsmin
go

-- (c) Martin Korneffel, Stuttgart 2008
-- Rekonstruieren eines Dateipfades aus einer hierarchy_id

if exists(select * from sys.sysobjects where [name] like 'GetPath')
	drop procedure data.GetPath
go

Create Procedure data.GetPath
	@hierarchy_id as int,	-- 
	@path		  as varchar(1000) output
as

declare @parent_id int

-- Initialisierungen
Select	@path = [name],  @parent_id = parent_id
from	dbo.DirHierarchy
where   id = @hierarchy_id 

-- Bei der Deklaration eines Cursors wird dieser an eine Ergebnismenge gebunden
Declare cursor_h cursor for
	select	id, parent_id, name 
	from	dbo.DirHierarchy
	where   id <= @hierarchy_id
	order by id desc

-- Vor einem Zugriff muß eine Cursor wie eine Datei geöffnet werden
open cursor_h

-- Solange beim Zugriff über einen Cursor nichts schief läuft, liefert
-- @@fetch_status 0 zurück

declare @akt_name varchar(255)
declare @akt_id int
declare @akt_parent_id int

--fetch next from cursor_h	
while @@fetch_status = 0 and @parent_id >0
begin
	fetch cursor_h into  @akt_id,  @akt_parent_id, @akt_name
	if @akt_id = @parent_id
	begin
		Set @parent_id = @akt_parent_id
		Set @path = @akt_name + '/' + @path
	end  
end

-- Der Cursor wird geschlossen. Nach erneutem Öffen zeigt er dann wieder auf den
-- ersten Datensatz
close cursor_h

-- Soll ein Cursor nicht weiterverwendet werden, dann ist er freizugeben
deallocate cursor_h

go

-- Test 
Declare @path as varchar(1000)
exec data.GetPath 14, @path output

print @path


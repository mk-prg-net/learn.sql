--=========================================
-- Create scalar-valued function template
--=========================================

USE dmsmin
GO

IF OBJECT_ID (N'data.PathOf') IS NOT NULL
   DROP FUNCTION data.PathOf
GO

CREATE FUNCTION data.PathOf (@hierarchy_id int)
RETURNS varchar(1000)
WITH EXECUTE AS CALLER
AS
-- place the body of the function here
BEGIN
	Declare @path varchar(1000)
	Declare @parent_id int 
	
	-- Initialisierungen
	Select	@path = [name],  @parent_id = parent_id
	from	dbo.DirHierarchy
	where   id = @hierarchy_id 

	-- Bei der Deklaration eines Cursors wird dieser an eine Ergebnismenge gebunden
	Declare cursor_h cursor for
		select	id, parent_id, [name] 
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

--	fetch next from cursor_h	
	while @@fetch_status = 0 and @parent_id >0
	begin
		fetch cursor_h into  @akt_id,  @akt_parent_id, @akt_name
		if @akt_id = @parent_id
		begin
			Set @parent_id = @akt_parent_id
			Set @path = @akt_name + '>' + @path
		end  
	end

	-- Der Cursor wird geschlossen. Nach erneutem Öffen zeigt er dann wieder auf den
	-- ersten Datensatz
	close cursor_h

	-- Soll ein Cursor nicht weiterverwendet werden, dann ist er freizugeben
	deallocate cursor_h

    RETURN(@path)
END
GO

select data.PathOf(14)
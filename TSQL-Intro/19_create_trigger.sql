use dmsmin
go
-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER data.TrgMelder 
   ON  data.files
   Instead of INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    insert into data.EventLog (EventLogType_id, created, author, [log])
	values (1, getdate(), 'mko', '<info>' + 'neue files eingegeben' + '</info>')

	if exists(select * from inserted)
	begin
		declare @fname as nvarchar(300)
		select @fname = [path] from inserted
		insert into data.files ([file_id], [path]) values(NewId(), @fname)
	end


END
GO

-- Test
insert into data.files ([file_id], [path]) values(NewId(), 'c:/hallo/NeueWelt')

select * from data.EventLog

select * from data.files where path = 'c:/hallo/NeueWelt'
use dmsmin
go
------------------------------------------------------------------------------------
-- Skalarfunktion
CREATE FUNCTION data.InKB
(
	-- Add the parameters for the function here
	@valueInByte int
)
RETURNS float
AS
BEGIN
	
	-- Return the result of the function
	RETURN @valueInByte / 1024.0

END
GO

-- Test
Select ext, sum(SizeInBytes) as InBytes, data.InKB(sum(SizeInBytes)) as InKB
from data.FileInfos
group by ext
go

-------------------------------------------------------------------------------------
-- Tabellenwertfunktion
CREATE FUNCTION data.TypeSpace(@muster varchar(300))
RETURNS TABLE
AS RETURN
(
	Select ext, sum(SizeInBytes) as InBytes
	from data.FileInfos
	where ext like @muster 
	group by ext	
)
GO

-- Test
select * from data.TypeSpace('.p%')

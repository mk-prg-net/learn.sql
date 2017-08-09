use db_indextest
go

create table dbo.MitGruppierendenIndex
(
	werkNr  int,
	probeNr int
)
go
create clustered index ixGruppierend
on dbo.MitGruppierendenIndex(werkNr, probeNr)
go

declare @werkNr int
declare @ProbeNr int
Set @werkNr = 1
while @werkNr < 100
begin
   Set @ProbeNr = 1000
   while @ProbeNr >= 0
   begin
		insert into dbo.MitGruppierendenIndex (werkNr, probeNr)
		values(@werkNr, @ProbeNr)

		Set @ProbeNr = @ProbeNr - 5

   end 

   set @werkNr = @werkNr + 5

end
 


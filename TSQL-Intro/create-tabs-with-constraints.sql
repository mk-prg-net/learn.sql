use DemoVerknuepfteTabellen
go


create table  dbo.masterTab(
	ID int primary key,
)

create table dbo.detailTab(
	ID int primary key,
	master_id int,
	foreign key(master_id) references dbo.masterTab(ID)

)
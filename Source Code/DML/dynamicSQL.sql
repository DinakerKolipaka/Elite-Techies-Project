create procedure searchSubleasesProc 
	@pdoa datetime=null,
	@pbud int=null,
	@pname varchar(50)=null,
	@papttype varchar(30)=null,
	@pavail int=null,
	@pmax int=null
as
begin
	declare @sql nvarchar(MAX)
	declare @params nvarchar(MAX)
	set @params='@doa datetime=null,@bud int=null,@name varchar(50)=null,@apttype varchar(30)=null,@avail int=null,@max int=null'
	set @sql='select Subleases.DateOfAvailability,Subleases.Budget,Apartment_Details.Name,Apartment_Details.ApartmentType,Apartment_Details.NoOfRoomsAvailable,
	Apartment_Details.MaxOccupancy from Subleases join Apartment_Details on Subleases.AptID=Apartment_Details.AptID '+'where 
	(Subleases.DateOfAvailability=@doa) or
	(Subleases.Budget=@bud) or
	(Apartment_Details.Name=@name) or
	(Apartment_Details.ApartmentType=@apttype) or
	(Apartment_Details.NoOfRoomsAvailable=@avail) or
	(Apartment_Details.MaxOccupancy=@max)'

	/*
	insert into apartment_details values(3,'12Fifty5','1255 E Univ',NULL,200,20,'2B2B','1000',2,5,'Extra')
	select * from apartment_details
	insert into subleases values(3,3,'12Fifty5 Rocks!!!','2017-08-01','2017-10-01',300)
	select * from subleases
	*/
	execute sp_executesql @sql,@params,@bud=200
end

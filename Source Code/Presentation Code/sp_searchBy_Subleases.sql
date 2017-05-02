if object_id('sp_searchBy_Subleases') is not null
drop proc sp_searchBy_Subleases
go
create procedure sp_searchBy_Subleases 
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

	execute sp_executesql @sql,@params,@doa=@pdoa,@bud=@pbud,@name=@pname,@apttype=@papttype,@avail=@pavail,@max=@pmax

end

exec sp_searchBy_Subleases @pbud = 500, @pname = 'La Cresenta'

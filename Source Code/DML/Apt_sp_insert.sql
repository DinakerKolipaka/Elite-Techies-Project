--use ISADatabase;

if object_id('Apt_Details_Insert') is not null
drop proc dbo.Apt_Details_Insert;
go
create procedure Apt_Details_Insert  
@Name varchar(50),
@Address varchar(50),
@Photos varbinary(max)=null,
@Rent money,
@OtherExpenses money,
@ApartmentType varchar(30),
@Area varchar(50)=null,
@NoOfRoomsAvailable int,
@MaxOccupancy int=null,
@Amenities varchar(100)=null
as
begin
	insert into Apartment_Details(Name,
				Address,
				Photos,
				Rent,
				OtherExpenses,
				ApartmentType,
				Area,
				NoOfRoomsAvailable,
				MaxOccupancy,
				Amenities) 
	values(@Name,
				@Address,
				@Photos,
				@Rent,	
				@OtherExpenses,
				@ApartmentType,
				@Area,
				@NoOfRoomsAvailable,
				@MaxOccupancy,
				@Amenities)
end
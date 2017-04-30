--use ISADatabase;

if object_id('Apt_Details_Update') is not null
drop proc dbo.Apt_Details_Update;
go
create procedure Apt_Details_Update  
@AptID int,
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
	update Apartment_Details set
				Name = @Name,
				Address = @Address,
				Photos = @Photos,
				Rent = @Rent,
				OtherExpenses = @OtherExpenses,
				ApartmentType = @ApartmentType,
				Area = @Area,
				NoOfRoomsAvailable = @NoOfRoomsAvailable,
				MaxOccupancy = @MaxOccupancy,
				Amenities = @Amenities
	where AptID = @AptID;
end
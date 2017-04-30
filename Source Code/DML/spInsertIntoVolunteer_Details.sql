if object_id ('spInsertIntoVolunteer_Details') IS NOT NULL
drop proc spInsertIntoVolunteer_Details;
go
create proc spInsertIntoVolunteer_Details
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@ContactNo VARCHAR(20),
	@EmailID VARCHAR(50),
	@VolunteerService INT,
	@TShirtSize INT,
	@Address VARCHAR(255),
	@NoOfDays INT,
	@NoOfPeople INT

as
	begin
	insert into Volunteer_Details 
		(FirstName, LastName, ContactNo, EmailID, VolunteerService, TShirtSize, Address, NoOfDays, NoOfPeople)
	values (@FirstName, @LastName, @ContactNo, @EmailID, @VolunteerService, @TShirtSize, @Address, @NoOfDays, @NoOfPeople)
	end
use ISADatabase;

if object_id('Pickup_Students') is not null
drop procedure Pickup_Students;
go
create procedure Pickup_Students
@FirstName varchar(50),
@LastName varchar(50),
@ContactNo varchar(20),
@EmailID varchar(20),
@Gender int,
@ArrivalDate datetime,
@PortOfEntry varchar(50),
@FlightBoardingCity varchar(50),
@FlightDetails varchar(30),
@NumberOfBags int,
@EmergencyContactName varchar(50),
@EmergencyContactAddress varchar(255),
@EmergencyContactEmailID varchar(50),
@EmergencyContactNumber varchar(20),
@SuperShuttleStatus int,
@AccompanyingPeople int
as
begin
	insert into Pickup_Student_Details (FirstName,
			LastName,
			ContactNo,
			EmailID,
			Gender,
			ArrivalDate,
			PortOfEntry,
			FlightBoardingCity,
			FlightDetails,
			NumberOfBags,
			EmergencyContactName,
			EmergencyContactAddress,
			EmergencyContactEmailID,
			EmergencyContactNumber,
			SuperShuttleStatus,
			AccompanyingPeople) 
	values (@FirstName,
			@LastName,
			@ContactNo,
			@EmailID,
			@Gender,
			@ArrivalDate,
			@PortOfEntry,
			@FlightBoardingCity,
			@FlightDetails,
			@NumberOfBags,
			@EmergencyContactName,
			@EmergencyContactAddress,
			@EmergencyContactEmailID,
			@EmergencyContactNumber,
			@SuperShuttleStatus,
			@AccompanyingPeople)
end

















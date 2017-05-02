if object_id('spInsert_Pickup_Students') is not null
drop procedure spInsert_Pickup_Students;
go
create procedure spInsert_Pickup_Students
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

exec spInsert_Pickup_Students 'Hermoine','Granger','488-511-3219','hermoine.granger@hogwarts.edu',1,'2017-08-01 19:30:00','New York','London',
'AA2702 American Airlines',3,'Arthur Weasley','1265 E University Drive, Apt 1062, Tempe, 85281',
'arthur.weasley@hogwarts.edu','612-342-6543',0,0
exec spInsert_Pickup_Students 'Ronald','Weasley','488-511-3038','ronald.weasley@hogwarts.edu',0,'2017-07-24 8:10:00','Chicago','Birmingham',
'BA3403 British Airways',3,'Arthur Weasley','1270 E University Drive, Apt 1064, Tempe, 85281',
'arthur.weasley@hogwarts.edu','612-334-6456',1,1
exec spInsert_Pickup_Students 'Harry','Potter','488-511-3057','harry.potter@hogwarts.edu',0,'2017-07-28 6:30:00','Dallas','Edinburgh',
'EY6798 Etihad Airways',3,'Sirius Black','1264 E University Drive, Apt 1063, Tempe, 85281',
'sirius.black@hogwarts.edu','612-312-4378',0,0
exec spInsert_Pickup_Students 'Draco','Malfoy','488-511-3076','draco.malfoy@hogwarts.edu',0,'2017-08-04 6:30:00','Atlanta','Glasgow','AI1234 Air India',
3,'Lucius Malfoy','1261 E University Drive, Apt 1072, Tempe, 85281','lucius.malfoy@hogwarts.edu','612-415-2345',1,1
exec spInsert_Pickup_Students 'Neville','Longbottom','488-511-3095','neville.longbottom@hogwarts.edu',0,'2017-08-05 11:00:00','Los Angeles','Bristol',
'EK4565 Emirates',3,null,null,null,null,0,0

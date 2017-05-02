--Creation of Database
--drop database ISADatabase
--select * from sys.databases

if db_id('ISADatabase') is not null 
drop database ISADatabase;
go
create database ISADatabase;
go
--switching the instance from master to ISADatabase

use ISADatabase;

/*Below are the individual tables that are part of the ISADatabase. Most of the primary keys have been made identity because they 
just had to be unique. Some of the tables like Student_Volunteer_Mapping,Student_Sublease_Mapping, DateRanges and Languages
do not have an identity column as their columns are foreign keys from other tables. There are composite primary keys involved 
in tables like Student_Volunteer_Mapping,Student_Sublease_Mapping, DateRanges, Languages and Discussion Forum to keep make the rows 
differentiable and unique from one another*/

/*Creation of Pickup_Student_Details table which stores details about the incoming students*/

--SuperShuttleStatus 0 Yes; 1 No
CREATE TABLE Pickup_Student_Details
(
  StudentID INT NOT NULL IDENTITY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  ContactNo VARCHAR(20) NOT NULL,
  EmailID VARCHAR(50) NOT NULL,
  Gender INT NOT NULL,
  ArrivalDate DATETIME NOT NULL,
  PortOfEntry VARCHAR(50) NULL,
  FlightBoardingCity VARCHAR(50) NOT NULL,
  FlightDetails VARCHAR(50) NOT NULL,
  NumberOfBags INT NOT NULL,
  EmergencyContactName VARCHAR(50) NULL,
  EmergencyContactAddress VARCHAR(255) NULL,
  EmergencyContactEmailID VARCHAR(50) NULL,
  EmergencyContactNumber VARCHAR(20) NULL,
  SuperShuttleStatus INT NOT NULL,
  AccompanyingPeople INT NOT NULL,
  PRIMARY KEY (StudentID)
);

/*Creation of Volunteer_Details table which stores details of Volunteers*/

--VoulnteerService 0 Pickup; 1 TemporaryAccomodation; 2 Both
CREATE TABLE Volunteer_Details
(
  VolunteerID INT NOT NULL IDENTITY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  ContactNo VARCHAR(20) NOT NULL,
  EmailID VARCHAR(50) NOT NULL,
  VolunteerService INT NOT NULL,
  TShirtSize INT NULL,
  Address VARCHAR(255) NOT NULL,
  NoOfDays INT NULL,
  NoOfPeople INT NULL,
  PRIMARY KEY (VolunteerID)
);

/*Creation of Student_Volunteer_Mapping table which stores information about which student is mapped to which volunteer 
and the service provided by the volunteer */

--ServiceProvided 0 Pickup; 1 TemporaryAccomodation; 2 Both
CREATE TABLE Student_Volunteer_Mapping
(
  StudentID INT NOT NULL,
  VolunteerID INT NOT NULL,
  ServiceProvided INT NOT NULL,
  PRIMARY KEY (ServiceProvided, VolunteerID, StudentID),
  FOREIGN KEY (VolunteerID) REFERENCES Volunteer_Details(VolunteerID),
  FOREIGN KEY (StudentID) REFERENCES Pickup_Student_Details(StudentID)
);

/* Creation of Date_Ranges table which has information about the available dates of volunteers*/

--TypeOfService 0 Pickup; 1 TemporaryAccomodation; 2 Both
CREATE TABLE Date_Ranges
(
 VolunteerID INT NOT NULL,
 FromDate DATETIME NOT NULL,
 ToDate DATETIME NOT NULL,
 TypeOfService INT NOT NULL,
 PRIMARY KEY(VolunteerID,FromDate,ToDate,TypeOfService),
 FOREIGN KEY (VolunteerID) REFERENCES Volunteer_Details(VolunteerID)
);

/*Creation of Automated_Messages table to store the messages sent on behalf of ISA*/
CREATE TABLE Automated_Messages
(
  MessageID INT NOT NULL IDENTITY,
  MessageDescription VARCHAR(MAX) NOT NULL,
  PRIMARY KEY (MessageID)
);

/*Creation of Apartment_Details table which store information like Name,Rent,Type etc about an apartment */
CREATE TABLE Apartment_Details
(
  AptID INT NOT NULL IDENTITY,
  Name VARCHAR(50) NOT NULL,
  Address VARCHAR(255) NOT NULL,
  Photos VARBINARY(MAX) NULL,
  Rent MONEY NOT NULL,
  OtherExpenses MONEY NULL,
  ApartmentType VARCHAR(30) NOT NULL,
  Area VARCHAR(50) NULL,
  NoOfRoomsAvailable INT NOT NULL,
  MaxOccupancy INT NULL,
  Amenities VARCHAR(MAX) NULL,
  PRIMARY KEY (AptID)
);

/*Creation of SubLeases table which stores information about a Sublease like the LeaseEndDate,Budget etc */
CREATE TABLE SubLeases
(
  SubLeaseID INT NOT NULL IDENTITY,
  AptID INT NOT NULL UNIQUE,
  Description VARCHAR(MAX) NOT NULL,
  DateOfAvailability DATETIME NOT NULL,
  LeaseEndDate DATETIME NOT NULL,
  Budget MONEY NOT NULL,
  PRIMARY KEY (SubLeaseID),
  FOREIGN KEY (AptID) REFERENCES Apartment_Details(AptID)
);

/*Creation of the Groups table which has data about the Groups created by students*/
--GroupStatus 0 Open; 1 CLosed
CREATE TABLE Groups
(
  GroupID INT NOT NULL IDENTITY,
  GroupStatus INT NOT NULL,
  GroupName VARCHAR(50) NOT NULL,
  AptID INT NULL,
  PRIMARY KEY (GroupID),
  FOREIGN KEY (AptID) REFERENCES Apartment_Details(AptID)
);

/*Creation of Discussion_Forum table to store each Thread in every group*/
CREATE TABLE Discussion_Forum
(
  ThreadID INT NOT NULL IDENTITY,
  GroupID INT NOT NULL,
  ThreadName VARCHAR(50) NULL,
  FOREIGN KEY (GroupID) REFERENCES Groups(GroupID),
  PRIMARY KEY (GroupID,ThreadID)
  );

/*Creation of Message_Content table to store all the messages that are exchanged between the students*/
CREATE TABLE Message_Content	
(
  MessageID INT NOT NULL IDENTITY,
  ThreadID INT NOT NULL,
  GroupID INT NOT NULL,
  AuthorID VARCHAR(50) NOT NULL,
  Body VARCHAR(MAX) NOT NULL,
  MessageDate DATETIME NOT NULL,
  PRIMARY KEY (MessageID),
  FOREIGN KEY (GroupID,ThreadID) REFERENCES Discussion_Forum(GroupID,ThreadID)
);

/*Creation of Student_Profile table to store details of a student for the purpose of Roommate Search*/
--Gender 0 Male;1 female
--All habits and preferences 0 Yes;1 No;2 Dont care
CREATE TABLE Student_Profile
(
  StudentID INT NOT NULL IDENTITY,
  Firstname VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  ContactNo VARCHAR(20) NOT NULL,
  EmailID VARCHAR(50) NOT NULL,
  Gender INT NOT NULL,
  SmokingHabit INT NULL,
  DrinkingHabit INT NULL,
  FoodHabits INT NULL,
  LoginPassword VARCHAR(255) NOT NULL,
  Major VARCHAR(50) NOT NULL,
  Native VARCHAR(50) NOT NULL,
  GroupID INT NULL,
  SmokingPref INT NULL,
  DrinkingPref INT NULL,
  FoodPref INT NULL,
  BudgetPref INT NULL,
  NoOfRoommatesPref INT NULL,
  PRIMARY KEY (StudentID),
  FOREIGN KEY (GroupID) REFERENCES Groups(GroupID)
);

/*Creation of Student_SubLease_Mapping table which stores the link between a sublease and the student who posted it*/
CREATE TABLE Student_SubLease_Mapping
(
	StudentID INT NOT NULL,
	SubLeaseID INT NOT NULL,
    PRIMARY KEY(StudentID,SubLeaseID),
    FOREIGN KEY (StudentID) REFERENCES Student_Profile(StudentID),
    FOREIGN KEY (SubLeaseID) REFERENCES SubLeases(SubLeaseID)
    
);

/*Creation of Notifications_Req_Tracker to track the request status of the requests exchanged between students*/
--RequestStatus 0 is Pending; 1 is Approved
CREATE TABLE Notifications_Req_Tracker
(
  RequestID INT NOT NULL IDENTITY,
  FromStudent INT NOT NULL,
  ToStudent INT NULL,
  ToGroup INT NULL,
  RequestStatus INT NOT NULL,
  PRIMARY KEY (RequestID),
  FOREIGN KEY (ToGroup) REFERENCES Groups(GroupID),
  FOREIGN KEY (ToStudent) REFERENCES Student_Profile(StudentID),
  FOREIGN KEY (FromStudent) REFERENCES Student_Profile(StudentID)
);

/*Creation of Languages to store the Spoken Languages and Preferenced languages of a student*/
--Type 0 is Habit; 1 is Preference
CREATE TABLE Languages
(
	StudentID INT NOT NULL,
    Language VARCHAR(50) NOT NULL,
	Type INT NOT NULL,
    PRIMARY KEY(StudentID,Language,Type),
    FOREIGN KEY (StudentID) REFERENCES Student_Profile(StudentID)
);

/*Inserting data into PickUp_Student_Details*/

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Hermoine','Granger','488-511-3219','hermoine.granger@hogwarts.edu',1,'2017-08-01 19:30:00','New York','London',
'AA2702 American Airlines',3,'Arthur Weasley','1265 E University Drive, Apt 1062, Tempe, 85281',
'arthur.weasley@hogwarts.edu','612-342-6543',0,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Ronald','Weasley','488-511-3038','ronald.weasley@hogwarts.edu',0,'2017-07-24 8:10:00','Chicago','Birmingham',
'BA3403 British Airways',3,'Arthur Weasley','1270 E University Drive, Apt 1064, Tempe, 85281',
'arthur.weasley@hogwarts.edu','612-334-6456',1,1);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Harry','Potter','488-511-3057','harry.potter@hogwarts.edu',0,'2017-07-28 6:30:00','Dallas','Edinburgh',
'EY6798 Etihad Airways',3,'Sirius Black','1264 E University Drive, Apt 1063, Tempe, 85281',
'sirius.black@hogwarts.edu','612-312-4378',0,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Draco','Malfoy','488-511-3076','draco.malfoy@hogwarts.edu',0,'2017-08-04 6:30:00','Atlanta','Glasgow','AI1234 Air India',
3,'Lucius Malfoy','1261 E University Drive, Apt 1072, Tempe, 85281','lucius.malfoy@hogwarts.edu','612-415-2345',1,1);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Neville','Longbottom','488-511-3095','neville.longbottom@hogwarts.edu',0,'2017-08-05 11:00:00','Los Angeles','Bristol',
'EK4565 Emirates',3,null,null,null,null,0,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Seamus','Finnigan','488-511-3114','seamus.finnigan@hogwarts.edu',0,'2017-08-03 16:45:00','Seattle','Belfast','9W5436 Jet Airways',	
3,'Mary Finnigan','1267 E University Drive, Apt 1089, Tempe, 85281','mary.finnigan@hogwarts.edu','612-134-9864',1,1);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Dean','Thomas','488-511-3133','dean.thomas@hogwarts.edu',0,'2017-08-03 15:00:00','Boston','Cardiff','QR2700 Qatar Airways',	
3,'Mary Finnigan','1268 E University Drive, Apt 313, Tempe, 85281','mary.finnigan@hogwarts.edu','612-143-6576',0,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Padma','Patil','488-511-3152','padma.patil@hogwarts.edu',1,'2017-07-24 06:00:00','Pittsburgh','London','UA3322 United Airlines',	
3,null,null,null,null,1,2);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Parvati','Patil','488-511-3171','parvati.patil@hogwarts.edu',1,'2017-08-01 19:30:00','New York','London',
'AA2702 American Airlines',3,'Narendra Patil','1266 E University Drive, Apt 987, Tempe, 85281','narendra.patil@hogwarts.edu',
'612-432-4568',0,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Susanne','Bones','488-511-3190','susanne.bones@hogwarts.edu',1,'2017-07-24 8:10:00','Chicago','Birmingham','BA3403 British Airways',	
3,'Temperance Bones','1269 E University Drive, Apt 1055, Tempe, 85281','temperance.bones@hogwarts.edu','612-121-8764',1,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Hannah','Abbott','488-511-3209','hannah.abbott@hogwarts.edu',1,'2017-07-28 6:30:00','Dallas','Edinburgh','EY3434 Etihad Airways',
3,'Luke Abbott','1265 E University Drive, Apt 1070, Tempe, 85281','luke.abbott@hogwarts.edu','612-112-5463',0,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Terry','Boot','488-511-3228','terry.boot@hogwarts.edu',0,'2017-07-29 6:30:00','Atlanta','Glasgow','AI1122 Air India',	
3,'James Boot','1270 E University Drive, Apt 456, Tempe, 85281','james.boot@hogwarts.edu','612-133-8520',1,1);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Lavender','Brown','488-511-3247','lavender.brown@hogwarts.edu',1,'2017-07-30 11:00:00','Los Angeles','Bristol','EK7734 Emirates',	
3,'Mill Brown','1264 E University Drive, Apt 312, Tempe, 85281','mill.brown@hogwarts.edu','612-114-0420',0,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Millicent','Bulstrode','488-511-3266','milicent.bulstrode@hogwarts.edu',1,'2017-08-03 16:45:00','Seattle','Belfast',
'9W5436 Jet Airways',3,null,null,null,null,1,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Ernie','McMillan','488-511-3285','ernie.mcmillan@hogwarts.edu',0,'2017-08-03 15:00:00','Boston','Cardiff','QR2700 Qatar Airways',
3,'Chad McMillan','1262 E University Drive, Apt 1080, Tempe, 85281','chad.mcmillan@hogwarts.edu','612-123-6540',0,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Michael','Corner','488-511-3304','michael.corner@hogwarts.edu',0,'2017-07-24 06:00:00','Pittsburgh','London','UA3322 United Airlines',
3,'Susie Corner','1267 E University Drive, Apt 212, Tempe, 85281','susie.corner@hogwarts.edu','612-313-7689',1,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Pansy','Parkinson','488-511-3323','pansy.parkinson@hogwarts.edu',1,'2017-07-26 19:30:00','New York','London','AA2702 American Airlines',
3,'Peter Parkinson','1268 E University Drive, Apt 1073, Tempe, 85281','peter.parkinson@hogwarts.edu','612-331-5095',0,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Justin','Finch','488-511-3342','justin.finch@hogwarts.edu',0,'2017-07-24 8:10:00','Chicago','Birmingham','BA3403 British Airways',	
3,'Jade Finch','1263 E University Drive, Apt 1024, Tempe, 85281','jade.finch@hogwarts.edu','612-432-8768',1,0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Blaise','Zabini','488-511-3361','blaise.zabini@hogwarts.edu',0,'2017-07-28 6:30:00','Dallas','Edinburgh','EY6798 Etihad Airways',	
3,'Bob Zabini',	'1266 E University Drive, Apt 1032, Tempe, 85281',	'bob.zabini@hogwarts.edu',	'612-102-4095',	0,	0);

insert into Pickup_Student_Details
(FirstName,LastName,ContactNo,EmailID,Gender,ArrivalDate,PortOfEntry,FlightBoardingCity,FlightDetails,NumberOfBags,
EmergencyContactName,EmergencyContactAddress,EmergencyContactEmailID,EmergencyContactNumber,SuperShuttleStatus,AccompanyingPeople)
values
('Morag','MacDougal','488-511-3380','morag.macdougal@hogwarts.edu',0,'2017-08-04 6:30:00','Atlanta','Glasgow','AI1234 Air India',
3,'Dorothy MacDouglas','1269 E University Drive, Apt 143, Tempe, 85281','dorothy.macdouglas@hogwarts.edu','612-343-3902',1,1);

/*Inserting data into Volunteer_Details*/

insert into Volunteer_Details 
(FirstName, LastName, ContactNo, EmailID, VolunteerService, TShirtSize, Address,  NoOfDays, NoOfPeople)
values
('Minerva','McGonagall','480-235-0876', 'minerva.mcgonagall@asu.edu', 0, 0, '1265 E University Drive, Apt 1062, Tempe, 85281', 1, 1),
('Severus', 'Snape', '480-532-0777', 'severus.snape@asu.edu', 1, 1, '1270 E University Drive, Apt 1064, Tempe, 85281', 2, 2),
('Filius', 'Flitwick', '480-333-7654', 'filius.flitwick@asu.edu', 2, 1, '1264 E University Drive, Apt 1063, Tempe, 85281', 3, 1),
('Pomona', 'Sprout', '480-212-6509', 'pomona.sprout@asu.edu', 0, 0, '1261 E University Drive, Apt 1072, Tempe, 85281', 1, 2),
('Remus', 'Lupin', '480-563-7690', 'remus.lupin@asu.edu', 1,	1, '1262 E University Drive, Apt 1074, Tempe, 85281', 2, 1),
('Rubeus', 'Hagrid', '480-238-1354', 'rubeus.hagrid@asu.edu', 2, 3, '1267 E University Drive, Apt 1089, Tempe, 85281', 3, 2),
('Sybill', 'Trelawney', '480-135-4098', 'sybill.trelawney@asu.edu', 0, 0, '1268 E University Drive, Apt 313, Tempe, 85281', 1, 1),
('Gilderoy', 'Lockhart', '480-653-4390', 'gilderoy.lockhart@asu.edu', 1, 1, '1263 E University Drive, Apt 512, Tempe, 85281', 2, 2),
('Horace', 'Slughorn', '480-414-7509', 'horace.slughorn@asu.edu', 2, 3, '1266 E University Drive, Apt 987, Tempe, 85281', 3, 1),
('Alastor', 'Moody', '480-612-7498', 'alastor.moody@asu.edu', 0, 3, '1269 E University Drive, Apt 1055, Tempe, 85281', 1, 2);

/*Inserting data into Student_Volunteer_Mapping*/

insert into Student_Volunteer_Mapping(StudentID,VolunteerID,ServiceProvided) values (1,7,0);
insert into Student_Volunteer_Mapping(StudentID,VolunteerID,ServiceProvided) values (9,7,0);

/*Inserting Data into DateRanges*/

insert into Date_Ranges(VolunteerID,FromDate,ToDate,TypeOfService) values(1,'2017-07-08','2017-07-10',0);
insert into Date_Ranges(VolunteerID,FromDate,ToDate,TypeOfService) values(2,'2017-07-26','2017-07-28',1);
insert into Date_Ranges(VolunteerID,FromDate,ToDate,TypeOfService) values(3,'2017-07-29','2017-07-31',2);
insert into Date_Ranges(VolunteerID,FromDate,ToDate,TypeOfService) values(4,'2017-07-22','2017-07-24',0);
insert into Date_Ranges(VolunteerID,FromDate,ToDate,TypeOfService) values(5,'2017-07-29','2017-07-31',1);
insert into Date_Ranges(VolunteerID,FromDate,ToDate,TypeOfService) values(6,'2017-08-03','2017-08-06',2);
insert into Date_Ranges(VolunteerID,FromDate,ToDate,TypeOfService) values(7,'2017-08-01','2017-08-07',0);
insert into Date_Ranges(VolunteerID,FromDate,ToDate,TypeOfService) values(8,'2017-07-09','2017-07-11',1);
insert into Date_Ranges(VolunteerID,FromDate,ToDate,TypeOfService) values(9,'2017-07-15','2017-07-17',2);
insert into Date_Ranges(VolunteerID,FromDate,ToDate,TypeOfService) values(10,'2017-07-19','2017-07-23',0);

/*Inserting Data into Automated_Messages*/

insert into Automated_messages (MessageDescription) 
values('Hello All! Welcome to ISA');
insert into Automated_messages (MessageDescription) 
values('Hi All! Please follow the link in case you need assistance with pick up on your arrival at Arizona');
insert into Automated_messages (MessageDescription) 
values('Hi All! Welcome to the sunny Arizona State University');
insert into Automated_messages (MessageDescription) 
values('Hello Volunteers! Please follow the link and provide details regarding your availability');
insert into Automated_messages (MessageDescription) 
values('Hello Volunteers! This is just a reminder that the Fall semester is coming up soon');
insert into Automated_messages (MessageDescription) 
values('Hello ISA Volunteers!! This is a thank you for all the awesome work you have done. 
										Please follow the link for a gift voucher.');
insert into Automated_messages (MessageDescription) 
values('Hello All! Please follow the link for signing up with ISA Roommate search');
insert into Automated_messages (MessageDescription) 
values('Hello ALL! Please make sure you fill your profile section after creating your account. 
										This will improve your search accuarcy.');
insert into Automated_messages (MessageDescription) 
values('Hello All! Join ISA for some authentic Indian food by the SDFC pool on April 28th from 7:00 pm to 11:00 pm');
insert into Automated_messages (MessageDescription) 
values('Hello All! Join ISA for de-stressing with authentic South-Indian breakfast during this exam time');


/*Inserting Data into Apartment_Details*/

insert into Apartment_Details (Name,Address,Photos,Rent,OtherExpenses,ApartmentType,Area,NoOfRoomsAvailable,MaxOccupancy,Amenities) 
values('12Fifty5 On University','1255 E University Dr Apt 3070, Tempe, AZ 85281',NULL,1200,
										300,'2B2B','848',2,5,'Laundry Rooms, Swimming Pools, Game room');	
insert into Apartment_Details (Name,Address,Photos,Rent,OtherExpenses,ApartmentType,Area,NoOfRoomsAvailable,MaxOccupancy,Amenities) 
values('12Fifty5 On University','1255 E University Dr Apt 3134, Tempe, AZ 85281',NULL,1200,
										300,'2B2B','848',2,5,'Laundry Rooms, Swimming Pools, Game room');
insert into Apartment_Details (Name,Address,Photos,Rent,OtherExpenses,ApartmentType,Area,NoOfRoomsAvailable,MaxOccupancy,Amenities) 
values('University Park','1015 E University Dr Apt 1001, Tempe, AZ 85281',NULL,1000,
										500,'2B2B','960',2,4,'Laundry Rooms, Swimming Pools, Game room');
insert into Apartment_Details (Name,Address,Photos,Rent,OtherExpenses,ApartmentType,Area,NoOfRoomsAvailable,MaxOccupancy,Amenities) 
values('La Cresenta','1025 E Orange St g129 Apt 300, Tempe, AZ 85281',NULL,1300,
										300,'2B2B','848',2,4,'Laundry Rooms, Swimming Pools, Game room');
insert into Apartment_Details (Name,Address,Photos,Rent,OtherExpenses,ApartmentType,Area,NoOfRoomsAvailable,MaxOccupancy,Amenities) 
values('University Park','1015 E University Dr Apt 2004, Tempe, AZ 85281',NULL,1000,
										600,'3B2B','960',3,5,'Laundry Rooms, Swimming Pools, Game room');
insert into Apartment_Details (Name,Address,Photos,Rent,OtherExpenses,ApartmentType,Area,NoOfRoomsAvailable,MaxOccupancy,Amenities) 
values('ReNue on Orange','1137 E Orange St Apt 100, Tempe, AZ 85281',NULL,1200,
										300,'2B2B','960',2,5,'Laundry Rooms, Swimming Pools, Game room');
insert into Apartment_Details (Name,Address,Photos,Rent,OtherExpenses,ApartmentType,Area,NoOfRoomsAvailable,MaxOccupancy,Amenities) 
values('Willowbrook','905 S Dorsey Ln # 111, Tempe, AZ 85281',NULL,1100,
										400,'2B2B','960',2,4,'Laundry Rooms, Swimming Pools, Game room');
insert into Apartment_Details (Name,Address,Photos,Rent,OtherExpenses,ApartmentType,Area,NoOfRoomsAvailable,MaxOccupancy,Amenities) 
values('San Sonoma','9010 South Priest Drive Apt 2009, Tempe, Arizona 85284',NULL,1400,
										400,'3B2B','1115',3,5,'Swimming Pools, Spa, Game room');
insert into Apartment_Details (Name,Address,Photos,Rent,OtherExpenses,ApartmentType,Area,NoOfRoomsAvailable,MaxOccupancy,Amenities) 
values('Dorsey Place','1275 E. University Drive, Tempe, AZ 85281',NULL,1100,
										500,'2B2B','949',2,5,'Laundry Rooms, Swimming Pools, Game room');										
insert into Apartment_Details (Name,Address,Photos,Rent,OtherExpenses,ApartmentType,Area,NoOfRoomsAvailable,MaxOccupancy,Amenities) 
values('La Cresenta','1025 E Orange St g129 Apt 400, Tempe, AZ 85281',NULL,1300,
										300,'2B2B','848',2,4,'Laundry Rooms, Swimming Pools, Game room');

/*Inserting Data into SubLeases*/

insert into subleases(AptID,Description,DateOfAvailability,LeaseEndDate,Budget) 
values(1,'Summer Sublease at 1255 - Great place to live','2017-08-25','2018-05-10',500);
insert into subleases(AptID,Description,DateOfAvailability,LeaseEndDate,Budget)
values(2,'Fully furnished private bed/bath 5 minutes from ASU','2017-08-21','2018-08-15',500);
insert into subleases(AptID,Description,DateOfAvailability,LeaseEndDate,Budget) 
values(3,'One month of free rent no deposit 2 Bed 2 Bath at University Park','2017-08-29','2018-05-25',450);
insert into subleases(AptID,Description,DateOfAvailability,LeaseEndDate,Budget) 
values(4,'Hey guys! I am looking for someone to sublease my room in 2 bedroom apartment at La Cresenta','2017-08-05','2018-01-01',600);
insert into subleases(AptID,Description,DateOfAvailability,LeaseEndDate,Budget) 
values(5,'I am a senior looking for someone to take over my lease','2017-08-03','2018-08-30',550);

/*Inserting Data into Groups*/

insert into Groups(GroupName,GroupStatus,AptID,ThreadID) values ('Gryffindor',1,1,null);
insert into Groups(GroupName,GroupStatus,AptID,ThreadID) values ('Ravenclaw',0,2,null);	
insert into Groups(GroupName,GroupStatus,AptID,ThreadID) values ('Hufflepuff',0,3,null);


/*Inserting Data into Discussion_Forum*/
insert into Discussion_Forum (GroupID,ThreadName) 
values	(1,'RoomRules'),
		(1,'CommonThings');

/*Inserting Data into Message_Content*/
insert into Message_Content (ThreadID,GroupID,AuthorID,Body,MessageDate) 
values (1,1,2,'hello guys!','2017-06-10 10:32:14'),
(1,1,3,'Hi all!','2017-06-10 10:35:36'),
(1,1,2,'Have we decided on Apartment yet?','2017-06-10 10:36:45'),
(1,1,5,'Thinking of dorsy place','2017-06-10 10:38:45'),
(1,1,7,'please read post in the other thread common things','2017-07-10 16:30:45'),
(2,1,7,'Please list the common things to bring for our apartment','2017-07-10 17:00:40');



/*Inserting Data into Student_Profile*/

insert into Student_Profile
(
Firstname, LastName, ContactNo, EmailID, Gender, SmokingHabit, DrinkingHabit, FoodHabits, LoginPassword, 
Major, Native, GroupID, SmokingPref, DrinkingPref, FoodPref, BudgetPref, NoOfRoommatesPref
)
values
('Hermione', 'Granger', '488-511-3019', 'hermoine.granger@hogwarts.edu', 1, 0, 1, 3, 'Granger', 'CSE', 'Surrey', Null, 3, 2, 3, 300, 5),
('Ronald', 'Weasley', '488-511-3038', 'ronald.weasley@hogwarts.edu', 0, 1, 1, 2, 'Weasley', 'IT', 'West Sussex', 1, 2, 2, 3, 300, 5),
('Harry', 'Potter', '488-511-3057', 'harry.potter@hogwarts.edu', 0, 1, 1, 1, 'Potter', 'Mech', 'Yorkshire', 1, 3, 3, 3, 400, 4),
('Draco', 'Malfoy', '488-511-3076', 'draco.malfoy@hogwarts.edu', 0, Null, Null, Null, 'Draco', 'IE', 'Lancashire', Null, 3, 1, 3, 200, Null),
('Neville', 'Longbottom', '488-511-3095', 'neville.longbottom@hogwarts.edu', 0, 0, 0, 2, 'Longbottom', 'EE', 'Cleveland', 1, 1, 3, 2, 500, 2), 
('Seamus', 'Finnigan', '488-511-3114', 'seamus.finnigan@hogwarts.edu', 0,Null, Null, Null, 'Finnigan', 'SE', 'Essex' ,Null, 1, 2, 1, 350, 4),
('Dean', 'Thomas', '488-511-3133', 'dean.thomas@hogwarts.edu', 0, 0, 0, 2, 'Thomas', 'Civil', 'Norfolk', 1, 1, 1, 1, 250, 5),
('Parvati', 'Patil', '488-511-3152', 'parvati.patil@hogwarts.edu', 1, Null, Null, Null, 'Patil', 'Chem', 'Essex', Null, 3, 2, 1, 350, 4),
('Padma', 'Patil', '488-511-3171', 'padma.patil@hogwarts.edu', 1, 0, 1, 1, 'Patil', 'CSE', 'Essex', 2, 2, 1, 2, 350, 4),
('Susanne', 'Bones', '488-511-3190', 'susanne.bones@hogwarts.edu', 1, 1, 1, 1, 'Bones', 'CSE', 'Lancashire', Null, 2, 1, 1, 250, 5),  
('Hannah', 'Abbott', '488-511-3209', 'hannah.abbott@hogwarts.edu', 1, 1, 1, 3, 'Abbott', 'CSE', 'Cleveland', Null, 2, 3, 3, 250, 5),
('Terry', 'Boot', '488-511-3228', 'terry.boot@hogwarts.edu', 0, Null, Null, Null, 'Boot', 'IT', 'Lancashire', Null, 3, 4, 1, 450, 3),  
('Lavender', 'Brown', '488-511-3247', 'lavender.brown@hogwarts.edu', 1, 1, 1, 1, 'Brown', 'Mech', 'West Sussex', Null, 3, 2, 1, 650, 2), 
('Millicent', 'Bulstrode', '488-511-3266', 'milicent.bulstrode@hogwarts.edu', 1, 0, 0, 2, 'Bulstrode', 'EE', 'Surrey', Null, 3, 2, 2, 300, 4),  
('Ernie', 'McMillan', '488-511-3285', 'ernie.mcmillan@hogwarts.edu', 0, 0, 1, 1, 'McMillan', 'EE', 'West Sussex', Null,  1, 2, 2, 400, 3),  
('Michael', 'Corner', '488-511-3304', 'michael.corner@hogwarts.edu', 0, Null, Null, Null, 'Corner', 'EE', 'Cleveland', Null, 2, 1, 3, 300, 4),  
('Pansy', 'Parkinson', '488-511-3323', 'pansy.parkinson@hogwarts.edu', 1, 0, 1, 2, 'Parkinson', 'CE', 'Essex', Null, 3, 1, 1, 350, 4),  
('Justin', 'Finch', '488-511-3342', 'justin.finch@hogwarts.edu', 0, 1, 1, 3, 'Finch', 'CE', 'Lancashire', 3, 1, 3, 2, 300, 4), 
('Blaise', 'Zabini', '488-511-3361', 'blaise.zabini@hogwarts.edu', 0, 1, 0, 3, 'Zabini', 'Civil', 'Surrey', Null, 1, 2, 2, 400, 4 ), 
('Morag', 'MacDougal', '488-511-3380', 'morag.macdougal@hogwarts.edu', 0, 1, 0, 1, 'MacDougal', 'CSE', 'Cleveland', Null, 1, 1, 1, 500, 2);

/* Inserting Data into Student_Sublease_Mapping*/
insert into Student_SubLease_Mapping(StudentID, SubLeaseID)
values
(4, 1),
(6, 2),
(8, 3),
(12, 4),
(16, 5);

/*Inserting Data into Notification_Request_Tracker*/
insert into Notifications_Req_Tracker(FromStudent,ToStudent,ToGroup,RequestStatus) 
values	(10,null,2,0),
		(11,null,2,0),
		(17,14,null,0),
		(15,null,3,0),
		(10,1,null,0);


/* Inserting Data into Languages*/

insert into Languages
(StudentID, Language, Type)
values
(1, 'English', 1),
(1, 'French', 1),
(1, 'German', 1),
(1, 'Mandarin', 1),
(1, 'English', 2),
(1, 'French', 2),
(2, 'English', 1),
(2, 'Spanish', 1),
(2, 'English', 2),
(2, 'Spanish', 2),
(3, 'English', 1),
(3, 'English', 2),
(4, 'English', 2),
(5, 'English', 1),
(5, 'English', 2),
(6, 'Spanish', 2),
(7, 'English', 1), 
(7, 'Urdu', 1),
(7, 'Hindi', 1),
(7, 'Urdu', 2),
(7, 'Hindi', 2),
(8, 'Mandarin', 2),
(9, 'Japanese', 1),
(9, 'English', 1),
(9, 'Japanese', 2),
(9, 'English', 2),
(10, 'English', 1),
(10, 'Hindi', 1),
(10, 'Telugu', 1),
(10, 'Teugu', 2),
(11, 'English', 1),
(11, 'Tamil', 1),
(11, 'English', 2),
(11, 'Tamil', 2),
(12, 'English', 2),
(13, 'English', 1),
(13, 'English', 2),
(14, 'English', 1),
(14, 'English', 2),
(15, 'English', 1),
(15, 'German', 1),
(15, 'German', 2),
(16, 'English', 2),
(17, 'English', 1),
(17, 'French', 1),
(17, 'French', 2),
(17, 'English', 2),
(18, 'Hindi', 1),
(18, 'Kannada', 1),
(18, 'English', 1),
(18, 'Telugu', 2),
(18, 'Kannada', 2),
(19, 'English', 1), 
(19, 'English', 2), 
(20, 'English', 1), 
(20, 'English', 2);

/**/

/*Stored Procedure for Insert into Pickup_Student_Details*/

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

/*Stored Procedure for Insert into Volunteer_Details*/
if object_id ('spInsert_Volunteer_Details') IS NOT NULL
drop proc spInsert_Volunteer_Details;
go
create proc spInsert_Volunteer_Details
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@ContactNo VARCHAR(20),
	@EmailID VARCHAR(50),
	@VolunteerService INT,
	@TShirtSize INT,
	@Address VARCHAR(255),
	@NoOfDays INT,
	@NoOfPeople INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@TypeOfService INT
as
	begin
		if(@EmailID not in (select EmailID from Volunteer_Details))
		begin
			insert into Volunteer_Details 
				(FirstName, LastName, ContactNo, EmailID, VolunteerService, TShirtSize, Address, NoOfDays, NoOfPeople)
			values (@FirstName, @LastName, @ContactNo, @EmailID, @VolunteerService, @TShirtSize, @Address, @NoOfDays, @NoOfPeople);
		end
		declare @volunteerid int = (select VolunteerID from Volunteer_Details where EmailID = @EmailID)
		insert into Date_Ranges(VolunteerID, FromDate, ToDate, TypeOfService)
		values(@volunteerid, @FromDate, @ToDate, @TypeOfService)
	end

/*Stored Procedure for Insert into Apartment_Details*/

if object_id('spInsert_Apt_Details') is not null
drop proc dbo.spInsert_Apt_Details;
go
create procedure spInsert_Apt_Details  
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

/*Stored procedure for Inserting data into Subleases*/

if object_id('spInsert_Subleases') is not null
drop proc spInsert_Subleases
go
create proc spInsert_Subleases
	@AptID INT,
	@Description VARCHAR(200),
	@DateOfAvailability DATETIME,
	@LeaseEndDate DATETIME,
	@Budget INT,
	@StudentID INT
as
begin
	if(@AptID not in (select AptID from SubLeases))
	begin
		insert into Subleases (AptID,Description,DateOfAvailability,LeaseEndDate,Budget) 
		values (@AptID,@Description,@DateOfAvailability,@LeaseEndDate,@Budget);
	end
	
	declare @SubleaseID INT = (select SubleaseID from SubLeases where AptID = @AptID)
	insert into Student_SubLease_Mapping values(@StudentID,@SubleaseID);
end


/*Stored Procedure for Insert into Student_Volunteer_Mapping*/
if object_id ('spInsert_StudentVolunteerMapping') is not null
drop proc spInsert_StudentVolunteerMapping;
go
create proc spInsert_StudentVolunteerMapping
		@StudentID INT, 
		@VolunteerID INT, 
		@ServiceProvided INT 
as
	begin
		insert into Student_Volunteer_Mapping 
			(StudentID, VolunteerID, ServiceProvided)
		values (@StudentID, @VolunteerID, @ServiceProvided);
	end

/*Stored Procedure for Inserting data into Groups*/

if object_id ('spInsert_Groups') IS NOT NULL
drop proc spInsert_Groups;
go
create proc spInsert_Groups
	@GroupStatus INT,
	@GroupNameName VARCHAR(50),
	@AptID INT,
	@ThreadID INT
as
	begin
		insert into Groups 
			(GroupStatus, GroupName, AptID, ThreadID)
		values (@GroupStatus, @GroupNameName, @AptID, @ThreadID)
	end

/*Stored Procedure for Insert into Message_Content*/

if object_id('spInsert_Message_Cont') is not null
drop procedure spInsert_Message_Cont;
go
create procedure spInsert_Message_Cont
@ThreadID int,
@AuthorID varchar(50),
@Body varchar(200)
as
	begin
		declare @GroupID int
		set @GroupID = (select GroupID from Student_Profile where StudentID = @AuthorID)
		insert into Message_Content(ThreadID,GroupID,AuthorID,Body,MessageDate)
		values(@ThreadID,@GroupID,@AuthorID,@Body,GETDATE())
	end


/* Stored Procedure for Insert into Student_Profile*/
if object_id('spInsert_studentProfile') is not null
drop proc spInsert_studentProfile
go
CREATE PROC spInsert_studentProfile
  @Firstname VARCHAR(50),
  @LastName VARCHAR(50),
  @ContactNo VARCHAR(20),
  @EmailID VARCHAR(50),
  @Gender INT,
  @SmokingHabit INT,
  @DrinkingHabit INT,
  @FoodHabits INT,
  @LoginPassword VARCHAR(20),
  @Major VARCHAR(20),
  @Native VARCHAR(30),
  @GroupID INT,
  @SmokingPref INT,
  @DrinkingPref INT,
  @FoodPref INT,
  @BudgetPref MONEY,
  @NoOfRoommatesPref INT,
  @lang varchar(50),
  @type int
AS
begin
	if(@EmailID not in (select EmailID from Student_Profile))
	begin
		insert into Student_Profile(Firstname,LastName,ContactNo,EmailID,Gender,
					SmokingHabit,DrinkingHabit,FoodHabits,LoginPassword,Major,
					Native,GroupID,SmokingPref,DrinkingPref,FoodPref,BudgetPref,NoOfRoommatesPref) 
		values (@Firstname,@LastName,@ContactNo,@EmailID,@Gender,
					@SmokingHabit,@DrinkingHabit,@FoodHabits,@LoginPassword,@Major,
					@Native,@GroupID,@SmokingPref,@DrinkingPref,@FoodPref,@BudgetPref,@NoOfRoommatesPref);
	end
		declare @StudentID INT = (select StudentID from Student_Profile where EmailID = @EmailID)
		insert into languages values(@StudentID,@lang,@type);
	
end

/* Stored Procedure for inserting into Notification_request_tracker*/

if object_id('spInsert_Notification_Tracker') is not null
drop procedure spInsert_Notification_Tracker;
go
create procedure spInsert_Notification_Tracker
@FromStudent int,
@ToStudent int,
@ToGroup int,
@RequestStatus int
as
	begin
		insert into Notifications_Req_Tracker(FromStudent,ToStudent,ToGroup,RequestStatus)
		values(@FromStudent,@ToStudent,@ToGroup,@RequestStatus)
	end

/* Update stored procedure for Apartment_details*/

if object_id('spUpdate_Apt_Details') is not null
drop proc dbo.spUpdate_Apt_Details;
go
create procedure spUpdate_Apt_Details  
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

/* Update stored procedure for Student Profile */

if object_id('spUpdate_Student_Profile') is not null
drop procedure spUpdate_Student_Profile;
go
create proc spUpdate_Student_Profile
	@Studentid int,
	@Firstname VARCHAR(50), 
	@LastName VARCHAR(50), 
	@ContactNo VARCHAR(20), 
	@EmailID VARCHAR(50), 
	@Gender INT, 
	@SmokingHabit INT, 
	@DrinkingHabit INT, 
	@FoodHabits INT, 
	@LoginPassword VARCHAR(20), 
	@Major VARCHAR(20), 
	@Native VARCHAR(30), 
	@GroupID INT, 
	@SmokingPref INT, 
	@DrinkingPref INT, 
	@FoodPref INT, 
	@BudgetPref INT, 
	@NoOfRoommatesPref INT 

as
	begin
	update Student_Profile
	set  
		Firstname = @Firstname, 
		LastName = @LastName, 
		ContactNo = @ContactNo, 
		EmailID = @EmailID, 
		Gender = @Gender, 
		SmokingHabit = @SmokingHabit, 
		DrinkingHabit = @DrinkingHabit, 
		FoodHabits = @FoodHabits, 
		LoginPassword = @LoginPassword, 
		Major = @Major, 
		Native = @Native, 
		GroupID = @GroupID, 
		SmokingPref = @SmokingPref, 
		DrinkingPref = @DrinkingPref, 
		FoodPref = @FoodPref, 
		BudgetPref = @BudgetPref, 
		NoOfRoommatesPref = @NoOfRoommatesPref
		where StudentID = @StudentID
	end

/* Update Stored Procedure for Notification_Req_Tracker*/

if object_id ('spUpdate_Notification_Req_Tracker') is not null
drop proc spUpdate_Notification_Req_Tracker;
go
create proc spUpdate_Notification_Req_Tracker
  @RequestID INT ,  
  @RequestStatus INT 
as
	begin
	update Notifications_Req_Tracker
	set RequestStatus = 1
	where RequestID = @RequestID
	end

/*Trigger to update groupid column of student_profiles table when the RequestStatus changes from pending to accepted*/

if object_id ('tr_Group_Req_Accepted') is not null
drop trigger tr_Group_Req_Accepted;
go
create trigger tr_Group_Req_Accepted
on notifications_req_tracker
for update
as
	begin
	if (select RequestStatus from inserted) like 1
		Begin
			declare @FromStudentID int
			declare @Groupid int
			select @FromStudentID = FromStudent from inserted
			select @Groupid = ToGroup from inserted
		
			Update Student_Profile
			set GroupID = @Groupid where StudentID = @FromStudentID
		end
	end

/*Stored Procedure for search by people. Used Dynamic SQL for reading search parameters and executing search query for the results*/

if object_id('sp_search_By_People') is not null
drop proc sp_search_By_People
go
create procedure sp_search_By_People 
	@pfname varchar(50)=null,
	@plname varchar(50)=null,
	@pmajor varchar(50)=null,
	@pgender int=null,
	@pnative varchar(50)=null,
	@pbudgetpref MONEY=null,
	@psmokingpref INT=null,
	@pdrinkingpref INT=null,
	@pfoodpref INT=null,
	@pnumroommatespref INT=null	
as
begin
	declare @sql nvarchar(MAX)
	declare @params nvarchar(MAX)
	set @params='@fname varchar(50)=null,
				 @lname varchar(50)=null,
				 @major varchar(50)=null,
	             @gender int=null,
	             @native varchar(50)=null,
	             @budgetpref MONEY=null,
	             @smokingpref INT=null,
	             @drinkingpref INT=null,
	             @foodpref INT=null,
	             @numroommatespref int=null	'
	set @sql='select FirstName, LastName, Major, Gender, Native, SmokingHabit, 
	DrinkingHabit, FoodHabits, NoOfRoommatesPref from Student_Profile '+
	'where 
	(FirstName=@fname) or
	(LastName=@lname) or
	(Major=@major) or
	(Gender=@gender) or
	(Native=@native) or
	(Budget=@budgetpref) or
	(SmokingHabit=@smokingpref) or
	(DrinkingHabit=@drinkingpref) or
	(FoodHabits=@foodpref) or
	(NoOfRoommatesPref=@numroommatespref) 
	'

	execute sp_executesql @sql,@params,@fname=@pfname,@lname=@plname,@major=@pmajor,@gender=@pgender,
	@native=@pnative,@budgetpref=@pbudgetpref,@smokingpref=@psmokingpref,@drinkingpref=@pdrinkingpref,
	@foodpref=@pfoodpref,@numroommatespref=@pnumroommatespref	


end

/*Stored Procedure for search by groups.
Used Dynamic SQL for implementing the search by groups.
Used CTE to get a temporary list of students who are in a group
Used Curosr to print the list of students who are in a particular group
*/
if object_id ('sp_search_By_Groups') is not null
drop proc sp_search_By_Groups;
go
create proc sp_search_By_Groups @groupid int
as 
begin
	declare @sqlcommand nvarchar(max)
	declare @columnlist nvarchar(200)
	set @columnlist = 'GroupName, count(groups.GroupID) as NoOfOccupancies, apartment_details.Name as AptName'
	set @sqlcommand = 'select ' + @columnlist + ' from Groups
						join Student_Profile
						on groups.GroupID = Student_Profile.GroupID
						join Apartment_Details
						on Groups.AptID = Apartment_Details.AptID
						where Groups.GroupID = ' + convert (varchar, @groupid) + 
						' group by GroupName, apartment_details.Name'

	exec sp_executesql  @sqlcommand 

	declare PrintListOfStudents cursor static for
	with ListOfStudents 
	as
	(
		select CONCAT(Firstname, ' ', LastName) as StName 
		from Student_Profile 
		where GroupID = @groupid
	)
	select * from ListOfStudents

	declare @ListStudents nvarchar(50)

	open PrintListOfStudents;
	fetch next from PrintListOfStudents into @ListStudents
	while @@FETCH_STATUS = 0
	begin
		print @ListStudents
		fetch next from PrintListOfStudents into @ListStudents
	end
	close PrintListOfStudents;
	deallocate PrintListOfStudents ;	
end

/*Stored Procedure for Search By Subleases
Used Dynamic sql for implementing search by sublease*/
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

/*stored procedure for deleting a pending request when request is not approved*/
if object_id ('spDelete_Req_Notification_Req_Tracker') is not null
drop proc spDelete_Req_Notification_Req_Tracker;
go
create proc spDelete_Req_Notification_Req_Tracker
  @RequestID INT ,  
  @RequestStatus INT 

as
	begin
		delete from Notifications_Req_Tracker
		where RequestID = @RequestID
	end

/*View for the search panel for search by subleases
panels:- AptName,DateofAvailability,Rent,NoOfRoomsavailability*/
go
create view search_by_sublease
as
select ad.Name,sl.DateOfAvailability,ad.NoOfRoomsAvailable,ad.Rent 
from SubLeases sl join Apartment_Details ad on ad.AptID = sl.AptID;
go

/*View for displaying all the details related to subleases*/

create view sublease_details
as
select stupro.Firstname + ' ' + stupro.LastName as FullName,stupro.EmailID,ad.Name,ad.Address,sl.Budget,sl.DateOfAvailability,
sl.Description, sl.LeaseEndDate,ad.Photos,ad.Amenities,ad.ApartmentType,ad.Area,ad.MaxOccupancy,ad.NoOfRoomsAvailable,ad.OtherExpenses
from Student_Profile as stupro join Student_SubLease_Mapping ssm on stupro.StudentID = ssm.StudentID 
join SubLeases sl on ssm.SubLeaseID = sl.SubLeaseID join Apartment_Details ad on ad.AptID = sl.AptID;
go

/*Function to return the available volunteers for a student based on their date of arrival*/
if object_id('fnDateRanges') is not null
drop function fnDateRanges;
go
create function fnDateRanges(@sid int)
returns @temptable table
	(
		volunteerid int,
		firstname varchar(50),
		lastname varchar(50),
		fromdate datetime,
		todate datetime
	)
as
begin
	declare @arrdate datetime

	set @arrdate=(select arrivaldate from pickup_student_details where studentid=@sid);
	declare @volunteerid int,@fromdate datetime,@todate datetime
	declare dateCursor cursor for select volunteerid,fromdate,todate from date_ranges;
	open dateCursor
	fetch next from dateCursor into @volunteerid,@fromdate,@todate;
	while(@@fetch_status=0)
	begin
		if ((@arrdate>=@fromdate) and (@arrdate<=@todate))
			begin
				insert @temptable
				select v.VolunteerID,FirstName,LastName,FromDate,ToDate 
				from Volunteer_Details v join Date_Ranges d on v.VolunteerID = d.VolunteerID
				where d.VolunteerID = @volunteerid; 
			end
		fetch next from dateCursor into @volunteerid,@fromdate,@todate;
	end
	close dateCursor;
	deallocate dateCursor;
return
end

/*DCL*/
go
create login Dinaker with password='dinaker' must_change,check_expiration=on,
	check_policy=on,default_database=ISADatabase;

create user Dinaker for login Dinaker;

create role PickupRole;

grant select,alter,insert,update,delete on Pickup_Student_details to PickupRole;
grant select,alter,insert,update,delete on Student_Volunteer_Mapping to PickupRole;
grant select,alter,insert,update,delete on Volunteer_Details to PickupRole;
grant select,alter,insert,update,delete on Date_Ranges to PickupRole;

alter role PickupRole add member Dinaker

create login Anusha with password='anusha' must_change,check_expiration=on,
	check_policy=on,default_database=ISADatabase;

create user Anusha for login Anusha;


create role RoommateSearchRole;

grant select,alter,insert,update,delete on Languages to RoommateSearchRole;
grant select,alter,insert,update,delete on Student_Profile to RoommateSearchRole;
grant select,alter,insert,update,delete on Student_Sublease_Mapping to RoommateSearchRole;
grant select,alter,insert,update,delete on Apartment_Details to RoommateSearchRole;
grant select,alter,insert,update,delete on SubLeases to RoommateSearchRole;
grant select,alter,insert,update,delete on Groups to RoommateSearchRole;
grant select,alter,insert,update,delete on Automated_Messages to RoommateSearchRole;
grant select,alter,insert,update,delete on Notifications_Req_Tracker to RoommateSearchRole;
grant select,alter,insert,update,delete on Discussion_Forum to RoommateSearchRole;
grant select,alter,insert,update,delete on Message_Content to RoommateSearchRole;

alter role RoommateSearchRole add member Anusha

create login Administrator with password='administrator' must_change,check_expiration=on,
	check_policy=on,default_database=ISADatabase;

create user Administrator for login Administrator;

create login Deepika with password='deepika' must_change,check_expiration=on,
	check_policy=on,default_database=ISADatabase;

create user Deepika for login Deepika;

create role AdminRole;

grant select,alter,insert,update,delete on Pickup_Student_details to AdminRole;
grant select,alter,insert,update,delete on Student_Volunteer_Mapping to AdminRole;
grant select,alter,insert,update,delete on Volunteer_Details to AdminRole;
grant select,alter,insert,update,delete on Date_Ranges to AdminRole;
grant select,alter,insert,update,delete on Languages to AdminRole;
grant select,alter,insert,update,delete on Student_Profile to AdminRole;
grant select,alter,insert,update,delete on Student_Sublease_Mapping to AdminRole;
grant select,alter,insert,update,delete on Apartment_Details to AdminRole;
grant select,alter,insert,update,delete on SubLeases to AdminRole;
grant select,alter,insert,update,delete on Groups to AdminRole;
grant select,alter,insert,update,delete on Automated_Messages to AdminRole;
grant select,alter,insert,update,delete on Notifications_Req_Tracker to AdminRole;
grant select,alter,insert,update,delete on Discussion_Forum to AdminRole;
grant select,alter,insert,update,delete on Message_Content to AdminRole;

alter role AdminRole add member Administrator
alter role AdminRole add member Deepika


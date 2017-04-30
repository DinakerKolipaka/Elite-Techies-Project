--if db_id('ISADatabase') is null 
--create database ISADatabase
--use master
--drop database isadatabase
--use ISADatabase

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

CREATE TABLE Automated_Messages
(
  MessageID INT NOT NULL IDENTITY,
  MessageDescription VARCHAR(MAX) NOT NULL,
  PRIMARY KEY (MessageID)
);


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

CREATE TABLE SubLeases
(
  SubLeaseID INT NOT NULL IDENTITY,
  AptID INT NOT NULL,
  Description VARCHAR(MAX) NOT NULL,
  DateOfAvailability DATETIME NOT NULL,
  LeaseEndDate DATETIME NOT NULL,
  Budget MONEY NOT NULL,
  PRIMARY KEY (SubLeaseID),
  FOREIGN KEY (AptID) REFERENCES Apartment_Details(AptID)
);

--GroupStatus 0 Open; 1 CLosed
CREATE TABLE Groups
(
  GroupID INT NOT NULL IDENTITY,
  GroupStatus INT NOT NULL,
  GroupName VARCHAR(50) NOT NULL,
  AptID INT NULL,
  ThreadID INT NULL,
  PRIMARY KEY (GroupID),
  FOREIGN KEY (AptID) REFERENCES Apartment_Details(AptID)
);


CREATE TABLE Discussion_Forum
(
  GroupID INT NOT NULL,
  ThreadID INT NOT NULL IDENTITY,
  FOREIGN KEY (GroupID) REFERENCES Groups(GroupID),
  PRIMARY KEY (GroupID,ThreadID)
  );

CREATE TABLE Message_Content	
(
  MessageID INT NOT NULL IDENTITY,
  ThreadID INT NOT NULL,
  GroupID INT NOT NULL,
  AuthorID VARCHAR(50) NOT NULL,
  MessageSubject VARCHAR(100) NOT NULL,
  Body VARCHAR(MAX) NOT NULL,
  MessageDate DATETIME NOT NULL,
  PRIMARY KEY (MessageID),
  FOREIGN KEY (GroupID,ThreadID) REFERENCES Discussion_Forum(GroupID,ThreadID)
);

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
  Budget Money NULL,
  LoginPassword VARCHAR(255) NOT NULL,
  Major VARCHAR(50) NOT NULL,
  Native VARCHAR(50) NOT NULL,
  GroupID INT NULL,
  SmokingPref INT NULL,
  DrinkingPref INT NULL,
  FoodPref INT NULL,
  BudgetPref Money NULL,
  NoOfRoommatesPref INT NULL,
  PRIMARY KEY (StudentID),
  FOREIGN KEY (GroupID) REFERENCES Groups(GroupID)
);


CREATE TABLE Student_SubLease_Mapping
(
	StudentID INT NOT NULL,
	SubLeaseID INT NOT NULL,
    PRIMARY KEY(StudentID,SubLeaseID),
    FOREIGN KEY (StudentID) REFERENCES Student_Profile(StudentID),
    FOREIGN KEY (SubLeaseID) REFERENCES SubLeases(SubLeaseID)
    
);


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


--Type 0 is Habit; 1 is Preference
CREATE TABLE Languages
(
	StudentID INT NOT NULL,
    Language VARCHAR(50) NOT NULL,
	Type INT NOT NULL,
    PRIMARY KEY(StudentID,Language,Type),
    FOREIGN KEY (StudentID) REFERENCES Student_Profile(StudentID)
);



--if db_id('ISADatabase') is null 
--create database ISADatabase
--use master
--drop database isadatabase
--use ISADatabase

CREATE TABLE Pickup_Student_Details
(
  StudentID INT NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  ContactNo VARCHAR(20) NOT NULL,
  EmailID VARCHAR(20) NOT NULL,
  Gender INT NOT NULL,
  ArrivalDate DATETIME NOT NULL,
  PortOfEntry VARCHAR(50) NULL,
  FlightBoardingCity VARCHAR(50) NOT NULL,
  FlightDetails VARCHAR(30) NOT NULL,
  NumberOfBags INT NOT NULL,
  EmergencyContactName VARCHAR(50) NOT NULL,
  EmergencyContactAddress VARCHAR(255) NULL,
  EmergencyContactEmailID VARCHAR(50) NOT NULL,
  EmergencyContactNumber VARCHAR(20) NOT NULL,
  SuperShuttleStatus INT NOT NULL,
  AccompanyingPeople INT NOT NULL,
  PRIMARY KEY (StudentID)
);

CREATE TABLE Volunteer_Details
(
  VolunteerID INT NOT NULL,
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

CREATE TABLE Student_Volunteer_Mapping
(
  StudentID INT NOT NULL,
  VolunteerID INT NOT NULL,
  ServiceProvided INT NOT NULL,
  PRIMARY KEY (ServiceProvided, VolunteerID, StudentID),
  FOREIGN KEY (VolunteerID) REFERENCES Volunteer_Details(VolunteerID),
  FOREIGN KEY (StudentID) REFERENCES Pickup_Student_Details(StudentID)
);

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
  MessageID INT NOT NULL,
  MessageDescription VARCHAR(200) NOT NULL,
  PRIMARY KEY (MessageID)
);


CREATE TABLE Apartment_Details
(
  AptID INT NOT NULL,
  Name VARCHAR(50) NOT NULL,
  Address VARCHAR(50) NOT NULL,
  Photos VARBINARY(MAX) NULL,
  Rent MONEY NOT NULL,
  OtherExpenses MONEY NOT NULL,
  ApartmentType VARCHAR(30) NOT NULL,
  Area VARCHAR(50) NULL,
  NoOfRoomsAvailable INT NOT NULL,
  MaxOccupancy INT NULL,
  Amenities VARCHAR(100) NULL,
  PRIMARY KEY (AptID)
);
CREATE TABLE SubLeases
(
  SubLeaseID INT NOT NULL,
  AptID INT NOT NULL,
  Description VARCHAR(200) NOT NULL,
  DateOfAvailability DATETIME NOT NULL,
  LeaseEndDate DATETIME NOT NULL,
  Budget INT NOT NULL,
  PRIMARY KEY (SubLeaseID),
  FOREIGN KEY (AptID) REFERENCES Apartment_Details(AptID)
);

CREATE TABLE Groups
(
  GroupID INT NOT NULL,
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
  ThreadID INT NOT NULL,
  FOREIGN KEY (GroupID) REFERENCES Groups(GroupID),
  PRIMARY KEY (GroupID,ThreadID)
  );

CREATE TABLE Message_Content	
(
  MessageID INT NOT NULL,
  ThreadID INT NOT NULL,
  GroupID INT NOT NULL,
  AuthorID VARCHAR(50) NOT NULL,
  MessageSubject VARCHAR(100) NOT NULL,
  Body VARCHAR(200) NOT NULL,
  MessageDate DATETIME NOT NULL,
  PRIMARY KEY (MessageID),
  FOREIGN KEY (GroupID,ThreadID) REFERENCES Discussion_Forum(GroupID,ThreadID)
);
CREATE TABLE Student_Profile
(
  StudentID INT NOT NULL,
  Firstname VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  ContactNo VARCHAR(20) NOT NULL,
  EmailID VARCHAR(50) NOT NULL,
  Gender INT NOT NULL,
  SmokingHabit INT NOT NULL,
  DrinkingHabit INT NOT NULL,
  FoodHabits INT NOT NULL,
  LoginPassword VARCHAR(20) NOT NULL,
  Major VARCHAR(20) NOT NULL,
  Native VARCHAR(30) NOT NULL,
  GroupID INT NULL,
  SmokingPref INT NOT NULL,
  DrinkingPref INT NOT NULL,
  FoodPref INT NOT NULL,
  BudgetPref INT NOT NULL,
  NoOfRoommatesPref INT NOT NULL,
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




CREATE TABLE Notifications_Req_Tracker
(
  RequestID INT NOT NULL,
  FromStudent INT NOT NULL,
  ToStudent INT NULL,
  ToGroup INT NULL,
  RequestStatus INT NOT NULL,
  PRIMARY KEY (RequestID),
  FOREIGN KEY (ToGroup) REFERENCES Groups(GroupID),
  FOREIGN KEY (ToStudent) REFERENCES Student_Profile(StudentID),
  FOREIGN KEY (FromStudent) REFERENCES Student_Profile(StudentID)
);

CREATE TABLE Languages
(
	StudentID INT NOT NULL,
    Language VARCHAR(50) NOT NULL,
	Type INT NOT NULL,
    PRIMARY KEY(StudentID,Language,Type),
    FOREIGN KEY (StudentID) REFERENCES Student_Profile(StudentID)
);



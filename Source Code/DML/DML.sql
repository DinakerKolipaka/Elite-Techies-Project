/* Insert procedure for Pickup_Student_Details*/
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
exec spInsert_Pickup_Students 'Seamus','Finnigan','488-511-3114','seamus.finnigan@hogwarts.edu',0,'2017-08-03 16:45:00','Seattle','Belfast','9W5436 Jet Airways',	
3,'Mary Finnigan','1267 E University Drive, Apt 1089, Tempe, 85281','mary.finnigan@hogwarts.edu','612-134-9864',1,1
exec spInsert_Pickup_Students 'Dean','Thomas','488-511-3133','dean.thomas@hogwarts.edu',0,'2017-08-03 15:00:00','Boston','Cardiff','QR2700 Qatar Airways',	
3,'Mary Finnigan','1268 E University Drive, Apt 313, Tempe, 85281','mary.finnigan@hogwarts.edu','612-143-6576',0,0
exec spInsert_Pickup_Students 'Padma','Patil','488-511-3152','padma.patil@hogwarts.edu',1,'2017-07-24 06:00:00','Pittsburgh','London','UA3322 United Airlines',	
3,null,null,null,null,1,2
exec spInsert_Pickup_Students 'Parvati','Patil','488-511-3171','parvati.patil@hogwarts.edu',1,'2017-08-01 19:30:00','New York','London',
'AA2702 American Airlines',3,'Narendra Patil','1266 E University Drive, Apt 987, Tempe, 85281','narendra.patil@hogwarts.edu',
'612-432-4568',0,0
exec spInsert_Pickup_Students 'Susanne','Bones','488-511-3190','susanne.bones@hogwarts.edu',1,'2017-07-24 8:10:00','Chicago','Birmingham','BA3403 British Airways',	
3,'Temperance Bones','1269 E University Drive, Apt 1055, Tempe, 85281','temperance.bones@hogwarts.edu','612-121-8764',1,0

select * from Pickup_Student_Details

/*Insert procedure for Volunteer_Details*/

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

exec spInsert_Volunteer_Details 'Minerva','McGonagall','480-235-0876', 'minerva.mcgonagall@asu.edu', 0, 0, '1265 E University Drive, Apt 1062, Tempe, 85281', 1, 1,'2017-07-08','10-07-2017',0
exec spInsert_Volunteer_Details 'Severus', 'Snape', '480-532-0777', 'severus.snape@asu.edu', 1, 1, '1270 E University Drive, Apt 1064, Tempe, 85281', 2, 2,'2017-07-26','2017-07-28',1
exec spInsert_Volunteer_Details 'Filius', 'Flitwick', '480-333-7654', 'filius.flitwick@asu.edu', 2, 1, '1264 E University Drive, Apt 1063, Tempe, 85281', 3, 1,'2017-07-29','2017-07-31',2
exec spInsert_Volunteer_Details 'Pomona', 'Sprout', '480-212-6509', 'pomona.sprout@asu.edu', 0, 0, '1261 E University Drive, Apt 1072, Tempe, 85281', 1, 2,'2017-07-22','2017-07-24',0
exec spInsert_Volunteer_Details 'Remus', 'Lupin', '480-563-7690', 'remus.lupin@asu.edu', 1,	1, '1262 E University Drive, Apt 1074, Tempe, 85281', 2, 1,'2017-07-29','2017-07-31',1

select * from Volunteer_Details
select * from Date_Ranges

/*Insert Procedure for Student_Profile*/
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

exec spInsert_studentProfile 'Hermione', 'Granger', '488-511-3019', 'hermoine.granger@hogwarts.edu', 1, 0, 1, 3, 'Granger', 'CSE', 'Surrey', Null, 3, 2, 3, 300, 5,'English', 1
exec spInsert_studentProfile 'Hermione', 'Granger', '488-511-3019', 'hermoine.granger@hogwarts.edu', 1, 0, 1, 3, 'Granger', 'CSE', 'Surrey', Null, 3, 2, 3, 300, 5, 'French', 1
exec spInsert_studentProfile 'Hermione', 'Granger', '488-511-3019', 'hermoine.granger@hogwarts.edu', 1, 0, 1, 3, 'Granger', 'CSE', 'Surrey', Null, 3, 2, 3, 300, 5, 'German', 1

exec spInsert_studentProfile 'Ronald', 'Weasley', '488-511-3038', 'ronald.weasley@hogwarts.edu', 0, 1, 1, 2, 'Weasley', 'IT', 'West Sussex', null, 2, 2, 3, 300, 5,'English', 1
exec spInsert_studentProfile 'Ronald', 'Weasley', '488-511-3038', 'ronald.weasley@hogwarts.edu', 0, 1, 1, 2, 'Weasley', 'IT', 'West Sussex', null, 2, 2, 3, 300, 5,'Spanish', 1
exec spInsert_studentProfile 'Ronald', 'Weasley', '488-511-3038', 'ronald.weasley@hogwarts.edu', 0, 1, 1, 2, 'Weasley', 'IT', 'West Sussex', null, 2, 2, 3, 300, 5,'English', 2
exec spInsert_studentProfile 'Ronald', 'Weasley', '488-511-3038', 'ronald.weasley@hogwarts.edu', 0, 1, 1, 2, 'Weasley', 'IT', 'West Sussex', null, 2, 2, 3, 300, 5,'Spanish', 2

exec spInsert_studentProfile 'Harry', 'Potter', '488-511-3057', 'harry.potter@hogwarts.edu', 0, 1, 1, 1, 'Potter', 'Mech', 'Yorkshire', Null, 3, 3, 3, 400, 4,'English', 1
exec spInsert_studentProfile 'Harry', 'Potter', '488-511-3057', 'harry.potter@hogwarts.edu', 0, 1, 1, 1, 'Potter', 'Mech', 'Yorkshire', Null, 3, 3, 3, 400, 4,'English', 2

--exec spInsert_studentProfile 'Draco', 'Malfoy', '488-511-3076', 'draco.malfoy@hogwarts.edu', 0, Null, Null, Null, 'Malfoy', 'IE', 'Lancashire', Null, 3, 1, 3, 200, Null,4, 'English', 2

exec spInsert_studentProfile 'Neville', 'Longbottom', '488-511-3095', 'neville.longbottom@hogwarts.edu', 0, 0, 0, 2, 'Longbottom', 'EE', 'Cleveland', Null, 1, 3, 2, 500, 2,'English', 1
exec spInsert_studentProfile 'Neville', 'Longbottom', '488-511-3095', 'neville.longbottom@hogwarts.edu', 0, 0, 0, 2, 'Longbottom', 'EE', 'Cleveland', Null, 1, 3, 2, 500, 2,'English', 2


select * from Student_Profile
select * from Languages


/*Insert into Apartment_Details*/
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

exec spInsert_Apt_Details '12Fifty5 On University','1255 E University Dr Apt 3070, Tempe, AZ 85281',NULL,1200,
										300,'2B2B','848',2,5,'Laundry Rooms, Swimming Pools, Game room'
exec spInsert_Apt_Details 'University Park','1015 E University Dr Apt 1001, Tempe, AZ 85281',NULL,1000,
										500,'2B2B','960',2,4,'Laundry Rooms, Swimming Pools, Game room'
exec spInsert_Apt_Details 'La Cresenta','1025 E Orange St g129 Apt 300, Tempe, AZ 85281',NULL,1300,
										300,'2B2B','848',2,4,'Laundry Rooms, Swimming Pools, Game room'

select * from Apartment_Details

/*Search By People*/
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
	(BudgetPref=@budgetpref) or
	(SmokingHabit=@smokingpref) or
	(DrinkingHabit=@drinkingpref) or
	(FoodHabits=@foodpref) or
	(NoOfRoommatesPref=@numroommatespref) 
	'

	execute sp_executesql @sql,@params,@fname=@pfname,@lname=@plname,@major=@pmajor,@gender=@pgender,
	@native=@pnative,@budgetpref=@pbudgetpref,@smokingpref=@psmokingpref,@drinkingpref=@pdrinkingpref,
	@foodpref=@pfoodpref,@numroommatespref=@pnumroommatespref	

end

exec sp_search_By_People 'harry', @pbudgetpref = 300

select * from Student_Profile

/*Serach by Groups*/
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

exec sp_search_By_Groups 1

select * from groups

select * from Student_Profile

update Student_Profile set GroupID = 1 where StudentID = 10

update groups set AptID = 1 where GroupID = 1


/*Search By Subleases*/

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

select * from Subleases

select * from Apartment_Details

/*Function for Date Ranges*/
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

select * from fnDateRanges(2)

select * from Date_Ranges

select * from Pickup_Student_Details


/*Trigger on Notification Request Tracker*/
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

select * from Notifications_Req_Tracker

delete from Notifications_Req_Tracker

update Notifications_Req_Tracker set RequestStatus = 1 where RequestID = 2

select * from Student_Profile where StudentID = 9


insert into Notifications_Req_Tracker(FromStudent,ToStudent,ToGroup,RequestStatus) 
values	(9,null,1,0)

select * from Student_Profile



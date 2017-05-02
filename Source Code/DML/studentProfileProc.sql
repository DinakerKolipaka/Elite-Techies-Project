use ISADatabase
if object_id('studentProfileProc') is not null
drop proc studentProfileProc
go
CREATE PROC studentProfileProc
  @Firstname VARCHAR(50),
  @LastName VARCHAR(50),
  @ContactNo VARCHAR(20),
  @EmailID VARCHAR(50),
  @Gender INT,
  @SmokingHabit INT,
  @DrinkingHabit INT,
  @FoodHabits INT,
  @Budget Money,
  @LoginPassword VARCHAR(20),
  @Major VARCHAR(20),
  @Native VARCHAR(30),
  @GroupID INT,
  @SmokingPref INT,
  @DrinkingPref INT,
  @FoodPref INT,
  @BudgetPref INT,
  @NoOfRoommatesPref INT,
  @lang varchar(50),
  @type int
AS
begin
	insert into Student_Profile(Firstname,LastName,ContactNo,EmailID,Gender,
					SmokingHabit,DrinkingHabit,FoodHabits,LoginPassword,Major,
					Native,GroupID,SmokingPref,DrinkingPref,FoodPref,BudgetPref,NoOfRoommatesPref) 
	values (@Firstname,@LastName,@ContactNo,@EmailID,@Gender,
					@SmokingHabit,@DrinkingHabit,@FoodHabits,@LoginPassword,@Major,
					@Native,@GroupID,@SmokingPref,@DrinkingPref,@FoodPref,@BudgetPref,@NoOfRoommatesPref);

	declare @StudentID INT = (select StudentID from Student_Profile where EmailID = @EmailID)
	insert into languages values(@StudentID,@lang,@type);
	
end

EXEC studentProfileProc @StudentID=6,@Firstname='Hermoine',@LastName='Granger',@ContactNo='480-511-3019',
						@EmailID='hermoine.granger@hogwarts.edu',@Gender=1,
					@SmokingHabit=0,@DrinkingHabit=1,@FoodHabits=3,@Budget=250,@LoginPassword='Granger',@Major='CSE',
					@Native='Surrey',@GroupID=NULL,@SmokingPref=3,@DrinkingPref=2,@FoodPref=3,@BudgetPref=200,@NoOfRoommatesPref=5
					,@lang='English',@type=0;

select * from Student_Profile
select * from languages

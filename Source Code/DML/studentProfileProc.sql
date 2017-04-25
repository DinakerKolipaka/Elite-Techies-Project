use ISADatabase
if exists(select object_id('studentProfileProc'))
drop proc studentProfileProc
CREATE PROC studentProfileProc
  @StudentID INT,
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
  @NoOfRoommatesPref INT,
  @lang varchar(50),
  @type int
AS
begin
	insert into Student_Profile values ( @StudentID,@Firstname,@LastName,@ContactNo,@EmailID,@Gender,
					@SmokingHabit,@DrinkingHabit,@FoodHabits,@LoginPassword,@Major,
					@Native,@GroupID,@SmokingPref,@DrinkingPref,@FoodPref,@BudgetPref,@NoOfRoommatesPref);
	insert into languages values(@StudentID,@lang,@type);
	
end

EXEC studentProfileProc @StudentID=6,@Firstname='Hermoine',@LastName='Granger',@ContactNo='480-511-3019',
						@EmailID='hermoine.granger@hogwarts.edu',@Gender=1,
					@SmokingHabit=0,@DrinkingHabit=1,@FoodHabits=3,@LoginPassword='Granger',@Major='CSE',
					@Native='Surrey',@GroupID=NULL,@SmokingPref=3,@DrinkingPref=2,@FoodPref=3,@BudgetPref=200,@NoOfRoommatesPref=5
					,@lang='English',@type=0;

select * from Student_Profile
select * from languages

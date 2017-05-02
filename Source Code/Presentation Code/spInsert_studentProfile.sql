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

exec spInsert_studentProfile 'Anusha', 'Samala', '488-511-3019', 'anusha.samala@hogwarts.edu', 1, 0, 1, 3, 'Samala', 'CSE', 'Surrey', Null, 3, 2, 3, 300, 5,'English', 1

select * from Student_Profile where FirstName = 'Anusha'
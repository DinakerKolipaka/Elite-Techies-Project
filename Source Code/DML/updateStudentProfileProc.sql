use ISADatabase
if exists(select object_id('updateStudentProfileProc'))
drop proc updateStudentProfileProc
go
create proc updateStudentProfileProc

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


EXEC updateStudentProfileProc @StudentID=1,@Firstname='Hermoine Jean',@LastName='Granger',@ContactNo='480-511-3019',
						@EmailID='hermoine.granger@hogwarts.edu',@Gender=1,
					@SmokingHabit=0,@DrinkingHabit=1,@FoodHabits=3,@LoginPassword='Granger',@Major='CSE',
					@Native='Surrey',@GroupID=NULL,@SmokingPref=3,@DrinkingPref=2,@FoodPref=3,@BudgetPref=200,@NoOfRoommatesPref=5;

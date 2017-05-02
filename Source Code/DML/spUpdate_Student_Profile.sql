if object_id('spUpdateStudent_Profile') is not null
drop procedure spUpdateStudent_Profile;
go
create proc spUpdateStudent_Profile
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

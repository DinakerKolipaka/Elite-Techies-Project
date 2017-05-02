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

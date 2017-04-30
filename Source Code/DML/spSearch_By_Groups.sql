if exists(select object_id ('spSearchByGroups'))
drop proc spSearchByGroups;
go
create proc spSearchByGroups @groupid int
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
if exists(select object_id ('spInsertIntoStudentVolunteerMapping'))
drop proc spInsertIntoStudentVolunteerMapping;
go
create proc spInsertIntoStudentVolunteerMapping
		@StudentID INT, 
		@VolunteerID INT, 
		@ServiceProvided INT 
as
	begin
	insert into Student_Volunteer_Mapping 
		(StudentID, VolunteerID, ServiceProvided)
	values (@StudentID, @VolunteerID, @ServiceProvided)
	end
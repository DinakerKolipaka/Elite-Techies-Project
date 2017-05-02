if object_id ('spInsertIntoStudentVolunteerMapping') is not null
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
	values (@StudentID, @VolunteerID, @ServiceProvided);
	end
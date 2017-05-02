use ISADatabase
if object_id('spInsert_Subleases') is not null
drop proc spInsert_Subleases
go
create proc spInsert_Subleases
	@AptID INT,
	@Description VARCHAR(200),
	@DateOfAvailability DATETIME,
	@LeaseEndDate DATETIME,
	@Budget INT,
	@StudentID INT
as
begin
	insert into Subleases values (@AptID,@Description,@DateOfAvailability,@LeaseEndDate,
							@Budget);

	declare @SubleaseID INT = (select SubleaseID from SubLeases where AptID = @AptID)
	insert into Student_SubLease_Mapping values(@StudentID,@SubleaseID);
end


EXEC subleasesProc @AptID=1,@Description='A great apartment',@DateOfAvailability='2017-05-01',
	@LeaseEndDate='2017-08-10',@Budget=100,@StudentID=2

select * from subleases
select * from Student_SubLease_Mapping
select * from Apartment_Details  

insert into apartment_details values(1,'Temp','1255 E University Dr',NULL,400,200,'2B2B',848,2,5,'Laundry,Rent,Swimming Pool' )

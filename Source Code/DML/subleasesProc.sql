use ISADatabase
if exists(select object_id('subleasesProc'))
drop proc subleasesProc
go
create proc subleasesProc
	@SubleaseID INT,
	@AptID INT,
	@Description VARCHAR(200),
	@DateOfAvailability DATETIME,
	@LeaseEndDate DATETIME,
	@Budget INT,
	@StudentID INT
as
begin
	insert into Subleases values (@SubleaseID,@AptID,@Description,@DateOfAvailability,@LeaseEndDate,
							@Budget);
	insert into Student_SubLease_Mapping values(@StudentID,@SubleaseID);
end

EXEC subleasesProc @SubleaseID=1,@AptID=1,@Description='A great apartment',@DateOfAvailability='2017-05-01',
	@LeaseEndDate='2017-08-10',@Budget=100,@StudentID=2

select * from subleases
select * from Student_SubLease_Mapping
select * from Apartment_Details  

insert into apartment_details values(1,'Temp','1255 E University Dr',NULL,400,200,'2B2B',848,2,5,'Laundry,Rent,Swimming Pool' )

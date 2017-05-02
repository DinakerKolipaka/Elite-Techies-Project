use ISADatabase

go
if object_id('search_by_sublease') is not null
drop proc searchSubleasesProc
go
create view search_by_sublease
as
select ad.Name,sl.DateOfAvailability,ad.NoOfRoomsAvailable,ad.Rent 
from SubLeases sl join Apartment_Details ad on ad.AptID = sl.AptID

select * from SubLeases
select * from Apartment_Details
delete from subleases where subleaseid = 10

select * from Student_SubLease_Mapping


--panels:- AptName,DateofAvailability,Rent,NoOfRoomsavailability
--view details :- all details from sublease,apartment and student(no gender)

go
create view sublease_details
as
select stupro.Firstname + ' ' + stupro.LastName as FullName,stupro.EmailID,ad.Name,ad.Address,sl.Budget,sl.DateOfAvailability,
sl.Description, sl.LeaseEndDate,ad.Photos,ad.Amenities,ad.ApartmentType,ad.Area,ad.MaxOccupancy,ad.NoOfRoomsAvailable,ad.OtherExpenses
from Student_Profile as stupro join Student_SubLease_Mapping ssm on stupro.StudentID = ssm.StudentID 
join SubLeases sl on ssm.SubLeaseID = sl.SubLeaseID join Apartment_Details ad on ad.AptID = sl.AptID

select stupro.Firstname + ' ' + stupro.LastName as FullName,stupro.EmailID,ad.Name,ad.Address,sl.Budget,sl.DateOfAvailability,
sl.Description, sl.LeaseEndDate,ad.Photos,ad.Amenities,ad.ApartmentType,ad.Area,ad.MaxOccupancy,ad.NoOfRoomsAvailable,ad.OtherExpenses
from Student_Profile as stupro,Student_SubLease_Mapping ssm,SubLeases sl,Apartment_Details ad
where stupro.StudentID = ssm.StudentID
and sl.SubleaseID = ssm.SubLeaseID
and ad.AptID = sl.AptID


select stupro.Firstname + ' ' + stupro.LastName as FullName,stupro.EmailID
from Student_Profile as stupro where stupro.StudentID in (select StudentID from Student_SubLease_Mapping)

select sl.Budget,sl.DateOfAvailability,sl.Description, sl.LeaseEndDate 
from SubLeases sl where sl.SubLeaseID in (select SubLeaseID from Student_SubLease_Mapping)

select ad.Name,ad.Address,ad.Photos,ad.Amenities,ad.ApartmentType,ad.Area,ad.MaxOccupancy,ad.NoOfRoomsAvailable,ad.OtherExpenses
from Apartment_Details ad where ad.AptID in(select AptID from Subleases)
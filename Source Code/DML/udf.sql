if object_id('fnDateRanges') is not null
drop function fnDateRanges
go
create function fnDateRanges(@sid int)
returns @temptable table
	(
		volunteerid int,
		firstname varchar(50),
		lastname varchar(50),
		fromdate datetime,
		todate datetime
	)
as
begin
	declare @arrdate datetime

	set @arrdate=(select arrivaldate from pickup_student_details where studentid=@sid);
	declare @volunteerid int,@fromdate datetime,@todate datetime
	declare dateCursor cursor for select volunteerid,fromdate,todate from date_ranges;
	open dateCursor
	fetch next from dateCursor into @volunteerid,@fromdate,@todate;
	while(@@fetch_status=0)
	begin
		if ((@arrdate>=@fromdate) and (@arrdate<=@todate))
			begin
				insert @temptable
				select v.VolunteerID,FirstName,LastName,FromDate,ToDate 
				from Volunteer_Details v join Date_Ranges d on v.VolunteerID = d.VolunteerID
				where d.VolunteerID = @volunteerid; 
			end
		fetch next from dateCursor into @volunteerid,@fromdate,@todate;
	end
	close dateCursor;
	deallocate dateCursor;
return
end

insert into Pickup_Student_Details values(3,'Hermoine','Granger','488-511-3219','herm.grang@hog.edu',1,'2017-07-27','New York','London','AA2702 American Airlines',3,'Arthur Weasley','1265 E University Drive, Apt 1062, Tempe, 85281','arthur.weasley@hogwarts.edu','612-342-6543',0,0)

select * from fnDateRanges(3);

insert into Volunteer_Details values(1,'Minerva', 'McGonagall','480-235-0876','minerva.mcgonagall@asu.edu',0,0,'1265 E University Drive, Apt 1062, Tempe, 85281',1,1)
insert into Volunteer_Details values(2,'Severus','Snape','480-532-0777','severus.snape@asu.edu',1,1,'1270 E University Drive, Apt 1064, Tempe, 85281',2,2)
insert into Volunteer_Details values(3,'Filius','Flitwick','480-333-7654','filius.flitwick@asu.edu',2,1,'1264 E University Drive, Apt 1063, Tempe, 85281',3,1)
insert into Volunteer_Details values(4,'Pomona','Sprout','480-212-6509','pomona.sprout@asu.edu',0,0,'1261 E University Drive, Apt 1072, Tempe, 85281',1,2)


select * from volunteer_details 

insert into Date_Ranges values(1,'2017-07-08','2017-07-10',0)
insert into Date_Ranges values(2,'2017-07-26','2017-07-28',1)
insert into Date_Ranges values(3,'2017-07-29','2017-07-31',2)
insert into Date_Ranges values(4,'2017-07-22','2017-07-24',0)

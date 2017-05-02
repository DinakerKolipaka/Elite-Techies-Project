if object_id('fnDateRanges') is not null
drop function fnDateRanges;
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

select * from fnDateRanges(2)

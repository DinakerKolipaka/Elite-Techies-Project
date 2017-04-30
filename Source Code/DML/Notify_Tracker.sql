use ISADatabase

if object_id('Notify_Tracker') is not null
drop procedure Notify_Tracker;
go
create procedure Notify_Tracker
@FromStudent int,
@ToStudent int,
@ToGroup int,
@RequestStatus int
as
	begin
		insert into Notifications_Req_Tracker(FromStudent,ToStudent,ToGroup,RequestStatus)
		values(@FromStudent,@ToStudent,@ToGroup,@RequestStatus)
	end


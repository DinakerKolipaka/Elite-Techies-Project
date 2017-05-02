if object_id ('tr_Group_Req_Accepted') is not null
drop trigger tr_Group_Req_Accepted;
go
create trigger tr_Group_Req_Accepted
on notifications_req_tracker
for update
as
	begin
	if (select RequestStatus from inserted) like 1
		Begin
			declare @FromStudentID int
			declare @Groupid int
			select @FromStudentID = FromStudent from inserted
			select @Groupid = ToGroup from inserted
		
			Update Student_Profile
			set GroupID = @Groupid where StudentID = @FromStudentID
		end
	end


update Notifications_Req_Tracker set RequestStatus = 1 where RequestID = 2

select * from Student_Profile where StudentID = 9
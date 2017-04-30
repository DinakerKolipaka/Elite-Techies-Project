if exists(select object_id ('tr_Group_Req_Accepted'))
drop proc tr_Group_Req_Accepted;
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

select * from Student_Profile
select * from Notifications_Req_Tracker
select * from Groups

insert into Notifications_Req_Tracker (RequestID, FromStudent, ToStudent, ToGroup, RequestStatus)
values(1, 1, Null, 1, 0)

update Notifications_Req_Tracker
set RequestStatus = 1 where FromStudent = 1
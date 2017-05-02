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

select * from Student_Profile where StudentID =3
select * from Notifications_Req_Tracker
select * from Groups

update Student_Profile set GroupID = 1 where StudentID = 2

insert into Groups(GroupName,GroupStatus,AptID,ThreadID) values ('Gryffindor',0,null,null);

insert into Notifications_Req_Tracker (FromStudent, ToStudent, ToGroup, RequestStatus)
values(3, Null, 1, 0)


update Notifications_Req_Tracker
set RequestStatus = 1 where FromStudent = 3
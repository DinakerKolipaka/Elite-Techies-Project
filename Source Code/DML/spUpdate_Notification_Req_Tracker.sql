if object_id ('spUpdateNotification_Req_Tracker') is not null
drop proc spUpdateNotification_Req_Tracker;
go
create proc spUpdateNotification_Req_Tracker
  @RequestID INT ,  
  @RequestStatus INT 

as
	begin
	update Notifications_Req_Tracker
	set RequestStatus = 1
	where RequestID = @RequestID
	end

if object_id ('spDelete_Req_Notification_Req_Tracker') is not null
drop proc spDelete_Req_Notification_Req_Tracker;
go
create proc spDelete_Req_Notification_Req_Tracker
  @RequestID INT ,  
  @RequestStatus INT 

as
	begin
		delete from Notifications_Req_Tracker
		where RequestID = @RequestID
	end
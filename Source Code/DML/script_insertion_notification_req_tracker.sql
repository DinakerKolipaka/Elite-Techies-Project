insert into Notifications_Req_Tracker
(FromStudent, ToStudent, ToGroup, RequestStatus)
values
(11, Null, 2, 0),
(17, 14, Null, 0),
(15,Null, 3, 0),
(7, Null, 1, 0),
(10, 1, Null, 0)

-- Notes:
--select * from Notifications_Req_Tracker;
-- update status of  reqid 1,3,5 to 1 and check if trigger works and updates data in student profile

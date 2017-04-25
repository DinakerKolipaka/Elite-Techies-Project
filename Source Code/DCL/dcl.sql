use isadatabase

create login Dinaker with password='dinaker' must_change,check_expiration=on,
	check_policy=on,default_database=ISADatabase;

create user Dinaker for login Dinaker;
drop role PickupRole
create role PickupRole;

grant select,alter,insert,update,delete on Pickup_Student_details to PickupRole;
grant select,alter,insert,update,delete on Student_Volunteer_Mapping to PickupRole;
grant select,alter,insert,update,delete on Volunteer_Details to PickupRole;
grant select,alter,insert,update,delete on Date_Ranges to PickupRole;

alter role PickupRole add member Dinaker
	

create login Deepika with password='deepika' must_change,check_expiration=on,
	check_policy=on,default_database=ISADatabase;

create user Deepika for login Deepika;

create login Anusha with password='anusha' must_change,check_expiration=on,
	check_policy=on,default_database=ISADatabase;

create user Anusha for login Anusha;

drop role RoommateSearchRole
create role RoommateSearchRole;

grant select,alter,insert,update,delete on Languages to RoommateSearchRole;
grant select,alter,insert,update,delete on Student_Profile to RoommateSearchRole;
grant select,alter,insert,update,delete on Student_Sublease_Mapping to RoommateSearchRole;
grant select,alter,insert,update,delete on Apartment_Details to RoommateSearchRole;
grant select,alter,insert,update,delete on SubLeases to RoommateSearchRole;
grant select,alter,insert,update,delete on Groups to RoommateSearchRole;
grant select,alter,insert,update,delete on Automated_Messages to RoommateSearchRole;
grant select,alter,insert,update,delete on Notifications_Req_Tracker to RoommateSearchRole;
grant select,alter,insert,update,delete on Discussion_Forum to RoommateSearchRole;
grant select,alter,insert,update,delete on Message_Content to RoommateSearchRole;

create login Administrator with password='administrator' must_change,check_expiration=on,
	check_policy=on,default_database=ISADatabase;

create user Administrator for login Administrator;

drop role AdminRole
create role AdminRole;

grant select,alter,insert,update,delete on Pickup_Student_details to AdminRole;
grant select,alter,insert,update,delete on Student_Volunteer_Mapping to AdminRole;
grant select,alter,insert,update,delete on Volunteer_Details to AdminRole;
grant select,alter,insert,update,delete on Date_Ranges to AdminRole;
grant select,alter,insert,update,delete on Languages to AdminRole;
grant select,alter,insert,update,delete on Student_Profile to AdminRole;
grant select,alter,insert,update,delete on Student_Sublease_Mapping to AdminRole;
grant select,alter,insert,update,delete on Apartment_Details to AdminRole;
grant select,alter,insert,update,delete on SubLeases to AdminRole;
grant select,alter,insert,update,delete on Groups to AdminRole;
grant select,alter,insert,update,delete on Automated_Messages to AdminRole;
grant select,alter,insert,update,delete on Notifications_Req_Tracker to AdminRole;
grant select,alter,insert,update,delete on Discussion_Forum to AdminRole;
grant select,alter,insert,update,delete on Message_Content to AdminRole;

alter role AdminRole add member Administrator


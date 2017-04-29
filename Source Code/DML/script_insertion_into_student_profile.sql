insert into Student_Profile
(
Firstname, LastName, ContactNo, EmailID, Gender, SmokingHabit, DrinkingHabit, FoodHabits, LoginPassword, 
Major, Native, GroupID, SmokingPref, DrinkingPref, FoodPref, BudgetPref, NoOfRoommatesPref
)
values
('Hermione', 'Granger', '488-511-3019', 'hermoine.granger@hogwarts.edu', 1, 0, 1, 3, 'Granger', 'CSE', 'Surrey', Null, 3, 2, 3, 300, 5),
('Ronald', 'Weasley', '488-511-3038', 'ronald.weasley@hogwarts.edu', 0, 1, 1, 2, 'Weasley', 'IT', 'West Sussex', 1, 2, 2, 3, 300, 5),
('Harry', 'Potter', '488-511-3057', 'harry.potter@hogwarts.edu', 0, 1, 1, 1, 'Potter', 'Mech', 'Yorkshire', 1, 3, 3, 3, 400, 4),
('Draco', 'Malfoy', '488-511-3076', 'draco.malfoy@hogwarts.edu', 0, Null, Null, Null, 'Draco', 'IE', 'Lancashire', Null, 3, 1, 3, 200, Null),
('Neville', 'Longbottom', '488-511-3095', 'neville.longbottom@hogwarts.edu', 0, 0, 0, 2, 'Longbottom', 'EE', 'Cleveland',1, 1, 3, 2, 500, 2), 
('Seamus', 'Finnigan', '488-511-3114', 'seamus.finnigan@hogwarts.edu', 0,Null, Null, Null, 'Finnigan', 'SE', 'Essex',Null, 1, 2, 1, 350, 4),
('Dean', 'Thomas', '488-511-3133', 'dean.thomas@hogwarts.edu', 0, 0, 0, 2, 'Thomas', 'Civil', 'Norfolk',1, 1, 1, 1, 250, 5),
('Parvati', 'Patil', '488-511-3152', 'parvati.patil@hogwarts.edu', 1, Null, Null, Null, 'Patil', 'Chem', 'Essex',Null, 3, 2, 1, 350, 4),
('Padma', 'Patil', '488-511-3171', 'padma.patil@hogwarts.edu', 1, 0, 1, 1, 'Patil', 'CSE', 'Essex', 2, 2, 1, 2, 350, 4),
('Susanne', 'Bones', '488-511-3190', 'susanne.bones@hogwarts.edu', 1, 1, 1, 1, 'Bones', 'CSE', 'Lancashire',Null, 2, 1, 1, 250, 5),  
('Hannah', 'Abbott', '488-511-3209', 'hannah.abbott@hogwarts.edu', 1, 1, 1, 3, 'Abbott', 'CSE', 'Cleveland', Null, 2, 3, 3, 250, 5),
('Terry', 'Boot', '488-511-3228', 'terry.boot@hogwarts.edu', 0, Null, Null, Null, 'Boot', 'IT', 'Lancashire',Null, 3, 4, 1, 450, 3),  
('Lavender', 'Brown', '488-511-3247', 'lavender.brown@hogwarts.edu', 1, 1, 1, 1, 'Brown', 'Mech', 'West Sussex',2 , 3, 2, 1, 650, 2), 
('Millicent', 'Bulstrode', '488-511-3266', 'milicent.bulstrode@hogwarts.edu', 1, 0, 0, 2, 'Bulstrode', 'EE', 'Surrey', Null, 3, 2, 2, 300, 4),  
('Ernie', 'McMillan', '488-511-3285', 'ernie.mcmillan@hogwarts.edu', 0, 0, 1, 1, 'McMillan', 'EE', 'West Sussex',Null,  1, 2, 2, 400, 3),  
('Michael', 'Corner', '488-511-3304', 'michael.corner@hogwarts.edu', 0, Null, Null, Null, 'Corner', 'EE', 'Cleveland', Null, 2, 1, 3, 300, 4),  
('Pansy', 'Parkinson', '488-511-3323', 'pansy.parkinson@hogwarts.edu', 1, 0, 1, 2, 'Parkinson', 'CE', 'Essex', Null, 3, 1, 1, 350, 4),  
('Justin', 'Finch', '488-511-3342', 'justin.finch@hogwarts.edu', 0, 1, 1, 3, 'Finch', 'CE', 'Lancashire',3, 1, 3, 2, 300, 4), 
('Blaise', 'Zabini', '488-511-3361', 'blaise.zabini@hogwarts.edu', 0, 1, 0, 3, 'Zabini', 'Civil', 'Surrey', Null, 1, 2, 2, 400, 4 ), 
('Morag', 'MacDougal', '488-511-3380', 'morag.macdougal@hogwarts.edu', 0, 1, 0, 1, 'MacDougal', 'CSE', 'Cleveland',3, 1, 1, 1, 500, 2) 







/*
select * from Student_Profile;
delete from Student_Profile where StudentID = 2

select * from Notifications_Req_Tracker
delete from Notifications_Req_Tracker where RequestID = 1

select * from Groups;

set IDENTITY_INSERT Groups off
insert into Groups(GroupID,GroupName,GroupStatus,AptID,ThreadID) values (1,'Gryffindor',1,7,null)

insert into Groups(GroupID,GroupName,GroupStatus,AptID,ThreadID) values (2,'Ravenclaw',0,null,null)	
insert into Groups(GroupID,GroupName,GroupStatus,AptID,ThreadID) values (3,'Hufflepuff',0,null,null)

set IDENTITY_INSERT apartment_details off
insert into Apartment_Details (  AptID, Name, Address, Photos, Rent, OtherExpenses, ApartmentType, Area, NoOfRoomsAvailable, MaxOccupancy, Amenities)
values (7,'12Fifty5','1255 E U Dr, Tempe, Arizona, 85281', Null, 1200, 300, '2B2B', 848, 2, 5, 'Laundry, swimming pool, game room')

update apartment_details 
set AptID = 7




1 Hermione Granger 488-511-3019 hermoine.granger@hogwarts.edu 1 0 1 3 Granger CSE Surrey 3 2 3 200 5  
2 Ronald Weasley 488-511-3038 ronald.weasley@hogwarts.edu 0 1 1 2 Weasley IT West Sussex 2 2 3 300 5 1 
3 Harry Potter 488-511-3057 harry.potter@hogwarts.edu 0 1 1 1 Potter Mech Yorkshire 3 3 3 400 4 1 
4 Draco Malfoy 488-511-3076 draco.malfoy@hogwarts.edu 0    Malfoy IE Lancashire 3 1 3 200 5  

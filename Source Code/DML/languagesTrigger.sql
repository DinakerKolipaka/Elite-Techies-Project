use ISADatabase
drop trigger languagesTrigger
create trigger languagesTrigger
on Student_Profile
after insert
as
begin
	declare @new_student_id int
	declare @lang varchar(50)='English'
	declare @type int=1

	set @new_student_id = (select studentid from inserted)
	insert into languages values(@new_student_id,@lang,@type)
end
select * from languages
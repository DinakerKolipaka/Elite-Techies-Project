use ISADatabase

if object_id('spInsert_Message_Cont') is not null
drop procedure spInsert_Message_Cont;
go
create procedure spInsert_Message_Cont
@ThreadID int,
@AuthorID varchar(50),
@Body varchar(200)
as
	begin
		declare @GroupID int
		set @GroupID = (select GroupID from Student_Profile where StudentID = @AuthorID)
		insert into Message_Content(ThreadID,GroupID,AuthorID,Body,MessageDate)
		values(@ThreadID,@GroupID,@AuthorID,@Body,GETDATE())
	end
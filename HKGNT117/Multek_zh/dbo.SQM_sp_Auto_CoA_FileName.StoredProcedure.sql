USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Auto_CoA_FileName]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SQM_sp_Auto_CoA_FileName]
AS
BEGIN	

declare @tb table(id int identity,filename nvarchar(max)) 
insert @tb(filename) exec xp_cmdshell 'dir \\Mcnnt109\PUBLIC\Co\*.txt /b'  

declare cur cursor for 
    select filename from @tb a WHERE filename<>'' AND not EXISTS (SELECT filename FROM SQM_CoA_FileName b WHERE a.filename=b.filename); 
declare @filename nvarchar(1000); 

open cur; 
fetch next from cur into @filename; 
while @@fetch_status=0 
  begin 
     set @filename = '\\Mcnnt109\PUBLIC\Co\'+@filename 
		 exec SQM_sp_Insert_STS_Form @filename   --这里执行存储过程 
     fetch next from cur into @filename; 
  end 
close cur; 
deallocate cur; 

--insert to SQM_CoA_FileName
	INSERT INTO SQM_CoA_FileName (filename)
	SELECT filename FROM @tb a WHERE filename<>'' AND not EXISTS (SELECT filename FROM SQM_CoA_FileName b WHERE a.filename=b.filename) 

end

GO

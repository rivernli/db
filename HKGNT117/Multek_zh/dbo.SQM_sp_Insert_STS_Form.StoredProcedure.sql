USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Insert_STS_Form]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SQM_sp_Insert_STS_Form]
@FileFullName NVARCHAR(200) 

as

BEGIN

	declare @tmp_table table(fieldname nvarchar(max)) 
	declare @fName nvarchar(max), @Rc nvarchar(50), @Item nvarchar(50), @Plant varchar(5),@m int,@n int, @ReportNo nvarchar(50), @NewId int  
	declare @taskid nvarchar(50),@Checked_Userid nvarchar(50),@Checked_By nvarchar(50),@email nvarchar(50),@tel nvarchar(50),@SendUrl nvarchar(50)   

	--insert temp table
	insert into @tmp_table EXEC ('(SELECT * FROM OPENROWSET(BULK '''+@FileFullName+''',SINGLE_CLOB) as x)') 
	
	select @fName=fieldname from @tmp_table 

	set @m=CHARINDEX(',',@fName)  
	set @n=1   
    set @Item = substring(@fName,@n,@m-@n)
	set  @n=@m+1  
	set  @m=CHARINDEX(',',@fName,@n)  	
	set @Plant = substring(@fName,@n,@m-@n) 

	
	set @ReportNo = left(@Item,1)+@Plant+right(year(getdate()),2)+right(100+month(getdate()),2)+right(100+day(getdate()),2)

	
	--Create Report No
	exec SQM_sp_GetNewNo 'IncomingMaterialCheckForm',@ReportNo,2,'0',@NewNo=@Rc output  

	select @fName=REPLACE(fieldname,',',',') from @tmp_table 
	exec('INSERT INTO SQM_IncomingMaterialCheck (Material,Plant,Date,PN,Vendor,Location,Vendor_PN,Core_thickness,
		  Construction,Copper_thickness,Copper_Treatment,Size,HF,RoHs,Description,Receiving_Date,Po_Number,Qty,IsSTS,
		  Package,CoA,Conclusion,Checked_Userid,Checked_By,Checked_Date,Send_State,TaskId,Attachment,SQMAttachment,Approved_By,F_N) 
	VALUES ('''+@fName+''',''1'',LTRIM(ABS(CHECKSUM(NEWID())))+ LTRIM(ABS(CHECKSUM(NEWID())))+ LEFT(LTRIM(ABS(CHECKSUM(NEWID()))),4),
		LTRIM(ABS(CHECKSUM(NEWID())))+ LTRIM(ABS(CHECKSUM(NEWID())))+ LEFT(LTRIM(ABS(CHECKSUM(NEWID()))),4),
		LTRIM(ABS(CHECKSUM(NEWID())))+ LTRIM(ABS(CHECKSUM(NEWID())))+ LEFT(LTRIM(ABS(CHECKSUM(NEWID()))),4),'''','''+@Rc+''')')

	SET @NewId = @@IDENTITY;

	-- Update Report No Table
	UPDATE SQM_Ts_Lsh SET Lsh = Lsh + 1 WHERE ModuleName = 'IncomingMaterialCheckForm' AND KeyName = 'LB1130422'

	select * from SQM_System_Users
	--Send email
	DECLARE sts_C CURSOR FOR
			select taskid,Checked_Userid,Checked_By,(select Email from SQM_System_Users where UserID=Checked_Userid) as email,(select tel from SQM_System_Users where UserID=Checked_Userid) as tel from SQM_IncomingMaterialCheck WHERE ID=@NewId
			OPEN sts_C
			FETCH NEXT FROM sts_C INTO @taskid,@Checked_Userid,@Checked_By,@email,@tel
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @SendUrl='STS/IncomingMaterialCheckForm_Add.aspx?dataId='+@NewId 
					EXEC dbo.SQM_sp_STS_Send_Mail 'PPCSendSupervisor',@taskid,'PPC Supervisor Step',@SendUrl,@Checked_Userid,'',@Checked_By,@tel,@email,'' 

					FETCH NEXT FROM sts_C INTO @taskid,@Checked_Userid,@Checked_By,@email,@tel
				END
			CLOSE sts_C
			DEALLOCATE sts_C
	
END 
 
 

GO

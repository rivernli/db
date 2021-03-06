USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Send_TimeOutTask_Mail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SQM_sp_Send_TimeOutTask_Mail] 
	@Option VARCHAR(2),
	@mID INT,
	@To NVARCHAR(MAX),
	@PN NVARCHAR(50),
	@Notice_No NVARCHAR(50),
	@Vendor NVARCHAR(50),
	@Material NVARCHAR(50),
	@ManagerEmail NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Cc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)

	--Send Mail
	IF @Option='1'		
		BEGIN
			SET @Cc=''
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a one day past due task: <br>' 			
			
			SET @Body=@Body+'<font color=''Red''> P/N: '+@PN+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Notice No.: '+@Notice_No+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Vendor: '+@Vendor+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Material: '+@Material+'</font><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'Regards,'
			SET @Body=@Body+'<br>Operations'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a one day past due task:.'
		
		--update State
		update SQM_Inbox_Info set State='1' where ID=@mID
		END

	IF @Option='2'		
		BEGIN
			SET @Cc=@ManagerEmail;
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a two days past due task: <br>' 			
			
			SET @Body=@Body+'<font color=''Red''> P/N: '+@PN+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Notice No.: '+@Notice_No+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Vendor: '+@Vendor+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Material: '+@Material+'</font><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'Regards,'
			SET @Body=@Body+'<br>Operations'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a two days past due task.'
		
		--update State
		update SQM_Inbox_Info set State='2' where ID=@mID
		END

		--PE环节超时10日后系统自动发出提醒邮件通知及时处理，如在1天内没有处理，系统将自动职消该单
		IF @Option='4'		
		BEGIN
			SET @Cc=@ManagerEmail;
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear PE Team,<br><br>'
			SET @Body=@Body+'You have a work task past due date in IQA/STS system. <br>' 			
			SET @Body=@Body+'The defect material information as below, please confirm and verify it within one workday after receiving the reminding, otherwise, the task will be cancelled in the system automatically directly. <br>' 	
			SET @Body=@Body+'Thanks! <br>' 	
			
			SET @Body=@Body+'<font color=''Red''> P/N: '+@PN+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Notice No.: '+@Notice_No+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Vendor: '+@Vendor+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Material: '+@Material+'</font><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'Regards,'
			SET @Body=@Body+'<br>Operations'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a work task past due date'
		
		--update State
		update SQM_Inbox_Info set State='4',TimeOutDate=convert(varchar(10),getdate(),120) where ID=@mID
		END
		
		--PE环节超时系统自动职消该单
		IF @Option='5'		
		BEGIN
			SET @Cc=@ManagerEmail;
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear PE Team,<br><br>'			
			SET @Body=@Body+'You have a work task in IQA/STS system and it has been auto cancelled due to past due date <br>' 				
			SET @Body=@Body+'<font color=''Red''> P/N: '+@PN+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Notice No.: '+@Notice_No+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Vendor: '+@Vendor+'</font><br>'
			SET @Body=@Body+'<font color=''Red''> Material: '+@Material+'</font><br>'
			SET @Body=@Body+'<br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'Regards,'
			SET @Body=@Body+'<br>Operations'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a work task cancel notice'
		
		--update State
		update SQM_Inbox_Info set Del='1' where ID=@mID
		Update SQM_NoticeOfDefectMaterial set Send_State='-1' Where Notice_No = @Notice_No
		END

	EXECUTE SQM_sp_Send_Mail @TO=@To,@Cc=@Cc,@Subject=@Subject,@Body=@Body
		
END





GO

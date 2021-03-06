USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_IQA_Send_Mail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SQM_sp_IQA_Send_Mail] 
	-- Add the parameters for the stored procedure here
	@Option VARCHAR(50),
	@SendId NVARCHAR(50),
	@SendTitle NVARCHAR(200),
	@PN NVARCHAR(50),
	@SendUrl NVARCHAR(200),
	@Sender NVARCHAR(50),
	@Vendor NVARCHAR(50),
	@Material NVARCHAR(50),
	@Plant NVARCHAR(50),
	@NoticeNo NVARCHAR(50),
	@Description NVARCHAR(50),
	@Remark NVARCHAR(Max),
	@ReturnPeople NVARCHAR(MAX),
	@PNType NVARCHAR(50),
	@SenderName NVARCHAR(50),
	@SenderTel NVARCHAR(50),
	@SenderEmail NVARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200),@EmailId NVARCHAR(500),@Eid NVARCHAR(500) 

	--Send Mail
	IF @Option='PE'		
		BEGIN
			SET @To=''
			SET @EmailId=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email, SQM_Email_Settings_Info.ID from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where PLsh='201106071024460007' AND Plant= @Plant  
			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email,@Eid 
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@To+@Email+';'
					SET @EmailId=@EmailId+@Eid+','
					FETCH NEXT FROM User_C INTO @Email,@Eid 
				END
			CLOSE User_C
			DEALLOCATE User_C

			SET @Cc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Notice of Defect Material task - PE Step: <br>' 
			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'			
			SET @Body=@Body+'	<td widht="20%" align="center">Description</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'			
			SET @Body=@Body+'	<td>'+@Description+'</td>'	
			SET @Body=@Body+'	<td>'+@NoticeNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Notice of Defect Material task - PE Step'
		END

		IF @Option='IQC'		
		BEGIN
			SET @To=''
			SET @EmailId=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email, SQM_Email_Settings_Info.ID from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where PLsh='201106071024460008' AND Plant= @Plant 
			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email,@Eid 
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@To+@Email+';'
					SET @EmailId=@EmailId+@Eid+','
					FETCH NEXT FROM User_C INTO @Email,@Eid 
				END
			CLOSE User_C
			DEALLOCATE User_C

			SET @Cc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Notice of Defect Material task - IQC Step: <br>' 
			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Description</td>'			
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'	
			SET @Body=@Body+'	<td>'+@Description+'</td>'			
			SET @Body=@Body+'	<td>'+@NoticeNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Notice of Defect Material task - IQC Step'
		END

		IF @Option='SQM'		
		BEGIN
			SET @To=''
			SET @EmailId=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email, SQM_Email_Settings_Info.ID from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID  where PLsh='201106071024460009' 
			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email,@Eid 
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@To+@Email+';'
					SET @EmailId=@EmailId+@Eid+','
					FETCH NEXT FROM User_C INTO @Email,@Eid 
				END
			CLOSE User_C
			DEALLOCATE User_C

			SET @Cc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Notice of Defect Material task - SQM Step: <br>' 
			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'			
			SET @Body=@Body+'	<td widht="20%" align="center">Description</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'	
			SET @Body=@Body+'	<td>'+@Description+'</td>'			
			SET @Body=@Body+'	<td>'+@NoticeNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Notice of Defect Material task - SQM Step'
		END
	
		IF @Option='SendPUR'		
		BEGIN
			update SQM_NoticeOfDefectMaterial set PUR_Quality='1',PUR_Quality_Userid=@Sender where taskid=@SendId 

			SET @To=''
			SET @EmailId=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
			ELSE Email end) as Email, SQM_Email_Settings_Info.ID from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID  where PLsh='201106071024460021' 
			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email,@Eid 
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@To+@Email+';'
					SET @EmailId=@EmailId+@Eid+','
					FETCH NEXT FROM User_C INTO @Email,@Eid 
				END
			CLOSE User_C
			DEALLOCATE User_C

			SET @Cc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Notice of Defect Material task - PUR Step: <br>' 
			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'			
			SET @Body=@Body+'	<td widht="20%" align="center">Description</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'	
			SET @Body=@Body+'	<td>'+@Description+'</td>'			
			SET @Body=@Body+'	<td>'+@NoticeNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Notice of Defect Material task - PUR Step'
		END

		IF @Option='SendIQC'
		BEGIN
			SET @To=''
			SET @EmailId=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email, SQM_Email_Settings_Info.ID from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where PLsh='201106071024460008' AND Plant= @Plant 
			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email,@Eid 
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@To+@Email+';'
					SET @EmailId=@EmailId+@Eid+','
					FETCH NEXT FROM User_C INTO @Email,@Eid 
				END
			CLOSE User_C
			DEALLOCATE User_C

			SET @Cc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Notice of Defect Material task - IQC Print. <br>' 
			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'			
			SET @Body=@Body+'	<td widht="20%" align="center">Description</td>'		
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'		
			SET @Body=@Body+'	<td>'+@Description+'</td>'		
			SET @Body=@Body+'	<td>'+@NoticeNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Link to print: <br>' 
			SET @Body=@Body+'<a href='+@SendUrl+'>http://hkgnt117/SQM/Form/IQA/PrintPage.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Notice of Defect Material task - IQC Print.'
		END

	    IF @Option='ReturnIQA'		
		BEGIN
			SET @To=@ReturnPeople
			SET @Cc=''
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Notice of Defect Material task - Returned to task<br>' 
			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'			
			SET @Body=@Body+'	<td widht="20%" align="center">Description</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'	
			SET @Body=@Body+'	<td>'+@Description+'</td>'				
			SET @Body=@Body+'	<td>'+@NoticeNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+ @Remark +'<br><br><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Notice of Defect Material task - Returned to task'
		END
	
	EXECUTE SQM_sp_Send_Mail @TO=@To,@Cc=@Cc,@Subject=@Subject,@Body=@Body
	
	--Insert to Inbox_Info
	IF @Option<>'SendIQC' 	
	BEGIN
	INSERT INTO SQM_Inbox_Info (SendId, SendTitle, Reportno, PN, SendUrl, Sender, Accepter,EmailId,Remark,Material)VALUES(@SendId, @SendTitle, @NoticeNo, @PN, @SendUrl, @Sender, @TO, @EmailId, @Remark, @PNType)
	END
END


































GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_ShareWithPlants_Send_Mail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--这个SP没有用了
CREATE PROCEDURE [dbo].[SQM_sp_ShareWithPlants_Send_Mail] 	
	@SendId NVARCHAR(50),	
	@PN NVARCHAR(50),
	@Sender NVARCHAR(50),
	@Vendor NVARCHAR(50),
	@Material NVARCHAR(50),
	@Plant NVARCHAR(50),
	@ReportNo NVARCHAR(50),
	@SenderName NVARCHAR(50),
	@SenderTel NVARCHAR(50),
	@SenderEmail NVARCHAR(100),
	@FilesUrl NVARCHAR(MAX) 
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Attachment NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)

	--Send Mail
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			select Email from SQM_Email_Settings_Info where PLsh='201106071024460019' --Share with plants
			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@To+@Email+';'
					FETCH NEXT FROM User_C INTO @Email
				END
			CLOSE User_C
			DEALLOCATE User_C

			SET @Cc=''
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear ALL,<br><br>'
			SET @Body=@Body+'A defect of '+@Material+' material was detected in '+@Plant+' IQC,SQM has informed Supplier to come to multek for verification. <br>'
			SET @Body=@Body+'The defect material information as below please feedback us if you have the same problems,Thanks. <br><br><br>' 
			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'			
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'			
			SET @Body=@Body+'	<td>'+@ReportNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br><br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='Share with you-Internal Quality Alert'
			SET @Attachment = @FilesUrl 
		END		

		EXECUTE SQM_sp_Send_Mail @TO=@To,@Cc=@Cc,@Subject=@Subject,@Body=@Body,@Attachment=@Attachment

END















GO

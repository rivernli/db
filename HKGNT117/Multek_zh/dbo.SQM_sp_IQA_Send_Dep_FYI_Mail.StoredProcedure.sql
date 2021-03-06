USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_IQA_Send_Dep_FYI_Mail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--
CREATE PROCEDURE [dbo].[SQM_sp_IQA_Send_Dep_FYI_Mail] 
	@ToLsh VARCHAR(MAX),	
	@PN NVARCHAR(50),
	@SendCc NVARCHAR(MAX),
	@Plant NVARCHAR(50), 
	@mId NVARCHAR(MAX),
	@SenderName NVARCHAR(50),
	@SenderTel NVARCHAR(50),
	@SenderEmail NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200) 

	--Send Mail
			SET @To='' 			
			DECLARE User_C CURSOR FOR			
			Select distinct Email from SQM_Email_Settings_Info where Plant=@Plant AND charindex(','+PLsh+',',@ToLsh) <> 0 		
			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email 
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@To+@Email+';'
					FETCH NEXT FROM User_C INTO @Email 
				END
			CLOSE User_C
			DEALLOCATE User_C
			
			SET @Cc=@SendCc 
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Notice of Defect Material task, Please pay attention: <br>' 			
			SET @Body=@Body+'P/N: '+@PN+''
			SET @Body=@Body+'<br>'
			SET @Body=@Body+'For more information, please check the following link:<br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Form/IQA/IQAPrintPage.aspx?dataId='+@mId+'>http://hkgnt117/SQM/Form/IQA/IQAPrintPage.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Notice of Defect Material task, Please pay attention'

	EXECUTE SQM_sp_Send_Mail @TO=@To,@Cc=@Cc,@Subject=@Subject,@Body=@Body
	
END 









GO

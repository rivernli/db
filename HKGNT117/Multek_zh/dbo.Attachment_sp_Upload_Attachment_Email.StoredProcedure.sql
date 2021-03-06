USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Attachment_sp_Upload_Attachment_Email]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Attachment_sp_Upload_Attachment_Email] 
    @MenuID VARCHAR(50)
AS
BEGIN	
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200) 

	--Send Mail
			SET @To=''
			DECLARE User_C CURSOR FOR
			select a.Email from Attachment_Users a LEFT JOIN Attachment_Authority b ON a.UserID=b.UserID
			LEFT JOIN Attachment_Is_Send_Email c ON c.MenuID=b.MenuID
			where b.CanSee='1' AND b.MenuID=@MenuID AND c.Istag='1'
			
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
			SET @Body=@Body+'Team,<br><br>'
			SET @Body=@Body+'The Multek global cost saving tracker report is now available on BI: ' 
			SET @Body=@Body+'<a href=http://hkgnt117/COST_SAVING_TRACKER/Login.aspx> COST SAVING TRACKER</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'Regards,'
			SET @Body=@Body+'<br>Operations'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='The Multek global cost saving tracker report is now available on BI.'

	EXECUTE Attachment_sp_Send_Mail @TO=@To,@Cc=@Cc,@Subject=@Subject,@Body=@Body

END



















GO

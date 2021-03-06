USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[E_quote_sp_Auto_TimeOutEmail]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[E_quote_sp_Auto_TimeOutEmail] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here 
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200),@title NVARCHAR(500),@id int 
	
	--截止日期发邮件通知发布人
			SET @To=''
			DECLARE User_C CURSOR FOR
			select (select Email from E_quote_Users where UserID=Initiator) as Email,subject as title, ID from E_quote_New_Purchase
			where EndDateState='0' AND convert(varchar(12),End_date,103) < CONVERT(varchar(12),getdate(),103) 

			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email,@title,@id
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@Email
					SET @title=@title 
					SET @id=@id

					SET @Cc=''
					SET @Body=''
					SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
					SET @Body=@Body+'<html>'
					SET @Body=@Body+'<body style=''font-size: 11pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
					SET @Body=@Body+'Dear Team,<br><br>'
					SET @Body=@Body+'A work task past due date: <br>' 
					
					SET @Body=@Body+'<table border="0">' 
					SET @Body=@Body+'<tr>'	
					SET @Body=@Body+'	<td align="right">Subject:</td>'
					SET @Body=@Body+'	<td align="left">'+@title+'</td>'
					SET @Body=@Body+'</tr>'

					SET @Body=@Body+'</table><br>'	
					SET @Body=@Body+'You can click here to access '			
					SET @Body=@Body+'<a href=http://hkgnt105.asia.ad.flextronics.com/equote/Login.aspx>E quote System</a>'
					SET @Body=@Body+'<br><br><br><br>'
					SET @Body=@Body+'This is an automatically e-mail, please do not reply it, Thanks a lot.'
					SET @Body=@Body+'<br><br>'
					SET @Body=@Body+'<font size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards</span></font>'
					SET @Body=@Body+'<br><font size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek E quote System</span></font></td>'
					SET @Body=@Body+'<br><br>'
					SET @Body=@Body+'</body></html>'

					SET @Subject='A work task past due date'	
					--Update
					UPDATE E_quote_New_Purchase SET EndDateState='1' WHERE ID=@id
					--Send Email
					EXECUTE E_quote_sp_Send_Mail @TO=@To,@Cc=@Cc,@Subject=@Subject,@Body=@Body

					FETCH NEXT FROM User_C INTO @Email,@title,@id
				END
			CLOSE User_C
			DEALLOCATE User_C
			
	
END 


GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[E_quote_sp_Send_Mail_Step]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[E_quote_sp_Send_Mail_Step] 
	--Add the parameters for the stored procedure here
	@Option VARCHAR(50),
	@SenderName NVARCHAR(50),
	@SenderEmail NVARCHAR(50),
	@Remark NVARCHAR(100) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here 
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@BCC NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)
	
	--Send Mail
	IF @Option='Register'		
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			select top 1 ApproverEmail as Email from E_quote_SupplierUser where Email=@SenderEmail 
			--select Email from E_quote_Users inner join E_quote_Authority on E_quote_Users.UserID=E_quote_Authority.UserID 
			--where MenuID='0000800004' AND CanSee='1' AND Administrator='0' 
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
			SET @Body=@Body+'<body style=''font-size: 11pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'Please approve a new user login to E quote System: <br>' 
			
			SET @Body=@Body+'<table border="0">' 
			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td align="right">E-mail:</td>'
			SET @Body=@Body+'	<td align="left">'+@SenderEmail+'</td>'
			SET @Body=@Body+'</tr>'

			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td align="right">Real name:</td>'
			SET @Body=@Body+'	<td align="left">'+@SenderName+'</td>'	
			SET @Body=@Body+'</tr>'	

			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td align="right">Corporate name:</td>' 			
			SET @Body=@Body+'	<td align="left">'+@Remark+'</td>'
			SET @Body=@Body+'</tr>'

			SET @Body=@Body+'</table><br>'			
			SET @Body=@Body+'You can click here to access '
			SET @Body=@Body+'<a href=http://hkgnt105.asia.ad.flextronics.com/equote/Login.aspx>E quote System</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'This is an automatically e-mail, please do not reply it, Thanks a lot.'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'<font size="3"><span lang=EN-US style="font-style:italic">Best Regards</span></font>'
			SET @Body=@Body+'<br><font size="3"><span lang=EN-US style="font-style:italic">Multek E quote System</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a new user register task'
		END 
	
	IF @Option='RegisterSuccessFully'		
		BEGIN
			SET @To=@SenderEmail 
			SET @Cc=''
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 11pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear User,<br><br>'
			SET @Body=@Body+'Password has been generated. Please use this password to login at E quote system.<br>' 
			
			SET @Body=@Body+'<table border="0">' 
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td align="right">E-mail:</td>'
			SET @Body=@Body+'	<td align="left">'+@SenderEmail+'</td>'
			SET @Body=@Body+'</tr>' 
			SET @Body=@Body+'<tr>'				
			SET @Body=@Body+'	<td align="right">Password:</td>'
			SET @Body=@Body+'	<td align="left">'+@Remark+'</td>'
			SET @Body=@Body+'</tr>'		

			SET @Body=@Body+'</table><br>'	
			SET @Body=@Body+'You can click here to access '		
			SET @Body=@Body+'<a href=http://hkgapp02.hk.multek.com:8888/equote/SupplierLogin.aspx>E quote System</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'This is an automatically e-mail, please do not reply it, Thanks a lot.'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'<font size="3"><span lang=EN-US style="font-style:italic">Best Regards</span></font>'
			SET @Body=@Body+'<br><font size="3"><span lang=EN-US style="font-style:italic">Multek E quote System</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='Password has been generated'
		END

		IF @Option='FindPassword'		
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			select top 1 ApproverEmail as Email from E_quote_SupplierUser where Email=@SenderEmail 
			--select (select Email from E_quote_Users where E_quote_Users.UserID=E_quote_Authority.UserID) as Email from E_quote_Authority where MenuID='0000800004' AND CanSee='1' AND UserID='asia\mcnwkuan' 
			--select Email from E_quote_Users inner join E_quote_Authority on E_quote_Users.UserID=E_quote_Authority.UserID 
			--where MenuID='0000800004' AND CanSee='1' AND Administrator='0' 
			
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
			SET @Body=@Body+'<body style=''font-size: 11pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'Please approve generate a new password: <br>' 
			
			SET @Body=@Body+'<table border="0">' 
			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td align="right">E-mail:</td>'
			SET @Body=@Body+'	<td align="left">'+@SenderEmail+'</td>'
			SET @Body=@Body+'</tr>'

			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td align="right">Real name:</td>'
			SET @Body=@Body+'	<td align="left">'+@SenderName+'</td>'	
			SET @Body=@Body+'</tr>'	

			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td align="right">Corporate name:</td>' 			
			SET @Body=@Body+'	<td align="left">'+@Remark+'</td>'
			SET @Body=@Body+'</tr>'

			SET @Body=@Body+'</table><br>'		
			SET @Body=@Body+'You can click here to access '	
			SET @Body=@Body+'<a href=http://hkgnt105.asia.ad.flextronics.com/equote/Login.aspx>E quote System</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'This is an automatically e-mail, please do not reply it, Thanks a lot.'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'<font size="3"><span lang=EN-US style="font-style:italic">Best Regards</span></font>'
			SET @Body=@Body+'<br><font size="3"><span lang=EN-US style="font-style:italic">Multek E quote System</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a new task'
		END

		IF @Option='PurchaseRequest'		
		BEGIN
			SET @To=''
			SET @Cc=''
			SET @BCC=@SenderEmail
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 11pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear User,<br><br>'
			SET @Body=@Body+'A new purchase information.<br>' 
			
			SET @Body=@Body+'<table border="0">' 
			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td align="right">Subject:</td>'
			SET @Body=@Body+'	<td align="left">'+@Remark+'</td>'
			SET @Body=@Body+'</tr>'		

			SET @Body=@Body+'</table><br>'		
			SET @Body=@Body+'You can click here to access '		
			SET @Body=@Body+'<a href=http://hkgapp02.hk.multek.com:8888/equote/SupplierLogin.aspx>E quote System</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'This is an automatically e-mail, please do not reply it, Thanks a lot.'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'<font size="3"><span lang=EN-US style="font-style:italic">Best Regards</span></font>'
			SET @Body=@Body+'<br><font size="3"><span lang=EN-US style="font-style:italic">Multek E quote System</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='A new purchase information'
		END
		
		IF @Option='PurchaseRequestModify'		
		BEGIN
			SET @To=''
			SET @Cc=''
			SET @BCC=@SenderEmail
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 11pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear User,<br><br>'
			SET @Body=@Body+'Purchase information has been modified.<br>' 
			
			SET @Body=@Body+'<table border="0">' 
			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td align="right">Subject:</td>'
			SET @Body=@Body+'	<td align="left">'+@Remark+'</td>'
			SET @Body=@Body+'</tr>'		

			SET @Body=@Body+'</table><br>'		
			SET @Body=@Body+'You can click here to access '		
			SET @Body=@Body+'<a href=http://hkgapp02.hk.multek.com:8888/equote/SupplierLogin.aspx>E quote System</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'This is an automatically e-mail, please do not reply it, Thanks a lot.'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'<font size="3"><span lang=EN-US style="font-style:italic">Best Regards</span></font>'
			SET @Body=@Body+'<br><font size="3"><span lang=EN-US style="font-style:italic">Multek E quote System</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='Purchase information has been modified'
		END

	EXECUTE E_quote_sp_Send_Mail @TO=@To,@Cc=@Cc,@BCC=@BCC,@Subject=@Subject,@Body=@Body
	
END 


















GO

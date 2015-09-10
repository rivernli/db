USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Send_Vendor_Mail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--这个SP没有用了
CREATE PROCEDURE [dbo].[SQM_sp_Send_Vendor_Mail]
	@GroupValue NVARCHAR(200),
		@SenderName NVARCHAR(50),
	@SenderTel NVARCHAR(50),
	@SenderEmail NVARCHAR(100)
AS
BEGIN	
	SET NOCOUNT ON;
	DECLARE @item NVARCHAR(100)

	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)

	--Send Mail	
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			--Vendor
			select distinct Email from SQM_Email_Settings_Info where PLsh=(select Lsh from SQM_Email_Settings_Info where Account=@GroupValue)
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
			SET @Body=@Body+'Dear ,<br><br>'			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="0" bordercolor="#000000" align="Left">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td> A defect of LAMINATE material was detected in B1,SQM has informed Supplier to come to multek for verification. </td>'
			SET @Body=@Body+'</tr>'	
			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'   <td> The detected material information as below please feedback us if you have any same problems,Thanks </td>'
			SET @Body=@Body+'</tr>'	
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='Share with you-Internal Quality Alert'
		END	

	EXECUTE SQM_sp_Send_Mail @TO=@To,@Cc=@Cc,@Subject=@Subject,@Body=@Body
	
END





















GO

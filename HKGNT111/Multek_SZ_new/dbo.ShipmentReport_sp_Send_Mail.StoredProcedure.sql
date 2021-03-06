USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Send_Mail]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Send_Mail] 
	-- Add the parameters for the stored procedure here
	@Option VARCHAR(100),
	@Comment VARCHAR(MAX)=NULL,
	@MenuID VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Bcc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)

	--Send Mail
	IF @Option='Weekly Operation Report'		
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT b.Email
			FROM ShipmentReport_Authority a,ShipmentReport_Users b
			WHERE a.UserID=b.UserID
				AND a.MenuID='0000300006'
				AND a.CanSee=1
				AND b.Enable=1
				AND a.UserID NOT IN ('asia\lgzjzhan','asia\hkg10369','asia\MCN00318','asia\admin_hkg10369','asia\HKGJOCHE','asia\mcn01009')
			ORDER BY b.Region,b.Email
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
			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Team,<br><br>'
			SET @Body=@Body+'The Multek global weekly report is now available on BI: ' 
			SET @Body=@Body+'<a href=http://hkgnt111.asia.ad.flextronics.com/revenuereport/>RevenueReport</a>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'Regards,'
			SET @Body=@Body+'<br>Operations'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='The Multek global weekly report is now available on BI.'
		END
	IF @Option='Engineering Evaluation File'
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT b.Email
			FROM ShipmentReport_Authority a,ShipmentReport_Users b
			WHERE a.UserID=b.UserID
				AND a.MenuID='0000300007'
				AND a.CanSee=1
				AND b.Enable=1
				AND a.UserID NOT IN ('asia\lgzjzhan','asia\hkg10369','asia\MCN00318','asia\admin_hkg10369','asia\HKGJOCHE','asia\mcn01009')
			ORDER BY b.Region,b.Email
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
			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Team,<br><br>'
			SET @Body=@Body+'The Multek global material expense for non production is now available on BI: ' 
			SET @Body=@Body+'<a href=http://hkgnt111.asia.ad.flextronics.com/revenuereport/>RevenueReport</a>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'Regards,'
			SET @Body=@Body+'<br>Operations'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='The Multek global material expense for non production is now available on BI.'
		END
	IF @Option='Baan Handly File'
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT b.Email
			FROM ShipmentReport_Authority a,ShipmentReport_Users b
			WHERE a.UserID=b.UserID
				AND a.MenuID=@MenuID
				AND a.CanSee=1
				AND b.Enable=1
				AND a.UserID NOT IN ('asia\lgzjzhan','asia\hkg10369','asia\MCN00318','asia\admin_hkg10369','asia\HKGJOCHE','asia\mcn01009')
			ORDER BY b.Region,b.Email
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
			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Team,<br><br>'
			SET @Body=@Body+'The Multek global '+@Comment+' is now available on BI: ' 
			SET @Body=@Body+'<a href=http://hkgnt111.asia.ad.flextronics.com/revenuereport/>RevenueReport</a>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'Regards,'
			SET @Body=@Body+'<br>Operations'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='The Multek global '+@Comment+' is now available on BI.'

		END
	
	IF @To=''
		BEGIN
			SET @To='JIANGUANG.ZHANG@HK.MULTEK.COM'
		END

	SET @BCC='PETER.XU@HK.MULTEK.COM;JIANGUANG.ZHANG@HK.MULTEK.COM'

	EXECUTE sp_Send_Mail @TO=@To,@Cc=@Cc,@Bcc=@Bcc,@Subject=@Subject,@Body=@Body

END
GO

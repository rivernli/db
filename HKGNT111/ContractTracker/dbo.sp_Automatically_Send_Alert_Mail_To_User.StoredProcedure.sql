USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Automatically_Send_Alert_Mail_To_User]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Automatically_Send_Alert_Mail_To_User]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @OwnerID VARCHAR(100),@UserName VARCHAR(100),@UserEmail VARCHAR(100),@ID INT,@SQLString VARCHAR(MAX),@Subject VARCHAR(300)
	CREATE TABLE #TempTable (ID INT IDENTITY(1,1),GPANo VARCHAR(50),CustomerName VARCHAR(300),ExpectedClosingDate DATE,StatusName VARCHAR(100))
	DECLARE Owner_C CURSOR FOR 
	SELECT a.OwnerID,
			(
				SELECT b.BDM FROM Users b WHERE b.UserID=a.OwnerID
			) AS UserName,
			(
				SELECT b.Email FROM Users b WHERE b.UserID=a.OwnerID
			) AS UserEmail
	FROM GPA a
	WHERE a.Closed=0
	GROUP BY a.OwnerID

	OPEN Owner_C 
	FETCH NEXT FROM Owner_C INTO @OwnerID,@UserName ,@UserEmail

	WHILE @@FETCH_STATUS=0
		BEGIN
			TRUNCATE TABLE #TempTable
			INSERT INTO #TempTable(GPANo,CustomerName,ExpectedClosingDate ,StatusName)
			SELECT GPANo,CustomerName,ExpectedClosingDate ,StatusName FROM uvwGPA WHERE OwnerID=@OwnerID AND Closed=0 AND Deleted=0 ORDER BY GPANo
			IF EXISTS(SELECT * FROM #TempTable)
				BEGIN
					SET @SQLString='<table width=900px style='+''''+'font-size: 8pt; font-family: Verdana, Times New Roman, Courier New;'+''''+'  border=0 cellpadding=2 cellspacing=2 >'
					SET @SQLString=@SQLString+'<TR align=left style='+''''+'font-size: 8pt; font-family: Verdana, Times New Roman, Courier New;background-color: navy;color: white'+''''+'><td>Contract #</td><td >Customer</td><td>Expected closure date</td><td>Status</td></tr>'
					SET @ID=1
					WHILE @ID<=(SELECT COUNT(*) FROM #TempTable)
						BEGIN
							SET @SQLString=@SQLString+'<TR>'
							SET @SQLString=@SQLString+'<td bgcolor=#F9F9F9>'+(SELECT GPANo FROM #TempTable WHERE ID=@ID) + '&nbsp;</td>'
							SET @SQLString=@SQLString+'<td bgcolor=#F9F9F9>'+(SELECT CustomerName FROM #TempTable WHERE ID=@ID) + '&nbsp;</td>'
							SET @SQLString=@SQLString+'<td bgcolor=#F9F9F9>'+(SELECT CASE WHEN ExpectedClosingDate='01/01/1900' THEN '' ELSE CONVERT(VARCHAR(10),ExpectedClosingDate,101) END FROM #TempTable WHERE ID=@ID) + '&nbsp;</td>'
							SET @SQLString=@SQLString+'<td bgcolor=#F9F9F9>'+(SELECT StatusName FROM #TempTable WHERE ID=@ID) + '&nbsp;</td>'
							SET @SQLString=@SQLString+'</TR>'
							SET @ID=@ID+1
						END
					SET @SQLString=@SQLString+'</tr>'
					SET @SQLString=@SQLString+'</table>'
					SET @SQLString='<html><body style='+''''+'font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;'+''''+'>'+
									'Dear '+ @UserName+',<br><br>This e-mail is sent as a reminder that the following contracts remain open.<br><br>'+
									@SQLString
					SET @SQLString=@SQLString+'<br>Kindly update any changes to the status of contracts accordingly – thank you.<br><br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/ContractTracker/>here</a> to access contract tracker. <br><br>Regards,<br><br>System Administration'
                    SET @SQLString=@SQLString+'</body></html>'
                    --SET @UserEmail='jianguang.zhang@hk.multek.com'
                    SET @Subject=@UserName+'s'+''''+' Contract Tracker Open Cases'
                    EXECUTE Multek_SZ_New.dbo.sp_Send_Mail @To=@UserEmail,@Body=@SQLString,@Subject=@Subject,@BCC='peter.xu@hk.multek.com;jianguang.zhang@hk.multek.com',@CC='lynn.catalano@multek.com;garry.hunt@hk.multek.com'
				END
			FETCH NEXT FROM Owner_C INTO @OwnerID,@UserName ,@UserEmail
		END

	CLOSE Owner_C
	DEALLOCATE Owner_C
END
GO

USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Automatically_Send_Alert_Mail_To_EXC]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Automatically_Send_Alert_Mail_To_EXC]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @OwnerID VARCHAR(100),@UserName VARCHAR(100),@UserEmail VARCHAR(100),@ID INT,@SQLString VARCHAR(MAX),@Subject VARCHAR(300)
	CREATE TABLE #TempTable (ID INT IDENTITY(1,1),GPANo VARCHAR(50),CustomerName VARCHAR(300),OwnerName VARCHAR(100),ExpectedClosingDate DATE,StatusName VARCHAR(100))

	TRUNCATE TABLE #TempTable
	INSERT INTO #TempTable(GPANo,CustomerName,OwnerName,ExpectedClosingDate ,StatusName)
	SELECT GPANo,CustomerName,OwnerName,ExpectedClosingDate ,StatusName FROM uvwGPA WHERE Closed=0 AND Deleted=0 ORDER BY GPANo
	IF EXISTS(SELECT * FROM #TempTable)
		BEGIN
			SET @SQLString='<table width=900px style='+''''+'font-size: 8pt; font-family: Verdana, Times New Roman, Courier New;'+''''+'  border=0 cellpadding=2 cellspacing=2 >'
			SET @SQLString=@SQLString+'<TR align=left style='+''''+'font-size: 8pt; font-family: Verdana, Times New Roman, Courier New;background-color: navy;color: white'+''''+'><td>Contract #</td><td >Customer</td><td>Contract Owner (GAM/BAM)</td><td>Expected closure date</td><td>Status</td></tr>'
			SET @ID=1
			WHILE @ID<=(SELECT COUNT(*) FROM #TempTable)
				BEGIN
					SET @SQLString=@SQLString+'<TR>'
					SET @SQLString=@SQLString+'<td bgcolor=#F9F9F9>'+(SELECT GPANo FROM #TempTable WHERE ID=@ID) + '&nbsp;</td>'
					SET @SQLString=@SQLString+'<td bgcolor=#F9F9F9>'+(SELECT CustomerName FROM #TempTable WHERE ID=@ID) + '&nbsp;</td>'
					SET @SQLString=@SQLString+'<td bgcolor=#F9F9F9>'+(SELECT OwnerName FROM #TempTable WHERE ID=@ID) + '&nbsp;</td>'
					SET @SQLString=@SQLString+'<td bgcolor=#F9F9F9>'+(SELECT CASE WHEN ExpectedClosingDate='01/01/1900' THEN '' ELSE CONVERT(VARCHAR(10),ExpectedClosingDate,101) END FROM #TempTable WHERE ID=@ID) + '&nbsp;</td>'
					SET @SQLString=@SQLString+'<td bgcolor=#F9F9F9>'+(SELECT StatusName FROM #TempTable WHERE ID=@ID) + '&nbsp;</td>'
					SET @SQLString=@SQLString+'</TR>'
					SET @ID=@ID+1
				END
			SET @SQLString=@SQLString+'</tr>'
			SET @SQLString=@SQLString+'</table>'
			SET @SQLString='<html><body style='+''''+'font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;'+''''+'>'+
							'Dear All,<br><br>This is a weekly reminder as to the status of open contracts - a brief summary is included below.  The contracts'+''''+' respective owners have been sent a reminder to update the status on the tracker accordingly.<br><br>'+
							@SQLString
			SET @SQLString=@SQLString+'<br><br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/ContractTracker/>here</a> to access contract tracker. <br><br>Regards,<br><br>System Administration'
            SET @SQLString=@SQLString+'</body></html>'
            SET @UserEmail='jianguang.zhang@hk.multek.com'
            SET @Subject='Contract Tracker Open Cases'
            EXECUTE Multek_SZ_New.dbo.sp_Send_Mail @To='werner.widmann@multek.com;lynn.catalano@multek.com;garry.hunt@hk.multek.com;vaughn.may@multek.com;tom.ingham@multek.com;Bernard.Liew@sg.flextronics.com;becky.chan@multek.com; Franck.Lize@flextronics.com',@Body=@SQLString,@Subject=@Subject,@BCC='peter.xu@hk.multek.com;jianguang.zhang@hk.multek.com'
		END
END
GO

USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[PT_fun_GetDownLoad_History]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[PT_fun_GetDownLoad_History]
(
	-- Add the parameters for the function here
	@AutoID INT
)
RETURNS VARCHAR(8000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @DownLoadHistory VARCHAR(8000),@ReceivingDownloadUserID VARCHAR(50),@ReceivingDownloadDate DATETIME
	SET @DownLoadHistory=''
	-- Add the T-SQL statements to compute the return value here
	DECLARE DownLoad_C CURSOR FOR
	SELECT b.BDM+'('+ReceivingDownloadUserID+')' AS ReceivingDownloadUserID,a.ReceivingDownloadDate
	FROM PT_Order_CheckList_Detail_DownLoad a,PT_Users b
	WHERE a.ReceivingDownloadUserID=b.UserID
		AND a.OrderCheckListDetailAutoID=@AutoID
	OPEN DownLoad_C
	FETCH NEXT FROM DownLoad_C INTO @ReceivingDownloadUserID,@ReceivingDownloadDate
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @DownLoadHistory=@DownLoadHistory+@ReceivingDownloadUserID+' '+CONVERT(VARCHAR(20),@ReceivingDownloadDate,120)+'*****'
			FETCH NEXT FROM DownLoad_C INTO @ReceivingDownloadUserID,@ReceivingDownloadDate
		END
	CLOSE DownLoad_C
	DEALLOCATE DownLoad_C
	
	SET @DownLoadHistory=ISNULL(@DownLoadHistory,'')
	IF LEN(@DownLoadHistory)>=5
		BEGIN
			SET @DownLoadHistory=LEFT(@DownLoadHistory,LEN(@DownLoadHistory)-5)
		END
	-- Return the result of the function
	RETURN (@DownLoadHistory)

END
GO

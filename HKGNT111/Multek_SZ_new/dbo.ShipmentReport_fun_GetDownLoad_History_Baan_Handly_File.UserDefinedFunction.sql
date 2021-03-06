USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_GetDownLoad_History_Baan_Handly_File]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_GetDownLoad_History_Baan_Handly_File]
(
	-- Add the parameters for the function here
	@AutoID INT
)
RETURNS VARCHAR(8000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @DownLoadHistory VARCHAR(8000),@DownloadUserID VARCHAR(50),@DownloadDate DATETIME
	SET @DownLoadHistory=''
	-- Add the T-SQL statements to compute the return value here
	DECLARE DownLoad_C CURSOR FOR
	SELECT b.BDM AS DownloadUserID,a.DownloadDate
	FROM ShipmentReport_Baan_Handly_File_Downloaded_History a, ShipmentReport_Users b
	WHERE a.DownloadUserID=b.UserID
		AND a.FileAutoID=@AutoID
	ORDER BY a.DownloadDate DESC
	OPEN DownLoad_C
	FETCH NEXT FROM DownLoad_C INTO @DownloadUserID,@DownloadDate
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @DownLoadHistory=@DownLoadHistory+@DownloadUserID+' '+CONVERT(VARCHAR(20),@DownloadDate,120)+'*****'
			FETCH NEXT FROM DownLoad_C INTO @DownloadUserID,@DownloadDate
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

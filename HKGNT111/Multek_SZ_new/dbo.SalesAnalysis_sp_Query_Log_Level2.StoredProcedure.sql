USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Query_Log_Level2]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Query_Log_Level2]
	-- Add the parameters for the stored procedure here
	@Date DATETIME,
	@UserName VARCHAR(MAX)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.* --, IDENTITY(INT, 1,1) AS ID
	--INTO #Temp
	FROM (
			SELECT a.OperatedDate AS OperatedDate ,
				   (SELECT b.BDM FROM SalesAnalysis_Users b WHERE b.UserID=a.UserID)+'('+a.UserID+')' AS UserName
			FROM SalesAnalysis_Log a
			WHERE CONVERT(VARCHAR(10),a.OperatedDate,120) =@Date
				AND a.Operation='Login'
			GROUP BY a.UserID,a.OperatedDate
		 ) a
	WHERE CHARINDEX(a.UserName,@UserName)>0
	ORDER BY a.UserName,a.OperatedDate 
	
	--SELECT * FROM #Temp
END
GO

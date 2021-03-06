USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Query_Log_Level1]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Query_Log_Level1]
	-- Add the parameters for the stored procedure here
	@DateFrom DATETIME=NULL,
	@DateTo DATETIME=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @DateFrom IS NULL
		BEGIN
			SET @DateTo=CONVERT(VARCHAR(10),GETDATE(),120)
			SET @DateFrom='1900-01-01'
		END
    
    DECLARE @Date DATETIME,@UserName VARCHAR(100),@SumUserName VARCHAR(MAX),@Amount INT
    DECLARE @Level1 TABLE (OperatedDate DATETIME,UserName VARCHAR(MAX),Amount INT)
	SELECT a.*
	INTO #Temp
	FROM (
			SELECT CONVERT(VARCHAR(10),a.OperatedDate,120) AS OperatedDate ,
				   (SELECT b.BDM FROM SalesAnalysis_Users b WHERE b.UserID=a.UserID)+'('+a.UserID+')' AS UserName
			FROM SalesAnalysis_Log a
			WHERE CONVERT(VARCHAR(10),a.OperatedDate,120) BETWEEN @DateFrom AND @DateTo
				AND a.Operation='Login'
			GROUP BY a.UserID,CONVERT(VARCHAR(10),a.OperatedDate,120)
		  ) a
	WHERE a.UserName IS NOT NULL
	ORDER BY a.OperatedDate DESC ,a.UserName
	

    DECLARE Level1_C CURSOR FOR
	SELECT * FROM #Temp
	OPEN Level1_C
	FETCH NEXT FROM Level1_C INTO @Date,@UserName
	WHILE @@FETCH_STATUS=0
		BEGIN
			IF NOT EXISTS(SELECT * FROM @Level1 WHERE OperatedDate=@Date)
				BEGIN
					SET @SumUserName=@UserName
					SET @Amount=1
					INSERT INTO @Level1 VALUES(@Date,@SumUserName,@Amount)
				END
			ELSE
				BEGIN
					SET @SumUserName=(SELECT UserName FROM @Level1 WHERE OperatedDate=@Date)+' , '+@UserName
					SET @Amount=(SELECT Amount FROM @Level1 WHERE OperatedDate=@Date)+1
					UPDATE @Level1 
					SET UserName=@SumUserName,Amount=@Amount
					WHERE OperatedDate=@Date
				END
				
			FETCH NEXT FROM Level1_C INTO @Date,@UserName
		END
	CLOSE LEvel1_C
	DEALLOCATE Level1_C
	
	SELECT * FROM @Level1
	
END
GO

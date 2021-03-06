USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Automatically_Process_DailyIncoming]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Automatically_Process_DailyIncoming]
	-- Add the parameters for the stored procedure here
	@CalculateDay INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @i INT,@Date DATETIME,@Site VARCHAR(3),@Plant VARCHAR(10),@Amount BIGINT,@SQLString VARCHAR(MAX),@DateFrom DATETIME,@DateTo DATETIME

	CREATE TABLE #Temp1 (Plant VARCHAR(50),Date DATETIME,Amount NUMERIC(19,2))
	CREATE TABLE #Temp (Plant VARCHAR(50),Date DATETIME,Amount NUMERIC(19,2))

	CREATE NONCLUSTERED INDEX [TempTypeSitePlantOEMDay] ON [#Temp] 
	(
		[Plant] ASC,[Date] ASC
	)
	CREATE NONCLUSTERED INDEX [Temp1TypeSitePlantOEMDay] ON [#Temp1] 
	(
		[Plant] ASC,[Date] ASC
	)
	
	SET @DateTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
	SET @DateFrom=CONVERT(VARCHAR(10),DATEADD(DAY,-@CalculateDay,@DateTo),120)
	TRUNCATE TABLE #Temp
	SET @Site='Chi'
	SET @Plant='B1'
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.GlobalViewReport_fun_Get_DailyIncoming(@Plant,@DateFrom,@DateTo)
	DELETE GlobalViewReport_DailyIncoming
	WHERE Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp

	TRUNCATE TABLE #Temp
	SET @Plant='B2F'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.GlobalViewReport_fun_Get_DailyIncoming(@Plant,@DateFrom,@DateTo)
	DELETE GlobalViewReport_DailyIncoming
	WHERE Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp

	TRUNCATE TABLE #Temp
	SET @Plant='B3'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.GlobalViewReport_fun_Get_DailyIncoming(@Plant,@DateFrom,@DateTo)
	DELETE GlobalViewReport_DailyIncoming
	WHERE Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp

	TRUNCATE TABLE #Temp
	SET @Plant='B4'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.GlobalViewReport_fun_Get_DailyIncoming(@Plant,@DateFrom,@DateTo)
	DELETE GlobalViewReport_DailyIncoming
	WHERE Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp

	TRUNCATE TABLE #Temp
	SET @Plant='B5'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.GlobalViewReport_fun_Get_DailyIncoming(@Plant,@DateFrom,@DateTo)
	DELETE GlobalViewReport_DailyIncoming
	WHERE Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp

	TRUNCATE TABLE #Temp
	SET @Plant='VVI'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.GlobalViewReport_fun_Get_DailyIncoming(@Plant,@DateFrom,@DateTo)
	DELETE GlobalViewReport_DailyIncoming
	WHERE Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp

	TRUNCATE TABLE #Temp
	SET @Plant='SUB'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.GlobalViewReport_fun_Get_DailyIncoming(@Plant,@DateFrom,@DateTo)
	DELETE GlobalViewReport_DailyIncoming
	WHERE Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp

	TRUNCATE TABLE #Temp
	SET @Plant='Total'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.GlobalViewReport_fun_Get_DailyIncoming(@Plant,@DateFrom,@DateTo)
	DELETE GlobalViewReport_DailyIncoming
	WHERE Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp

	DELETE #Temp1
	FROM #Temp1 a,GlobalViewReport_DailyIncoming b
	WHERE a.Plant=b.Plant
		AND a.Date=b.Day
		AND a.Amount=b.Amount

	SET @SQLString='
					INSERT INTO GlobalViewReport_DailyIncoming(Plant,Day,Amount)
					SELECT a.Plant,A.DaTE,a.Amount
					FROM #Temp1 a
					WHERE NOT EXISTS(SELECT b.* FROM GlobalViewReport_DailyIncoming b WHERE a.Plant+CONVERT(VARCHAR(10),a.Date,120)=b.Plant+CONVERT(VARCHAR(10),b.Day,120)) 

					UPDATE GlobalViewReport_DailyIncoming
					SET Amount=b.Amount
					FROM GlobalViewReport_DailyIncoming a,#Temp1 b
					WHERE a.Plant=b.Plant
						AND a.Day=b.Date
					'
	EXECUTE (@SQLString)
	
	INSERT INTO GlobalViewReport_DailyIncoming(Plant,Day,Amount)
	SELECT 'TotalEXB2F',a.Day,0 
	FROM GlobalViewReport_DailyIncoming a
	WHERE a.Plant<>'TotalEXB2F'
		AND a.Day NOT IN (SELECT b.Day FROM GlobalViewReport_DailyIncoming b WHERE b.Plant='TotalEXB2F') 
	GROUP BY a.Day

	UPDATE GlobalViewReport_DailyIncoming
	SET Amount=b.Amount-ISNULL(c.Amount,0)
	FROM GlobalViewReport_DailyIncoming a,
		(
			SELECT * FROM GlobalViewReport_DailyIncoming WHERE Plant='Total'
		) b,
		(
			SELECT * FROM GlobalViewReport_DailyIncoming WHERE Plant='B2F'
		) c	
	WHERE a.Plant='TotalEXB2F'
		AND a.Day=b.Day
		AND a.Day*=c.Day
	
END
GO

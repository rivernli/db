USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_AutomaticallyProcess_Daily]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_AutomaticallyProcess_Daily]
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(10),
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
	SET @Plant='P2'
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_Daily(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistribitionReport_Daily
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	/*
	SET @Date=@DateFrom
	WHILE @Date<=@DateTo
		BEGIN
			IF NOT EXISTS(SELECT * FROM #Temp WHERE Plant=@Plant AND Date=@Date)
				BEGIN
						INSERT INTO #Temp (Plant,Date,Amount) VALUES(@Plant,@Date,0)
				END
			SET @Date=@Date+1
		END
	*/
	TRUNCATE TABLE #Temp
	SET @Plant='2F'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_Daily(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistribitionReport_Daily
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	/*
	SET @Date=@DateFrom
	WHILE @Date<=@DateTo
		BEGIN
			IF NOT EXISTS(SELECT * FROM #Temp WHERE Plant=@Plant AND Date=@Date)
				BEGIN
						INSERT INTO #Temp (Plant,Date,Amount) VALUES(@Plant,@Date,0)
				END
			SET @Date=@Date+1
		END
	*/
	TRUNCATE TABLE #Temp
	SET @Plant='B3'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_Daily(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistribitionReport_Daily
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	/*
	SET @Date=@DateFrom
	WHILE @Date<=@DateTo
		BEGIN
			IF NOT EXISTS(SELECT * FROM #Temp WHERE Plant=@Plant AND Date=@Date)
				BEGIN
						INSERT INTO #Temp (Plant,Date,Amount) VALUES(@Plant,@Date,0)
				END
			SET @Date=@Date+1
		END
	*/
	TRUNCATE TABLE #Temp
	SET @Plant='B4'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_Daily(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistribitionReport_Daily
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	/*
	SET @Date=@DateFrom
	WHILE @Date<=@DateTo
		BEGIN
			IF NOT EXISTS(SELECT * FROM #Temp WHERE Plant=@Plant AND Date=@Date)
				BEGIN
						INSERT INTO #Temp (Plant,Date,Amount) VALUES(@Plant,@Date,0)
				END
			SET @Date=@Date+1
		END
	*/
	TRUNCATE TABLE #Temp
	SET @Plant='B5'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_Daily(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistribitionReport_Daily
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	/*
	SET @Date=@DateFrom
	WHILE @Date<=@DateTo
		BEGIN
			IF NOT EXISTS(SELECT * FROM #Temp WHERE Plant=@Plant AND Date=@Date)
				BEGIN
						INSERT INTO #Temp (Plant,Date,Amount) VALUES(@Plant,@Date,0)
				END
			SET @Date=@Date+1
		END
	*/
	TRUNCATE TABLE #Temp
	SET @Plant='HK'		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_Daily(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistribitionReport_Daily
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	/*
	SET @Date=@DateFrom
	WHILE @Date<=@DateTo
		BEGIN
			IF NOT EXISTS(SELECT * FROM #Temp WHERE Plant=@Plant AND Date=@Date)
				BEGIN
						INSERT INTO #Temp (Plant,Date,Amount) VALUES(@Plant,@Date,0)
				END
			SET @Date=@Date+1
		END
	*/
	TRUNCATE TABLE #Temp
	SET @Plant=''		
	INSERT INTO #Temp (Plant,Date,Amount)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_Daily(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistribitionReport_Daily
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	/*
	SET @Date=@DateFrom
	WHILE @Date<=@DateTo
		BEGIN
			IF NOT EXISTS(SELECT * FROM #Temp WHERE Plant=@Plant AND Date=@Date)
				BEGIN
						INSERT INTO #Temp (Plant,Date,Amount) VALUES(@Plant,@Date,0)
				END
			SET @Date=@Date+1
		END
	*/

	DELETE #Temp1
	FROM #Temp1 a,DistribitionReport_Daily b
	WHERE a.Plant=b.Plant
		AND a.Date=b.Day
		AND b.Type=@Type
		AND a.Amount=b.Amount

	SET @SQLString='
					INSERT INTO DistribitionReport_Daily(Type,Site,Plant,Day,Amount)
					SELECT '+''''+@Type+''''+'AS Type,'+''''+@Site+''''+' AS Site,a.Plant,A.DaTE,a.Amount
					FROM #Temp1 a
					WHERE NOT EXISTS(SELECT b.* FROM DistribitionReport_Daily b WHERE '+''''+@Type+''''+'+a.Plant+CONVERT(VARCHAR(10),a.Date,120)=b.Type+b.Plant+CONVERT(VARCHAR(10),b.Day,120)) 

					UPDATE DistribitionReport_Daily
					SET Amount=b.Amount
					FROM DistribitionReport_Daily a,#Temp1 b
					WHERE a.Plant=b.Plant
						AND a.Day=b.Date
						AND a.Type='+''''+@Type+''''+'
					'
	EXECUTE (@SQLString)

END
GO

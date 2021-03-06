USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_AutomaticallyProcess_DailyOEMCost]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_AutomaticallyProcess_DailyOEMCost]
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(10),
	@CalculateDay INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @j INT,@i INT,@DateFrom DATETIME,@DateTo DATETIME,@Date DATETIME,@Site VARCHAR(3),@Plant VARCHAR(10),@OEM VARCHAR(200),@RevenueAmount BIGINT,@MaterialAmount BIGINT,@MaterialPercent NUMERIC(18,2),@SQLString VARCHAR(MAX) 

	CREATE TABLE #Temp1 (AutoID INT ,Plant VARCHAR(50),Date DATETIME,OEM VARCHAR(200),RevenueAmount NUMERIC(19,2),MaterialAmount NUMERIC(19,2),MaterialPercent NUMERIC(18,2))
	CREATE TABLE #Temp (AutoID INT ,Plant VARCHAR(50),Date DATETIME,OEM VARCHAR(200),RevenueAmount NUMERIC(19,2),MaterialAmount NUMERIC(19,2),MaterialPercent NUMERIC(18,2))

	CREATE NONCLUSTERED INDEX [TempTypeSitePlantOEMDay] ON [#Temp] 
	(
		[Plant] ASC,[OEM] ASC,[Date] ASC
	)
	CREATE NONCLUSTERED INDEX [Temp1TypeSitePlantOEMDay] ON [#Temp1] 
	(
		[Plant] ASC,[OEM] ASC,[Date] ASC
	)


	SET @DateTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
	SET @DateFrom=CONVERT(VARCHAR(10),DATEADD(DAY,-@CalculateDay,@DateTo),120)
	
	TRUNCATE TABLE #Temp
	SET @Site='Chi'
	SET @Plant='P2'
	INSERT INTO #Temp (Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_DailyOEMCost(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistributionReport_Daily_OEM
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND NOT EXISTS(
						SELECT * FROM #Temp a WHERE DistributionReport_Daily_OEM.Day=a.Date AND DistributionReport_Daily_OEM.OEM=a.OEM
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
	INSERT INTO #Temp (Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_DailyOEMCost(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistributionReport_Daily_OEM
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND NOT EXISTS(
						SELECT * FROM #Temp a WHERE DistributionReport_Daily_OEM.Day=a.Date AND DistributionReport_Daily_OEM.OEM=a.OEM
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
	INSERT INTO #Temp (Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_DailyOEMCost(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistributionReport_Daily_OEM
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND NOT EXISTS(
						SELECT * FROM #Temp a WHERE DistributionReport_Daily_OEM.Day=a.Date AND DistributionReport_Daily_OEM.OEM=a.OEM
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
	INSERT INTO #Temp (Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_DailyOEMCost(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistributionReport_Daily_OEM
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND NOT EXISTS(
						SELECT * FROM #Temp a WHERE DistributionReport_Daily_OEM.Day=a.Date AND DistributionReport_Daily_OEM.OEM=a.OEM
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
	INSERT INTO #Temp (Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_DailyOEMCost(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistributionReport_Daily_OEM
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND NOT EXISTS(
						SELECT * FROM #Temp a WHERE DistributionReport_Daily_OEM.Day=a.Date AND DistributionReport_Daily_OEM.OEM=a.OEM
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
	INSERT INTO #Temp (Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_DailyOEMCost(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistributionReport_Daily_OEM
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND NOT EXISTS(
						SELECT * FROM #Temp a WHERE DistributionReport_Daily_OEM.Day=a.Date AND DistributionReport_Daily_OEM.OEM=a.OEM
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
	INSERT INTO #Temp (Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	SELECT @Plant AS Plant,* FROM dbo.DistributionReport_fun_Get_DailyOEMCost(@Type,@Site,@Plant,@DateFrom,@DateTo)
	DELETE DistributionReport_Daily_OEM
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND NOT EXISTS(
						SELECT * FROM #Temp a WHERE DistributionReport_Daily_OEM.Day=a.Date AND DistributionReport_Daily_OEM.OEM=a.OEM
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
	FROM #Temp1 a,DistributionReport_Daily_OEM b
	WHERE a.Plant=b.Plant
		AND a.OEM=b.OEM
		AND a.Date=b.Day
		AND a.RevenueAmount=b.RevenueAmount
		AND a.MaterialAmount=b.MaterialAmount
		AND a.MaterialPercent=b.MaterialPercent
		AND b.Type=@Type
		
	SET @SQLString='
					INSERT INTO DistributionReport_Daily_OEM(Type,Site,Plant,OEM,Day,RevenueAmount,MaterialAmount,MaterialPercent)
					SELECT '+''''+@Type+''''+'AS Type,'+''''+@Site+''''+' AS Site,a.Plant,a.OEM,A.DaTE,a.RevenueAmount,a.MaterialAmount,a.MaterialPercent
					FROM #Temp1 a
					WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Daily_OEM b WHERE '+''''+@Type+''''+'+a.Plant+a.OEM+CONVERT(VARCHAR(10),a.Date,120)=b.Type+b.Plant+b.OEM+CONVERT(VARCHAR(10),b.Day,120)) 

					UPDATE DistributionReport_Daily_OEM
					SET RevenueAmount=b.RevenueAmount,MaterialAmount=b.MaterialAmount,MaterialPercent=b.MaterialPercent
					FROM DistributionReport_Daily_OEM a,#Temp1 b
					WHERE a.Plant=b.Plant
						AND a.OEM=b.OEM
						AND a.Day=b.Date
						AND a.Type='+''''+@Type+''''+'
					'
					
	EXECUTE (@SQLString)

END
GO

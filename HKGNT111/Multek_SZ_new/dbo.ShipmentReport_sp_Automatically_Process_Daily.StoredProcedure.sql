USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Automatically_Process_Daily]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Automatically_Process_Daily]
	-- Add the parameters for the stored procedure here
	@CalculateDay INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @i INT,@DateFrom DATETIME,@DateTo DATETIME,@Site VARCHAR(3),@Plant VARCHAR(10),@Amount BIGINT,@SQLString VARCHAR(MAX) 

	CREATE TABLE #Temp1 (Site VARCHAR(10),Plant VARCHAR(50),Date DATETIME,Amount NUMERIC(19,2))
	CREATE TABLE #Temp (Site VARCHAR(10),Plant VARCHAR(50),Date DATETIME,Amount NUMERIC(19,2))

	CREATE NONCLUSTERED INDEX [TempTypeSitePlantOEMDay] ON [#Temp] 
	(
		[SITE] ASC,[Plant] ASC,[Date] ASC
	)
	CREATE NONCLUSTERED INDEX [Temp1TypeSitePlantOEMDay] ON [#Temp1] 
	(
		[SITE] ASC,[Plant] ASC,[Date] ASC
	)
	
	SET @DateTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
	SET @DateFrom=CONVERT(VARCHAR(10),DATEADD(DAY,-@CalculateDay,@DateTo),120)
	
	TRUNCATE TABLE #Temp
	SET @Site='Dis'
	SET @Plant=''
	INSERT INTO #Temp (Site,Plant,Date,Amount)
	SELECT * FROM dbo.ShipmentReport_fun_Get_Daily(@Site,@Plant,@DateFrom,@DateTo)
	DELETE ShipmentReport_Shipped_All_Daily
	WHERE Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	TRUNCATE TABLE #Temp
	SET @Site='Chi'
	SET @Plant=''
	INSERT INTO #Temp (Site,Plant,Date,Amount)
	SELECT * FROM dbo.ShipmentReport_fun_Get_Daily(@Site,@Plant,@DateFrom,@DateTo)
	DELETE ShipmentReport_Shipped_All_Daily
	WHERE Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	TRUNCATE TABLE #Temp
	SET @Site='Ger'
	SET @Plant=''
	INSERT INTO #Temp (Site,Plant,Date,Amount)
	SELECT * FROM dbo.ShipmentReport_fun_Get_Daily(@Site,@Plant,@DateFrom,@DateTo)
	DELETE ShipmentReport_Shipped_All_Daily
	WHERE Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	TRUNCATE TABLE #Temp
	SET @Site='Nfd'
	SET @Plant=''
	INSERT INTO #Temp (Site,Plant,Date,Amount)
	SELECT * FROM dbo.ShipmentReport_fun_Get_Daily(@Site,@Plant,@DateFrom,@DateTo)
	DELETE ShipmentReport_Shipped_All_Daily
	WHERE Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	TRUNCATE TABLE #Temp
	SET @Site='Sao'
	SET @Plant=''
	INSERT INTO #Temp (Site,Plant,Date,Amount)
	SELECT * FROM dbo.ShipmentReport_fun_Get_Daily(@Site,@Plant,@DateFrom,@DateTo)
	DELETE ShipmentReport_Shipped_All_Daily
	WHERE Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
		AND Day NOT IN (
						SELECT Date FROM #Temp GROUP BY Date
					   )
	INSERT INTO #Temp1 SELECT * FROM #Temp

	SET @SQLString='
					INSERT INTO ShipmentReport_Shipped_All_Daily(Site,Plant,Day,Amount)
					SELECT a.Site,a.Plant,A.DaTE,a.Amount
					FROM #Temp1 a
					WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Daily b WHERE a.Site+a.Plant+CONVERT(VARCHAR(10),a.Date,120)=b.Site+b.Plant+CONVERT(VARCHAR(10),b.Day,120)) 

					UPDATE ShipmentReport_Shipped_All_Daily
					SET Amount=b.Amount
					FROM ShipmentReport_Shipped_All_Daily a,#Temp1 b
					WHERE a.Plant=b.Plant
						AND a.Day=b.Date
						AND a.Site=b.Site
					'
	EXECUTE (@SQLString)


END
GO

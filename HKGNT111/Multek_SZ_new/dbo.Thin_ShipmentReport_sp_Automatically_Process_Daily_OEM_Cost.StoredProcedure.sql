USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[Thin_ShipmentReport_sp_Automatically_Process_Daily_OEM_Cost]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Thin_ShipmentReport_sp_Automatically_Process_Daily_OEM_Cost]
	-- Add the parameters for the stored procedure here
	@CalculateDay INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @j INT,@i INT,@DateFrom DATETIME,@DateTo DATETIME,@Date DATETIME,@Site VARCHAR(3),@Plant VARCHAR(10),@OEM VARCHAR(200),@RevenueAmount BIGINT,@MaterialAmount BIGINT,@MaterialPercent NUMERIC(18,2),@SQLString VARCHAR(MAX) 

	CREATE TABLE #Temp1 (Site VARCHAR(10),Plant VARCHAR(50),Date DATETIME,OEM VARCHAR(200),RevenueAmount NUMERIC(19,2),MaterialAmount NUMERIC(19,2),MaterialPercent NUMERIC(18,2))
	CREATE TABLE #Temp (Site VARCHAR(10),Plant VARCHAR(50),Date DATETIME,OEM VARCHAR(200),RevenueAmount NUMERIC(19,2),MaterialAmount NUMERIC(19,2),MaterialPercent NUMERIC(18,2))

	CREATE NONCLUSTERED INDEX [TempTypeSitePlantOEMDay] ON [#Temp] 
	(
		[Site] ASC,[Plant] ASC,[OEM] ASC,[Date] ASC
	)
	CREATE NONCLUSTERED INDEX [Temp1TypeSitePlantOEMDay] ON [#Temp1] 
	(
		[Site] ASC,[Plant] ASC,[OEM] ASC,[Date] ASC
	)


	SET @DateTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
	SET @DateFrom=CONVERT(VARCHAR(10),DATEADD(DAY,-@CalculateDay,@DateTo),120)
	

	--TRUNCATE TABLE #Temp
	--SET @Site='Dis'
	--SET @Plant=''
	--INSERT INTO #Temp (Site,Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	--SELECT * FROM dbo.ShipmentReport_fun_Get_Daily_OEM_Cost(@Site,@Plant,@DateFrom,@DateTo)
	--DELETE ShipmentReport_Shipped_All_Daily_OEM
	--FROM ShipmentReport_Shipped_All_Daily_OEM a
	--WHERE a.Site=@Site
	--	AND a.Day BETWEEN @DateFrom AND @DateTo
	--	AND NOT EXISTS (
	--						SELECT b.* FROM #Temp b WHERE b.Site=a.Site AND b.Plant=a.Plant AND b.OEM=a.OEM AND b.Date=a.Day
	--					  )
						  
	--INSERT INTO #Temp1 SELECT * FROM #Temp
	--TRUNCATE TABLE #Temp
	--SET @Site='Chi'
	--SET @Plant=''
	--INSERT INTO #Temp (Site,Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	--SELECT * FROM dbo.ShipmentReport_fun_Get_Daily_OEM_Cost(@Site,@Plant,@DateFrom,@DateTo)
	--DELETE ShipmentReport_Shipped_All_Daily_OEM
	--FROM ShipmentReport_Shipped_All_Daily_OEM a,#Temp b
	--WHERE a.Site=@Site
	--	AND a.Day BETWEEN @DateFrom AND @DateTo
	--	AND NOT EXISTS (
	--						SELECT b.* FROM #Temp b WHERE b.Site=a.Site AND b.Plant=a.Plant AND b.OEM=a.OEM AND b.Date=a.Day
	--					  )
	--INSERT INTO #Temp1 SELECT * FROM #Temp
	--TRUNCATE TABLE #Temp
	--SET @Site='Ger'
	--SET @Plant=''
	--INSERT INTO #Temp (Site,Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	--SELECT * FROM dbo.ShipmentReport_fun_Get_Daily_OEM_Cost(@Site,@Plant,@DateFrom,@DateTo)
	--DELETE ShipmentReport_Shipped_All_Daily_OEM
	--FROM ShipmentReport_Shipped_All_Daily_OEM a,#Temp b
	--WHERE a.Site=@Site
	--	AND a.Day BETWEEN @DateFrom AND @DateTo
	--	AND NOT EXISTS (
	--						SELECT b.* FROM #Temp b WHERE b.Site=a.Site AND b.Plant=a.Plant AND b.OEM=a.OEM AND b.Date=a.Day
	--					  )
	--INSERT INTO #Temp1 SELECT * FROM #Temp
	TRUNCATE TABLE #Temp
	SET @Site='Nfd'
	SET @Plant=''
	INSERT INTO #Temp (Site,Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	SELECT * FROM dbo.ShipmentReport_fun_Get_Daily_OEM_Cost(@Site,@Plant,@DateFrom,@DateTo)
	DELETE ShipmentReport_Shipped_All_Daily_OEM
	FROM ShipmentReport_Shipped_All_Daily_OEM a,#Temp b
	WHERE a.Site=@Site
		AND a.Day BETWEEN @DateFrom AND @DateTo
		AND NOT EXISTS (
							SELECT b.* FROM #Temp b WHERE b.Site=a.Site AND b.Plant=a.Plant AND b.OEM=a.OEM AND b.Date=a.Day
						  )
	INSERT INTO #Temp1 SELECT * FROM #Temp
	TRUNCATE TABLE #Temp
	SET @Site='Sao'
	SET @Plant=''
	INSERT INTO #Temp (Site,Plant,Date,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
	SELECT * FROM dbo.ShipmentReport_fun_Get_Daily_OEM_Cost(@Site,@Plant,@DateFrom,@DateTo)
	DELETE ShipmentReport_Shipped_All_Daily_OEM
	FROM ShipmentReport_Shipped_All_Daily_OEM a,#Temp b
	WHERE a.Site=@Site
		AND a.Day BETWEEN @DateFrom AND @DateTo
		AND NOT EXISTS (
							SELECT b.* FROM #Temp b WHERE b.Site=a.Site AND b.Plant=a.Plant AND b.OEM=a.OEM AND b.Date=a.Day
						  )
	INSERT INTO #Temp1 SELECT * FROM #Temp

	SET @SQLString='
					SELECT a.Site,a.Plant,a.Date,a.OEM,a.RevenueAmount,a.MaterialAmount,a.MaterialPercent
					INTO #Temp2
					FROM #Temp1 a
					WHERE EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Daily_OEM b WHERE a.Site+a.Plant+a.OEM+CONVERT(VARCHAR(10),a.Date,120)=b.Site+b.Plant+b.OEM+CONVERT(VARCHAR(10),b.Day,120)) 
					INSERT INTO ShipmentReport_Shipped_All_Daily_OEM(Site,Plant,Day,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
					SELECT a.Site,a.Plant,a.Date,a.OEM,a.RevenueAmount,a.MaterialAmount,a.MaterialPercent
					FROM #Temp1 a
					WHERE NOT EXISTS(SELECT b.* FROM #Temp2 b WHERE a.Site+a.Plant+a.OEM+CONVERT(VARCHAR(10),a.Date,120)=b.Site+b.Plant+b.OEM+CONVERT(VARCHAR(10),b.Date,120)) 
					/*
					INSERT INTO ShipmentReport_Shipped_All_Daily_OEM(Site,Plant,Day,OEM,RevenueAmount,MaterialAmount,MaterialPercent)
					SELECT a.Site,a.Plant,a.Date,a.OEM,a.RevenueAmount,a.MaterialAmount,a.MaterialPercent
					FROM #Temp1 a
					WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Daily_OEM b WHERE a.Site+a.Plant+a.OEM+CONVERT(VARCHAR(10),a.Date,120)=b.Site+b.Plant+b.OEM+CONVERT(VARCHAR(10),b.Day,120)) 
					*/
					UPDATE ShipmentReport_Shipped_All_Daily_OEM
					SET RevenueAmount=b.RevenueAmount,
						MaterialAmount=b.MaterialAmount,
						MaterialPercent=b.MaterialPercent
					FROM ShipmentReport_Shipped_All_Daily_OEM a,#Temp1 b
					WHERE a.Site=b.Site
						AND a.Plant=b.Plant
						AND a.OEM=b.OEM
						AND a.Day=b.Date
					'
	EXECUTE (@SQLString)
					
END
GO

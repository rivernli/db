USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[PurchaseTrend_Query_Testing]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PurchaseTrend_Query_Testing]
	@Issue_batchNo			NVARCHAR(20),
	@Forecast_YearFROM		NVARCHAR(5),
	@Forecast_YearTo		NVARCHAR(5),
	@Forecast_PeriodFROM	NVARCHAR(5),
	@Forecast_PeriodTo		NVARCHAR(5),
	@Item_Group_FROM		NVARCHAR(5),
	@Item_Group_To			NVARCHAR(5),
	@Vendor_FROM			NVARCHAR(5),
	@Vendor_To				NVARCHAR(5),
	@Plant_FROM				NVARCHAR(5),
	@Plant_To				NVARCHAR(5)
AS
BEGIN
	SET NOCOUNT ON;
--****************************** Valiable declaration section ***************************
--declaration
	DECLARE @Temp_Fyear		INT
	DECLARE @Temp_Period	INT
	DECLARE @Period_Count	INT
	DECLARE @sqlString		NVARCHAR(500)

--****************************** field section ******************************************
-- Condition data check
	SET @Issue_batchNo =		ISNULL(@Issue_batchNo,'')
	SET @Forecast_YearFROM =	ISNULL(@Forecast_YearFROM,'')
	SET @Forecast_YearTo =		ISNULL(@Forecast_YearTo,'')
	SET @Forecast_PeriodFROM =	ISNULL(@Forecast_PeriodFROM,'')
	SET @Forecast_PeriodTo =	ISNULL(@Forecast_PeriodTo,'')
	SET @Item_Group_FROM =		ISNULL(@Item_Group_FROM,'')
	SET @Item_Group_To =		ISNULL(@Item_Group_To,'')
	SET @Vendor_FROM =			ISNULL(@Vendor_FROM,'')
	SET @Vendor_To =			ISNULL(@Vendor_To,'')
	SET @Plant_FROM =			ISNULL(@Plant_FROM,'')
	SET @Plant_To =				ISNULL(@Plant_To,'')

	IF @Forecast_YearFROM > @Forecast_YearTo
		BEGIN
			RAISERROR('Base On Range Error !',16,1)
			RETURN
		END

	IF @Forecast_YearFROM = @Forecast_YearTo AND cast(@Forecast_PeriodFROM as int)> cast(@Forecast_PeriodTo as int)
		BEGIN
			RAISERROR('Base On Range Error !',16,1)
			RETURN
		END

	IF @Forecast_YearFROM = '' or @Forecast_YearFROM = '0' or @Forecast_YearFROM is null OR @Forecast_YearTo = '' or @Forecast_YearTo = '0' or @Forecast_YearTo is null
		BEGIN
			RAISERROR('Year cannot be empty!',16,1)
			RETURN
		END

	IF @Forecast_PeriodFROM = '' OR @Forecast_PeriodFROM = '0' OR @Forecast_PeriodFROM IS NULL or @Forecast_PeriodTo = '' OR @Forecast_PeriodTo = '0' OR @Forecast_PeriodTo IS NULL
		BEGIN
			RAISERROR('Period cannot be empty!',16,1)
			RETURN
		END		

	IF @Item_Group_To IS NULL OR @Item_Group_To = ''
		SET @Item_Group_To = 'ZZZZZZ'

	IF @Vendor_To IS NULL OR @Vendor_To = ''
		SET @Vendor_To = 'ZZZZZZ'

	IF @Plant_To IS NULL OR @Plant_To = ''
		SET @Plant_To = 'ZZ'

--Get Period Number
	SET @Temp_Fyear	=	CAST(@Forecast_YearFROM AS INT)
	SET @Temp_Period =	CAST(@Forecast_PeriodFROM AS INT)
	SET @Period_Count = 1

	WHILE @Temp_Fyear <> @Forecast_YearTo OR @Temp_Period <> @Forecast_PeriodTo
		BEGIN
			IF @Temp_Period >= 12 
				BEGIN
					SET @Temp_Fyear = @Temp_Fyear + 1
					SET @Temp_Period = 1
				END
			ELSE
				BEGIN
					SET @Temp_Fyear = @Temp_Fyear
					SET @Temp_Period = @Temp_Period + 1
				END
			SET @Period_Count = @Period_Count + 1
		END
		--IF @Period_Count = 0 
		--SET @Period_Count = @Period_Count + 1

--|******************* TABLE declaration section **************************************
	-- Get Data to temp TABLE 
	IF exists(SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'tempdb..#TFSPUR033180') AND TYPE = 'U')
		DROP TABLE #TFSPUR033180
	
	SELECT * INTO #TFSPUR033180 FROM dbo.TFSPUR033180 WHERE t$sern = @Issue_batchNo
	IF not exists(SELECT TOP 1 * FROM #TFSPUR033180)
		BEGIN
			RAISERROR('Batch# not found in issue history!',16,1)
			RETURN
		END

	-- UPDATE table dbo.TFSPUR034180 to temp table , & UPDATE plant P2 to B1
	IF exists(SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'tempdb..#TFSPUR034180_temp') AND TYPE = 'U')
		DROP TABLE #TFSPUR034180_temp
	SELECT * INTO #TFSPUR034180_temp FROM dbo.TFSPUR034180 
	WHERE t$sern = @Issue_batchNo 
	AND	  t$suno BETWEEN @Vendor_FROM AND @Vendor_To
	AND	  rtrim(ltrim(t$citg)) BETWEEN @Item_Group_FROM AND @Item_Group_To

	UPDATE #TFSPUR034180_temp set t$plnt = 'B1' WHERE t$plnt = 'P2'

	IF exists(SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'tempdb..#TFSPUR034180') AND TYPE = 'U')
		DROP TABLE #TFSPUR034180
	SELECT * INTO #TFSPUR034180 FROM #TFSPUR034180_temp WHERE #TFSPUR034180_temp.t$plnt BETWEEN @Plant_FROM AND @Plant_To

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb..#TFSPUR035180') AND TYPE = 'U')
		DROP TABLE #TFSPUR035180
	SELECT * INTO #TFSPUR035180 FROM dbo.TFSPUR035180

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb..#TTCCOM020180') AND TYPE = 'U')
		DROP TABLE #TTCCOM020180
	SELECT * INTO #TTCCOM020180 FROM dbo.TTCCOM020180

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb..#TTCMCS023180') AND TYPE = 'U')
		DROP TABLE #TTCMCS023180
	SELECT * INTO #TTCMCS023180 FROM dbo.TTCMCS023180

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb..#TTDPUR_PRODUCTION_OUTPUT') AND TYPE = 'U')
		DROP TABLE #TTDPUR_PRODUCTION_OUTPUT
	SELECT * INTO #TTDPUR_PRODUCTION_OUTPUT FROM dbo.TTDPUR_PRODUCTION_OUTPUT

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb..#TTDPUROTHERS') AND TYPE = 'U')
		DROP TABLE #TTDPUROTHERS
	SELECT * INTO #TTDPUROTHERS FROM dbo.TTDPUROTHERS

--****************************** function section ******************************
--FUNCTIONS:
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb..#PURCHASETREND') AND TYPE = 'U')
		DROP TABLE #PURCHASETREND

	SELECT A.t$year,A.t$prod,A.t$item,B.t$dsca,a.t$citg,
		SUM(t$iqty) as t$iqty,
		SUM(A.t$pric * A.t$iqty) as Amount_Base_Last,
		SUM(A.t$cprc * A.t$iqty) as Amount_Base_Curr,
		CAST(SUM(A.t$pric * A.t$iqty)-SUM(A.t$cprc * A.t$iqty) AS DECIMAL(18,0)) as Saving
	INTO #PURCHASETREND
	FROM #TFSPUR034180 AS A LEFT JOIN #TTCMCS023180 AS B ON A.t$citg = B.t$citg
	GROUP BY A.t$year,A.t$prod,A.t$item,B.t$dsca,a.t$citg
	ORDER BY A.t$year,A.t$prod,A.t$item,B.t$dsca,a.t$citg

	--GET Forecast Quanlity
	ALTER TABLE #PURCHASETREND ADD t$fqty INT

	UPDATE #PURCHASETREND SET t$fqty = (SELECT B.t$fqty FROM #TFSPUR035180 as B WHERE B.t$year = t$year AND B.t$prod = t$prod and B.t$item = t$item)

	SELECT * FROM #PURCHASETREND

--	SELECT t$year,t$prod,t$dsca,t$citg,
--		CAST(SUM(Amount_Base_Last)/1000 AS DECIMAL(18,0)) AS Amount_Base_Last,
--		CAST(SUM(Amount_Base_Curr)/1000 AS DECIMAL(18,0)) AS Amount_Base_Curr,
--		CAST((SUM(Amount_Base_Last)  - SUM(Amount_Base_Curr))/1000  AS DECIMAL(18,0)) AS Saving,
--		CAST(((SUM(Amount_Base_Last) - SUM(Amount_Base_Curr)) / SUM(Amount_Base_Last))  AS DECIMAL(18,4))*100 AS SavingPercent
--	FROM #PURCHASETREND
--	GROUP BY t$year,t$prod,t$dsca,t$citg
--	ORDER BY t$citg
END


GO

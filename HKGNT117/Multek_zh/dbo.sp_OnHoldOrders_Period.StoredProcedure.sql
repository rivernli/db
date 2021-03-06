USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_Period]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_Period] 
	@FisYear	VARCHAR(20),
	@From		VARCHAR(30),
	@Type		VARCHAR(50),
	@Plant		VARCHAR(10),
	@kusd		BIT=1
AS
BEGIN

	SET NOCOUNT ON;

	--
	DECLARE @FILS VARCHAR(MAX)
	DECLARE @SQL VARCHAR(MAX)
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)

	IF OBJECT_ID(N'tempdb.dbo.#TEMPAB','U') IS NOT NULL
		DROP TABLE #TEMPAB
		
	SELECT @CurrentFiscalYear=CONVERT(VARCHAR,FiscalYear),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM vw_Calendar_A
	WHERE DATEDIFF(DAY,CalenderDate,GETDATE())=0

	---
	SELECT
		FiscalPeriodDesc
		,REPLACE(DPAT,'FIN','Payment past due') AS DPAT
		,OHTP
		,SALM
		,CSMA
		,CUST
		,OEMA
		,PLNT
		,FLAG
		,AMNT
	INTO #TEMPAB
	FROM
	(SELECT
		(b.FiscalPeriodDesc+b.FiscalYearDesc) AS FiscalPeriodDesc,
		a.T$DPAT AS DPAT,
		(CASE
			WHEN a.T$SFLG=1 THEN 'production'
			WHEN a.T$SSTA=1 THEN 'shipment'
			ELSE ''
		END) AS OHTP,
		a.T$SALM AS SALM,
		a.T$CSMA AS CSMA,
		a.T$CUST AS CUST,
		a.T$OEMA AS OEMA,
		a.T$PLNT AS PLNT,
		a.T$FLAG AS FLAG,
		a.T$AMNT AS AMNT
	FROM (SELECT * FROM dbo.vw_OnHoldOrders_TFSOLP120180 WHERE DATEDIFF(DAY,T$OHDT,GETDATE())>=0) a
	RIGHT JOIN dbo.vw_Calendar_A b ON a.T$OHDT=b.calenderDate
	WHERE b.FiscalYearDesc=@FisYear) A
	--WHERE a.[T$OHDT] = @RptDate) A 
	--WHERE a.T$DATE = @RptDate - 1) A 
	
	IF @From<>''
		DELETE FROM #TEMPAB WHERE DPAT<>@From
		
	IF @Type<>''
		DELETE FROM #TEMPAB WHERE OHTP<>@Type
	
	IF @Plant<>''
		DELETE FROM #TEMPAB WHERE PLNT<>@Plant
	--;
	--WITH AGDP AS(
	--	SELECT DISTINCT AGING FROM #TEMPAB
	--)
	--SELECT @FILS=ISNULL(@FILS+',','')+'['+AGING+']' FROM (SELECT AGING FROM AGDP) A ORDER BY AGING
	
	-- release & cancel
	SELECT
		FiscalPeriodDesc
		--DPAT
		--,OHTP
		--,SALM
		--,CSMA
		--,CUST
		--,OEMA
		--,PLNT
		,FLAG
		,(CASE @kusd
			WHEN 1 THEN ROUND(SUM(AMNT)*1.000/1000,3) --ROUND(SUM(AMNT)/1000,0), CHANGED BY ABILL @2012.2.3
			ELSE SUM(AMNT)
		END) AS AMNT
	INTO #TEMPABC
	FROM #TEMPAB
	GROUP BY FiscalPeriodDesc,FLAG
	--GROUP BY DPAT,OHTP,SALM,CSMA,CUST,OEMA,PLNT,FLAG
	
		
	SET @SQL='
		SELECT
			A.FiscalPeriodDesc
			,ISNULL(A.[On Hold],0) AS [OnHold]
			,ISNULL(A.[Release],0) AS Release
			,ISNULL(A.[Order Cancel],0) AS Cancel
			,B.GAMNT
		FROM 
		(SELECT
			FiscalPeriodDesc
			,[On Hold]
			,Release
			,[Order Cancel]
			FROM #TEMPABC
		PIVOT (
			SUM(AMNT) FOR FLAG IN ([On Hold],Release,[Order Cancel])
		) P) A,
		(SELECT
			[FiscalPeriodDesc]
			,SUM(AMNT) AS GAMNT
			FROM #TEMPABC
			GROUP BY FiscalPeriodDesc) B
		WHERE A.[FiscalPeriodDesc]=B.[FiscalPeriodDesc]
		ORDER BY
			A.[FiscalPeriodDesc] DESC
	'
--PRINT @SQL
	EXEC(@SQL)
END





GO

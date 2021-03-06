USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_Daily]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_Daily] 
	@RptDate	DATETIME,
	@Period		VARCHAR(10),
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
		FiscalYear,
		FiscalPeriod
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
		ISNULL(b.FiscalYear,2999) AS FiscalYear,
		ISNULL(b.FiscalPeriod,12) AS FiscalPeriod,
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
	FROM dbo.vw_OnHoldOrders_TFSOLP120180 a
	LEFT JOIN dbo.vw_Calendar_A b ON a.T$DDTA=b.calenderDate
	WHERE a.[T$OHDT] = @RptDate) A 
	--WHERE a.T$DATE = @RptDate - 1) A 

	IF @Period='current'
		DELETE FROM #TEMPAB WHERE DATEDIFF(MONTH,
											CONVERT(DATETIME,@CurrentFiscalYear+'-'+@CurrentFiscalPeriod+'-01'),
											CONVERT(DATETIME,CONVERT(VARCHAR,FiscalYear)+'-'+CONVERT(VARCHAR,FiscalPeriod)+'-01'))>0
	IF @Period='next'
		DELETE FROM #TEMPAB WHERE DATEDIFF(MONTH,
											CONVERT(DATETIME,@CurrentFiscalYear+'-'+@CurrentFiscalPeriod+'-01'),
											CONVERT(DATETIME,CONVERT(VARCHAR,FiscalYear)+'-'+CONVERT(VARCHAR,FiscalPeriod)+'-01'))<>1
	IF @Period='third'
		DELETE FROM #TEMPAB WHERE DATEDIFF(MONTH,
											CONVERT(DATETIME,@CurrentFiscalYear+'-'+@CurrentFiscalPeriod+'-01'),
											CONVERT(DATETIME,CONVERT(VARCHAR,FiscalYear)+'-'+CONVERT(VARCHAR,FiscalPeriod)+'-01'))<>2
	IF @Period='future'
		DELETE FROM #TEMPAB WHERE DATEDIFF(MONTH,
											CONVERT(DATETIME,@CurrentFiscalYear+'-'+@CurrentFiscalPeriod+'-01'),
											CONVERT(DATETIME,CONVERT(VARCHAR,FiscalYear)+'-'+CONVERT(VARCHAR,FiscalPeriod)+'-01'))<4
	
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
		DPAT
		,OHTP
		,SALM
		,CSMA
		,CUST
		,OEMA
		,PLNT
		,FLAG
		,(CASE @kusd
			WHEN 1 THEN ROUND(SUM(AMNT)*1.000/1000,3) --ROUND(SUM(AMNT)/1000,0), changed by abill @2012.2.3
			ELSE SUM(AMNT)
		END) AS AMNT
	INTO #TEMPABC
	FROM #TEMPAB
	GROUP BY DPAT,OHTP,SALM,CSMA,CUST,OEMA,PLNT,FLAG
	
		
	SET @SQL='
		SELECT
			A.DPAT
			,A.OHTP
			,A.SALM
			,A.CSMA
			,A.CUST
			,A.OEMA
			,A.PLNT
			,ISNULL(A.[On Hold],0) AS [OnHold]
			,ISNULL(A.[Release],0) AS Release
			,ISNULL(A.[Order Cancel],0) AS Cancel
			,B.GAMNT
		FROM 
		(SELECT
			DPAT
			,OHTP
			,SALM
			,CSMA
			,CUST
			,OEMA
			,PLNT
			,[On Hold]
			,Release
			,[Order Cancel]
			FROM #TEMPABC
		PIVOT (
			SUM(AMNT) FOR FLAG IN ([On Hold],Release,[Order Cancel])
		) P) A,
		(SELECT DPAT
			,OHTP
			,SALM
			,CSMA
			,CUST
			,OEMA
			,PLNT
			,SUM(AMNT) AS GAMNT
			FROM #TEMPABC
			GROUP BY DPAT,OHTP,SALM,CSMA,CUST,OEMA,PLNT) B
		WHERE A.DPAT=B.DPAT AND A.OHTP=B.OHTP AND A.SALM=B.SALM AND A.CSMA=B.CSMA AND A.CUST=B.CUST AND A.OEMA=B.OEMA AND A.PLNT=B.PLNT
		ORDER BY
			A.DPAT
			,A.OHTP
			,A.SALM
			,A.CSMA
			,A.CUST
			,A.OEMA
			,A.PLNT
	'
--PRINT @SQL
	EXEC(@SQL)
END





GO

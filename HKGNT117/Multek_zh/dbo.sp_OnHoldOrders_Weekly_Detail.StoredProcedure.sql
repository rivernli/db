USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_Weekly_Detail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_Weekly_Detail] 
	@FisYear	VARCHAR(20),
	@From		VARCHAR(30),
	@Type		VARCHAR(50),
	@Plant		VARCHAR(10),
	@Aging		VARCHAR(10),
	@Week		VARCHAR(2)

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
		*
	INTO #TEMPAB
	FROM
	(SELECT
		--ISNULL(b.FiscalYear,2999) AS FiscalYear,
		--ISNULL(b.FiscalPeriod,12) AS FiscalPeriod,
		RIGHT(RTRIM(b.FiscalWeekDesc),3)+'FY'+RIGHT(RTRIM(b.FiscalYearDesc),2) AS [Week],
		a.*,
		(CASE
			WHEN a.T$SFLG=1 THEN 'production'
			WHEN a.T$SSTA=1 THEN 'shipment'
			ELSE ''
		END) AS OHTP
	FROM (SELECT * FROM dbo.vw_OnHoldOrders_TFSOLP120180 WHERE DATEDIFF(DAY,T$OHDT,GETDATE())>=0) a
	RIGHT JOIN dbo.vw_Calendar_A b ON a.T$OHDT=b.calenderDate
	WHERE b.FiscalYearDesc=@FisYear
	AND b.FiscalWeek=@Week ) A
	--WHERE a.[T$OHDT] = @RptDate) A 
	--WHERE a.T$DATE = @RptDate - 1) A 
	
	IF @From<>''
		DELETE FROM #TEMPAB WHERE T$DPAT<>@From
		
	IF @Type<>''
		DELETE FROM #TEMPAB WHERE OHTP<>@Type
	
	IF @Plant<>''
		DELETE FROM #TEMPAB WHERE T$PLNT<>@Plant
		
	IF @Aging='ON'
		DELETE FROM #TEMPAB WHERE T$FLAG<>'On Hold'
	IF @Aging='RE'
		DELETE FROM #TEMPAB WHERE T$FLAG<>'Release'
	IF @Aging='CA'
		DELETE FROM #TEMPAB WHERE T$FLAG<>'Order Cancel'
	--;
	--WITH AGDP AS(
	--	SELECT DISTINCT AGING FROM #TEMPAB
	--)
	--SELECT @FILS=ISNULL(@FILS+',','')+'['+AGING+']' FROM (SELECT AGING FROM AGDP) A ORDER BY AGING
	
	SELECT
		T$OEMA AS OEM,
		T$ITEM AS PROJ,
		T$PLNT AS PLNT,
		SUM(T$AMNT) AS AMNT
	FROM #TEMPAB
	WHERE ISNULL(T$OEMA,'')<>''
	GROUP BY T$OEMA,T$ITEM,T$PLNT
	ORDER BY T$OEMA,T$ITEM,T$PLNT
	
END





GO

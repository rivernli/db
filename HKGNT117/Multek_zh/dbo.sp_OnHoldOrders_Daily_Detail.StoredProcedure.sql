USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_Daily_Detail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_Daily_Detail] 
	@RptDate	DATETIME,
	@Period		VARCHAR(10),
	@From		VARCHAR(30),
	@Type		VARCHAR(50),
	@Sales		VARCHAR(100),
	@Cust		VARCHAR(200),
	@OEM		VARCHAR(100),
	@Plant		VARCHAR(10),
	@aging		VARCHAR(10)
AS
BEGIN

	SET NOCOUNT ON;
	
	SET @From=REPLACE(@From,'Payment past due','FIN')

	--
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
		a.*,
		ISNULL(b.FiscalYear,2999) AS FiscalYear,
		ISNULL(b.FiscalPeriod,12) AS FiscalPeriod,
		(CASE
			WHEN a.T$SFLG=1 THEN 'production'
			WHEN a.T$SSTA=1 THEN 'shipment'
			ELSE ''
		END) AS OHTP
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
		DELETE FROM #TEMPAB WHERE T$DPAT<>@From
		
	IF @Type<>''
		DELETE FROM #TEMPAB WHERE OHTP<>@Type
		
	IF @Sales<>''
		DELETE FROM #TEMPAB WHERE T$SALM<>@Sales
		
	IF @Cust<>''
		DELETE FROM #TEMPAB WHERE T$CUST<>@Cust
		
	IF @OEM<>''
		DELETE FROM #TEMPAB WHERE T$OEMA<>@OEM
	
	IF @Plant<>''
		DELETE FROM #TEMPAB WHERE T$PLNT<>@Plant
		
	IF @aging='ON'
		DELETE FROM #TEMPAB WHERE T$FLAG<>'On Hold'
	ELSE IF @aging='RE'
		DELETE FROM #TEMPAB WHERE T$FLAG<>'Release'
	ELSE IF @aging='CA'
		DELETE FROM #TEMPAB WHERE T$FLAG<>'Order Cancel'

	--ELSE --'GT'
	--	DELETE FROM #TEMPAB WHERE AGING<>@aging
	
--SELECT SUM(T$AMNT) FROM #TEMPAB

	SELECT
		T$OEMA AS OEM,
		T$ITEM AS PROJ,
		T$PLNT AS PLNT,
		SUM(T$AMNT) AS AMNT
	FROM #TEMPAB
	GROUP BY T$OEMA,T$ITEM,T$PLNT
	ORDER BY T$OEMA,T$ITEM,T$PLNT
	
END




GO

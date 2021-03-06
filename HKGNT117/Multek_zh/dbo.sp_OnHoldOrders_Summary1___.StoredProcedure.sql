USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_Summary1___]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_Summary1___] 
	@CalDate	DATETIME,
	@kusd		BIT=1
AS
BEGIN

	SET NOCOUNT ON;

	--
	SELECT
	T$PLNT AS PLANT,
	AGING,
	T$DPAT AS DEPT,
	(AGING+'-'+T$DPAT) AS AA,
	(CASE @kusd
		WHEN 1 THEN ROUND(SUM(T$AMNT)/1000,0)
		ELSE SUM(T$AMNT)
	END) AS AMT
	--INTO #TEMP
	FROM (SELECT *,
	(CASE
		WHEN DATEDIFF(DAY,T$OHDT,@CalDate)<=30 THEN 'A1' --within 1 month
		WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 30 AND 60 THEN 'A2' -- 1-2 months
		WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 60 AND 180 THEN 'A3' -- 2-6 months
		WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 180 AND 360 THEN 'A4' -- 6-12 months
		ELSE 'A5' -- over 1 year
	END) AS AGING FROM TFSOLP120180) A
	WHERE T$DATE<=@CalDate
	GROUP BY T$PLNT,AGING,T$DPAT
	ORDER BY T$PLNT,AGING,T$DPAT

--SELECT * FROM #TEMP

--DECLARE @FIELDS VARCHAR(MAX)
--SELECT @FIELDS=ISNULL(@FIELDS+',','')+'['+AA+']' FROM (SELECT DISTINCT AA FROM #TEMP) B
--EXEC('SELECT PLANT,AGING,DEPT,'+@FIELDS+' FROM #TEMP PIVOT (SUM(AMT) FOR AA IN ('+@FIELDS+')) AS PVT')
	--
	--
	-- count on-hold-shipment
	SELECT
	T$DPAT AS DEPT,
	[TYPE],
	(CASE @kusd
		WHEN 1 THEN ROUND(SUM(T$AMNT)/1000,0)
		ELSE SUM(T$AMNT)
	END) AS AMT
	FROM (SELECT *,
		(CASE
			WHEN T$SSTA=1 THEN 'Oh hold shipment'
			WHEN T$SFLG=1 THEN 'Oh hold production'
			ELSE ''
		END) AS [TYPE] FROM TFSOLP120180) A
	WHERE T$DATE<=@CalDate AND (T$SSTA=1 OR T$SFLG=1)
	GROUP BY T$DPAT,[TYPE]
	ORDER BY T$DPAT
END


GO

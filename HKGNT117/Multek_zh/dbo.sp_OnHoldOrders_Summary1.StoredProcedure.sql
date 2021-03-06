USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_Summary1]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_Summary1] 
	@RptDate	DATETIME,
	@kusd		BIT=1
AS
BEGIN

	SET NOCOUNT ON;

	--
	DECLARE @FILS VARCHAR(MAX)
	DECLARE @SQL VARCHAR(MAX)

	IF OBJECT_ID(N'tempdb.dbo.#TEMPAB','U') IS NOT NULL
		DROP TABLE #TEMPAB

	---
	SELECT PLNT,(AGING+'-'+DPAT) AS AGDP,AMNT
	INTO #TEMPAB
	FROM
		(SELECT
			(CASE
				WHEN GROUPING(PLNT)=1 THEN 'ZZZ'
				ELSE PLNT END) AS PLNT,
			(CASE
				WHEN GROUPING(AGING)=1 THEN 'ZZZ'
				ELSE AGING END) AS AGING,
			(CASE
				WHEN GROUPING(DPAT)=1 THEN 'ZZZ'
				ELSE DPAT END) AS DPAT,
			(CASE @kusd
				WHEN 1 THEN ROUND(SUM(AMNT)*1.000/1000,3)	--ROUND(SUM(AMNT)/1000,0)/ changed by abill @2012.2.3
				ELSE SUM(AMNT)
			END) AS AMNT
		FROM
		(SELECT
			T$PLNT AS PLNT,
			(CASE
				WHEN DATEDIFF(DAY,T$OHDT,@RptDate) <= 30 THEN 'A1'
				WHEN DATEDIFF(DAY,T$OHDT,@RptDate) BETWEEN 30 AND 60 THEN 'A2'
				WHEN DATEDIFF(DAY,T$OHDT,@RptDate) BETWEEN 60 AND 180 THEN 'A3'
				WHEN DATEDIFF(DAY,T$OHDT,@RptDate) BETWEEN 180 AND 360 THEN 'A4'
				ELSE 'A5'
			END) AS AGING,
			T$DPAT AS DPAT,
			T$AMNT AS AMNT
		--FROM TFSOLP120180 WHERE T$DATE <= @RptDate) A   -- original 2011-08-08
		FROM TFSOLP120180 WHERE T$DATE = @RptDate - 1) A   -- add 2011-08-08 by rivern
		GROUP BY PLNT,AGING,DPAT WITH ROLLUP) B
	ORDER BY PLNT,AGING,DPAT
	;
	WITH AGDP AS(
		SELECT DISTINCT AGDP FROM #TEMPAB
	)
	SELECT @FILS=ISNULL(@FILS+',','')+'['+AGDP+']' FROM (SELECT AGDP FROM AGDP) A ORDER BY AGDP
	SET @SQL='
		SELECT PLNT,'+@FILS+'
		FROM #TEMPAB
		PIVOT (
			SUM(AMNT) FOR AGDP IN ('+@FILS+')
		) P
		WHERE PLNT<>''ZZZ''
		ORDER BY PLNT
	'
--PRINT @SQL
	EXEC(@SQL)
	
	DECLARE @C INT
	SELECT @C=COUNT(*) FROM #TEMPAB
	IF @C=0
		SELECT 'Sorry, there is no data to display.',0

	--
	--
	-- count on-hold-shipment
	SELECT
	T$DPAT AS DEPT,
	[TYPE],
	(CASE @kusd
		WHEN 1 THEN ROUND(SUM(T$AMNT)/1000,0)
		ELSE SUM(T$AMNT)
	END) AS AMNT
	FROM (SELECT *,
		(CASE
			WHEN T$SSTA=1 THEN 'Oh hold shipment'
			WHEN T$SFLG=1 THEN 'Oh hold production'
			ELSE ''
		END) AS [TYPE] FROM TFSOLP120180 WHERE T$DATE = @RptDate-1) A
	WHERE T$DATE<=@RptDate AND (T$SSTA=1 OR T$SFLG=1)
	GROUP BY T$DPAT,[TYPE]
	ORDER BY T$DPAT
END


GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_YieldTrend_QueryByOEM_Monthly_Fiscal]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_YieldTrend_QueryByOEM_Monthly_Fiscal] 
	@y1 INT,
	@s1 INT,
	@y2 INT,
	@s2 INT,
	@site VARCHAR(10)=NULL,
	@top INT=5
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @p1 INT, @p2 INT

	SET @p1=@y1*100+@s1
	SET @p2=@y2*100+@s2

	SELECT
		G1,
		YIELD,
		ROW_NUMBER() OVER(ORDER BY YIELD DESC) AS ROWID
	INTO #TEMP
	FROM (
		SELECT
			t.T$CSGS AS G1,
			(CASE SUM(t.T$YDAS/(t.T$YIED*100))
				WHEN 0 THEN 0
				ELSE SUM(t.T$YDAS)/SUM(t.T$YDAS/(t.T$YIED*100))
			 END) AS YIELD
		FROM TFSOLP108180 t
		LEFT JOIN vw_Calender c ON t.T$OUDT=c.calenderDate
		WHERE
			c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
		AND T$PLNT=@site
		AND t.T$YIED<>0
		GROUP BY t.T$CSGS
	) A;

	
	--
	--

    SELECT
		t.CSGS AS G1,
		c.FiscalPeriodDesc AS G2,
		(CASE SUM(t.T$YDAS/(t.T$YIED*100))
			WHEN 0 THEN 0
			ELSE SUM(t.T$YDAS)/SUM(t.T$YDAS/(t.T$YIED*100))
		 END) AS YIELD
	FROM (SELECT a.*,
			(CASE
				WHEN a.T$CSGS=b.G1 THEN a.T$CSGS
				ELSE 'ZZZ-Others'
			END) AS CSGS
		FROM TFSOLP108180 a
		LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<=@top) b ON a.T$CSGS=b.G1
		) t
	LEFT JOIN vw_Calender c ON t.T$OUDT=c.calenderDate
	WHERE
		c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
	AND T$PLNT=@site
	AND t.T$YIED<>0
	GROUP BY t.CSGS,c.FiscalPeriodDesc
	ORDER BY t.CSGS,c.FiscalPeriodDesc

END




GO

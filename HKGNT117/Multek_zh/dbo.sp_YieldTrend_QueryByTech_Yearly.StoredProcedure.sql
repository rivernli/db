USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_YieldTrend_QueryByTech_Yearly]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_YieldTrend_QueryByTech_Yearly] 
	@y1 INT,
	@y2 INT,
	@site VARCHAR(10)=NULL,
	@top INT=5
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @p1 INT, @p2 INT

	SET @p1=@y1*100
	SET @p2=@y2*100

	SELECT
		G1,
		YIELD,
		ROW_NUMBER() OVER(ORDER BY YIELD DESC) AS ROWID
	INTO #TEMP
	FROM (
		SELECT
			t.T$PRDT AS G1,
			SUM(t.T$YDAS)/SUM(t.T$YDAS/(t.T$YIED*100)) AS YIELD
		FROM TFSOLP108180 t
		LEFT JOIN vw_Calender c ON t.T$OUDT=c.calenderDate
		WHERE
			YEAR(T$OUDT) BETWEEN @y1 AND @y2
		AND T$PLNT=@site
		AND t.T$YIED<>0
		GROUP BY t.T$PRDT
	) A



    SELECT
		t.PRDT AS G1,
		CONVERT(VARCHAR,YEAR(t.T$OUDT)) AS G2,
		SUM(t.T$YDAS)/SUM(t.T$YDAS/(t.T$YIED*100)) AS YIELD
	FROM (SELECT a.*,
			(CASE
				WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
				ELSE 'ZZZ-Others'
			END) AS PRDT
		FROM TFSOLP108180 a
		LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<@top) b ON a.T$PRDT=b.G1
		) t
	LEFT JOIN vw_Calender c ON t.T$OUDT=c.calenderDate
	WHERE
		YEAR(T$OUDT) BETWEEN @y1 AND @y2
	AND T$PLNT=@site
	AND t.T$YIED<>0
	GROUP BY t.PRDT,CONVERT(VARCHAR,YEAR(t.T$OUDT))
	ORDER BY t.PRDT,CONVERT(VARCHAR,YEAR(t.T$OUDT))
	
END





GO

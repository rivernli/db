USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_YieldTrend_QueryByCust_Monthly]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_YieldTrend_QueryByCust_Monthly] 
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
			t.T$BOAR AS G1,
			(CASE SUM(t.TT)
				WHEN 0 THEN 0
				ELSE SUM(t.T$YDAS)/SUM(t.TT)
			END) AS YIELD
		FROM (SELECT *,(CASE T$YIED WHEN 0 THEN 0 ELSE T$YDAS/(T$YIED*100) END) AS TT FROM TFSOLP108180) t
		LEFT JOIN vw_Calender c ON t.T$OUDT=c.calenderDate
		WHERE
			YEAR(t.T$OUDT)*100+MONTH(t.T$OUDT) BETWEEN @p1 AND @p2
		AND T$PLNT=@site
		AND T$YIED<>0
		GROUP BY t.T$BOAR
	) A;
	
	---
	
	----



    SELECT
		t.BOAR AS G1,
		c.calenderMonthDesc AS G2,
		(CASE SUM(t.TT)
			WHEN 0 THEN 0
			ELSE SUM(t.T$YDAS)/SUM(t.TT)
		END) AS YIELD
	FROM (SELECT a.*,
			(CASE
				WHEN a.T$BOAR=b.G1 THEN a.T$BOAR
				ELSE 'ZZZ-Others'
			END) AS BOAR
		FROM (SELECT *,(CASE T$YIED WHEN 0 THEN 0 ELSE T$YDAS/(T$YIED*100) END) AS TT FROM TFSOLP108180) a
		LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<@top) b ON a.T$BOAR=b.G1
		) t
	LEFT JOIN vw_Calender c ON t.T$OUDT=c.calenderDate
	WHERE
		YEAR(t.T$OUDT)*100+MONTH(t.T$OUDT) BETWEEN @p1 AND @p2
	AND T$PLNT=@site
	AND T$YIED<>0
	GROUP BY t.BOAR,c.calenderMonthDesc
	ORDER BY t.BOAR,c.calenderMonthDesc
	
END



GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_YieldTrend_QueryBySite_Quarterly]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_YieldTrend_QueryBySite_Quarterly]
	@y1 INT,
	@s1 INT,
	@y2 INT,
	@s2 INT
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @p1 INT, @p2 INT

	SET @p1=@y1*100+@s1
	SET @p2=@y2*100+@s2

	SELECT
		t.T$PLNT AS G1,
		c.calenderQuarterDesc AS G2,
		SUM(t.T$YDAS)/SUM(t.T$YDAS/(t.T$YIED*100)) AS YIELD
	FROM
		(SELECT *, 
		YEAR(T$OUDT) AS [YEAR],
		(CASE 
			 WHEN MONTH(T$OUDT)>=1 AND MONTH(T$OUDT)<=3 THEN 1
			 WHEN MONTH(T$OUDT)>=4 AND MONTH(T$OUDT)<=6 THEN 2
			 WHEN MONTH(T$OUDT)>=7 AND MONTH(T$OUDT)<=9 THEN 3
			 WHEN MONTH(T$OUDT)>=10 AND MONTH(T$OUDT)<=12 THEN 4
		END) AS QUARTER
		FROM TFSOLP108180) t
	LEFT JOIN vw_Calender c ON t.T$OUDT=c.calenderDate
	WHERE
		t.[YEAR]*100+t.QUARTER BETWEEN @p1 AND @p2
	AND t.T$YIED<>0
	GROUP BY t.T$PLNT,c.calenderQuarterDesc
	ORDER BY t.T$PLNT,c.calenderQuarterDesc
END











GO

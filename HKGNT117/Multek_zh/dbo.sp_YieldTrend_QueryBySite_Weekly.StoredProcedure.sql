USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_YieldTrend_QueryBySite_Weekly]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_YieldTrend_QueryBySite_Weekly] 
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
		(CONVERT(VARCHAR,YEAR(t.T$OUDT))+'.W'+t.T$WEEK) AS G2,
		SUM(t.T$YDAS)/SUM(t.T$YDAS/(t.T$YIED*100)) AS YIELD
	FROM TFSOLP108180 t
	LEFT JOIN vw_Calender c ON t.T$OUDT=c.calenderDate
	WHERE
		YEAR(t.T$OUDT)*100+CONVERT(INT,t.T$WEEK) BETWEEN @p1 AND @p2
	AND t.T$YIED<>0
	GROUP BY t.T$PLNT,(CONVERT(VARCHAR,YEAR(t.T$OUDT))+'.W'+t.T$WEEK)
	ORDER BY t.T$PLNT,(CONVERT(VARCHAR,YEAR(t.T$OUDT))+'.W'+t.T$WEEK)
END








GO

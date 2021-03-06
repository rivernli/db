USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_YieldTrend_QueryBySite_Monthly_Fiscal_Plant]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[sp_YieldTrend_QueryBySite_Monthly_Fiscal_Plant] 
	@y1 INT,
	@s1 INT,
	@y2 INT,
	@s2 INT,
	@plant char(4)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @p1 INT, @p2 INT

	SET @p1=@y1*100+@s1
	SET @p2=@y2*100+@s2

	SELECT
		t.T$PLNT AS G1,
		c.FiscalPeriodDesc AS G2,
		SUM(t.T$YDAS)/SUM(
		(CASE t.T$YIED
			WHEN 0 THEN 0
			ELSE t.T$YDAS/(t.T$YIED*100)
		END)) AS YIELD
	FROM TFSOLP108180 t
	LEFT JOIN vw_Calender c ON t.T$OUDT=c.calenderDate
	WHERE
		c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
	AND t.T$PLNT = @plant
	AND t.T$YIED<>0
	GROUP BY t.T$PLNT,c.FiscalPeriodDesc
	ORDER BY t.T$PLNT,c.FiscalPeriodDesc
/*
	SELECT
		t.T$PLNT AS G1,
		c.FiscalPeriodDesc AS G2,
		YIELD = case when sum(t.T$YDAS) =0 then 0 else SUM(t.T$YDAS)/SUM(t.T$YDAS/(t.T$YIED*100)) end
	FROM TFSOLP108180 t
	LEFT JOIN vw_Calender c ON t.T$OUDT=c.calenderDate
	WHERE
		c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
	GROUP BY t.T$PLNT,c.FiscalPeriodDesc
	ORDER BY t.T$PLNT,c.FiscalPeriodDesc
*/
END










GO

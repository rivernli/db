USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_YieldTrend_QueryBySite_Yearly_Fiscal]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_YieldTrend_QueryBySite_Yearly_Fiscal]
	@y1 int, 
	@y2 int
AS
BEGIN

	SET NOCOUNT ON;

    SELECT
		t.T$PLNT AS G1,
		c.FiscalYearDesc AS G2,
		SUM(t.T$YDAS)/SUM(
		(CASE t.T$YIED
			WHEN 0 THEN 0
			ELSE t.T$YDAS/(t.T$YIED*100)
		END)) AS YIELD
	FROM TFSOLP108180 t
	LEFT JOIN vw_Calender c ON t.T$OUDT=c.calenderDate
	WHERE 
		c.FiscalYear BETWEEN @y1 AND @y2
	AND t.T$YIED<>0
	GROUP BY t.T$PLNT,c.FiscalYearDesc
END









GO

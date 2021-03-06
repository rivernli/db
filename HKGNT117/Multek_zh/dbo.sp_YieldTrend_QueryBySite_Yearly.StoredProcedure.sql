USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_YieldTrend_QueryBySite_Yearly]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_YieldTrend_QueryBySite_Yearly] 
	@y1	INT, 
	@y2	INT
AS
BEGIN

	SET NOCOUNT ON;

	SELECT
		T$PLNT AS G1,
		CONVERT(VARCHAR,YEAR(T$OUDT)) AS G2,
		SUM(T$YDAS)/SUM(T$YDAS/(T$YIED*100)) AS YIELD
	FROM TFSOLP108180
	WHERE YEAR(T$OUDT) BETWEEN @y1 AND @y2
	AND T$YIED<>0
	GROUP BY T$PLNT,CONVERT(VARCHAR,YEAR(T$OUDT))
	ORDER BY T$PLNT,CONVERT(VARCHAR,YEAR(T$OUDT))

END







GO

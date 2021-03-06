USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_Week_OEM]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_Week_OEM]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @DateFrom DATETIME,@DateTo DATETIME

	SET @DateFrom=(
						SELECT TOP 1 FiscalWeekFrom
						FROM Calendar
						WHERE CONVERT(VARCHAR(4),FiscalYear)+(CASE WHEN FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalWeek)<=
								(
									SELECT CONVERT(VARCHAR(4),FiscalYear)+(CASE WHEN FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalWeek)
									FROM Calendar
									WHERE FiscalWeekTo=(
															SELECT DATEADD(DAY,-1,CONVERT(DATE,FiscalWeekFrom))
															FROM Calendar
															WHERE Calenderdate = CONVERT(VARCHAR(10),GETDATE(),120)
														)
									GROUP BY FiscalYear,FiscalWeek
								)
						GROUP BY FiscalYear,FiscalWeek,FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
						ORDER BY FiscalYear DESC,FiscalWeek DESC
					)
	SET @DateTo=(
						SELECT TOP 1 FiscalWeekTo
						FROM Calendar
						WHERE CONVERT(VARCHAR(4),FiscalYear)+(CASE WHEN FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalWeek)<=
								(
									SELECT CONVERT(VARCHAR(4),FiscalYear)+(CASE WHEN FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalWeek)
									FROM Calendar
									WHERE FiscalWeekTo=(
															SELECT DATEADD(DAY,-1,CONVERT(DATE,FiscalWeekFrom))
															FROM Calendar
															WHERE Calenderdate = CONVERT(VARCHAR(10),GETDATE(),120)
														)
									GROUP BY FiscalYear,FiscalWeek
								)
						GROUP BY FiscalYear,FiscalWeek,FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
						ORDER BY FiscalYear DESC,FiscalWeek DESC
					)

	--SET @DateFrom='2011-06-18'
	--SET @DateTo='2011-06-24'

	SELECT *,
		(B1+B2F+B3+B4+B5+VVI) AS Total
	FROM (
			SELECT a.T$DESC AS Type,a.T$CSGS AS OEM,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='P2' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo 
				)) AS B1,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='2F' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo 
				)) AS B2F,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='B3' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo 
				)) AS B3,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='B4' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo 
				)) AS B4,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='B5' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo 
				)) AS B5,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='HK' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo 
				)) AS VVI
			FROM TFSOLP121180 a
			WHERE a.T$TRDT BETWEEN @DateFrom AND @DateTo
			GROUP BY a.T$DESC,a.T$CSGS
		) c
	WHERE B1<>0 OR B2F<>0 OR B3<>0 OR B4<>0 OR B5<>0 OR VVI<>0
	ORDER BY c.Type DESC,(B1+B2F+B3+B4+B5+VVI) DESC,c.OEM ASC


END
GO

USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_DailyYear]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_DailyYear]
	-- Add the parameters for the stored procedure here
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Type VARCHAR(10),
	@LayYear BIT=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' WHEN 'ZhuHai' THEN '' ELSE @Plant END)

    -- Insert statements for procedure here
    SELECT a.*
    FROM (
			SELECT TOP 5 RIGHT(FiscalYearDesc,4) AS Year,
				(
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=1
				) AS YearDateFrom,
				(
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=12
				) AS YearDateTo
			FROM Calendar a
			WHERE LEFT(FiscalYearDesc,2)='FY'
			GROUP BY FiscalYearDesc
			ORDER BY FiscalYearDesc DESC
		) a
	WHERE (SELECT SUM(ABS(b.Amount)) FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN a.YearDateFrom AND a.YearDateTo)>0
END
GO

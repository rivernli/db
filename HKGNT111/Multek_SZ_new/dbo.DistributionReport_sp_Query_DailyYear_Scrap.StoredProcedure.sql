USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_DailyYear_Scrap]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_DailyYear_Scrap]
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
	WHERE (SELECT SUM(ABS(b.M1)+ABS(b.M2)+ABS(b.M3)+ABS(b.M4)+ABS(b.M5)+ABS(b.M6)+ABS(b.M7)+ABS(b.M8)+ABS(b.M9)+ABS(b.M10)+ABS(b.M11)+ABS(b.M12)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Type=@Type AND b.Site=@Site AND b.Plant=@Plant AND b.Year=a.Year)>0
END
GO

USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_SiteMonthlyDistributionTrend_ByPlant_By_SQFT]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_SiteMonthlyDistributionTrend_ByPlant_By_SQFT] 
	-- Add the parameters for the stored procedure here
	@ReportCode VARCHAR(3),
	@Type VARCHAR(10),
	@Year CHAR(4),
	@Site VARCHAR(3),
	@Plant VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- Insert statements for procedure here

	SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' WHEN 'ZhuHai' THEN '' ELSE @Plant END)

	DECLARE @YearMonth VARCHAR(7)
	IF EXISTS(	SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
				FROM DistribitionReport_SQFT_Calendar
				WHERE ReportCode=@ReportCode
					AND Type=@Type
					AND Year=@Year
					AND Site=@Site
					AND Plant=@Plant
			)
		BEGIN
			SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			FROM DistribitionReport_SQFT_Calendar
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Year=@Year
				AND Site=@Site
				AND Plant=@Plant
		END
	ELSE
		BEGIN
			SELECT 0,0,0,0,0,0,0,0,0,0,0,0
		END
END
GO

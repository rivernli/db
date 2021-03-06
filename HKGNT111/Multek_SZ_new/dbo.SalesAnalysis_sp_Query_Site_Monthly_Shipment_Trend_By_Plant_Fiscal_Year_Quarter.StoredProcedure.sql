USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Query_Site_Monthly_Shipment_Trend_By_Plant_Fiscal_Year_Quarter]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Query_Site_Monthly_Shipment_Trend_By_Plant_Fiscal_Year_Quarter] 
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(50),
	@Year CHAR(4),
	@Site VARCHAR(3),
	@Plant VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7),@ReportCode VARCHAR(3)
	SET @ReportCode=(CASE @Type WHEN 'ASP' THEN '801' WHEN 'ALC' THEN '802' WHEN 'PPL' THEN '803' ELSE '' END)
	IF EXISTS(	SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
				FROM dbo.SalesAnalysis_Amount_Fiscal
				WHERE ReportCode=@ReportCode 
					AND Year=@Year
					AND Site=@Site
					AND Plant=@Plant
			)
		BEGIN
			SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			FROM dbo.SalesAnalysis_Amount_Fiscal
			WHERE ReportCode=@ReportCode 
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

USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_TOP5CustomerOEMYearlyDistribution]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_TOP5CustomerOEMYearlyDistribution] 
	-- Add the parameters for the stored procedure here
	@ReportCode VARCHAR(10),
	@Type VARCHAR(10),
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@Year CHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7)

	SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' WHEN 'ZhuHai' THEN '' ELSE @Plant END)

	IF @Plant IS NULL
		BEGIN
			SELECT TOP 5 * ,LOWER(LEFT(REPLACE(REPLACE(OEMCustomer,'&',''),' ',''),10)) AS Short
			FROM DistributionReport_TOP20CustomerOEM
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Year=@Year
			ORDER BY Amount DESC
		END
	ELSE
		BEGIN
			SELECT TOP 5 * ,LOWER(LEFT(REPLACE(REPLACE(OEMCustomer,'&',''),' ',''),10)) AS Short
			FROM DistributionReport_TOP20CustomerOEM
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			ORDER BY Amount DESC
		END
END
GO

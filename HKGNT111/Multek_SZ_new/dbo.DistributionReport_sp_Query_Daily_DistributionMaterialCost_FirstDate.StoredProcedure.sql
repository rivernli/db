USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_Daily_DistributionMaterialCost_FirstDate]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_Daily_DistributionMaterialCost_FirstDate]
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(10),
	@Site VARCHAR(50),
	@Plant VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' WHEN 'ZhuHai' THEN '' ELSE @Plant END)

    -- Insert statements for procedure here
	SELECT TOP 1 Day 
	FROM DistributionReport_Daily_OEM
	WHERE Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND ABS(RevenueAmount)>0
	ORDER BY Day DESC
END
GO

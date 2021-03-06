USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_Techinics_RMA]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_Techinics_RMA]
	-- Add the parameters for the stored procedure here
	@ReportCode VARCHAR(20),
	@Type VARCHAR(20),
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@Year VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' WHEN 'ZhuHai' THEN '%' ELSE @Plant END)

    -- Insert statements for procedure here
	SELECT Technics
	FROM DistributionReport_Technics_Amount
	WHERE Reportcode=@ReportCode
		AND TYPE=@Type
		AND Plant LIKE @Plant
		AND CHARINDEX(YEAR,@Year)>0
	GROUP BY Technics
	ORDER BY Technics
END
GO

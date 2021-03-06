USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_Country]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_Country]
	-- Add the parameters for the stored procedure here
	@ReportCode VARCHAR(20),
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Year VARCHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Country
	FROM DistributionReport_uvw_Amount_Location
	WHERE ReportCode=@ReportCode
		AND Site=@Site
		AND Plant=@Plant
		AND YEAR=@Year
	GROUP BY Country
END
GO

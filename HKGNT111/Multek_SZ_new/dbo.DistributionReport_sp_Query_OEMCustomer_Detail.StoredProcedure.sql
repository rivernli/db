USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_OEMCustomer_Detail]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_OEMCustomer_Detail]
	-- Add the parameters for the stored procedure here
	@ReportCode VARCHAR(50),
	@Type VARCHAR(50),
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Year VARCHAR(4),
	@OEMCustomer varchar(300)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT OEMCustomer,ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,Amount
	FROM DistributionReport_TOP20CustomerOEM_Total_Detail
	WHERE ReportCode=@ReportCode
		AND Type=@Type
		AND Site=@Site
		AND Plant=@Plant
		AND Year=@Year
		AND OEMCustomer=@OEMCustomer
END
GO

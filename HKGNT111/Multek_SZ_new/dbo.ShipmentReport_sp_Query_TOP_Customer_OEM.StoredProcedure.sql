USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_TOP_Customer_OEM]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_TOP_Customer_OEM] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@Site VARCHAR(50),
	@Plant VARCHAR(10)=NULL,
	@OEMCustomer VARCHAR(300),
	@ReportCode VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * ,(M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12) AS Sum
	FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM 
	WHERE OEMCUSTOMER=@OEMCustomer
		AND Site=@Site
		AND Year=@Year
		AND Plant LIKE @Plant
		AND ReportCode=@ReportCode

END
GO

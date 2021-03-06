USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Daily_Revenue_Material_Cost]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Daily_Revenue_Material_Cost]
	-- Add the parameters for the stored procedure here
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Day DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * 
	FROM ShipmentReport_Shipped_All_Daily_OEM
	WHERE Site=@Site
		AND Plant=@Plant
		AND Day=@Day
		AND ABS(RevenueAmount)>0
	ORDER BY MaterialPercent DESC
END
GO

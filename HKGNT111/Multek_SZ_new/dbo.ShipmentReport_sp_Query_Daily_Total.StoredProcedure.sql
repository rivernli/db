USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Daily_Total]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Daily_Total]
	-- Add the parameters for the stored procedure here
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@DateFrom DATETIME,
	@DateTo DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT SUM(Amount) AS Amount
	FROM ShipmentReport_Shipped_All_Daily
	WHERE Site=@Site
		AND Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
	GROUP BY Site
END
GO

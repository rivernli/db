USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Initial_NFD_ShippedDate]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Initial_NFD_ShippedDate]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF EXISTS(SELECT * FROM SysObjects WHERE  Name ='NorthfieldSalesDataUpdateShippedDate')
	DROP TABLE NorthfieldSalesDataUpdateShippedDate
	
	SELECT b.FiscalPeriodFrom AS ShippedDate1,a.*
	INTO NorthfieldSalesDataUpdateShippedDate
	FROM NorthfieldSalesData a,
		(
			SELECT FiscalYear,FiscalPeriod,FiscalPeriodFrom,FiscalPeriodTo
			FROM  Calendar
			GROUP BY FiscalYear,FiscalPeriod,FiscalPeriodFrom,FiscalPeriodTo
		) b
	WHERE LEFT(RevenueYrMo,4)=b.FiscalYear
		AND CONVERT(INT,SUBSTRING(RevenueYrMo,7,2))=b.FiscalPeriod

END
GO

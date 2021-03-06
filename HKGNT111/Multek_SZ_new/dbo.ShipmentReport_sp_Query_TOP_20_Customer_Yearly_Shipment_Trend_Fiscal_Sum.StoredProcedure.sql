USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_TOP_20_Customer_Yearly_Shipment_Trend_Fiscal_Sum]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_TOP_20_Customer_Yearly_Shipment_Trend_Fiscal_Sum] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@DateFrom DATETIME,
	@DateTo DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7)

	INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal (Year,Customer,Amount)
	SELECT TOP 20 @Year AS Year,a.Real_Customer AS Customer,ISNULL(SUM(ISNULL(ShDols,0)),0) AS Amount
	FROM ShipmentReport_Shipped_All a
	WHERE a.ShDate>=@DateFrom
		  AND a.ShDate<=@DateTo
		  AND a.Real_Customer>''
	GROUP BY a.Real_Customer
	ORDER BY ISNULL(SUM(ISNULL(a.ShDols,0)),0) DESC

	UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal
	SET DisAmount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal(@DateFrom,@DateTo,Customer,'Dis'),
		ChiAmount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal(@DateFrom,@DateTo,Customer,'Chi'),
		NfdAmount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal(@DateFrom,@DateTo,Customer,'Nfd'),
		SaoAmount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal(@DateFrom,@DateTo,Customer,'Sao'),
		GerAmount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal(@DateFrom,@DateTo,Customer,'Ger')
	WHERE Year=@Year

END
GO

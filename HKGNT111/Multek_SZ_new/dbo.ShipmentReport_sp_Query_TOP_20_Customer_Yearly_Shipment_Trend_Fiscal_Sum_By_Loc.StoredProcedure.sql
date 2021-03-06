USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_TOP_20_Customer_Yearly_Shipment_Trend_Fiscal_Sum_By_Loc]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_TOP_20_Customer_Yearly_Shipment_Trend_Fiscal_Sum_By_Loc] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@DateFrom DATETIME,
	@DateTo DATETIME,
	@Loc varchar(3)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7)

	INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc (Loc,Year,Customer,Amount)
	SELECT TOP 20 @Loc AS Loc,@Year AS Year,a.Real_Customer AS Customer,ISNULL(SUM(ISNULL(ShDols,0)),0) AS Amount
	FROM ShipmentReport_Shipped_All a
	WHERE a.ShDate>=@DateFrom
		  AND a.ShDate<=@DateTo
		  AND a.Real_Customer>''
		  AND a.Loc=@Loc
	GROUP BY a.Real_Customer
	ORDER BY ISNULL(SUM(ISNULL(a.ShDols,0)),0) DESC

	IF @Loc='Chi'
		BEGIN
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			SET B1Amount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal_By_Loc(@DateFrom,@DateTo,Customer,@Loc,'P2'),
				B12Amount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal_By_Loc(@DateFrom,@DateTo,Customer,@Loc,'12'),
				B2FAmount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal_By_Loc(@DateFrom,@DateTo,Customer,@Loc,'2F'),
				B3Amount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal_By_Loc(@DateFrom,@DateTo,Customer,@Loc,'B3'),
				B4Amount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal_By_Loc(@DateFrom,@DateTo,Customer,@Loc,'B4'),
				B5Amount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal_By_Loc(@DateFrom,@DateTo,Customer,@Loc,'B5'),
				HKAmount=dbo.ShipmentReport_fun_Get_Customer_Sum_Fiscal_By_Loc(@DateFrom,@DateTo,Customer,@Loc,'HK')
			WHERE Year=@Year
				AND Loc=@Loc
		END

END
GO

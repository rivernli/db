USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_TOP_20_OEM_Yearly_Shipment_Trend_Sum_By_Loc]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_TOP_20_OEM_Yearly_Shipment_Trend_Sum_By_Loc] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@Loc VARCHAR(3)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7)

	INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc (Loc,Year,OEM,Amount)
	SELECT TOP 20 @Loc AS Loc,@Year AS Year,a.Real_OEM AS OEM,ISNULL(SUM(ISNULL(a.ShDols,0)),0) AS Amount
	FROM ShipmentReport_Shipped_All a
	WHERE a.ShDate>=@Year+'-01-01' 
		  AND a.ShDate<CONVERT(CHAR(4),CONVERT(INT,@Year)+1)+'-01-01' 
		  AND a.Real_OEM >''
		  AND a.Loc=@Loc
	GROUP BY a.Real_OEM
	ORDER BY ISNULL(SUM(ISNULL(a.ShDols,0)),0) DESC

	IF @Loc='Chi'
		BEGIN
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc
			SET B1Amount=dbo.ShipmentReport_fun_Get_OEM_Sum_By_Loc(@Year,OEM,@Loc,'P2'),
				B12Amount=dbo.ShipmentReport_fun_Get_OEM_Sum_By_Loc(@Year,OEM,@Loc,'12'),
				B2FAmount=dbo.ShipmentReport_fun_Get_OEM_Sum_By_Loc(@Year,OEM,@Loc,'2F'),
				B3Amount=dbo.ShipmentReport_fun_Get_OEM_Sum_By_Loc(@Year,OEM,@Loc,'B3'),
				B4Amount=dbo.ShipmentReport_fun_Get_OEM_Sum_By_Loc(@Year,OEM,@Loc,'B4'),
				B5Amount=dbo.ShipmentReport_fun_Get_OEM_Sum_By_Loc(@Year,OEM,@Loc,'B5'),
				HKAmount=dbo.ShipmentReport_fun_Get_OEM_Sum_By_Loc(@Year,OEM,@Loc,'HK')
			WHERE Year=@Year
				AND Loc=@Loc
		END
END
GO

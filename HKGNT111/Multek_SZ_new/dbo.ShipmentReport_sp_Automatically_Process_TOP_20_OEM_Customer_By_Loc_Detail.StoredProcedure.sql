USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Automatically_Process_TOP_20_OEM_Customer_By_Loc_Detail]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Automatically_Process_TOP_20_OEM_Customer_By_Loc_Detail]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET NOCOUNT ON;

    DECLARE @Year CHAR(4),@i INT,@SQLString VARCHAR(8000),@Color VARCHAR(50)

	-- Initial all
	TRUNCATE TABLE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
	TRUNCATE TABLE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc

	SET @i=1
	WHILE @i<=5
		BEGIN
			SET @Year=CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()),120)
			-- Chi Process Top 20 Customers   
			EXECUTE ShipmentReport_sp_Query_TOP_20_Customer_Yearly_Shipment_Trend_Sum_By_Loc @Year=@Year,@Loc='Chi'
			-- Chi Process Top 20 OEMs   
			EXECUTE ShipmentReport_sp_Query_TOP_20_OEM_Yearly_Shipment_Trend_Sum_By_Loc @Year=@Year,@Loc='Chi'
			-- Dis Process Top 20 Customers   
			EXECUTE ShipmentReport_sp_Query_TOP_20_Customer_Yearly_Shipment_Trend_Sum_By_Loc @Year=@Year,@Loc='Dis'
			-- Dis Process Top 20 OEMs   
			EXECUTE ShipmentReport_sp_Query_TOP_20_OEM_Yearly_Shipment_Trend_Sum_By_Loc @Year=@Year,@Loc='Dis'

			SET @i=@i+1	
		END

	UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
	SET Amount=B1Amount+B12Amount+B2FAmount+B3Amount+B4Amount+B5Amount+HKAmount
	WHERE Loc='Chi'

	UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc
	SET Amount=B1Amount+B12Amount+B2FAmount+B3Amount+B4Amount+B5Amount+HKAmount
	WHERE Loc='Chi'

END
GO

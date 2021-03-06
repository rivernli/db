USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_TOP_5_OEM_Yearly_Shipment_Trend_Fiscal_By_Plant]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_TOP_5_OEM_Yearly_Shipment_Trend_Fiscal_By_Plant] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@Plant VARCHAR(10)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7)
	SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' ELSE @Plant END)
	SELECT TOP 5 * ,LOWER(LEFT(REPLACE(REPLACE(OEM,'&',''),' ',''),10)) AS Short
	FROM dbo.ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
	WHERE Year=@Year
		AND PLANT=@PLANT
	ORDER BY Amount DESC

END
GO

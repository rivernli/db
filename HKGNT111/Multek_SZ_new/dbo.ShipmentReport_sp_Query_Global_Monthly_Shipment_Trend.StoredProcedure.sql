USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Global_Monthly_Shipment_Trend]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Global_Monthly_Shipment_Trend] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7)
	IF EXISTS(	SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
				FROM dbo.ShipmentReport_Shipped_All_Fixed
				WHERE ReportCode='001'
					AND Year=@Year
			)
		BEGIN
			SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			FROM dbo.ShipmentReport_Shipped_All_Fixed
			WHERE ReportCode='001'
				AND Year=@Year
		END
	ELSE
		BEGIN
			SELECT 0,0,0,0,0,0,0,0,0,0,0,0
		END

END
GO

USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Site_Monthly_Shipment_Trend_Fiscal_Year_Quarter]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Site_Monthly_Shipment_Trend_Fiscal_Year_Quarter] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@Site VARCHAR(3),
	@Plant VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	SET @Plant='%'+ISNULL(@Plant,'')+'%'
	DECLARE @YearMonth VARCHAR(7)
	IF EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal
				WHERE ReportCode='004'
						AND Year=@Year
						AND Site=@Site)
		BEGIN
			--SELECT M1 ,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			SELECT M1+(
						CASE WHEN @Site='Chi' THEN (SELECT SUM(b.M1) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='998' AND b.Site='Chi' AND b.Year=@Year) 
						     WHEN @Site='Dis' THEN (SELECT SUM(b.M1) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='996' AND b.Site='Dis' AND b.Year=@Year) 
						     WHEN @Site='Ger' THEN (SELECT SUM(b.M1) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='994' AND b.Site='Ger' AND b.Year=@Year) 
						     WHEN @Site='Sao' THEN (SELECT SUM(b.M1) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='992' AND b.Site='Sao' AND b.Year=@Year) 
						ELSE 0 
						END
					  ) AS M1,
				   M2+(
						CASE WHEN @Site='Chi' THEN (SELECT SUM(b.M2) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='998' AND b.Site='Chi' AND b.Year=@Year)
						     WHEN @Site='Dis' THEN (SELECT SUM(b.M2) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='996' AND b.Site='Dis' AND b.Year=@Year) 
						     WHEN @Site='Ger' THEN (SELECT SUM(b.M2) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='994' AND b.Site='Ger' AND b.Year=@Year) 
						     WHEN @Site='Sao' THEN (SELECT SUM(b.M2) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='992' AND b.Site='Sao' AND b.Year=@Year) 
						ELSE 0 
						END
					 ) AS M2,
				   M3+(
						CASE WHEN @Site='Chi' THEN (SELECT SUM(b.M3) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='998' AND b.Site='Chi' AND b.Year=@Year) 
						     WHEN @Site='Dis' THEN (SELECT SUM(b.M3) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='996' AND b.Site='Dis' AND b.Year=@Year) 
						     WHEN @Site='Ger' THEN (SELECT SUM(b.M3) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='994' AND b.Site='Ger' AND b.Year=@Year) 
						     WHEN @Site='Sao' THEN (SELECT SUM(b.M4) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='992' AND b.Site='Sao' AND b.Year=@Year) 
						ELSE 0 
						END
					  ) AS M3,
				   M4+(
						CASE WHEN @Site='Chi' THEN (SELECT SUM(b.M4) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='998' AND b.Site='Chi' AND b.Year=@Year) 
						     WHEN @Site='Dis' THEN (SELECT SUM(b.M4) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='996' AND b.Site='Dis' AND b.Year=@Year) 
						     WHEN @Site='Ger' THEN (SELECT SUM(b.M4) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='994' AND b.Site='Ger' AND b.Year=@Year) 
						     WHEN @Site='Sao' THEN (SELECT SUM(b.M4) FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode='992' AND b.Site='Sao' AND b.Year=@Year) 
						ELSE 0 
						END
					  ) AS M4,
				M5,M6,M7,M8,M9,M10,M11,M12

			FROM ShipmentReport_Shipped_All_Fixed_Fiscal
			WHERE ReportCode='004'
				AND Year=@Year
				AND Site=@Site
		END
	ELSE
		BEGIN
			SELECT 0,0,0,0,0,0,0,0,0,0,0,0
		END
END
GO

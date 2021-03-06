USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Site_Monthly_Shipment_Trend_By_Plant_Fiscal_Year_Quarter]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Site_Monthly_Shipment_Trend_By_Plant_Fiscal_Year_Quarter] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@Site VARCHAR(3),
	@Plant VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7)
	IF @Plant<>'JVM'
		BEGIN
			IF EXISTS(	SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
						FROM dbo.ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='005'
							AND Year=@Year
							AND Site=@Site
							AND Plant=@Plant
					)
				BEGIN
					SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
					FROM dbo.ShipmentReport_Shipped_All_Fixed_Fiscal
					WHERE ReportCode='005'
						AND Year=@Year
						AND Site=@Site
						AND Plant=@Plant
				END
			ELSE
				BEGIN
					SELECT 0,0,0,0,0,0,0,0,0,0,0,0
				END
		END
	ELSE
		BEGIN
			/*
			SELECT SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='998'
				 AND Site='Chi' 
				 AND Year=@Year
			*/
			SELECT a.M1-b.M1 AS M1,a.M2-b.M2 AS M2,a.M3-b.M3 AS M3,a.M4-b.M4 AS M4,a.M5-b.M5 AS M5,a.M6-b.M6 AS M6,a.M7-b.M7 AS M7,a.M8-b.M8 AS M8,a.M9-b.M9 AS M9,a.M10-b.M10 AS M10,a.M11-b.M11 AS M11,a.M12-b.M12 AS M12
			FROM 
				(
					SELECT SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
					FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
					WHERE ReportCode='998'
						 AND Site='Chi' 
						 AND Year=@Year
				) a,
				(				 
					SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
					FROM DistribitionReport_Amount_Fiscal
					WHERE ReportCode='554'
						AND Type='Scrap'
						AND Year=@Year
						AND Site='Chi'
						AND Plant=''
				) b

		END
END
GO

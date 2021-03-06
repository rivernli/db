USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Automatically_Process]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Automatically_Process]
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
	TRUNCATE TABLE ShipmentReport_Site
	TRUNCATE TABLE ShipmentReport_Year
	TRUNCATE TABLE ShipmentReport_Shipped_All_Fixed
	TRUNCATE TABLE ShipmentReport_Shipped_All_Fixed_Top_20_Customer
	TRUNCATE TABLE ShipmentReport_Shipped_All_Fixed_Top_20_OEM
	TRUNCATE TABLE ShipmentReport_Lay

	DELETE ShipmentReport_FushionChart_Color WHERE ReportCode=1

	--Process Lays
	INSERT INTO ShipmentReport_Lay
	SELECT Lays AS Name
	FROM ShipmentReport_uvw_Shipped_All
	WHERE Lays >0
	GROUP BY Lays
	ORDER BY Lays

	-- Process Site
	INSERT INTO ShipmentReport_Site
	SELECT Loc AS ShipmentSite
	FROM ShipmentReport_Shipped_All
	--WHERE Loc IS NOT NULL
	GROUP BY Loc
	ORDER BY Loc
	-- Process Layer
	IF EXISTS(SELECT * FROM sysobjects WHERE Name='ShipmentReport_Shipped_All_Fixed_Layer')
		BEGIN
			DROP TABLE ShipmentReport_Shipped_All_Fixed_Layer
		END
	CREATE TABLE ShipmentReport_Shipped_All_Fixed_Layer (Year VARCHAR(4))

	SET @i=1
	WHILE @i<=5
		BEGIN
			SET @Year=CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()),120)
			-- Process Year
			INSERT INTO ShipmentReport_Year VALUES(@Year)
			-- Process Global Monthly Shipment Trend  Code:0001
			INSERT INTO ShipmentReport_Shipped_All_Fixed (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '001','','',@Year,* FROM dbo.fun_Sum_by_Year(@Year,NULL,NULL)
			-- Process Site Monthly Shipment Trend   Code:0002
			SET @SQLString='
							DECLARE @Site VARCHAR(50)
							DECLARE Site_C CURSOR FOR 
							SELECT ShipmentSite 
							FROM ShipmentReport_Site 
							OPEN Site_C
							FETCH NEXT FROM Site_C INTO @Site
							WHILE @@FETCH_STATUS=0
								BEGIN
									-- Process Global Monthly Shipment Trend  Code:0002
									INSERT INTO ShipmentReport_Shipped_All_Fixed (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
									SELECT ''002'' AS ReportCode ,@Site AS Site,'''' AS Plant,'+''''+@Year+''''+' AS Year,* FROM dbo.fun_Sum_by_Year_Site('+''''+@Year+''''+',@Site,NULL)								
									FETCH NEXT FROM Site_C INTO @Site
								END
							CLOSE Site_C
							DEALLOCATE Site_C
							'
			EXECUTE (@SQLString)
			-- Process Site(chi) Plant 12 Monthly Shipment Trend   Code:0003
			INSERT INTO ShipmentReport_Shipped_All_Fixed (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','12',@Year,* FROM dbo.fun_Sum_by_Year_Site_Plant(@Year,'CHI','12')
			INSERT INTO ShipmentReport_Shipped_All_Fixed (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','2F',@Year,* FROM dbo.fun_Sum_by_Year_Site_Plant(@Year,'CHI','2F')
			INSERT INTO ShipmentReport_Shipped_All_Fixed (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','B3',@Year,* FROM dbo.fun_Sum_by_Year_Site_Plant(@Year,'CHI','B3')
			INSERT INTO ShipmentReport_Shipped_All_Fixed (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','B4',@Year,* FROM dbo.fun_Sum_by_Year_Site_Plant(@Year,'CHI','B4')
			INSERT INTO ShipmentReport_Shipped_All_Fixed (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','B5',@Year,* FROM dbo.fun_Sum_by_Year_Site_Plant(@Year,'CHI','B5')
			INSERT INTO ShipmentReport_Shipped_All_Fixed (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','HK',@Year,* FROM dbo.fun_Sum_by_Year_Site_Plant(@Year,'CHI','HK')
			INSERT INTO ShipmentReport_Shipped_All_Fixed (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','P2',@Year,* FROM dbo.fun_Sum_by_Year_Site_Plant(@Year,'CHI','P2')
			INSERT INTO ShipmentReport_Shipped_All_Fixed (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','NA',@Year,* FROM dbo.fun_Sum_by_Year_Site_Plant(@Year,'CHI','NA')
			-- Process Technology Breakdowns(layers)  Code:0004
			EXECUTE ShipmentReport_sp_Query_Layer_Yearly_Technology_Breakdown_Sum @Year=@Year
			-- Process Top 20 Customers   
			--EXECUTE ShipmentReport_sp_Query_TOP_20_Customer_Yearly_Shipment_Trend_Sum @Year=@Year
			-- Process Top 20 OEMs   
			--EXECUTE ShipmentReport_sp_Query_TOP_20_OEM_Yearly_Shipment_Trend_Sum @Year=@Year

			--Process fushionchart color
			SET @Color=(
							CASE WHEN @I=1 THEN '3399FF'
								 WHEN @I=2 THEN '00FF00'
								 WHEN @I=3 THEN '00FFFF'
								 WHEN @I=4 THEN 'FF00FF'
								 WHEN @I=5 THEN 'FFFF00'
							ELSE 'CC3300' 
							END
						)
			INSERT INTO ShipmentReport_FushionChart_Color(ReportCode,Year,Color)
				VALUES(1,@Year,@Color)
		
			SET @i=@i+1	
		END
END
GO

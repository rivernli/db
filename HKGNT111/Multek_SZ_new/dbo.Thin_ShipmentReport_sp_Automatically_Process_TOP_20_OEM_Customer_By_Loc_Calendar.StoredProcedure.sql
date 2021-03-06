USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[Thin_ShipmentReport_sp_Automatically_Process_TOP_20_OEM_Customer_By_Loc_Calendar]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[Thin_ShipmentReport_sp_Automatically_Process_TOP_20_OEM_Customer_By_Loc_Calendar]
	-- Add the parameters for the stored procedure here
	@CalculateYear INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @Year CHAR(4),@i INT,@j INT,@k INT,@SQLString VARCHAR(MAX),@Color VARCHAR(50),@DateFrom DATETIME,@DateTo DATETIME ,@NowMonth INT,
			@Amount BIGINT,@Site VARCHAR(50),@Plant VARCHAR(50),@Lay INT,@OEMCustomer VARCHAR(500),@OEM VARCHAR(500),@ReportCode CHAR(3),@SumCustomer VARCHAR(MAX),@SumOEM VARCHAR(MAX),
			@DateFrom1 DATETIME,@DateTo1 DATETIME,@DateFrom2 DATETIME,@DateTo2 DATETIME,@DateFrom3 DATETIME,@DateTo3 DATETIME,
			@DateFrom4 DATETIME,@DateTo4 DATETIME,@DateFrom5 DATETIME,@DateTo5 DATETIME,@DateFrom6 DATETIME,@DateTo6 DATETIME,
			@DateFrom7 DATETIME,@DateTo7 DATETIME,@DateFrom8 DATETIME,@DateTo8 DATETIME,@DateFrom9 DATETIME,@DateTo9 DATETIME,
			@DateFrom10 DATETIME,@DateTo10 DATETIME,@DateFrom11 DATETIME,@DateTo11 DATETIME,@DateFrom12 DATETIME,@DateTo12 DATETIME			
	CREATE TABLE #Temp (Loc VARCHAR(10),Year VARCHAR(4),OEMCustomer VARCHAR(300),Amount BIGINT) 
	CREATE NONCLUSTERED INDEX [TempTypeSitePlantOEMDay] ON [#Temp] 
	(
		[Loc] ASC,[Year] ASC,[OEMCustomer] ASC
	)
	SET @SQLString=''
	SET @Year=CONVERT(VARCHAR(4),GETDATE()-1,120)
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
		
			SET @Year=CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=@Year+'-01-01' 
			SET @DateTo=CONVERT(VARCHAR(10),CONVERT(DATETIME,CONVERT(CHAR(4),CONVERT(INT,@Year)+1)+'-01-01') -1,120)

			---- Dis Process Top 20 Customers 
			--TRUNCATE TABLE #Temp
			--SET @OEMCustomer='Customer'
			--SET @Site='Chi'
			--INSERT INTO #Temp (Loc,Year,OEMCustomer,Amount) 
			--SELECT @Site AS Loc,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_Loc(@OEMCustomer,@Site,@DateFrom,@DateTo)
			--DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc a
			--WHERE a.Year=@Year
			--	AND a.Loc=@Site
			--	AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			--SET @SQLString='
			--				INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc(Loc,Year ,Customer,Amount)
			--				SELECT a.*
			--				FROM #Temp a
			--				WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc b WHERE b.Loc+b.Year+b.Customer=a.Loc+a.Year+a.OEMCustomer) 
			--				'
			--EXECUTE (@SQLString)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--SET B1Amount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,'P2',@DateFrom,@DateTo),
			--	B12Amount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,'12',@DateFrom,@DateTo),
			--	B2FAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,'2F',@DateFrom,@DateTo),
			--	B3Amount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,'B3',@DateFrom,@DateTo),
			--	B4Amount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,'B4',@DateFrom,@DateTo),
			--	B5Amount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,'B5',@DateFrom,@DateTo),
			--	HKAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,'HK',@DateFrom,@DateTo)
			--WHERE Year=@Year
			--	AND Loc=@Site
			--UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--SET Amount=B1Amount+B12Amount+B2FAmount+B3Amount+B4Amount+B5Amount+HKAmount
			--WHERE Year=@Year
			--	AND Loc=@Site
				
			--TRUNCATE TABLE #Temp
			--SET @OEMCustomer='Customer'
			--SET @Site='Dis'
			--INSERT INTO #Temp (Loc,Year,OEMCustomer,Amount) 
			--SELECT @Site AS Loc,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_Loc(@OEMCustomer,@Site,@DateFrom,@DateTo)
			--DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc a
			--WHERE a.Year=@Year
			--	AND a.Loc=@Site
			--	AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			--SET @SQLString='
			--				INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc(Loc,Year ,Customer,Amount)
			--				SELECT a.*
			--				FROM #Temp a
			--				WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc b WHERE b.Loc+b.Year+b.Customer=a.Loc+a.Year+a.OEMCustomer) 
			--				'
			--EXECUTE (@SQLString)
			--TRUNCATE TABLE #Temp
			--SET @OEMCustomer='Customer'
			--SET @Site='Ger'
			--INSERT INTO #Temp (Loc,Year,OEMCustomer,Amount) 
			--SELECT @Site AS Loc,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_Loc(@OEMCustomer,@Site,@DateFrom,@DateTo)
			--DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc a
			--WHERE a.Year=@Year
			--	AND a.Loc=@Site
			--	AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			--SET @SQLString='
			--				INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc(Loc,Year ,Customer,Amount)
			--				SELECT a.*
			--				FROM #Temp a
			--				WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc b WHERE b.Loc+b.Year+b.Customer=a.Loc+a.Year+a.OEMCustomer) 
			--				'
			--EXECUTE (@SQLString)
			TRUNCATE TABLE #Temp
			SET @OEMCustomer='Customer'
			SET @Site='Nfd'
			INSERT INTO #Temp (Loc,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_Loc(@OEMCustomer,@Site,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc(Loc,Year ,Customer,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc b WHERE b.Loc+b.Year+b.Customer=a.Loc+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			TRUNCATE TABLE #Temp
			SET @OEMCustomer='Customer'
			SET @Site='Sao'
			INSERT INTO #Temp (Loc,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_Loc(@OEMCustomer,@Site,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc(Loc,Year ,Customer,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc b WHERE b.Loc+b.Year+b.Customer=a.Loc+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
				
				
			--TRUNCATE TABLE #Temp
			--SET @OEMCustomer='OEM'
			--SET @Site='Chi'
			--INSERT INTO #Temp (Loc,Year,OEMCustomer,Amount) 
			--SELECT @Site AS Loc,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_Loc(@OEMCustomer,@Site,@DateFrom,@DateTo)
			--DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc a
			--WHERE a.Year=@Year
			--	AND a.Loc=@Site
			--	AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			--SET @SQLString='
			--				INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc(Loc,Year ,OEM,Amount)
			--				SELECT a.*
			--				FROM #Temp a
			--				WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc b WHERE b.Loc+b.Year+b.OEM=a.Loc+a.Year+a.OEMCustomer) 
			--				'
			--EXECUTE (@SQLString)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc
			--SET B1Amount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,'P2',@DateFrom,@DateTo),
			--	B12Amount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,'12',@DateFrom,@DateTo),
			--	B2FAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,'2F',@DateFrom,@DateTo),
			--	B3Amount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,'B3',@DateFrom,@DateTo),
			--	B4Amount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,'B4',@DateFrom,@DateTo),
			--	B5Amount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,'B5',@DateFrom,@DateTo),
			--	HKAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,'HK',@DateFrom,@DateTo)
			--WHERE Year=@Year
			--	AND Loc=@Site
			--UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc
			--SET Amount=B1Amount+B12Amount+B2FAmount+B3Amount+B4Amount+B5Amount+HKAmount
			--WHERE Year=@Year
			--	AND Loc=@Site
				
			--TRUNCATE TABLE #Temp
			--SET @OEMCustomer='OEM'
			--SET @Site='Dis'
			--INSERT INTO #Temp (Loc,Year,OEMCustomer,Amount) 
			--SELECT @Site AS Loc,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_Loc(@OEMCustomer,@Site,@DateFrom,@DateTo)
			--DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc a
			--WHERE a.Year=@Year
			--	AND a.Loc=@Site
			--	AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			--SET @SQLString='
			--				INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc(Loc,Year ,OEM,Amount)
			--				SELECT a.*
			--				FROM #Temp a
			--				WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc b WHERE b.Loc+b.Year+b.OEM=a.Loc+a.Year+a.OEMCustomer) 
			--				'
			--EXECUTE (@SQLString)
			--TRUNCATE TABLE #Temp
			--SET @OEMCustomer='OEM'
			--SET @Site='Ger'
			--INSERT INTO #Temp (Loc,Year,OEMCustomer,Amount) 
			--SELECT @Site AS Loc,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_Loc(@OEMCustomer,@Site,@DateFrom,@DateTo)
			--DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc a
			--WHERE a.Year=@Year
			--	AND a.Loc=@Site
			--	AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			--SET @SQLString='
			--				INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc(Loc,Year ,OEM,Amount)
			--				SELECT a.*
			--				FROM #Temp a
			--				WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc b WHERE b.Loc+b.Year+b.OEM=a.Loc+a.Year+a.OEMCustomer) 
			--				'
			--EXECUTE (@SQLString)
			TRUNCATE TABLE #Temp
			SET @OEMCustomer='OEM'
			SET @Site='Nfd'
			INSERT INTO #Temp (Loc,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_Loc(@OEMCustomer,@Site,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc(Loc,Year ,OEM,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc b WHERE b.Loc+b.Year+b.OEM=a.Loc+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			TRUNCATE TABLE #Temp
			SET @OEMCustomer='OEM'
			SET @Site='Sao'
			INSERT INTO #Temp (Loc,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_Loc(@OEMCustomer,@Site,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc(Loc,Year ,OEM,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc b WHERE b.Loc+b.Year+b.OEM=a.Loc+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)

			SET @i=@i+1
		END
END
GO

USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[Thin_ShipmentReport_sp_Automatically_Process_TOP_20_OEM_Customer_Calendar]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Thin_ShipmentReport_sp_Automatically_Process_TOP_20_OEM_Customer_Calendar]
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
	CREATE TABLE #Temp (Year VARCHAR(4),OEMCustomer VARCHAR(300),Amount BIGINT) 
	CREATE NONCLUSTERED INDEX [TempTypeSitePlantOEMDay] ON [#Temp] 
	(
		[Year] ASC,[OEMCustomer] ASC
	)
	SET @SQLString=''
	SET @Year=CONVERT(VARCHAR(4),GETDATE()-1,120)
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
		
			SET @Year=CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=@Year+'-01-01' 
			SET @DateTo=CONVERT(VARCHAR(10),CONVERT(DATETIME,CONVERT(CHAR(4),CONVERT(INT,@Year)+1)+'-01-01') -1,120)

			-- Dis Process Top 20 Customers 
			TRUNCATE TABLE #Temp
			SET @OEMCustomer='Customer'
			/*
			INSERT INTO #Temp (Year,OEMCustomer,Amount) 
			SELECT @Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM(@OEMCustomer,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer a
			WHERE a.Year=@Year
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer(Year ,Customer,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer b WHERE b.Year+b.Customer=a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			*/
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer
			--SET DisAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,'Dis','',@DateFrom,@DateTo),
			--	ChiAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,'Chi','',@DateFrom,@DateTo),
			--	GerAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,'Ger','',@DateFrom,@DateTo),
			SET	NfdAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,'Nfd','',@DateFrom,@DateTo),
				SaoAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,'Sao','',@DateFrom,@DateTo)
			WHERE Year=@Year
				
			TRUNCATE TABLE #Temp
			SET @OEMCustomer='OEM'
			/*
			INSERT INTO #Temp (Year,OEMCustomer,Amount) 
			SELECT @Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM(@OEMCustomer,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM a
			WHERE a.Year=@Year
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM(Year ,OEM,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM b WHERE b.Year+b.OEM=a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			*/
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM
			--SET DisAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,'Dis','',@DateFrom,@DateTo),
			--	ChiAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,'Chi','',@DateFrom,@DateTo),
			--	GerAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,'Ger','',@DateFrom,@DateTo),
			SET	NfdAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,'Nfd','',@DateFrom,@DateTo),
				SaoAmount=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,'Sao','',@DateFrom,@DateTo)
			WHERE Year=@Year

			SET @i=@i+1
		END

	UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer
	SET Amount=DisAmount+ChiAmount+NfdAmount+SaoAmount+GerAmount
	UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM
	SET Amount=DisAmount+ChiAmount+NfdAmount+SaoAmount+GerAmount

END
GO

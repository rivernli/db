USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[AccountProfile_sp_Add_Data]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AccountProfile_sp_Add_Data]
   @ID INT=NULL,
   @Customer nvarchar(50),
   @Market nvarchar(50),
   @Location nvarchar(50),
   @FlextronicsBusinessSegment nvarchar(50),
   @TickerSymbol nvarchar(50),
   @CustomersAnnualRevenue nvarchar(50),
   @CustomersWebSite nvarchar(50),
   @RevenueCurrency nvarchar(50),
   @TAM nvarchar(50),
   @RevenueYear nvarchar(50),
   @MultekSAM nvarchar(50),
   @CustomersProfitability nvarchar(50),
   @MultekMarketShareOfSAM nvarchar(50),
   @KeyPurchasingContact nvarchar(50),
   @FY14Revenue nvarchar(50),
   @PurchasingManager nvarchar(50),
   @FY15Forecast nvarchar(50),
   @SupplierQualityEngineer nvarchar(50),
   @FY16Forecast nvarchar(50),
   @VPofSupplyChainPurchasing nvarchar(50),
   @FY17Forecast nvarchar(50),
   @President nvarchar(50),
   @ProgramsSupported nvarchar(300),
   @ProgramsSupported_remark nvarchar(50),
   @MultekApprovedFacilities nvarchar(50),
   @MultekCompetitors nvarchar(300),
   @StrategyforGrowth nvarchar(max),
   @FlextronicsBDMGAM nvarchar(50),
   @MultekSalesPerson nvarchar(50),
   @UserName nvarchar(50),
   @CreateDate datetime=NULL,
   @Operation VARCHAR(10) 
AS

IF @Operation='Insert' 
	BEGIN		 
			INSERT INTO AccountProfile_Data 
           ([Customer]
           ,[Market]
           ,[Location]
           ,[FlextronicsBusinessSegment]
           ,[TickerSymbol]
           ,[CustomersAnnualRevenue]
           ,[CustomersWebSite]
           ,[RevenueCurrency]
           ,[TAM]
           ,[RevenueYear]
           ,[MultekSAM]
           ,[CustomersProfitability]
           ,[MultekMarketShareOfSAM]
           ,[KeyPurchasingContact]
           ,[FY14Revenue]
           ,[PurchasingManager]
           ,[FY15Forecast]
           ,[SupplierQualityEngineer]
           ,[FY16Forecast]
           ,[VPofSupplyChainPurchasing]
           ,[FY17Forecast]
           ,[President]
           ,[ProgramsSupported]
           ,[ProgramsSupported_remark]
           ,[MultekApprovedFacilities]
           ,[MultekCompetitors]
           ,[StrategyforGrowth]
           ,[FlextronicsBDMGAM]
           ,[MultekSalesPerson]
           ,[CreateUser]
           ,[CreateDate])
     VALUES
           (@Customer,
		   @Market,
		   @Location,
		   @FlextronicsBusinessSegment,
		   @TickerSymbol,
		   @CustomersAnnualRevenue,
		   @CustomersWebSite,
		   @RevenueCurrency,
		   @TAM,
		   @RevenueYear,
		   @MultekSAM,
		   @CustomersProfitability,
		   @MultekMarketShareOfSAM,
		   @KeyPurchasingContact,
		   @FY14Revenue,
		   @PurchasingManager,
		   @FY15Forecast,
		   @SupplierQualityEngineer,
		   @FY16Forecast,
		   @VPofSupplyChainPurchasing,
		   @FY17Forecast,
		   @President,
		   @ProgramsSupported,
		   @ProgramsSupported_remark,
		   @MultekApprovedFacilities,
		   @MultekCompetitors,
		   @StrategyforGrowth,
		   @FlextronicsBDMGAM,
		   @MultekSalesPerson,
		   @UserName,
		   @CreateDate);
		   
	SET @ID = @@IDENTITY;
	END 

IF @Operation='Update' 
	BEGIN
			UPDATE AccountProfile_Data 
		   SET [Customer] = @Customer 
			  ,[Market] = @Market 
			  ,[Location] = @Location 
			  ,[FlextronicsBusinessSegment] = @FlextronicsBusinessSegment 
			  ,[TickerSymbol] = @TickerSymbol 
			  ,[CustomersAnnualRevenue] = @CustomersAnnualRevenue 
			  ,[CustomersWebSite] = @CustomersWebSite 
			  ,[RevenueCurrency] = @RevenueCurrency 
			  ,[TAM] = @TAM 
			  ,[RevenueYear] = @RevenueYear 
			  ,[MultekSAM] = @MultekSAM 
			  ,[CustomersProfitability] = @CustomersProfitability 
			  ,[MultekMarketShareOfSAM] = @MultekMarketShareOfSAM 
			  ,[KeyPurchasingContact] = @KeyPurchasingContact 
			  ,[FY14Revenue] = @FY14Revenue 
			  ,[PurchasingManager] = @PurchasingManager 
			  ,[FY15Forecast] = @FY15Forecast 
			  ,[SupplierQualityEngineer] = @SupplierQualityEngineer 
			  ,[FY16Forecast] = @FY16Forecast 
			  ,[VPofSupplyChainPurchasing] = @VPofSupplyChainPurchasing 
			  ,[FY17Forecast] = @FY17Forecast 
			  ,[President] = @President 
			  ,[ProgramsSupported] = @ProgramsSupported 
			  ,[ProgramsSupported_remark] = @ProgramsSupported_remark 
			  ,[MultekApprovedFacilities] = @MultekApprovedFacilities 
			  ,[MultekCompetitors] = @MultekCompetitors 
			  ,[StrategyforGrowth] = @StrategyforGrowth 
			  ,[FlextronicsBDMGAM] = @FlextronicsBDMGAM  
			  ,[MultekSalesPerson] = @MultekSalesPerson 
			  ,[ModifyUser] = @UserName 
			  ,[MondifyDate] = @CreateDate  
		 WHERE ID=@ID ;
	END
	
	
	
	--Insert Modify Logs	
	INSERT INTO AccountProfile_Data_Log 
           ([MID] 
           ,[Customer]
           ,[Market]
           ,[Location]
           ,[FlextronicsBusinessSegment]
           ,[TickerSymbol]
           ,[CustomersAnnualRevenue]
           ,[CustomersWebSite]
           ,[RevenueCurrency]
           ,[TAM]
           ,[RevenueYear]
           ,[MultekSAM]
           ,[CustomersProfitability]
           ,[MultekMarketShareOfSAM]
           ,[KeyPurchasingContact]
           ,[FY14Revenue]
           ,[PurchasingManager]
           ,[FY15Forecast]
           ,[SupplierQualityEngineer]
           ,[FY16Forecast]
           ,[VPofSupplyChainPurchasing]
           ,[FY17Forecast]
           ,[President]
           ,[ProgramsSupported]
           ,[ProgramsSupported_remark]
           ,[MultekApprovedFacilities]
           ,[MultekCompetitors]
           ,[StrategyforGrowth]
           ,[FlextronicsBDMGAM]
           ,[MultekSalesPerson]
           ,[ModifyUser]
           ,[MondifyDate])
     VALUES
           (@ID,
           @Customer,
		   @Market,
		   @Location,
		   @FlextronicsBusinessSegment,
		   @TickerSymbol,
		   @CustomersAnnualRevenue,
		   @CustomersWebSite,
		   @RevenueCurrency,
		   @TAM,
		   @RevenueYear,
		   @MultekSAM,
		   @CustomersProfitability,
		   @MultekMarketShareOfSAM,
		   @KeyPurchasingContact,
		   @FY14Revenue,
		   @PurchasingManager,
		   @FY15Forecast,
		   @SupplierQualityEngineer,
		   @FY16Forecast,
		   @VPofSupplyChainPurchasing,
		   @FY17Forecast,
		   @President,
		   @ProgramsSupported,
		   @ProgramsSupported_remark,
		   @MultekApprovedFacilities,
		   @MultekCompetitors,
		   @StrategyforGrowth,
		   @FlextronicsBDMGAM,
		   @MultekSalesPerson,
		   @UserName,
		   @CreateDate)
	


















GO

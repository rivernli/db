USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[AccountProfile_Data]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountProfile_Data](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Customer] [nvarchar](50) NULL,
	[Market] [nvarchar](200) NULL,
	[Location] [nvarchar](50) NULL,
	[FlextronicsBusinessSegment] [nvarchar](50) NULL,
	[TickerSymbol] [nvarchar](50) NULL,
	[CustomersAnnualRevenue] [float] NULL,
	[CustomersWebSite] [nvarchar](50) NULL,
	[RevenueCurrency] [nvarchar](50) NULL,
	[TAM] [float] NULL,
	[RevenueYear] [nvarchar](50) NULL,
	[MultekSAM] [float] NULL,
	[CustomersProfitability] [nvarchar](50) NULL,
	[MultekMarketShareOfSAM] [nvarchar](50) NULL,
	[KeyPurchasingContact] [nvarchar](50) NULL,
	[FY14Revenue] [float] NULL,
	[PurchasingManager] [nvarchar](50) NULL,
	[FY15Forecast] [float] NULL,
	[SupplierQualityEngineer] [nvarchar](50) NULL,
	[FY16Forecast] [float] NULL,
	[VPofSupplyChainPurchasing] [nvarchar](50) NULL,
	[FY17Forecast] [float] NULL,
	[President] [nvarchar](50) NULL,
	[ProgramsSupported] [nvarchar](300) NULL,
	[ProgramsSupported_remark] [nvarchar](50) NULL,
	[MultekApprovedFacilities] [nvarchar](50) NULL,
	[MultekCompetitors] [nvarchar](300) NULL,
	[StrategyforGrowth] [nvarchar](max) NULL,
	[FlextronicsBDMGAM] [nvarchar](50) NULL,
	[MultekSalesPerson] [nvarchar](50) NULL,
	[CreateUser] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL CONSTRAINT [DF_AccountProfile_Data_CreateDate]  DEFAULT (getdate()),
	[ModifyUser] [nvarchar](50) NULL,
	[MondifyDate] [datetime] NULL,
 CONSTRAINT [PK_AccountProfile_Data] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

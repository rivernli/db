USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EXR2_Details_bk20130928]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXR2_Details_bk20130928](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FYear] [nvarchar](10) NULL,
	[Period] [nvarchar](50) NULL,
	[Plant] [nvarchar](50) NULL,
	[Project] [nvarchar](50) NULL,
	[ShipmentQty] [float] NULL,
	[ShipmentArea(SQFT)] [float] NULL,
	[ScrapRate] [float] NULL,
	[CostAmountIncludeScrap] [float] NULL,
	[CostAmountExcludeScrap] [float] NULL,
	[UnitPrice] [float] NULL,
	[SalesAmount] [float] NULL,
	[TotalCostExcludedScrap] [float] NULL,
	[TotalCostIncludedScrap] [float] NULL,
	[StdCostIncludedScrap] [float] NULL,
	[StdCostExcludedScrap] [float] NULL,
	[t$cesu] [float] NULL,
	[t$cisu] [float] NULL,
	[t$tciu] [float] NULL,
	[t$tcuu] [float] NULL,
	[t$cupn] [nvarchar](30) NULL,
	[t$type] [nvarchar](30) NULL,
	[t$code] [nvarchar](30) NULL,
	[OEMName] [nvarchar](30) NULL
) ON [PRIMARY]

GO

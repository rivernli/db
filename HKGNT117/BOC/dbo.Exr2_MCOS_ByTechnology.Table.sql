USE [BOC]
GO
/****** Object:  Table [dbo].[Exr2_MCOS_ByTechnology]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exr2_MCOS_ByTechnology](
	[Technology] [nvarchar](50) NULL,
	[Plant] [nvarchar](50) NULL,
	[FiscalYear] [int] NULL,
	[FiscalYearDesc] [nvarchar](50) NULL,
	[FiscalQuarter] [int] NULL,
	[FiscalQuarterDesc] [nvarchar](50) NULL,
	[FiscalPeriod] [int] NULL,
	[FiscalPeriodDesc] [nvarchar](50) NULL,
	[ShipmentQty] [float] NULL,
	[UnitPrice] [float] NULL,
	[ScrapRate] [float] NULL,
	[SalesAmount] [decimal](18, 2) NULL,
	[Bom] [decimal](18, 2) NULL,
	[BomPercentage] [decimal](18, 2) NULL,
	[BOM100] [decimal](18, 2) NULL,
	[Bom100Percentage] [decimal](18, 2) NULL,
	[Bom+EDM] [decimal](18, 2) NULL,
	[Bom+EDMPercentage] [decimal](18, 2) NULL,
	[BOM+EDM100] [decimal](18, 2) NULL,
	[Bom+EDM100Percentage] [decimal](18, 2) NULL
) ON [PRIMARY]

GO

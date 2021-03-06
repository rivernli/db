USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[VI_Report_Shipped_All]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VI_Report_Shipped_All](
	[Loc] [varchar](3) NULL,
	[SONum] [varchar](15) NULL,
	[SOPos] [numeric](18, 4) NULL,
	[SHDate] [datetime] NULL,
	[CustNum] [varchar](15) NULL,
	[InvCustName] [varchar](100) NULL,
	[SHBrds] [numeric](18, 4) NULL,
	[SHDols] [float] NULL,
	[BaanItemNum] [varchar](55) NULL,
	[OEM Name] [varchar](100) NULL,
	[Customer Name] [varchar](100) NULL,
	[Lays] [int] NULL,
	[SHDols_Loc] [numeric](18, 4) NULL,
	[CostB_Loc] [numeric](18, 4) NULL,
	[ShipID] [numeric](18, 4) NULL,
	[Plant] [varchar](10) NULL,
	[SOType] [varchar](3) NULL,
	[Area] [numeric](18, 4) NULL,
	[Real_OEM] [varchar](100) NULL,
	[Real_Customer] [varchar](100) NULL,
	[AutoID] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

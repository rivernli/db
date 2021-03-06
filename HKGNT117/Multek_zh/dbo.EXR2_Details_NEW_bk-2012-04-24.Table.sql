USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EXR2_Details_NEW_bk-2012-04-24]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXR2_Details_NEW_bk-2012-04-24](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FYear] [nvarchar](10) NULL,
	[Period] [nvarchar](50) NULL,
	[Plant] [nvarchar](50) NULL,
	[Project] [nvarchar](50) NULL,
	[OEM_Name] [nvarchar](50) NULL,
	[UnitPrice] [float] NULL,
	[ShipmentQty] [float] NULL,
	[SalesAmount] [float] NULL,
	[ShipmentArea_SQFT] [float] NULL,
	[TotalCostExcludedScrap] [float] NULL,
	[TotalCostIncludedScrap] [float] NULL,
	[StdCostIncludedScrap] [float] NULL,
	[StdCostExcludedScrap] [float] NULL,
	[t$cesu] [float] NULL,
	[t$cisu] [float] NULL,
	[t$tciu] [float] NULL,
	[t$tcuu] [float] NULL,
 CONSTRAINT [PK_EXR2_Details_new_bk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EXR2_Details]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXR2_Details](
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
	[OEMName] [nvarchar](30) NULL,
 CONSTRAINT [PK_EXR2_Details] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [FYear]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [FYear] ON [dbo].[EXR2_Details]
(
	[FYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_EXR2_Details]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_EXR2_Details] ON [dbo].[EXR2_Details]
(
	[FYear] ASC,
	[Plant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Period]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Period] ON [dbo].[EXR2_Details]
(
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Plant]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Plant] ON [dbo].[EXR2_Details]
(
	[Plant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Project]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Project] ON [dbo].[EXR2_Details]
(
	[Project] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

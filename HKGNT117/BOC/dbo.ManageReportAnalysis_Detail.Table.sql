USE [BOC]
GO
/****** Object:  Table [dbo].[ManageReportAnalysis_Detail]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManageReportAnalysis_Detail](
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
 CONSTRAINT [PK_ManageReportAnalysis_Detail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [FYear]    Script Date: 2014/11/12 17:02:03 ******/
CREATE NONCLUSTERED INDEX [FYear] ON [dbo].[ManageReportAnalysis_Detail]
(
	[FYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Period]    Script Date: 2014/11/12 17:02:03 ******/
CREATE NONCLUSTERED INDEX [Period] ON [dbo].[ManageReportAnalysis_Detail]
(
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Plant]    Script Date: 2014/11/12 17:02:03 ******/
CREATE NONCLUSTERED INDEX [Plant] ON [dbo].[ManageReportAnalysis_Detail]
(
	[Plant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Project]    Script Date: 2014/11/12 17:02:03 ******/
CREATE NONCLUSTERED INDEX [Project] ON [dbo].[ManageReportAnalysis_Detail]
(
	[Project] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

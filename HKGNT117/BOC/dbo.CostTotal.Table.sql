USE [BOC]
GO
/****** Object:  Table [dbo].[CostTotal]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CostTotal](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FYear] [nvarchar](10) NULL,
	[Period] [nvarchar](10) NULL,
	[Plant] [nvarchar](50) NULL,
	[TotalCostExcludeYield_Amount] [float] NULL,
	[TotalCostIncludeYield_Amount] [float] NULL,
	[MaterialCostExcludeYield_Amount] [float] NULL,
	[MaterialCostIncludeYield_Amount] [float] NULL,
	[SalesAmount] [float] NULL,
	[MaterialIssue] [float] NULL,
	[TotalSQFT] [float] NULL
) ON [PRIMARY]

GO

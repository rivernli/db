USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EXR2_Fixed_All_projects_by_MAT_percentage]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXR2_Fixed_All_projects_by_MAT_percentage](
	[FYear] [nvarchar](10) NULL,
	[Period] [nvarchar](50) NULL,
	[t$cupn] [nvarchar](30) NULL,
	[Plant] [nvarchar](50) NULL,
	[OEM_NAME] [nvarchar](50) NULL,
	[Project] [nvarchar](50) NULL,
	[MATCost] [float] NULL,
	[UnitPrice] [float] NULL,
	[ShipmentQty] [float] NULL,
	[SalesAmount] [float] NULL,
	[PERCENTAGE] [float] NULL
) ON [PRIMARY]

GO

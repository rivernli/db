USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EXR2_Fixed_Unit_Selling_Price]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXR2_Fixed_Unit_Selling_Price](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Plant] [nvarchar](10) NULL,
	[FYear] [nvarchar](50) NULL,
	[Project] [nvarchar](50) NULL,
	[OEM_Name] [nvarchar](50) NULL,
	[Operation] [nvarchar](50) NULL,
	[SaleAmount] [decimal](18, 2) NULL,
	[P01] [nvarchar](50) NULL,
	[P02] [nvarchar](50) NULL,
	[P03] [nvarchar](50) NULL,
	[P04] [nvarchar](50) NULL,
	[P05] [nvarchar](50) NULL,
	[P06] [nvarchar](50) NULL,
	[P07] [nvarchar](50) NULL,
	[P08] [nvarchar](50) NULL,
	[P09] [nvarchar](50) NULL,
	[P10] [nvarchar](50) NULL,
	[P11] [nvarchar](50) NULL,
	[P12] [nvarchar](50) NULL,
 CONSTRAINT [PK_EXR2_Fixed_Unit_Selling_Price] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [FYear]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [FYear] ON [dbo].[EXR2_Fixed_Unit_Selling_Price]
(
	[FYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [OEM]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [OEM] ON [dbo].[EXR2_Fixed_Unit_Selling_Price]
(
	[OEM_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Operation]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Operation] ON [dbo].[EXR2_Fixed_Unit_Selling_Price]
(
	[Operation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Plant]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Plant] ON [dbo].[EXR2_Fixed_Unit_Selling_Price]
(
	[Plant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Project]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Project] ON [dbo].[EXR2_Fixed_Unit_Selling_Price]
(
	[Project] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [SalesAmount]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [SalesAmount] ON [dbo].[EXR2_Fixed_Unit_Selling_Price]
(
	[SaleAmount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

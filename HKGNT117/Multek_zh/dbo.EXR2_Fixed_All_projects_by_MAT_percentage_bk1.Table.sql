USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EXR2_Fixed_All_projects_by_MAT_percentage_bk1]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXR2_Fixed_All_projects_by_MAT_percentage_bk1](
	[FYear] [nvarchar](10) NULL,
	[Period] [nvarchar](50) NULL,
	[Plant] [nvarchar](50) NULL,
	[OEM_NAME] [nvarchar](50) NULL,
	[Project] [nvarchar](50) NULL,
	[MATCost] [float] NULL,
	[UnitPrice] [float] NULL,
	[ShipmentQty] [float] NULL,
	[SalesAmount] [float] NULL,
	[PERCENTAGE] [float] NULL,
	[t$cupn] [nvarchar](30) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [FYear]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [FYear] ON [dbo].[EXR2_Fixed_All_projects_by_MAT_percentage_bk1]
(
	[FYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [OEM]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [OEM] ON [dbo].[EXR2_Fixed_All_projects_by_MAT_percentage_bk1]
(
	[OEM_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Percentage]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Percentage] ON [dbo].[EXR2_Fixed_All_projects_by_MAT_percentage_bk1]
(
	[PERCENTAGE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Period]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Period] ON [dbo].[EXR2_Fixed_All_projects_by_MAT_percentage_bk1]
(
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Plant]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Plant] ON [dbo].[EXR2_Fixed_All_projects_by_MAT_percentage_bk1]
(
	[Plant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Project]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Project] ON [dbo].[EXR2_Fixed_All_projects_by_MAT_percentage_bk1]
(
	[Project] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [SalesAmount]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [SalesAmount] ON [dbo].[EXR2_Fixed_All_projects_by_MAT_percentage_bk1]
(
	[SalesAmount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

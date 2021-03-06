USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KOI_InputByHR]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KOI_InputByHR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Plant] [varchar](2) NULL,
	[Period] [varchar](20) NULL,
	[Financey] [varchar](20) NULL,
	[WorkingHours] [float] NULL,
	[Headcount] [float] NULL,
 CONSTRAINT [PK_KOI_InputByHR] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [FinanceyPeriodPlant]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [FinanceyPeriodPlant] ON [dbo].[KOI_InputByHR]
(
	[Financey] ASC,
	[Period] ASC,
	[Plant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_KOI_InputByHR]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_KOI_InputByHR] ON [dbo].[KOI_InputByHR]
(
	[Period] ASC,
	[Financey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PlantFinancey]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [PlantFinancey] ON [dbo].[KOI_InputByHR]
(
	[Plant] ASC,
	[Financey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

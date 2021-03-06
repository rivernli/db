USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP105180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP105180](
	[T$LOCA] [char](6) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$DESC] [char](30) NOT NULL,
	[T$DQUA] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$CSGS] [char](30) NOT NULL,
	[T$DACA] [char](30) NOT NULL,
	[T$LAYS] [char](3) NOT NULL,
	[T$DOLS] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$HKDT] [datetime] NULL,
	[T$CCTY] [char](3) NOT NULL,
	[T$PRDT] [char](30) NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$SQFT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Country]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Country] ON [dbo].[TFSOLP105180]
(
	[T$CCTY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [DateSqft]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [DateSqft] ON [dbo].[TFSOLP105180]
(
	[T$DATE] ASC,
	[T$SQFT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Item]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Item] ON [dbo].[TFSOLP105180]
(
	[T$ITEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Item_Date_Loca]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Item_Date_Loca] ON [dbo].[TFSOLP105180]
(
	[T$ITEM] ASC,
	[T$DATE] ASC,
	[T$LOCA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Item_Plant_Date_Loca]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Item_Plant_Date_Loca] ON [dbo].[TFSOLP105180]
(
	[T$ITEM] ASC,
	[T$PLNT] ASC,
	[T$DATE] ASC,
	[T$LOCA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [loca_date_plnt_csgs]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [loca_date_plnt_csgs] ON [dbo].[TFSOLP105180]
(
	[T$LOCA] ASC,
	[T$DATE] ASC,
	[T$PLNT] ASC,
	[T$CSGS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PlantDateSqft]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [PlantDateSqft] ON [dbo].[TFSOLP105180]
(
	[T$PLNT] ASC,
	[T$DATE] ASC,
	[T$SQFT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PlantItemDate]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [PlantItemDate] ON [dbo].[TFSOLP105180]
(
	[T$ITEM] ASC,
	[T$DATE] ASC,
	[T$PLNT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PlntDateLoca]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [PlntDateLoca] ON [dbo].[TFSOLP105180]
(
	[T$DATE] ASC,
	[T$LOCA] ASC,
	[T$PLNT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [SiteDate]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [SiteDate] ON [dbo].[TFSOLP105180]
(
	[T$LOCA] ASC,
	[T$DATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [SitePlantCountryDate]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [SitePlantCountryDate] ON [dbo].[TFSOLP105180]
(
	[T$LOCA] ASC,
	[T$PLNT] ASC,
	[T$CCTY] ASC,
	[T$DATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [SitePlantDate]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [SitePlantDate] ON [dbo].[TFSOLP105180]
(
	[T$LOCA] ASC,
	[T$PLNT] ASC,
	[T$DATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [SitePlantDateCustomer]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [SitePlantDateCustomer] ON [dbo].[TFSOLP105180]
(
	[T$LOCA] ASC,
	[T$PLNT] ASC,
	[T$DATE] ASC,
	[T$DESC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [SitePlantDateOEM]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [SitePlantDateOEM] ON [dbo].[TFSOLP105180]
(
	[T$LOCA] ASC,
	[T$PLNT] ASC,
	[T$DATE] ASC,
	[T$CSGS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [SitePlantLayDate]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [SitePlantLayDate] ON [dbo].[TFSOLP105180]
(
	[T$LOCA] ASC,
	[T$PLNT] ASC,
	[T$LAYS] ASC,
	[T$DATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

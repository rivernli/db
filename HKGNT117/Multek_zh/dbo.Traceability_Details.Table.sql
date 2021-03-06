USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Traceability_Details]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Traceability_Details](
	[T$PLNT] [char](2) NOT NULL,
	[T$LTNO] [char](32) NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$SEQU] [float] NOT NULL,
	[T$MACH] [char](20) NOT NULL,
	[T$MATR] [char](30) NOT NULL,
	[t$DDEC] [char](30) NULL,
	[T$suno] [char](6) NULL,
	[t$DESC] [char](35) NULL,
	[T$TOOL] [char](15) NOT NULL,
	[T$REMK] [char](30) NOT NULL,
	[T$DATE] [varchar](10) NULL,
	[T$TIME] [nvarchar](8) NULL,
	[T$USER] [char](15) NOT NULL,
	[T$MBCD] [char](20) NOT NULL,
	[T$DCDE] [char](10) NOT NULL,
	[T$PCDE] [char](20) NOT NULL,
	[T$PROJ] [char](30) NOT NULL,
	[T$PJNO] [char](8) NOT NULL,
	[T$MNWC] [char](3) NOT NULL,
	[T$BCDE] [char](2) NOT NULL,
	[T$TQTY] [float] NOT NULL,
	[T$TRCD] [char](10) NOT NULL,
	[T$OULN] [char](16) NOT NULL,
	[T$SPLN] [char](16) NOT NULL,
	[T$STMP] [char](4) NOT NULL,
	[T$MTYP] [float] NOT NULL,
	[T$LCQT] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Index_date]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Index_date] ON [dbo].[Traceability_Details]
(
	[T$DATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Main_Index]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Main_Index] ON [dbo].[Traceability_Details]
(
	[T$PLNT] ASC,
	[T$LTNO] ASC,
	[T$SEQU] ASC,
	[T$TRCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

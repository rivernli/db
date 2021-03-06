USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[TFSATT010180]    Script Date: 11/06/2014 15:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSATT010180](
	[T$ITEM] [char](32) NOT NULL,
	[T$DSCA] [char](30) NOT NULL,
	[T$CUNI] [char](6) NOT NULL,
	[T$STGU] [char](3) NOT NULL,
	[T$MATS] [char](30) NOT NULL,
	[T$VDPN] [char](30) NOT NULL,
	[T$DDIA] [float] NOT NULL,
	[T$DIUN] [char](3) NOT NULL,
	[T$DFLN] [float] NOT NULL,
	[T$FLUN] [char](3) NOT NULL,
	[T$VDOR] [char](30) NOT NULL,
	[T$MAFR] [char](30) NOT NULL,
	[T$LOCA] [char](30) NOT NULL,
	[T$CTRY] [char](30) NOT NULL,
	[T$WKCR] [char](30) NOT NULL,
	[T$CATG] [char](30) NOT NULL,
	[T$ITGP] [char](30) NOT NULL,
	[T$PUNI] [char](3) NOT NULL,
	[T$MAFA] [char](30) NOT NULL,
	[T$IUB1] [char](30) NOT NULL,
	[T$IUB2] [char](30) NOT NULL,
	[T$IUB3] [char](30) NOT NULL,
	[T$IUB4] [char](30) NOT NULL,
	[T$IUB5] [char](30) NOT NULL,
	[T$IUHK] [char](30) NOT NULL,
	[T$CSIG] [char](3) NOT NULL,
	[T$RLOC] [char](30) NOT NULL,
	[T$FLUQ] [float] NOT NULL,
	[T$ANGL] [float] NOT NULL,
	[T$SUNO] [char](6) NOT NULL,
	[T$IU2F] [char](30) NOT NULL,
	[T$IU12] [char](30) NOT NULL,
	[T$ROHS] [char](30) NOT NULL,
	[T$GPCC] [char](30) NOT NULL,
	[T$STSA] [char](30) NOT NULL,
	[T$STCD] [char](30) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_TFSATT010180] ON [dbo].[TFSATT010180] 
(
	[T$ITEM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

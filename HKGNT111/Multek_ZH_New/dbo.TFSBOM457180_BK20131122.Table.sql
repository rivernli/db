USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[TFSBOM457180_BK20131122]    Script Date: 11/06/2014 15:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM457180_BK20131122](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$TYPE] [char](2) NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$ATTR] [char](5) NOT NULL,
	[T$ASTR] [char](155) NOT NULL,
	[T$MNWC] [char](4) NOT NULL,
	[T$ANUM] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$DRSZ] [float] NOT NULL,
	[T$DRQT] [float] NOT NULL,
	[T$DRST] [float] NOT NULL,
	[T$DRTY] [char](10) NOT NULL,
	[T$THIN] [float] NOT NULL,
	[T$AREA] [float] NOT NULL,
	[T$UNIT] [char](3) NOT NULL,
	[T$LUPQ] [float] NOT NULL,
	[T$MCOD] [char](4) NOT NULL,
	[T$SIDA] [float] NOT NULL,
	[T$SIDB] [float] NOT NULL,
	[T$NSID] [float] NOT NULL,
	[T$PICE] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

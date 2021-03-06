USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP131180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP131180](
	[T$BTNO] [float] NOT NULL,
	[T$RGDT] [datetime] NOT NULL,
	[T$USER] [char](10) NOT NULL,
	[T$REAA] [float] NOT NULL,
	[T$RETY] [float] NOT NULL,
	[T$PRTY] [char](6) NOT NULL,
	[T$YEAR] [char](6) NOT NULL,
	[T$PROD] [char](2) NOT NULL,
	[T$FWEK] [char](2) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$ODTY] [char](6) NOT NULL,
	[T$BKTP] [char](12) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$COMT] [char](32) NOT NULL,
	[T$PDAT] [datetime] NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CDEL] [char](3) NOT NULL,
	[T$CUNO3] [char](6) NOT NULL,
	[T$CDEL3] [char](3) NOT NULL,
	[T$BQTY] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$PPRC] [float] NOT NULL,
	[T$BAMNT] [float] NOT NULL,
	[T$PAMNT] [float] NOT NULL,
	[T$SAMNT] [float] NOT NULL,
	[T$PASH] [char](10) NOT NULL,
	[T$LOSA] [char](10) NOT NULL,
	[T$OPMK] [char](50) NOT NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$CNAME] [char](35) NOT NULL,
	[T$CDDL] [char](30) NOT NULL,
	[T$CURR] [char](3) NOT NULL,
	[T$SQFT] [float] NOT NULL,
	[T$UNPL] [float] NOT NULL,
	[T$PANL] [float] NOT NULL,
	[T$CPAR] [char](30) NOT NULL,
	[T$CRFN] [char](6) NOT NULL,
	[T$MKCS] [char](30) NOT NULL,
	[T$OEMS] [char](30) NOT NULL,
	[T$CDEC] [char](3) NOT NULL,
	[T$CPAY] [char](3) NOT NULL,
	[T$MFLO] [char](30) NOT NULL,
	[T$SOMK] [char](30) NOT NULL,
	[T$INMK] [char](30) NOT NULL,
	[T$STYP] [char](10) NOT NULL,
	[T$LODEL] [char](10) NOT NULL,
	[T$DIM1] [char](10) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSCPP264180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSCPP264180](
	[T$STNO] [char](20) NOT NULL,
	[T$WONO] [char](10) NOT NULL,
	[T$WOPO] [float] NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$PJNO] [char](32) NOT NULL,
	[T$RQTY] [float] NOT NULL,
	[T$OQTY] [float] NOT NULL,
	[T$TRDT] [datetime] NULL,
	[T$TRTM] [float] NOT NULL,
	[T$WODT] [datetime] NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$TRWO] [char](10) NOT NULL,
	[T$TRWP] [float] NOT NULL,
	[T$TRWD] [datetime] NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$TRTP] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$MIPJ] [char](16) NOT NULL,
	[T$UNPL] [float] NOT NULL,
	[T$SFPL] [float] NOT NULL,
	[T$PANL] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$OPIC] [float] NOT NULL,
	[T$CURR] [char](3) NOT NULL,
	[T$CEMN] [char](6) NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CDEL] [char](3) NOT NULL,
	[T$CSGS] [char](6) NOT NULL,
	[T$IFCM] [float] NOT NULL,
	[T$CNGW] [char](3) NOT NULL,
	[T$SQFT] [float] NOT NULL,
	[T$YEAR] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$PFIX] [char](3) NOT NULL,
	[T$LYER] [char](2) NOT NULL,
	[T$CRFN] [char](6) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSCPP711180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSCPP711180](
	[T$CUNO] [char](6) NOT NULL,
	[T$CDEL] [char](3) NOT NULL,
	[T$CSGS] [char](6) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$PCDT] [datetime] NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$SQFT] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$TQUA] [float] NOT NULL,
	[T$EFDT] [datetime] NULL,
	[T$ASDT] [datetime] NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$CEMN] [char](6) NOT NULL,
	[T$PREF] [char](1) NOT NULL,
	[T$LYER] [char](2) NOT NULL,
	[T$PFIX] [char](3) NOT NULL,
	[T$CTYP] [char](3) NOT NULL,
	[T$TRDT] [datetime] NULL,
	[T$TRTM] [float] NOT NULL,
	[T$TRID] [char](10) NOT NULL,
	[T$YEAR] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$AJSD] [datetime] NULL,
	[T$SSDT] [datetime] NULL,
	[T$PRIC] [float] NOT NULL,
	[T$MIPJ] [char](16) NOT NULL,
	[T$UNPL] [float] NOT NULL,
	[T$SFPL] [float] NOT NULL,
	[T$PANL] [float] NOT NULL,
	[T$OPIC] [float] NOT NULL,
	[T$CURR] [char](3) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$SANO] [char](20) NOT NULL,
	[T$TYPE] [float] NOT NULL,
	[T$BUNO] [char](6) NOT NULL,
	[T$INVD] [datetime] NULL,
	[T$INVN] [float] NOT NULL,
	[T$USER] [char](8) NOT NULL,
	[T$TYPP] [char](3) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

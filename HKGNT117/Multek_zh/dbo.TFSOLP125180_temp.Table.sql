USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP125180_temp]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP125180_temp](
	[T$ORNO] [float] NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$JDAT] [datetime] NOT NULL,
	[T$WODT] [datetime] NOT NULL,
	[T$PDAT] [datetime] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$NAMA] [char](35) NOT NULL,
	[T$CUPN] [char](30) NOT NULL,
	[T$DSCA] [char](30) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$SPNT] [char](4) NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$OUUA] [float] NOT NULL,
	[T$WONO] [char](10) NOT NULL,
	[T$WOPO] [float] NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$OUMN] [float] NOT NULL,
	[T$SQFT] [float] NOT NULL,
	[T$SITM] [char](32) NOT NULL,
	[T$FLAG] [char](8) NOT NULL,
	[T$ISUB] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

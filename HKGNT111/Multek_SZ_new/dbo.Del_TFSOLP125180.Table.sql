USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[Del_TFSOLP125180]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Del_TFSOLP125180](
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$JDAT] [datetime] NULL,
	[T$WODT] [datetime] NULL,
	[T$PDAT] [datetime] NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$NAMA] [char](35) NOT NULL,
	[T$DSCA] [char](30) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
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

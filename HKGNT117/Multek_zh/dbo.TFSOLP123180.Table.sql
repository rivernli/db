USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP123180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP123180](
	[T$DATE] [datetime] NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$YDSC] [char](15) NOT NULL,
	[T$PRID] [char](3) NOT NULL,
	[T$CUDL] [char](10) NOT NULL,
	[T$CODE] [char](6) NOT NULL,
	[T$CUST] [char](35) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$PRDN] [char](30) NOT NULL,
	[T$OEMA] [char](30) NOT NULL,
	[T$DSCA] [char](30) NOT NULL,
	[T$CRFN] [char](8) NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$DDTA] [datetime] NULL,
	[T$SFLG] [float] NOT NULL,
	[T$SSTA] [char](10) NOT NULL,
	[T$QTYA] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$SQFT] [float] NOT NULL,
	[T$PLNT] [char](8) NOT NULL,
	[T$OHDT] [datetime] NULL,
	[T$OHNO] [char](20) NOT NULL,
	[T$DPAT] [char](3) NOT NULL,
	[T$CSMA] [char](30) NOT NULL,
	[T$SALM] [char](35) NOT NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$DIM1] [char](6) NOT NULL,
	[T$FLAG] [char](20) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

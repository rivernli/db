USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP112180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP112180](
	[T$SOUR] [char](30) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$CSGS] [char](30) NOT NULL,
	[T$CUNO] [char](35) NOT NULL,
	[T$PRDT] [char](30) NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$AREA] [float] NOT NULL,
	[T$LYER] [char](5) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$YEAR] [char](10) NOT NULL,
	[T$PROD] [char](10) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

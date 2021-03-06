USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSPUR034180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSPUR034180](
	[T$SERN] [float] NOT NULL,
	[T$YEAR] [float] NOT NULL,
	[T$PROD] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$SUNO] [char](6) NOT NULL,
	[T$CITG] [char](6) NOT NULL,
	[T$IQTY] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$CPRC] [float] NOT NULL,
	[T$SAMT] [float] NOT NULL,
	[T$TAMT] [float] NOT NULL,
	[T$TPRC] [float] NOT NULL,
	[T$CCUR] [char](3) NOT NULL,
	[T$DPRC] [float] NOT NULL,
	[T$TRTP] [char](10) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

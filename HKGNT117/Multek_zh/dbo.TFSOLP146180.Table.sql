USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP146180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP146180](
	[T$YEAR] [char](15) NOT NULL,
	[T$PERD] [char](3) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$PROJ] [char](32) NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$QTYI] [float] NOT NULL,
	[T$SQFT] [float] NOT NULL,
	[T$SCRP] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$CORA] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$TCES] [float] NOT NULL,
	[T$TCIS] [float] NOT NULL,
	[T$SCIS] [float] NOT NULL,
	[T$SCES] [float] NOT NULL,
	[T$CESU] [float] NOT NULL,
	[T$CISU] [float] NOT NULL,
	[T$TCIU] [float] NOT NULL,
	[T$TCUU] [float] NOT NULL,
	[T$CUST] [char](30) NOT NULL,
	[T$PRTY] [char](30) NOT NULL,
	[T$SURF] [char](30) NOT NULL,
	[T$OEMN] [char](30) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

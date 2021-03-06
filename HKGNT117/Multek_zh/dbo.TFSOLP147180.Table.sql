USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP147180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP147180](
	[T$YEAR] [char](15) NOT NULL,
	[T$PERD] [char](3) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$PROJ] [char](32) NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$OEMN] [char](50) NOT NULL,
	[T$MCES] [float] NOT NULL,
	[T$MCIS] [float] NOT NULL,
	[T$COSB] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$PRIU] [float] NOT NULL,
	[T$QUTY] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$MCCA] [float] NOT NULL,
	[T$MCET] [float] NOT NULL,
	[T$MCIA] [float] NOT NULL,
	[T$MCIT] [float] NOT NULL,
	[T$AMNB] [float] NOT NULL,
	[T$BCTA] [float] NOT NULL,
	[T$MCTA] [float] NOT NULL,
	[T$MTCT] [float] NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSBOM422180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM422180](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$ITEM] [char](16) NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$FLAY] [char](2) NOT NULL,
	[T$MOLY] [char](2) NOT NULL,
	[T$MTRC] [float] NOT NULL,
	[T$LABC] [float] NOT NULL,
	[T$OHCT] [float] NOT NULL,
	[T$AMTR] [float] NOT NULL,
	[T$ALAB] [float] NOT NULL,
	[T$AOVH] [float] NOT NULL,
	[T$SIDE] [float] NOT NULL,
	[T$PITM] [char](4) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

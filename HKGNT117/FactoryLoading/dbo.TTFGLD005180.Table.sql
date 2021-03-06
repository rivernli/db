USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TTFGLD005180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTFGLD005180](
	[T$PTYP] [float] NOT NULL,
	[T$YEAR] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$STDT] [datetime] NULL,
	[T$DESC] [char](15) NOT NULL,
	[T$CORR] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

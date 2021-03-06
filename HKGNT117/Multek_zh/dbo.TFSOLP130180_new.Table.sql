USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP130180_new]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP130180_new](
	[T$PLNT] [char](2) NOT NULL,
	[T$WONO] [char](10) NOT NULL,
	[T$LRUN] [float] NOT NULL,
	[T$STEP] [float] NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$PITM] [char](16) NOT NULL,
	[T$DTAT] [datetime] NOT NULL,
	[T$QTYA] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

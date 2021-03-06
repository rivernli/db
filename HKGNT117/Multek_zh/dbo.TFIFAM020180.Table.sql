USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFIFAM020180]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFIFAM020180](
	[T$ITEM] [char](32) NOT NULL,
	[T$MITM] [char](32) NOT NULL,
	[T$MANU] [char](6) NOT NULL,
	[T$PACK] [char](32) NOT NULL,
	[T$DSCA] [char](60) NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$COMT] [char](60) NOT NULL,
	[T$CTCN] [float] NOT NULL,
	[T$CTCQ] [float] NOT NULL,
	[T$CTCO] [float] NOT NULL,
	[T$EDCO] [datetime] NULL,
	[T$SHST] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

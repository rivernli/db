USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[tfsolp145180_20130108]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tfsolp145180_20130108](
	[T$COMP] [float] NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CDEL] [char](3) NOT NULL,
	[T$SUNO] [char](6) NOT NULL,
	[T$SDEL] [char](3) NOT NULL,
	[T$CUST] [char](100) NOT NULL,
	[T$ADEL] [char](100) NOT NULL,
	[T$BCUS] [char](100) NOT NULL,
	[T$BADD] [char](100) NOT NULL,
	[T$CURR] [char](3) NOT NULL,
	[T$FING] [char](3) NOT NULL,
	[T$FIND] [char](100) NOT NULL,
	[T$PAYM] [char](30) NOT NULL,
	[T$DELM] [char](30) NOT NULL,
	[T$STAT] [char](30) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

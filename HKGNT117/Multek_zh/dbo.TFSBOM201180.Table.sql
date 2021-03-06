USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSBOM201180]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM201180](
	[T$PITM] [char](16) NOT NULL,
	[T$VERS] [float] NOT NULL,
	[T$CITG] [char](6) NOT NULL,
	[T$STEP] [float] NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$MNWC] [char](4) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$QUTY] [float] NOT NULL,
	[T$UNIT] [char](3) NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$OCUN] [char](3) NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$SEQE] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[Temp_fsbom499]    Script Date: 11/06/2014 15:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Temp_fsbom499](
	[T$USRN] [char](12) NOT NULL,
	[T$PITM] [char](16) NOT NULL,
	[T$STEP] [float] NOT NULL,
	[T$CITG] [char](6) NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$MNWC] [char](4) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$QUTY] [float] NOT NULL,
	[T$UNIT] [char](3) NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$SEQE] [float] NOT NULL,
	[T$PJNO] [char](10) NOT NULL,
	[T$SPRI] [float] NOT NULL,
	[T$SCOS] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

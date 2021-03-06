USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSPUR018180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSPUR018180](
	[T$PLNT] [char](2) NOT NULL,
	[T$UPRN] [char](20) NOT NULL,
	[T$VERS] [char](20) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$USER] [char](10) NOT NULL,
	[T$CITG] [char](6) NOT NULL,
	[T$GRNO] [char](10) NOT NULL,
	[T$SUNO] [char](6) NOT NULL,
	[T$TEXT] [float] NOT NULL,
	[T$STSS] [float] NOT NULL,
	[T$TTYP] [char](1) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

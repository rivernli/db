USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSITM030180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSITM030180](
	[T$SUNO] [char](6) NOT NULL,
	[T$VDPN] [char](32) NOT NULL,
	[T$LOCA] [char](30) NOT NULL,
	[T$CITG] [char](6) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$VERS] [char](20) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

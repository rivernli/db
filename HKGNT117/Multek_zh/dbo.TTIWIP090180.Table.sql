USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTIWIP090180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTIWIP090180](
	[T$PLNT] [char](2) NOT NULL,
	[T$BTNO] [char](20) NOT NULL,
	[T$MNWC] [char](3) NOT NULL,
	[T$PART] [char](6) NOT NULL,
	[T$PJNO] [char](32) NOT NULL,
	[T$ROLE] [float] NOT NULL,
	[T$TYPE] [float] NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$WHNO] [float] NOT NULL,
	[T$OQUA] [float] NOT NULL,
	[T$TRDT] [datetime] NOT NULL,
	[T$TRTM] [float] NOT NULL,
	[T$TRID] [char](10) NOT NULL,
	[T$NGSN] [float] NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

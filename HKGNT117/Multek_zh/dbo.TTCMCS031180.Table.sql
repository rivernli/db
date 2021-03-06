USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTCMCS031180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTCMCS031180](
	[T$CBRN] [char](6) NOT NULL,
	[T$DSCA] [char](30) NOT NULL,
	[T$ADDR] [char](30) NOT NULL,
	[T$CSID] [char](10) NOT NULL,
	[T$SPID] [char](10) NOT NULL,
	[T$SPD2] [char](10) NOT NULL,
	[T$SPD3] [char](10) NOT NULL,
	[T$SPD4] [char](10) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

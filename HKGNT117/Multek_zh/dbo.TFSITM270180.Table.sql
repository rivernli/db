USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSITM270180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSITM270180](
	[T$ITEM] [char](32) NOT NULL,
	[T$MAFA] [float] NOT NULL,
	[T$REDT] [datetime] NULL,
	[T$EXPD] [datetime] NULL,
	[T$ISSU] [float] NOT NULL,
	[T$USNM] [char](10) NOT NULL,
	[T$DEPT] [char](10) NOT NULL,
	[T$REMK] [char](30) NOT NULL,
	[T$OSIG] [char](3) NOT NULL,
	[T$NSIG] [char](3) NOT NULL,
	[T$UPDT] [datetime] NULL,
	[T$UPTM] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

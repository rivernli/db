USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSITM271180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSITM271180](
	[T$MDCN] [char](20) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$ATTR] [char](20) NOT NULL,
	[T$SERI] [float] NOT NULL,
	[T$BVAL] [char](30) NOT NULL,
	[T$AVAL] [char](30) NOT NULL,
	[T$RBDT] [datetime] NULL,
	[T$REMK] [char](100) NOT NULL,
	[T$UPDT] [datetime] NULL,
	[T$UPTM] [float] NOT NULL,
	[T$USNM] [char](8) NOT NULL,
	[T$TLOG] [char](12) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

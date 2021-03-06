USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSPUR017180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSPUR017180](
	[T$UPRN] [char](20) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$STUN] [char](3) NOT NULL,
	[T$POCG] [char](12) NOT NULL,
	[T$PDAT] [datetime] NULL,
	[T$TDAT] [datetime] NULL,
	[T$RQTY] [float] NOT NULL,
	[T$BQTY] [float] NOT NULL,
	[T$BOXQ] [float] NOT NULL,
	[T$TTYP] [char](1) NOT NULL,
	[T$GRNO] [char](10) NOT NULL,
	[T$LOTN] [char](20) NOT NULL,
	[T$DLYN] [char](12) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

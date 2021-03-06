USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTDSLS030183]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTDSLS030183](
	[T$CUNO] [char](6) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$CNTR] [char](3) NOT NULL,
	[T$DILE] [float] NOT NULL,
	[T$QANP] [float] NOT NULL,
	[T$STDT] [datetime] NULL,
	[T$TDAT] [datetime] NULL,
	[T$PRIC] [float] NOT NULL,
	[T$DISC] [float] NOT NULL,
	[T$DAMT] [float] NOT NULL,
	[T$CDIS] [char](3) NOT NULL,
	[T$GNPR] [float] NOT NULL,
	[T$VERS] [char](12) NOT NULL,
	[T$USED] [float] NOT NULL,
	[T$TYPE] [float] NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$FILE] [char](100) NOT NULL,
	[T$RSCD] [char](3) NOT NULL,
	[T$QCPJ] [char](32) NOT NULL,
	[T$RFQN] [char](20) NOT NULL,
	[T$COND] [datetime] NULL,
	[T$CONU] [char](10) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

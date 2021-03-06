USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSBOM465180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM465180](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$MTYP] [char](4) NOT NULL,
	[T$ITEM] [char](30) NOT NULL,
	[T$NAME] [char](100) NOT NULL,
	[T$MQTY] [float] NOT NULL,
	[T$VDPN] [char](30) NOT NULL,
	[T$COTK] [char](8) NOT NULL,
	[T$CPTH] [char](5) NOT NULL,
	[T$CPTR] [char](30) NOT NULL,
	[T$LZBC] [char](1) NOT NULL,
	[T$DNIN] [char](1) NOT NULL,
	[T$CONS] [char](30) NOT NULL,
	[T$PLYU] [char](30) NOT NULL,
	[T$TYPE] [char](20) NOT NULL,
	[T$RESI] [float] NOT NULL,
	[T$PSSQ] [float] NOT NULL,
	[T$PUNI] [char](4) NOT NULL,
	[T$REMK] [char](30) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$VERN] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

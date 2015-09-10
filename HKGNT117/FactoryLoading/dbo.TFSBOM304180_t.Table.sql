USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSBOM304180_t]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM304180_t](
	[T$MRNO] [char](20) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$SITM] [char](32) NOT NULL,
	[T$UNIT] [char](3) NOT NULL,
	[T$IQUA] [float] NOT NULL,
	[T$CWOC] [char](3) NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$TRID] [char](10) NOT NULL,
	[T$TRDT] [datetime] NULL,
	[T$TRTM] [float] NOT NULL,
	[T$WHNO] [float] NOT NULL,
	[T$LINS] [float] NOT NULL,
	[T$TXTA] [float] NOT NULL,
	[T$REMK] [char](30) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$SWOC] [char](7) NOT NULL,
	[T$MTYP] [float] NOT NULL,
	[T$IFRT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

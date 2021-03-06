USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSBOM300180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM300180](
	[T$PLNT] [char](2) NOT NULL,
	[T$MITM] [char](32) NOT NULL,
	[T$VERS] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SEQN] [float] NOT NULL,
	[T$SITM] [char](32) NOT NULL,
	[T$QANA] [float] NOT NULL,
	[T$UPDT] [datetime] NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$USER] [char](10) NOT NULL,
	[T$UPTM] [float] NOT NULL,
	[T$EFDT] [datetime] NULL,
	[T$EXDT] [datetime] NULL,
	[T$STAT] [float] NOT NULL,
	[T$DBOM] [float] NOT NULL,
	[T$YIED] [float] NOT NULL,
	[T$UPNL] [float] NOT NULL,
	[T$PSHT] [float] NOT NULL,
	[T$CORE] [float] NOT NULL,
	[T$WIDT] [float] NOT NULL,
	[T$LENT] [float] NOT NULL,
	[T$PITM] [char](4) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

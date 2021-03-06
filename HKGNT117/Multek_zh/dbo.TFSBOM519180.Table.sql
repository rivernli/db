USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSBOM519180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM519180](
	[T$PLNT] [char](2) NOT NULL,
	[T$FYER] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$CPKC] [float] NOT NULL,
	[T$QBOM] [float] NOT NULL,
	[T$QTKS] [float] NOT NULL,
	[T$QELC] [float] NOT NULL,
	[T$QCPK] [float] NOT NULL,
	[T$QACT] [float] NOT NULL,
	[T$CPKB] [float] NOT NULL,
	[T$CFFB] [float] NOT NULL,
	[T$CFFI] [float] NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$USER] [char](10) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

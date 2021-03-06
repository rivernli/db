USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSPUR033180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSPUR033180](
	[T$SERN] [float] NOT NULL,
	[T$USER] [char](10) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$FLAG] [float] NOT NULL,
	[T$PROD] [float] NOT NULL,
	[T$YEAR] [float] NOT NULL,
	[T$CITF] [char](6) NOT NULL,
	[T$CITT] [char](6) NOT NULL,
	[T$SUNF] [char](6) NOT NULL,
	[T$SUNT] [char](6) NOT NULL,
	[T$YEAF] [float] NOT NULL,
	[T$YEAT] [float] NOT NULL,
	[T$PROT] [float] NOT NULL,
	[T$PROF] [float] NOT NULL,
	[T$PLNF] [char](2) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$TRTP] [char](10) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TTIWIP021181]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTIWIP021181](
	[T$WONO] [char](10) NOT NULL,
	[T$LRUN] [float] NOT NULL,
	[T$STEP] [float] NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$DTIN] [datetime] NULL,
	[T$TMIN] [float] NOT NULL,
	[T$QTYI] [float] NOT NULL,
	[T$MRBQ] [float] NOT NULL,
	[T$MRBC] [char](3) NOT NULL,
	[T$MATC] [char](16) NOT NULL,
	[T$MATL] [char](20) NOT NULL,
	[T$LOTS] [float] NOT NULL,
	[T$ESMT] [float] NOT NULL,
	[T$UOMT] [float] NOT NULL,
	[T$DTAT] [datetime] NULL,
	[T$TMAT] [float] NOT NULL,
	[T$QTYA] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$MATC2] [char](16) NOT NULL,
	[T$MATC3] [char](16) NOT NULL,
	[T$MATL2] [char](20) NOT NULL,
	[T$MATL3] [char](20) NOT NULL,
	[T$MRBS] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

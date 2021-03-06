USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSBOM202180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM202180](
	[T$PITM] [char](16) NOT NULL,
	[T$VERS] [float] NOT NULL,
	[T$QUTY] [float] NOT NULL,
	[T$UNIT] [char](3) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$AVER] [float] NOT NULL,
	[T$PRJF] [char](10) NOT NULL,
	[T$CRID] [char](10) NOT NULL,
	[T$FVER] [char](8) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSBOC106180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOC106180](
	[T$PLNT] [char](2) NOT NULL,
	[T$CSGS] [char](6) NOT NULL,
	[T$OEMN] [char](50) NOT NULL,
	[T$SERI] [float] NOT NULL,
	[T$AVAI] [float] NOT NULL,
	[T$GCUS] [char](6) NOT NULL,
	[T$GOEM] [char](50) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

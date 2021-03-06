USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSSLS003180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSSLS003180](
	[T$PROJ] [char](8) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$DMAT] [float] NOT NULL,
	[T$IMAT] [float] NOT NULL,
	[T$LABO] [float] NOT NULL,
	[T$OVHE] [float] NOT NULL,
	[T$ACST] [float] NOT NULL,
	[T$LAYE] [char](2) NOT NULL,
	[T$BUSP] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

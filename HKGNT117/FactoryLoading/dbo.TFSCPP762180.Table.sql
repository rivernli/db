USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSCPP762180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSCPP762180](
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$TTYP] [char](3) NOT NULL,
	[T$NINV] [float] NOT NULL,
	[T$INVD] [datetime] NULL,
	[T$TYPE] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$PLNT] [char](4) NOT NULL,
	[T$DAMT] [float] NOT NULL,
	[T$RPLN] [char](4) NOT NULL,
	[T$FROM] [char](3) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

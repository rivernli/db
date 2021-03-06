USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSBOC006180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOC006180](
	[T$YEAR] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$PITA] [char](16) NOT NULL,
	[T$PITM] [char](16) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$DEPT] [float] NOT NULL,
	[T$BITM] [char](12) NOT NULL,
	[T$BOCT] [char](6) NOT NULL,
	[T$SBOC] [char](6) NOT NULL,
	[T$CONS] [float] NOT NULL,
	[T$BCUN] [char](3) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSBOC004180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOC004180](
	[T$PLNT] [char](2) NOT NULL,
	[T$YEAR] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$BITM] [char](12) NOT NULL,
	[T$BQTY] [float] NOT NULL,
	[T$WKDY] [float] NOT NULL,
	[T$WKHR] [float] NOT NULL,
	[T$SQQT] [float] NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$EFFT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

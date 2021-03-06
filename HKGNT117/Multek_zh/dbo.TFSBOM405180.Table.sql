USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSBOM405180]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM405180](
	[T$PLNT] [char](2) NOT NULL,
	[T$MNWC] [char](3) NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$PVER] [char](8) NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$NOPD] [float] NOT NULL,
	[T$QSTA] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

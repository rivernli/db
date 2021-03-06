USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TIWIP401180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TIWIP401180](
	[T$PLNT] [char](2) NOT NULL,
	[T$FODA] [char](12) NOT NULL,
	[T$TODA] [char](12) NOT NULL,
	[T$FOTI] [char](12) NOT NULL,
	[T$TOTI] [char](12) NOT NULL,
	[T$FIDA] [char](12) NOT NULL,
	[T$TIDA] [char](12) NOT NULL,
	[T$PITM] [char](16) NOT NULL,
	[T$ATTR] [float] NOT NULL,
	[T$YIED] [float] NOT NULL,
	[T$PITA] [char](10) NOT NULL,
	[T$RYIE] [float] NOT NULL,
	[T$RATT] [float] NOT NULL,
	[T$EXDA] [char](12) NOT NULL,
	[T$MRBC] [float] NOT NULL,
	[T$YEDC] [float] NOT NULL,
	[T$COYI] [float] NOT NULL,
	[T$COAT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

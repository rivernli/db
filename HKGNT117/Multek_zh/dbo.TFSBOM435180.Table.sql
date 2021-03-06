USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSBOM435180]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM435180](
	[T$PLNT] [char](2) NOT NULL,
	[T$MNWC] [char](3) NOT NULL,
	[T$SERN] [char](8) NOT NULL,
	[T$DLAB] [float] NOT NULL,
	[T$ILAB] [float] NOT NULL,
	[T$DPAM] [float] NOT NULL,
	[T$EQEX] [float] NOT NULL,
	[T$FAUT] [float] NOT NULL,
	[T$CMPT] [float] NOT NULL,
	[T$SUPP] [float] NOT NULL,
	[T$TREN] [float] NOT NULL,
	[T$OTER] [float] NOT NULL,
	[T$LOAD] [float] NOT NULL,
	[T$PERI] [char](6) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$CRID] [char](10) NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$EFDA] [datetime] NULL,
	[T$QSTA] [float] NOT NULL,
	[T$FAPE] [char](6) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

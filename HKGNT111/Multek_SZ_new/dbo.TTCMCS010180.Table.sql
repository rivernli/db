USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[TTCMCS010180]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTCMCS010180](
	[T$CCTY] [char](3) NOT NULL,
	[T$DSCA] [char](30) NOT NULL,
	[T$ICTC] [char](3) NOT NULL,
	[T$TFCD] [char](6) NOT NULL,
	[T$TXCD] [char](6) NOT NULL,
	[T$FXCD] [char](6) NOT NULL,
	[T$MEEC] [float] NOT NULL,
	[T$GEOC] [char](3) NOT NULL,
	[T$PLTX$L] [float] NOT NULL,
	[T$PTTA$L] [float] NOT NULL,
	[T$TXMP$L] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

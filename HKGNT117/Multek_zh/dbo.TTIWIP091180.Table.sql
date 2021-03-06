USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTIWIP091180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTIWIP091180](
	[T$PLNT] [char](2) NOT NULL,
	[T$BTNO] [char](10) NOT NULL,
	[T$TYPE] [float] NOT NULL,
	[T$MNWC] [char](3) NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$PJNO] [char](32) NOT NULL,
	[T$WONO] [char](10) NOT NULL,
	[T$LRUN] [float] NOT NULL,
	[T$LOTQ] [float] NOT NULL,
	[T$LOPQ] [float] NOT NULL,
	[T$LOSQ] [float] NOT NULL,
	[T$MRBQ] [float] NOT NULL,
	[T$RQTY] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

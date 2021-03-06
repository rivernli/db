USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTIWIP001180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTIWIP001180](
	[T$CWOC] [char](4) NOT NULL,
	[T$MNWC] [char](3) NOT NULL,
	[T$DSCA] [char](35) NOT NULL,
	[T$DSCB] [char](35) NOT NULL,
	[T$TBPN] [float] NOT NULL,
	[T$LCAL] [float] NOT NULL,
	[T$MISW] [float] NOT NULL,
	[T$IOMG] [float] NOT NULL,
	[T$SFWC] [float] NOT NULL,
	[T$SMTP] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

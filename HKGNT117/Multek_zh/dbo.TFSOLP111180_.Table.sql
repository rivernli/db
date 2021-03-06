USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP111180_]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP111180_](
	[T$PLNT] [char](2) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$YEAR] [char](15) NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$FIWK] [char](2) NOT NULL,
	[T$TRDT] [datetime] NULL,
	[T$TYPE] [char](30) NOT NULL,
	[T$OQTY] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$FLAG] [char](2) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

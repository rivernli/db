USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSPUR019180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSPUR019180](
	[T$UPRN] [char](20) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$CAID] [char](6) NOT NULL,
	[T$CADA] [char](100) NOT NULL,
	[T$CAD1] [char](80) NOT NULL,
	[T$CAD2] [char](80) NOT NULL,
	[T$CAD3] [char](80) NOT NULL,
	[T$TYPE] [float] NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

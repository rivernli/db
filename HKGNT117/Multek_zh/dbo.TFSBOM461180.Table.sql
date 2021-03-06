USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSBOM461180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM461180](
	[T$PLNT] [char](2) NOT NULL,
	[T$TYPE] [float] NOT NULL,
	[T$PJNO] [char](13) NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$PTYP] [char](30) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$CRID] [char](10) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

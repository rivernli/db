USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSAMI014180]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSAMI014180](
	[T$PJNO] [char](16) NOT NULL,
	[T$ITEM] [char](20) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$VALE] [float] NOT NULL,
	[T$UNIT] [char](3) NOT NULL,
	[T$SVAL] [char](30) NOT NULL,
	[T$REMK] [char](30) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

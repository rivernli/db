USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSAMI004180]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSAMI004180](
	[T$PJNO] [char](16) NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$PNSK] [float] NOT NULL,
	[T$DSCA] [char](50) NOT NULL,
	[T$DSCB] [char](50) NOT NULL,
	[T$DSCC] [char](50) NOT NULL,
	[T$HOPN] [float] NOT NULL,
	[T$HOSQ] [float] NOT NULL,
	[T$CYDR] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

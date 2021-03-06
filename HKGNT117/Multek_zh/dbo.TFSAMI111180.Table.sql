USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSAMI111180]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSAMI111180](
	[T$CODE] [char](4) NOT NULL,
	[T$FILL] [float] NOT NULL,
	[T$FCUN] [char](3) NOT NULL,
	[T$WRAP] [float] NOT NULL,
	[T$WCUN] [char](3) NOT NULL,
	[T$CFIL] [float] NOT NULL,
	[T$CFCU] [char](3) NOT NULL,
	[T$CWRA] [float] NOT NULL,
	[T$CWCU] [char](3) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

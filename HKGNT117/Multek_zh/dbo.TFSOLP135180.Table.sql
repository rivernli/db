USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP135180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP135180](
	[T$PLNT] [char](2) NOT NULL,
	[T$PITM] [char](16) NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$PANL] [float] NOT NULL,
	[T$UNIT] [float] NOT NULL,
	[T$ID] [float] NOT NULL,
	[T$LOTQ] [float] NOT NULL,
	[T$LOPQ] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

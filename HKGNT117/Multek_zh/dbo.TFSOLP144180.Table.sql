USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP144180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP144180](
	[T$PLNT] [char](2) NOT NULL,
	[T$PJNO] [char](32) NOT NULL,
	[T$IQTY] [float] NOT NULL,
	[T$OQTY] [float] NOT NULL,
	[T$DATE] [datetime] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

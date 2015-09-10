USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSAMI252180]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSAMI252180](
	[T$PLNT] [char](2) NOT NULL,
	[T$PJNO] [char](16) NOT NULL,
	[T$ONDT] [datetime] NOT NULL,
	[T$OUTR] [float] NOT NULL,
	[T$LCNT] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

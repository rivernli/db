USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTIWIP006180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTIWIP006180](
	[T$PLNT] [char](2) NOT NULL,
	[T$PITM] [char](16) NOT NULL,
	[T$INLT] [float] NOT NULL,
	[T$OTLT] [float] NOT NULL,
	[T$PSPL] [float] NOT NULL,
	[T$PSHT] [float] NOT NULL,
	[T$RATE] [float] NOT NULL,
	[T$SQPL] [float] NOT NULL,
	[T$SQPS] [float] NOT NULL,
	[T$PROJ] [char](9) NOT NULL,
	[T$PRJ1] [char](10) NOT NULL,
	[T$ICOD] [char](32) NOT NULL,
	[T$PLOT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

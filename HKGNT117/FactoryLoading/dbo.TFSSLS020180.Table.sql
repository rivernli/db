USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSSLS020180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSSLS020180](
	[T$SUNO] [char](6) NOT NULL,
	[T$DSCA] [char](80) NOT NULL,
	[T$DSCC] [char](40) NOT NULL,
	[T$BKYN] [float] NOT NULL,
	[T$SUID] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSSLS021180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSSLS021180](
	[T$ITEM] [char](32) NOT NULL,
	[T$DSCA] [char](60) NOT NULL,
	[T$DSCC] [char](60) NOT NULL,
	[T$UNIT] [char](3) NOT NULL,
	[T$RTAX] [float] NOT NULL,
	[T$LOCA] [float] NOT NULL,
	[T$RTPR] [float] NOT NULL,
	[T$BKYN] [float] NOT NULL,
	[T$GRP1] [char](30) NOT NULL,
	[T$GRP2] [char](30) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

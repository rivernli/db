USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSCPP230180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSCPP230180](
	[T$INVN] [float] NOT NULL,
	[T$TTYP] [char](3) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$CRF1] [char](6) NOT NULL,
	[T$CRF2] [char](6) NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$CCTP] [char](3) NOT NULL,
	[T$USER] [char](10) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$YENX] [float] NOT NULL,
	[T$MCYN] [float] NOT NULL,
	[T$ITYP] [char](3) NOT NULL,
	[T$RADT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

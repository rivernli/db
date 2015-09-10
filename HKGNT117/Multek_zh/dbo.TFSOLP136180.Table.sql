USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP136180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP136180](
	[T$ITEM] [char](32) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$TYPE] [char](30) NOT NULL,
	[T$PROJ] [char](32) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$DQUA] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$CMNT] [float] NOT NULL,
	[T$SMNT] [float] NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$FLAG] [char](3) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[fsolp121180_current]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fsolp121180_current](
	[T$DATE] [datetime] NULL,
	[T$DESC] [char](20) NOT NULL,
	[T$TRTP] [char](25) NOT NULL,
	[T$IANO] [char](20) NOT NULL,
	[T$TRDT] [datetime] NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$NAMA] [char](35) NOT NULL,
	[T$CSGS] [char](15) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$PCDT] [datetime] NULL,
	[T$PCDN] [datetime] NULL,
	[T$PQTY] [float] NOT NULL,
	[T$MTLP] [float] NOT NULL,
	[T$MTLN] [float] NOT NULL,
	[T$UNPL] [float] NOT NULL,
	[T$SFPL] [float] NOT NULL,
	[T$PANL] [float] NOT NULL,
	[T$SQFT] [float] NOT NULL,
	[T$MAMT] [float] NOT NULL,
	[T$MAMN] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[TFSOLP109180]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP109180](
	[T$ORNO] [float] NOT NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$CUNO] [char](30) NOT NULL,
	[T$CSGS] [char](30) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$PRDT] [char](30) NOT NULL,
	[T$OQTY] [float] NOT NULL,
	[T$AREA] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$PENT] [float] NOT NULL,
	[T$RAMT] [float] NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$PONO] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$COMP] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

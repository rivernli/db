USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[ItemPriceMasterQuery_Data]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemPriceMasterQuery_Data](
	[CHI] [varchar](3) NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$PITM] [varchar](4) NULL,
	[T$DSCA] [char](30) NULL,
	[T$CSGS] [char](6) NULL,
	[OEM] [char](30) NULL,
	[T$CNTR] [char](3) NOT NULL,
	[T$DILE] [float] NOT NULL,
	[T$QANP] [float] NOT NULL,
	[T$STDT] [datetime] NULL,
	[T$TDAT] [datetime] NULL,
	[T$PRIC] [float] NOT NULL,
	[T$DISC] [float] NOT NULL,
	[T$DAMT] [float] NOT NULL,
	[T$CDIS] [char](3) NOT NULL,
	[T$GNPR] [varchar](5) NULL,
	[T$VERS] [char](12) NOT NULL,
	[T$USED] [float] NOT NULL,
	[T$TYPE] [varchar](20) NULL,
	[T$STAT] [varchar](3) NULL,
	[T$PLNT] [varchar](20) NOT NULL,
	[T$CCUR] [varchar](4) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

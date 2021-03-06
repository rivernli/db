USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSOLP101180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP101180](
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$BAD1] [char](35) NOT NULL,
	[T$BAD2] [char](35) NOT NULL,
	[T$COBA] [char](30) NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CUNM] [char](35) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$CUPN] [char](30) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$TTYP] [char](3) NOT NULL,
	[T$INVN] [float] NOT NULL,
	[T$INVD] [datetime] NULL,
	[T$PODT] [datetime] NULL,
	[T$RQDT] [datetime] NULL,
	[T$DQUA] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$CCUR] [char](3) NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$AREA] [float] NOT NULL,
	[T$REFA] [char](30) NOT NULL,
	[T$ENDC] [char](30) NOT NULL,
	[T$CODA] [char](30) NOT NULL,
	[T$NAMA] [char](35) NOT NULL,
	[T$CSCO] [char](30) NOT NULL,
	[T$USNM] [char](35) NOT NULL,
	[T$SEGM] [char](30) NOT NULL,
	[T$CDSC] [char](35) NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$STYP] [char](4) NOT NULL,
	[T$FIDS] [char](30) NOT NULL,
	[T$FLDT] [datetime] NULL,
	[T$PSPL] [float] NOT NULL,
	[T$PRDN] [char](30) NOT NULL,
	[T$FLEX] [float] NOT NULL,
	[T$ISEG] [char](6) NOT NULL,
	[T$DESC] [char](30) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[TFSOLP100180_unitset]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP100180_unitset](
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$BAD1] [char](35) NOT NULL,
	[T$BAD2] [char](35) NOT NULL,
	[T$COBA] [char](30) NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CUNM] [char](35) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$REFA] [char](30) NOT NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$CUPN] [char](30) NOT NULL,
	[T$PODT] [datetime] NOT NULL,
	[T$DDTA] [datetime] NOT NULL,
	[T$RQDT] [datetime] NOT NULL,
	[T$OQUA] [float] NOT NULL,
	[T$BQUA] [float] NOT NULL,
	[T$CCUR] [char](3) NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$AREA] [float] NOT NULL,
	[T$ECDT] [char](30) NOT NULL,
	[T$ADDR] [char](30) NOT NULL,
	[T$NAMA] [char](35) NOT NULL,
	[T$CSCO] [char](30) NOT NULL,
	[T$USNM] [char](35) NOT NULL,
	[T$SEGM] [char](30) NOT NULL,
	[T$CDSC] [char](35) NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$STYP] [char](4) NOT NULL,
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

USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TTDPUR040180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTDPUR040180](
	[T$ORNO] [float] NOT NULL,
	[T$SUNO] [char](6) NOT NULL,
	[T$COMP] [float] NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$CORG] [float] NOT NULL,
	[T$RAGR] [char](16) NOT NULL,
	[T$CPAY] [char](3) NOT NULL,
	[T$ODAT] [datetime] NULL,
	[T$ODIS] [float] NOT NULL,
	[T$CCUR] [char](3) NOT NULL,
	[T$RATP] [float] NOT NULL,
	[T$RATF] [float] NOT NULL,
	[T$CCOR] [char](3) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$CCON] [float] NOT NULL,
	[T$CVYN] [float] NOT NULL,
	[T$CCRS] [char](3) NOT NULL,
	[T$CFRW] [char](3) NOT NULL,
	[T$CPLP] [char](3) NOT NULL,
	[T$CCTY] [char](3) NOT NULL,
	[T$CLAN] [char](3) NOT NULL,
	[T$PSPR] [char](6) NOT NULL,
	[T$PSTX] [char](6) NOT NULL,
	[T$CDEC] [char](3) NOT NULL,
	[T$CFSG] [char](3) NOT NULL,
	[T$DDAT] [datetime] NULL,
	[T$DDTC] [datetime] NULL,
	[T$CBRN] [char](6) NOT NULL,
	[T$CREG] [char](3) NOT NULL,
	[T$REFA] [char](30) NOT NULL,
	[T$REFB] [char](20) NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$CTRJ] [char](3) NOT NULL,
	[T$EGEN] [float] NOT NULL,
	[T$TXTA] [float] NOT NULL,
	[T$TXTB] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

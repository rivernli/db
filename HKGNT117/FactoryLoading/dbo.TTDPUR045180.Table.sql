USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TTDPUR045180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTDPUR045180](
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$SUNO] [char](6) NOT NULL,
	[T$CPRJ] [char](6) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$CNTR] [char](3) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$DISC$1] [float] NOT NULL,
	[T$DISC$2] [float] NOT NULL,
	[T$DISC$3] [float] NOT NULL,
	[T$DAMT$1] [float] NOT NULL,
	[T$DAMT$2] [float] NOT NULL,
	[T$DAMT$3] [float] NOT NULL,
	[T$CPCP] [char](3) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$IQAN] [float] NOT NULL,
	[T$IAMT] [float] NOT NULL,
	[T$STSD] [float] NOT NULL,
	[T$STSC] [float] NOT NULL,
	[T$PDNO] [float] NOT NULL,
	[T$OPNO] [float] NOT NULL,
	[T$RONO] [float] NOT NULL,
	[T$SPUR] [float] NOT NULL,
	[T$PMSK] [char](20) NOT NULL,
	[T$RENO] [float] NOT NULL,
	[T$DINO] [char](20) NOT NULL,
	[T$TORN] [float] NOT NULL,
	[T$TPON] [float] NOT NULL,
	[T$TSRN] [float] NOT NULL,
	[T$INVN] [float] NOT NULL,
	[T$INVD] [datetime] NULL,
	[T$DDTB] [datetime] NULL,
	[T$MARK] [float] NOT NULL,
	[T$DIQU] [float] NOT NULL,
	[T$DQUA] [float] NOT NULL,
	[T$BQUA] [float] NOT NULL,
	[T$QUAP] [float] NOT NULL,
	[T$QUAD] [float] NOT NULL,
	[T$CDIS] [char](3) NOT NULL,
	[T$COPR] [float] NOT NULL,
	[T$COOP] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$LDAM] [float] NOT NULL,
	[T$ODAM] [float] NOT NULL,
	[T$CONO] [float] NOT NULL,
	[T$POSI] [float] NOT NULL,
	[T$MATC] [float] NOT NULL,
	[T$COMP] [float] NOT NULL,
	[T$FICO] [float] NOT NULL,
	[T$TXTA] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

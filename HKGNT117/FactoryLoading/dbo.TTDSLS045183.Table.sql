USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TTDSLS045183]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTDSLS045183](
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CPRJ] [char](6) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$CNTR] [char](3) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$CPCP] [char](3) NOT NULL,
	[T$DDAT] [datetime] NULL,
	[T$OQUA] [float] NOT NULL,
	[T$DQUA] [float] NOT NULL,
	[T$BQUA] [float] NOT NULL,
	[T$RECQ] [float] NOT NULL,
	[T$PINO] [float] NOT NULL,
	[T$DINO] [float] NOT NULL,
	[T$INVD] [datetime] NULL,
	[T$INVN] [float] NOT NULL,
	[T$TTYP] [char](3) NOT NULL,
	[T$FONO] [float] NOT NULL,
	[T$TORN] [float] NOT NULL,
	[T$TPON] [float] NOT NULL,
	[T$TSRN] [float] NOT NULL,
	[T$SSLS] [float] NOT NULL,
	[T$PMSK] [char](20) NOT NULL,
	[T$COPR] [float] NOT NULL,
	[T$COOP] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$DISC$1] [float] NOT NULL,
	[T$DISC$2] [float] NOT NULL,
	[T$DISC$3] [float] NOT NULL,
	[T$DAMT$1] [float] NOT NULL,
	[T$DAMT$2] [float] NOT NULL,
	[T$DAMT$3] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$LDAM] [float] NOT NULL,
	[T$ODAM] [float] NOT NULL,
	[T$RATS] [float] NOT NULL,
	[T$RATF] [float] NOT NULL,
	[T$CONO] [float] NOT NULL,
	[T$POSI] [float] NOT NULL,
	[T$OPRI] [float] NOT NULL,
	[T$TXAM$L] [float] NOT NULL,
	[T$TXTA] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

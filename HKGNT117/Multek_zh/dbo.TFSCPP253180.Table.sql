USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSCPP253180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSCPP253180](
	[T$CRFN] [char](6) NOT NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$EOPO] [float] NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$WONO] [char](10) NOT NULL,
	[T$WSFX] [float] NOT NULL,
	[T$WOPO] [float] NOT NULL,
	[T$WODT] [datetime] NULL,
	[T$WQTY] [float] NOT NULL,
	[T$OQTY] [float] NOT NULL,
	[T$CQTY] [float] NOT NULL,
	[T$SQTY] [float] NOT NULL,
	[T$PCDT] [datetime] NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$PJNO] [char](32) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$NLNE] [float] NOT NULL,
	[T$RCDE] [char](3) NOT NULL,
	[T$POS1] [float] NOT NULL,
	[T$ISUB] [float] NOT NULL,
	[T$FRWQ] [float] NOT NULL,
	[T$TXTA] [float] NOT NULL,
	[T$PITM] [char](4) NOT NULL,
	[T$AQTY] [float] NOT NULL,
	[T$TQTY] [float] NOT NULL,
	[T$HKSQ] [float] NOT NULL,
	[T$HUBQ] [float] NOT NULL,
	[T$CQPM] [float] NOT NULL,
	[T$DESC] [char](50) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TTDSLS040180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTDSLS040180](
	[T$ORNO] [float] NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CPER] [char](6) NOT NULL,
	[T$COMP] [float] NOT NULL,
	[T$CORG] [float] NOT NULL,
	[T$CPAY] [char](3) NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$ODAT] [datetime] NULL,
	[T$ODIS] [float] NOT NULL,
	[T$CCUR] [char](3) NOT NULL,
	[T$FCRT] [float] NOT NULL,
	[T$RATS] [float] NOT NULL,
	[T$RATF] [float] NOT NULL,
	[T$CCOR] [char](3) NOT NULL,
	[T$CDEL] [char](3) NOT NULL,
	[T$CREP] [float] NOT NULL,
	[T$CFCG] [char](3) NOT NULL,
	[T$CVYN] [float] NOT NULL,
	[T$CCRS] [char](3) NOT NULL,
	[T$CFRW] [char](3) NOT NULL,
	[T$CPLS] [char](3) NOT NULL,
	[T$PLDD] [char](3) NOT NULL,
	[T$PCPR] [char](6) NOT NULL,
	[T$PCTX] [char](6) NOT NULL,
	[T$CCTY] [char](3) NOT NULL,
	[T$CLAN] [char](3) NOT NULL,
	[T$CDEC] [char](3) NOT NULL,
	[T$CRTE] [char](5) NOT NULL,
	[T$DDAT] [datetime] NULL,
	[T$FUTO] [float] NOT NULL,
	[T$CBRN] [char](6) NOT NULL,
	[T$CREG] [char](3) NOT NULL,
	[T$REFA] [char](30) NOT NULL,
	[T$REFB] [char](20) NOT NULL,
	[T$BKYN] [float] NOT NULL,
	[T$CBLC] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$SCOM] [float] NOT NULL,
	[T$PRDT] [datetime] NULL,
	[T$CTRJ] [char](3) NOT NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$TXTA] [float] NOT NULL,
	[T$TXTB] [float] NOT NULL,
	[T$AGEN] [float] NOT NULL,
	[T$TLCH] [float] NOT NULL,
	[T$CRFN] [char](6) NOT NULL,
	[T$REMK] [char](30) NOT NULL,
	[T$OPMK] [char](50) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [PK_TTDSLS040180]    Script Date: 2014/11/12 17:06:44 ******/
CREATE UNIQUE CLUSTERED INDEX [PK_TTDSLS040180] ON [dbo].[TTDSLS040180]
(
	[T$ORNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

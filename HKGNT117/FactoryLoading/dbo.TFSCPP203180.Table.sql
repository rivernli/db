USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSCPP203180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSCPP203180](
	[T$CRFN] [char](6) NOT NULL,
	[T$ASDT] [datetime] NULL,
	[T$PITM] [char](4) NOT NULL,
	[T$PVER] [char](1) NOT NULL,
	[T$PFIX] [char](3) NOT NULL,
	[T$NORO] [float] NOT NULL,
	[T$CEMN] [char](6) NOT NULL,
	[T$CSGS] [char](6) NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CDEL] [char](3) NOT NULL,
	[T$DSCA] [char](30) NOT NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$COMP] [float] NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$LSLS] [float] NOT NULL,
	[T$LDEL] [float] NOT NULL,
	[T$DVMN] [float] NOT NULL,
	[T$ASBY] [float] NOT NULL,
	[T$CREP] [float] NOT NULL,
	[T$CRTE] [char](5) NOT NULL,
	[T$CBRN] [char](6) NOT NULL,
	[T$CPER] [char](6) NOT NULL,
	[T$MFL1] [char](6) NOT NULL,
	[T$MFL2] [char](3) NOT NULL,
	[T$REMK] [char](30) NOT NULL,
	[T$INDT] [datetime] NULL,
	[T$INTM] [float] NOT NULL,
	[T$INID] [char](10) NOT NULL,
	[T$MODT] [datetime] NULL,
	[T$MOTM] [float] NOT NULL,
	[T$MOID] [char](10) NOT NULL,
	[T$CRFS] [float] NOT NULL,
	[T$TXTA] [float] NOT NULL,
	[T$TXTB] [float] NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$CRDT] [datetime] NULL,
	[T$CRTM] [float] NOT NULL,
	[T$CRID] [char](10) NOT NULL,
	[T$PADT] [datetime] NULL,
	[T$PATM] [float] NOT NULL,
	[T$PAID] [char](10) NOT NULL,
	[T$PPCD] [datetime] NULL,
	[T$PPCT] [float] NOT NULL,
	[T$PPCI] [char](10) NOT NULL,
	[T$PCDT] [datetime] NULL,
	[T$PCTM] [float] NOT NULL,
	[T$PCID] [char](10) NOT NULL,
	[T$MCDT] [datetime] NULL,
	[T$MCTM] [float] NOT NULL,
	[T$MCID] [char](10) NOT NULL,
	[T$REF1] [char](30) NOT NULL,
	[T$REF2] [char](20) NOT NULL,
	[T$FLAG] [float] NOT NULL,
	[T$MAIL] [float] NOT NULL,
	[T$RJDT] [datetime] NULL,
	[T$RJTM] [float] NOT NULL,
	[T$RJID] [char](10) NOT NULL,
	[T$RJCD] [char](3) NOT NULL,
	[T$OPMK] [char](50) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

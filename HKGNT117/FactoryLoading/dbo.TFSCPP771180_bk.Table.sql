USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSCPP771180_bk]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSCPP771180_bk](
	[T$SERN] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$CRFN] [char](6) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$PCDT] [datetime] NULL,
	[T$OQUA] [float] NOT NULL,
	[T$TSQY] [float] NOT NULL,
	[T$TDAT] [datetime] NULL,
	[T$SQTY] [float] NOT NULL,
	[T$TPQY] [float] NOT NULL,
	[T$PDAT] [datetime] NULL,
	[T$PQTY] [float] NOT NULL,
	[T$SBLG] [float] NOT NULL,
	[T$PBLG] [float] NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CDEL] [char](3) NOT NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$CCUR] [char](3) NOT NULL,
	[T$SQFT$S] [float] NOT NULL,
	[T$SQFT$P] [float] NOT NULL,
	[T$CSGS] [char](30) NOT NULL,
	[T$CCTY] [char](3) NOT NULL,
	[T$CREP] [char](35) NOT NULL,
	[T$CBRN] [char](30) NOT NULL,
	[T$SFLG] [float] NOT NULL,
	[T$DSCA] [char](30) NOT NULL,
	[T$ODAT] [datetime] NULL,
	[T$PODATE] [datetime] NULL,
	[T$PCBL] [float] NOT NULL,
	[T$CUN1] [char](6) NOT NULL,
	[T$CDE1] [char](3) NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$RATS] [float] NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$INVT] [char](250) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$CEMN] [char](35) NOT NULL,
	[T$NAMA] [char](35) NOT NULL,
	[T$PRC1] [float] NOT NULL,
	[T$RAT1] [float] NOT NULL,
	[T$CSGP] [char](6) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

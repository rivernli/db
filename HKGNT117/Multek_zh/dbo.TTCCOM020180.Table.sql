USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTCCOM020180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTCCOM020180](
	[T$SUNO] [char](6) NOT NULL,
	[T$CTIT] [char](3) NOT NULL,
	[T$NAMA] [char](35) NOT NULL,
	[T$NAMB] [char](30) NOT NULL,
	[T$NAMC] [char](30) NOT NULL,
	[T$NAMD] [char](30) NOT NULL,
	[T$NAME] [char](30) NOT NULL,
	[T$NAMF] [char](30) NOT NULL,
	[T$PSTC] [char](10) NOT NULL,
	[T$COMP] [float] NOT NULL,
	[T$CREG] [char](3) NOT NULL,
	[T$PSPR] [char](6) NOT NULL,
	[T$PSTX] [char](6) NOT NULL,
	[T$SNDR] [float] NOT NULL,
	[T$CCOR] [char](3) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$REFA] [char](30) NOT NULL,
	[T$REFS] [char](30) NOT NULL,
	[T$OCUS] [char](15) NOT NULL,
	[T$TELP] [char](15) NOT NULL,
	[T$TELX] [char](15) NOT NULL,
	[T$TEFX] [char](15) NOT NULL,
	[T$SEAK] [char](16) NOT NULL,
	[T$CBRN] [char](6) NOT NULL,
	[T$CBAN] [char](3) NOT NULL,
	[T$CFCC] [char](3) NOT NULL,
	[T$FANO] [char](10) NOT NULL,
	[T$CCON] [float] NOT NULL,
	[T$CPAY] [char](3) NOT NULL,
	[T$CCRS] [char](3) NOT NULL,
	[T$CDEC] [char](3) NOT NULL,
	[T$CCTY] [char](3) NOT NULL,
	[T$CLAN] [char](3) NOT NULL,
	[T$CCUR] [char](3) NOT NULL,
	[T$CVYN] [float] NOT NULL,
	[T$SCUS] [char](6) NOT NULL,
	[T$CPLP] [char](3) NOT NULL,
	[T$CFSG] [char](3) NOT NULL,
	[T$PAYM] [char](3) NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$QUAL] [float] NOT NULL,
	[T$BUOR] [float] NOT NULL,
	[T$BUIN] [float] NOT NULL,
	[T$ODIS] [float] NOT NULL,
	[T$SUBC] [float] NOT NULL,
	[T$CRYR] [float] NOT NULL,
	[T$TOVR$1] [float] NOT NULL,
	[T$TOVR$2] [float] NOT NULL,
	[T$TOVR$3] [float] NOT NULL,
	[T$TOVR$4] [float] NOT NULL,
	[T$TOVR$5] [float] NOT NULL,
	[T$SUST] [float] NOT NULL,
	[T$EDED] [float] NOT NULL,
	[T$CADR] [char](6) NOT NULL,
	[T$FOVN] [char](20) NOT NULL,
	[T$INRL] [float] NOT NULL,
	[T$ISCN] [float] NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$TXTA] [float] NOT NULL,
	[T$GEOC$L] [char](10) NOT NULL,
	[T$EXDT] [datetime] NULL,
	[T$EXTM] [float] NOT NULL,
	[T$PEML] [char](80) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[TFSCPP200180]    Script Date: 11/06/2014 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSCPP200180](
	[T$PITM] [char](4) NOT NULL,
	[T$PVER] [char](1) NOT NULL,
	[T$PFIX] [char](3) NOT NULL,
	[T$CEMN] [char](6) NOT NULL,
	[T$CSGS] [char](6) NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CDEL] [char](3) NOT NULL,
	[T$DSCA] [char](30) NOT NULL,
	[T$CREP] [float] NOT NULL,
	[T$CRTE] [char](5) NOT NULL,
	[T$CBRN] [char](6) NOT NULL,
	[T$CPER] [char](6) NOT NULL,
	[T$CCDE] [char](8) NOT NULL,
	[T$REMK] [char](30) NOT NULL,
	[T$INDT] [datetime] NULL,
	[T$INTM] [float] NOT NULL,
	[T$INID] [char](10) NOT NULL,
	[T$MODT] [datetime] NULL,
	[T$MOTM] [float] NOT NULL,
	[T$MOID] [char](10) NOT NULL,
	[T$MFL1] [char](6) NOT NULL,
	[T$MFL2] [char](3) NOT NULL,
	[T$PFIX1] [char](1) NOT NULL,
	[T$PCBA] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$COPY] [float] NOT NULL,
	[T$CITG] [char](6) NOT NULL,
	[T$ISEG] [char](6) NOT NULL,
	[T$STYP] [float] NOT NULL,
	[T$ASST] [float] NOT NULL,
	[T$PRDN] [char](30) NOT NULL,
	[T$STMA] [float] NOT NULL,
	[T$OTYP] [float] NOT NULL,
	[T$OEMP] [char](30) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

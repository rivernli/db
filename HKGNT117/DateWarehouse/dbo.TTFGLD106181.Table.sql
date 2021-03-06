USE [DataWarehouse]
GO
/****** Object:  Table [dbo].[TTFGLD106181]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTFGLD106181](
	[T$OTYP] [char](3) NOT NULL,
	[T$ODOC] [float] NOT NULL,
	[T$OLIN] [float] NOT NULL,
	[T$OSRL] [float] NOT NULL,
	[T$OSRN] [float] NOT NULL,
	[T$OCMP] [float] NOT NULL,
	[T$FTYP] [char](3) NOT NULL,
	[T$FDOC] [float] NOT NULL,
	[T$OYER] [float] NOT NULL,
	[T$OBAT] [float] NOT NULL,
	[T$LEAC] [char](12) NOT NULL,
	[T$DCDT] [datetime] NULL,
	[T$TYP1] [float] NOT NULL,
	[T$DIM1] [char](6) NOT NULL,
	[T$TYP2] [float] NOT NULL,
	[T$DIM2] [char](6) NOT NULL,
	[T$TYP3] [float] NOT NULL,
	[T$DIM3] [char](6) NOT NULL,
	[T$TYP4] [float] NOT NULL,
	[T$DIM4] [char](6) NOT NULL,
	[T$TYP5] [float] NOT NULL,
	[T$DIM5] [char](6) NOT NULL,
	[T$REFR] [char](30) NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$CCUR] [char](3) NOT NULL,
	[T$RATE] [float] NOT NULL,
	[T$FACT] [float] NOT NULL,
	[T$AMTH] [float] NOT NULL,
	[T$DBCR] [float] NOT NULL,
	[T$CCTY] [char](3) NOT NULL,
	[T$CVAT] [char](9) NOT NULL,
	[T$VTYP] [float] NOT NULL,
	[T$VLAC] [char](12) NOT NULL,
	[T$VAMT] [float] NOT NULL,
	[T$VAMH] [float] NOT NULL,
	[T$QTY1] [float] NOT NULL,
	[T$QTY2] [float] NOT NULL,
	[T$FPRD] [float] NOT NULL,
	[T$FYER] [float] NOT NULL,
	[T$RPRD] [float] NOT NULL,
	[T$RYER] [float] NOT NULL,
	[T$VPRD] [float] NOT NULL,
	[T$VYER] [float] NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$SUNO] [char](6) NOT NULL,
	[T$CATG] [float] NOT NULL,
	[T$USER] [char](16) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$TRUN] [float] NOT NULL,
	[T$CONT] [float] NOT NULL,
	[T$CTYP] [char](3) NOT NULL,
	[T$CINV] [float] NOT NULL,
	[T$CORN] [float] NOT NULL,
	[T$CSRN] [float] NOT NULL,
	[T$TCSH] [float] NOT NULL,
	[T$TRAN] [float] NOT NULL,
	[T$TXTA] [float] NOT NULL,
	[T$DELE] [float] NOT NULL,
	[T$INTT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Index_tfgld181]    Script Date: 2014/11/12 17:04:26 ******/
CREATE NONCLUSTERED INDEX [Index_tfgld181] ON [dbo].[TTFGLD106181]
(
	[T$OTYP] ASC,
	[T$ODOC] ASC,
	[T$OLIN] ASC,
	[T$OSRL] ASC,
	[T$OSRN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

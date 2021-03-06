USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSSLS023180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSSLS023180](
	[T$ORNO] [char](15) NOT NULL,
	[T$YEAR] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$SUNO] [char](6) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$LOCA] [float] NOT NULL,
	[T$SDAT] [datetime] NULL,
	[T$DDAT] [datetime] NULL,
	[T$CCUR] [char](3) NOT NULL,
	[T$RATS] [float] NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$INID] [char](8) NOT NULL,
	[T$INDT] [datetime] NULL,
	[T$INTM] [float] NOT NULL,
	[T$PCID] [char](8) NOT NULL,
	[T$PCDT] [datetime] NULL,
	[T$PCTM] [float] NOT NULL,
	[T$PURI] [char](8) NOT NULL,
	[T$PURD] [datetime] NULL,
	[T$PUTM] [float] NOT NULL,
	[T$FIID] [char](8) NOT NULL,
	[T$FIDT] [datetime] NULL,
	[T$FITM] [float] NOT NULL,
	[T$MACH] [float] NOT NULL,
	[T$PPCO] [float] NOT NULL,
	[T$FINO] [float] NOT NULL,
	[T$RMKA] [char](100) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

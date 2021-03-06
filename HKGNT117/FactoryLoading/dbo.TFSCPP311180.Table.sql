USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSCPP311180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSCPP311180](
	[T$MAWB] [char](20) NOT NULL,
	[T$HAWB] [char](20) NOT NULL,
	[T$FLVE] [char](15) NOT NULL,
	[T$CFRW] [char](3) NOT NULL,
	[T$DEPA] [datetime] NULL,
	[T$COMP] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$TTYP] [char](3) NOT NULL,
	[T$INVN] [float] NOT NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$DSCA] [char](30) NOT NULL,
	[T$QUAN] [float] NOT NULL,
	[T$CRFN] [char](6) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$NAMA] [char](35) NOT NULL,
	[T$NAMB] [char](35) NOT NULL,
	[T$FORD] [char](30) NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CDEL] [char](3) NOT NULL,
	[T$CSGS] [char](6) NOT NULL,
	[T$OEMD] [char](30) NOT NULL,
	[T$BUNO] [char](6) NOT NULL,
	[T$BDEL] [char](3) NOT NULL,
	[T$BDES] [char](30) NOT NULL,
	[T$FSHP] [float] NOT NULL,
	[T$TOFW] [datetime] NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

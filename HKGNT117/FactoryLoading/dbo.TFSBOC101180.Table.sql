USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSBOC101180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOC101180](
	[T$DATS] [char](10) NOT NULL,
	[T$YEAR] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$CSGS] [char](6) NOT NULL,
	[T$OEMN] [char](50) NOT NULL,
	[T$PJNO] [char](32) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$OUOP] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$INSQ] [float] NOT NULL,
	[T$OUSQ] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$MAGN] [float] NOT NULL,
	[T$TRDT] [datetime] NULL,
	[T$TRTM] [float] NOT NULL,
	[T$SBNO] [float] NOT NULL,
	[T$TYPE] [char](30) NOT NULL,
	[T$OOEM] [char](50) NOT NULL,
	[T$OTYP] [char](30) NOT NULL,
	[T$DAMN] [float] NOT NULL,
	[T$DMAG] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

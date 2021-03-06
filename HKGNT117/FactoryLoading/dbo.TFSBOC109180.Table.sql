USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSBOC109180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOC109180](
	[T$DATS] [char](10) NOT NULL,
	[T$YEAR] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$CSGS] [char](6) NOT NULL,
	[T$OOEM] [char](50) NOT NULL,
	[T$PJNO] [char](32) NOT NULL,
	[T$BITM$1] [char](12) NOT NULL,
	[T$BITM$2] [char](12) NOT NULL,
	[T$BITM$3] [char](12) NOT NULL,
	[T$BITM$4] [char](12) NOT NULL,
	[T$BITM$5] [char](12) NOT NULL,
	[T$BITM$6] [char](12) NOT NULL,
	[T$BITM$7] [char](12) NOT NULL,
	[T$BITM$8] [char](12) NOT NULL,
	[T$BITM$9] [char](12) NOT NULL,
	[T$BITM$10] [char](12) NOT NULL,
	[T$BITM$11] [char](12) NOT NULL,
	[T$BITM$12] [char](12) NOT NULL,
	[T$BITM$13] [char](12) NOT NULL,
	[T$BITM$14] [char](12) NOT NULL,
	[T$BITM$15] [char](12) NOT NULL,
	[T$CONS$1] [float] NOT NULL,
	[T$CONS$2] [float] NOT NULL,
	[T$CONS$3] [float] NOT NULL,
	[T$CONS$4] [float] NOT NULL,
	[T$CONS$5] [float] NOT NULL,
	[T$CONS$6] [float] NOT NULL,
	[T$CONS$7] [float] NOT NULL,
	[T$CONS$8] [float] NOT NULL,
	[T$CONS$9] [float] NOT NULL,
	[T$CONS$10] [float] NOT NULL,
	[T$CONS$11] [float] NOT NULL,
	[T$CONS$12] [float] NOT NULL,
	[T$CONS$13] [float] NOT NULL,
	[T$CONS$14] [float] NOT NULL,
	[T$CONS$15] [float] NOT NULL,
	[T$OUOP] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$INSQ] [float] NOT NULL,
	[T$OUSQ] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$MARG] [float] NOT NULL,
	[T$TRDT] [datetime] NULL,
	[T$TRTM] [float] NOT NULL,
	[T$FCNS] [char](30) NOT NULL,
	[T$OTYP] [char](30) NOT NULL,
	[T$DAMN] [float] NOT NULL,
	[T$DMAR] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

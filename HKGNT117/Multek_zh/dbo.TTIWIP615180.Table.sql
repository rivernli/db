USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTIWIP615180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTIWIP615180](
	[T$PLNT] [char](2) NOT NULL,
	[T$LTNO] [char](32) NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$SEQU] [float] NOT NULL,
	[T$MACH] [char](20) NOT NULL,
	[T$MATR] [char](30) NOT NULL,
	[T$TOOL] [char](15) NOT NULL,
	[T$REMK] [char](30) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$USER] [char](15) NOT NULL,
	[T$MBCD] [char](20) NOT NULL,
	[T$DCDE] [char](10) NOT NULL,
	[T$PCDE] [char](20) NOT NULL,
	[T$PROJ] [char](30) NOT NULL,
	[T$PJNO] [char](8) NOT NULL,
	[T$MNWC] [char](3) NOT NULL,
	[T$BCDE] [char](2) NOT NULL,
	[T$TQTY] [float] NOT NULL,
	[T$TRCD] [char](10) NOT NULL,
	[T$OULN] [char](16) NOT NULL,
	[T$SPLN] [char](16) NOT NULL,
	[T$STMP] [char](4) NOT NULL,
	[T$MTYP] [float] NOT NULL,
	[T$LCQT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

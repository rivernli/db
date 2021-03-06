USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[TFSBOM473180]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM473180](
	[T$USRN] [char](12) NOT NULL,
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$OLDT] [datetime] NOT NULL,
	[T$VERS] [float] NOT NULL,
	[T$BUSP] [float] NOT NULL,
	[T$SREM] [char](20) NOT NULL,
	[T$TQTY] [float] NOT NULL,
	[T$OMVS] [char](8) NOT NULL,
	[T$NMVS] [char](8) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$SQFT] [float] NOT NULL,
	[T$UNNO] [float] NOT NULL,
	[T$MAXS] [float] NOT NULL,
	[T$GSRP] [float] NOT NULL,
	[T$BASE] [float] NOT NULL,
	[T$ADDE] [float] NOT NULL,
	[T$OEMG] [char](50) NOT NULL,
	[T$PSPL] [float] NOT NULL,
	[T$SQPL] [float] NOT NULL,
	[T$YEAR] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [TFSBOM473180$IDX1]    Script Date: 2014/11/12 17:13:32 ******/
CREATE UNIQUE NONCLUSTERED INDEX [TFSBOM473180$IDX1] ON [dbo].[TFSBOM473180]
(
	[T$USRN] ASC,
	[T$PJNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[TFSBOM473180_BK20131122]    Script Date: 11/06/2014 15:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM473180_BK20131122](
	[T$USRN] [char](12) NOT NULL,
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$OLDT] [datetime] NULL,
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
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

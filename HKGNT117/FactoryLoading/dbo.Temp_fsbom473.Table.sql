USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[Temp_fsbom473]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Temp_fsbom473](
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
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

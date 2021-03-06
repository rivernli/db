USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[TFSOLP107180_bk20140812]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP107180_bk20140812](
	[T$LOCA] [char](6) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$DESC] [char](30) NOT NULL,
	[T$DQUA] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$CSGS] [char](30) NOT NULL,
	[T$DACA] [char](30) NOT NULL,
	[T$LAYS] [char](3) NOT NULL,
	[T$DOLS] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$CCTY] [char](3) NOT NULL,
	[T$PRDT] [char](30) NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$STNO] [char](20) NOT NULL,
	[T$WONO] [char](10) NOT NULL,
	[T$WOPO] [float] NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$SQFT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

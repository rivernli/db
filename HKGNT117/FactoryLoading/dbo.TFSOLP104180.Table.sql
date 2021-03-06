USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSOLP104180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP104180](
	[T$LOCA] [char](6) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$DESC] [char](30) NOT NULL,
	[T$DQUA] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$CSGS] [char](6) NOT NULL,
	[T$DACA] [char](30) NOT NULL,
	[T$LAYS] [char](3) NOT NULL,
	[T$DOLS] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$CCTY] [char](3) NOT NULL,
	[T$HKDT] [datetime] NULL,
	[T$PRDT] [char](30) NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

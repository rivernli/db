USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MSS_AheadFGOut_ByOrder]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSS_AheadFGOut_ByOrder](
	[T$JDAT] [datetime] NULL,
	[T$AJSD_FiscalYear] [nvarchar](4) NULL,
	[T$AJSD_FiscalPeriod] [int] NULL,
	[T$PDAT_FiscalYear] [varchar](4) NULL,
	[T$PDAT_FiscalPeriod] [float] NOT NULL,
	[Plant] [char](2) NOT NULL,
	[OrderType] [char](3) NOT NULL,
	[Technology] [char](30) NULL,
	[Project] [char](32) NOT NULL,
	[Amount] [float] NULL,
	[Quantity] [float] NULL,
	[Sqft] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

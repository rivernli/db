USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MSS_MSSBreakdown]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSS_MSSBreakdown](
	[T$JDAT] [datetime] NULL,
	[T$PDAT_FiscalYear] [nvarchar](4) NULL,
	[T$PDAT_FiscalPeriod] [int] NULL,
	[Plant] [char](2) NOT NULL,
	[OrderType] [char](3) NOT NULL,
	[Technology] [varchar](30) NULL,
	[Project] [char](32) NOT NULL,
	[Project4Char] [varchar](4) NULL,
	[OEM] [char](30) NOT NULL,
	[CustomerPart] [char](30) NOT NULL,
	[Product] [char](30) NOT NULL,
	[FGavailable] [float] NULL,
	[BalanceToBuild] [float] NULL,
	[Amount] [float] NULL,
	[Quantity] [float] NULL,
	[Sqft] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

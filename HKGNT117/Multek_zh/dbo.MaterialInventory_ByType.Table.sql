USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MaterialInventory_ByType]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MaterialInventory_ByType](
	[Plant] [varchar](3) NOT NULL,
	[Category] [char](4) NOT NULL,
	[Type] [char](30) NOT NULL,
	[Description] [char](30) NOT NULL,
	[Date] [datetime] NULL,
	[Year] [int] NULL,
	[Quarter] [int] NULL,
	[Month] [int] NULL,
	[QuarterDesc] [nvarchar](62) NULL,
	[MonthDesc] [nvarchar](95) NULL,
	[DateDesc] [nvarchar](92) NULL,
	[FiscalYear] [int] NULL,
	[FiscalQuarter] [int] NULL,
	[FiscalPeriod] [int] NULL,
	[FiscalQuarterDesc] [nvarchar](38) NULL,
	[FiscalPeriodDesc] [varchar](50) NULL,
	[FiscalDesc] [nvarchar](101) NULL,
	[Amount] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

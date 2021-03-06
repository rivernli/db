USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MSS_FGOut_ByOrder]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSS_FGOut_ByOrder](
	[T$JDAT] [datetime] NULL,
	[T$AJSD_FiscalYear] [nvarchar](4) NULL,
	[T$AJSD_FiscalPeriod] [int] NULL,
	[Plant] [char](2) NOT NULL,
	[OrderType] [char](3) NOT NULL,
	[Project] [char](32) NOT NULL,
	[FGout] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
